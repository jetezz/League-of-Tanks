;;
;;sys create balas 2
;;

.include "../man/shot_manager.h.s"
.include "../man/entity_manager.h.s"
.include "sys/sys_create_bullet_2.h.s"
.include "../sys/sys_map_colision.h.s"
.include "../sys/sys_interrup_music.h.s"

velocidad_x:   .db  # _nivel_1x
velocidad_x_n: .db  # _nivel_1x_n
velocidad_y:   .db  # _nivel_1y
velocidad_y_n: .db  # _nivel_1y_n
comprobaciones: .db #0

sys_create_bullet_init2::

 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales	
 ld (_contador_balas), hl
 ld (_puntero_balas), ix

 ret




;;INPUT IX ENTIDAD QUE DISPARA
hacer_disparo2::
ld a, #0
ld (comprobaciones), a

ld a,e_sh(ix)
dec a
jr z, _ya_ha_disparado        ;;compruebo si ha disparado o no
_disparamos:

   call comprobar_bala            ;;no ha disparado y creo la bala
 
_ya_ha_disparado:
	
ret




comprobar_bala::


_contador_balas=.+1   
	ld hl, #0000 
	ld a ,(hl) 

	cp #max_bales                            ;; numero maximo de balas que podemos tener
	jr nz , _No_maximo_balas  
ret
_No_maximo_balas:
 							;;comprobar si choca contra la pared

ld b, e_x(ix) 
ld c, e_y(ix)
ld h, e_dir(ix)
call coloocar_bala	  
ld d, #b_width
ld e, #b_height	

						
	call comp_colisiones				;;compruebo si choca contra el mapa o no
	dec a
	jr z,_crear_bala
	;;la bala choca con el mapa por lo que salgo de crear bala 
  	ret


 	_crear_bala:

 
		call sonido_disparo

		call crear_bala

		;;incremento el contador de bala
		ld hl ,(_contador_balas)
		ld a ,(hl)
		inc a
		ld (hl),a

		;;le ponemos el shot del canon a 1
		ld e_sh(ix), #1

 


  
ret



crear_bala::

_puntero_balas=.+2		
ld iy, #0000			;;IY PUNTERO AL ARRAY DE BALAS
					;;IX PUNTERO A CANON
ld hl ,(_contador_balas)
ld a, (hl)				;;A CONTADOR DE BALAS

or a
jr z, primera_bala
ld de, #siceof_b
_loop_posicionar_bala:

	add iy, de
	dec a

jr nz, _loop_posicionar_bala

primera_bala:
ld (_puntero_balas2),iy



ld (puntero_canon_hl), ix
puntero_canon_hl=.+1
ld hl, #0000

ld b_canon_l(iy), l
ld b_canon_h(iy), h


;;comprobar direccion para ponerle la velocidad
ld b, e_x(ix) 
ld c, e_y(ix)
ld h, e_dir(ix)

ld a , #1
ld (comprobaciones), a
call coloocar_bala
call colocar_posicion

ret
coloocar_bala::

_puntero_balas2=.+2		
ld iy, #0000
ld a, h

cp #1
jr z,_izquierda
cp #2
jr z,_arriba
cp #3
jr z,_derecha
cp #4
jr z,_abajo 
ret


_izquierda:

	ld a, (comprobaciones)
	dec a
	jr nz, no_v_i
	;;velocidad
	ld a, (velocidad_x_n)
	ld b_vx(iy),a
	ld b_vy(iy),#0
	;;posicion

	no_v_i:

	.rept #3
 	 dec b
  	.endm

 	 ld a ,#alto_canon
 	 srl a
 	 add c

 	.rept #4
 	 dec a
  	.endm
  	ld c,a
 	 
 		

  	ret

_arriba:


	ld a, (comprobaciones)
	dec a
	jr nz, no_v_a
	;;velocidad
	ld a, (velocidad_y_n)
	ld b_vx(iy),#0
	ld b_vy(iy),a
	;;posicion
	no_v_a:

	


	ld a ,#ancho_canon
 	srl a
  	add b 
  	dec a 
  	ld b , a 

  	.rept #9
  	dec c
  	.endm
  	

  		
  	ret
  	
_derecha:


	ld a, (comprobaciones)
	dec a
	jr nz, no_v_d

	;;velocidad
	ld a, (velocidad_x)
	ld b_vx(iy),a
	ld b_vy(iy),#0
	;;posicion
	no_v_d:

	ld a ,#ancho_canon
  	add b
 	inc a
  	ld b,a

  	ld a ,#alto_canon
  	srl a  
  	add c
 
  	.rept #4
  	dec a
  	.endm
  	ld c,a

  		
  	ret
_abajo:

	ld a, (comprobaciones)
	dec a
	jr nz, no_v_ab

	;;velocidad
	ld a, (velocidad_y)
	ld b_vx(iy),#0
	ld b_vy(iy),a
	;;posicion

	no_v_ab:
	ld a ,#ancho_canon
	srl a
	add b 
	dec a
	ld b,a

	ld a ,#alto_canon 
	add c
	inc a
	ld c,a

  
  	ret





colocar_posicion:

	ld b_x(iy),b
 	ld b_xl(iy),b
 	ld b_xll(iy),b
 	ld b_y(iy),c
 	ld b_yl(iy),c
 	ld b_yll(iy),c
 	ld b_w(iy), #b_width
 	ld b_h(iy), #b_height

	ret