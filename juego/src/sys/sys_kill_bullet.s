;;
;; FUNCTION: Redimensiona el array de balas, cuando una de las balas ha coliionado o con un enemigo, o con el escenario
;; INPUT: Bala a eliminar (IX) y Numero de bala a borrar (H)
;; CHANGE: Memoria reservada para las balas en el entity manager
;;

.include "sys_kill_bullet.h.s"
.include "man/shot_manager.h.s"
.include "man/entity_manager.h.s"
.include "sys/clean_entities.h.s"
.include "sys/sys_a.h.s"

kill_bullet_init::

 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix

  ret


kill_bullet::
  
  ;; Me guardo el numero de balas que me han pasado por parametro (ya que la funcion "limpiar_ultima" me corrompe dicho dato)

push af



call iniciar_animacion_bala


pop af

  push af

  ;; Realizo el limpiado del rastro de la bala

  ld l, b_canon_l(ix)
  ld h, b_canon_h(ix)
  ld de, #e_sh
  add hl, de
  ld (hl),#0

  call limpiar_ultima

  ;; ME GUARDO LA BALA QUE TENGO QUE ELIMINAR (SU DIRECCION DE MEMORIA)

  ld (_puntero_bala_inicial), ix
  _puntero_bala_inicial = . + 1
  ld de, #0x0000

  ;; COMPRUEBO SI LA BALA A BORRAR ES LA ULTIMA DEL ARRAY

  pop af   ;; Recupero el numero de balas que he guardado en la pila con tal de realizar comprobaciones, como saber, si la bala que va a eliminarse, es la ultima del array o no
  ld c, a  ;; Cargo en el registro C, el numero de balas (registro A) con tal de saber el numero de desplazamientos que tendre que realizar en la memoria para borrar la/s bala/s
           ;; correspondiente/s

  cp #_id_last_bullet     ;; NUMERO MAXIMO DE BALAS - 1
  jr z, _ultima_bala

  ;; OBTENGO LOS DESPLAZAMIENTOS A REALIZAR EN LA MEMORIA

  ld a, #_id_last_bullet
  sub c

  _actualizar_memoria:
     ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA ENTIDAD
     add ix, bc
     ld (_puntero_bala_incremento_ix), ix
     _puntero_bala_incremento_ix = . + 1
     ld hl, #0x0000
     ldir
     dec a
    jr nz, _actualizar_memoria
    
  jr _actualizar_num_balas
  ;; AL SALIR DEL BUCLE, HE DE ENTRAR EN ULTIMA BALA PARA BORRAR LA ULTIMA BALA COPIADA, YA QUE LDIR, NO BORRA NADA, SOLO COPIA DE UNA DIRECCION DE MEMORIA A OTRA
 
 _ultima_bala:
     ld (_puntero_bala_final), ix       ;; CARGO EN HL, LA DIRECCION DE MEMORIA A LA QUE APUNTA IX PARA PODER IR INCREMENTANDO SU POSICION CON TAL DE BORRAR LA BALA CREADA. DESPUES,
     _puntero_bala_final = . + 1        ;; REALIZO EL MISMO NUMERO DE INCREMENTOS QUE EL TAMANYO TOTAL DE LA ENTIDAD BALA Y VOY PONIENDO EN CADA POSICION DE MEMORIA UN 0. CON ESTO ME
     ld hl, #0x0000                     ;; EVITO EL COPIAR ZONAS DE MEMORIA (A LA QUE APUNTABA HL ORIGINALMENTE CUANDO NO SE MODIFICABA AL ENTRAR EN ESTA PARTE DEL CODIGO) QUE PUEDEN
     ld (hl), #-1                       ;; ESTAR VACIAS, O NO
     .rept #siceof_b -1                    
        inc hl
        ld (hl), #00
     .endm
   
 _actualizar_num_balas:
  ;; ACTUALIZO EL CONTADOR DE BALAS
   _contador_balas=.+1
  ld hl, #0000                ;; Obtengo en hl el numero de balas
   ld a, (hl)                ;; Guardo en A el numero de balas
   dec a                     ;; Decremento el numero de balas que hay
   ld (hl), a                ;; Actualizo las balas que hay una vez se elimina una

  ret


kill_bullet_all::

 _puntero_balas=.+2
  ld ix, #0000
 ld hl ,(_contador_balas)
 ld (hl),a
 or a
 jr nz, _limpiamos_array_de_balas
ret

_limpiamos_array_de_balas:
  _loop_clean:
   ld (_puntero_limpiar), ix
     _puntero_limpiar = . + 1
     ld de, #0x0000
     ex de,hl
     inc de
     ld bc, #siceof_b
     ldir
     dec a
     ret z
     jr _limpiamos_array_de_balas

  ret