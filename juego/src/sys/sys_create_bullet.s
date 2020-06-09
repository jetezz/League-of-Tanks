;;
;;create bullet
;;
.include "sys_create_bullet.h.s"
.include "../man/shot_manager.h.s"
.include "../man/entity_manager.h.s"
.include "../sys/sys_map_colision.h.s"
.include "../sys/sys_interrup_music.h.s"

velocidad_x:   .db  # _nivel_1x
velocidad_x_n: .db  # _nivel_1x_n
velocidad_y:   .db  # _nivel_1y
velocidad_y_n: .db  # _nivel_1y_n

sys_create_bullet_init::

call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix

  ret
hacer_disparo::
   
  ld a,e_sh(ix)
     dec a
    jr z, _ya_ha_disparado        ;;compruebo si ha disparado o no
    _disparamos:
    

   call create_bullets            ;;no ha disparado y creo la bala
 
_ya_ha_disparado:
	ret


create_bullets::
   
   ;; INCREMENTO EL NUMERO DE BALAS CREADAS
  _contador_balas=.+1
  ld hl, #0000       ;; cargo la posicion de memoria donde tengo mi registro de balas creadas en el registro HL
   
   ld   a, (hl)                    ;; obtengo el numero de balas cargandolo en el registro A
   push af
   cp #max_bales                            ;; numero maximo de balas que podemos tener
   jr z , _maximo_de_balas         ;;si es 0 hemos llegado al numero maximo y no incrementamos 
   ;;no hemos llegado al maximo de balas


   call create_bullet 

   pop af   

   inc  a  

   _puntero_balas=.+2
  ld ix, #0000


   
   ;;compruebo si la bala que va a salir choca con el mapa
ld (_puntero_bala_creada), iy
   _puntero_bala_creada=.+2
   ld ix, #0x0000

  

   ld h,b_canon_h(ix)
   ld l,b_canon_l(ix)

   ld de, #e_dir
   add hl , de
   ld h, (hl)
   ld b, b_x(ix)
   ld c, b_y(ix)
   ld d, #b_width
   ld e, #b_height
push hl
   call comp_colisiones
pop hl

  dec a
  jr z,_crear_bala
;;la bala choca con el mapa por lo que salgo de crear bala 
  ret


  _crear_bala:
  call sonido_disparo
  ;la bala no choca con el mapa asi que la creo
    ;; incremento el numero de balas

  ld b_h(ix), #b_height
  ld b_w(ix), #b_width


  ld h,b_canon_h(ix)
  ld l,b_canon_l(ix)
  ld de, #e_sh
  add hl, de
  ld (hl), #1


  ld hl, (_contador_balas) 
   ld a ,(hl)
   inc a
   ld   (hl), a       

   jr _saltamos2

   _maximo_de_balas:

   
   
  

    pop af

    ld h,b_canon_h(ix)
  ld l,b_canon_l(ix)
  ld de, #e_sh
  add hl, de
  ld (hl), #0

 _saltamos2:

	ret

;;
;; FUNCTION: ME ACTUALIZA LA POSICION DE LA BALA A LA DEL PERSONAJE CON TAL DE QUE SE DISPARE DESDE AHI
;; INPUT: DIRECCION DE MEMORIA DE LA ENTIDAD QUE HA DISPARADO (EN IX)
;; CHANGE: POSX, POSY, VELX, VELY, HEIGHT, WIDTH, STATUS DE LA BALA
;;
create_bullet::

   push ix ;; Me guardo la posicion de memoria de la entidad que ha disparado en la pila con tal de utilizarlo mas adelante
   
   ld (_puntero_entidad_disparo), ix  ;; Guardo la direccion de memoria de la entidad que ha disparado en el registro de para que la bala pueda guardarlo en sus datos

  ld ix, (_puntero_balas)
  ld hl, (_contador_balas)
   ld a, (hl)
   or a
   jr z, _no_hay
_multi:
   ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA ENTIDAD
   add ix, bc
   dec a
   jr nz ,_multi

_no_hay:
   ld (_puntero_bala_actual), ix
   _puntero_bala_actual = . + 2
   ld iy, #0x0000  ;; Me guardo en el registro iy, la posicion de memoria relativa a mi entidad bala, con tal de utilizarlo mas adelante
   
   pop ix  ;; Recupero la posicion de memoria de la entidad que ha disparado

   ld b, e_x(ix)    ;; posicion x de la entidad que ha disparado
   ld c, e_y(ix)    ;; posicion y de la entidad que ha disparado
   ld a, e_dir(ix)  ;; direccion a la que apunta la entidad que ha disparado

   ;; Cogemos los datos de las entidades

   ;; If que determina la direccion de la bala, a partir de la del personaje

   cp #e_dir_right
   jp z, _b_dir_right
   cp #e_dir_top
   jp z, _b_dir_top
   cp #e_dir_left
   jp z, _b_dir_left
   cp #e_dir_bott
   jp z, _b_dir_bott

   ;; Segun la direccion, se establece la velocidad en xy, siendo esta positiva, o negativa. Ademas, se establece la anchura y la altura de la bala en funcion de viaja horizontalmente. o verticalmente (ya que su ancho y su alto, varian en esas condiciones)
   
   _b_dir_right:

   ;; INCREMENTAMOS EL VALOR DE LOS REGISTROS B Y C, CON TAL DE QUE LA BALA SE DISPARO DESDE UNA POSICION REALISTA DEL SPRITE (EVITANDO QUE ESTA MISMA, COLISIONE CON EL)



  ld a ,e_ancho(ix)
  add b
  inc a
  ld b,a

  ld a ,e_alto(ix)
  srl a  
  add c
 
  .rept #4
  dec a
  .endm
  
  ld c,a




   ld b_x(iy), b     ;; ponemos la posicion del personaje como posicion de la bala en el eje x
   ld b_y(iy), c     ;; lo mismo con el eje y
   ld b_xl(iy), b    ;; lo mismo con la posicion anterior en el eje x
   ld b_yl(iy), c    ;; y en el eje y
   ld b_xll(iy), b   ;; lo mismo con la posicion anterior de la anterior
   ld b_yll(iy), c   ;; y en el eje y

      ld a,(velocidad_x)
      ld b_vx(iy), a      ;; Asigno la velocidad en x
      ld b_vy(iy), #sin_vel      ;; Elimino la velocidad en y (para que solo se desplace en una direccion, evitando que vaya en diagonales por el posible cambio de posicion del personaje, o por otros factores)
    
      jp _endif


   _b_dir_top:


 

  ld a ,e_ancho(ix)
  srl a
  add b 
  dec a
  ld b,a

   
  .rept #9
  dec c
  .endm
 


   ld b_x(iy), b     ;; ponemos la posicion del personaje como posicion de la bala en el eje x
   ld b_y(iy), c     ;; lo mismo con el eje y
   ld b_xl(iy), b    ;; lo mismo con la posicion anterior en el eje x
   ld b_yl(iy), c    ;; y en el eje y
   ld b_xll(iy), b   ;; lo mismo con la posicion anterior de la anterior
   ld b_yll(iy), c   ;; y en el eje y

      ld a,(velocidad_y_n)
      ld b_vx(iy), #sin_vel      ;; Elimino la velocidad en x (para que solo se desplace en una direccion, evitando que vaya en diagonales por el posible cambio de posicion del personaje, o por otros factores)
      ld b_vy(iy), a      ;; Asigno la velocidad en y
   
      jr _endif


   _b_dir_left:



  .rept #3
  dec b
  .endm

  ld a ,e_alto(ix)
  srl a
  add c
  dec a
  dec a
  dec a
  dec a
  ld c,a


   ld b_x(iy), b     ;; ponemos la posicion del personaje como posicion de la bala en el eje x
   ld b_y(iy), c     ;; lo mismo con el eje y
   ld b_xl(iy), b    ;; lo mismo con la posicion anterior en el eje x
   ld b_yl(iy), c    ;; y en el eje y
   ld b_xll(iy), b   ;; lo mismo con la posicion anterior de la anterior
   ld b_yll(iy), c   ;; y en el eje y


      ld a,(velocidad_x_n)
      ld b_vx(iy), a      ;; Asigno la velocidad en x
      ld b_vy(iy), #sin_vel      ;; Elimino la velocidad en y (para que solo se desplace en una direccion, evitando que vaya en diagonales por el posible cambio de posicion del personaje, o por otros factores)
  
      jr _endif


   _b_dir_bott:

 

  ld a ,e_ancho(ix)
  srl a
  add b 
  dec a
  ld b,a

  ld a ,e_alto(ix)  
  add c
  inc a
  ld c,a


   ld b_x(iy), b     ;; ponemos la posicion del personaje como posicion de la bala en el eje x
   ld b_y(iy), c     ;; lo mismo con el eje y
   ld b_xl(iy), b    ;; lo mismo con la posicion anterior en el eje x
   ld b_yl(iy), c    ;; y en el eje y
   ld b_xll(iy), b   ;; lo mismo con la posicion anterior de la anterior
   ld b_yll(iy), c   ;; y en el eje y
   
      ld a,(velocidad_y)      
      ld b_vx(iy), #sin_vel      ;; Elimino la velocidad en x (para que solo se desplace en una direccion, evitando que vaya en diagonales por el posible cambio de posicion del personaje, o por otros factores)
      ld b_vy(iy), a     ;; Asigno la velocidad en y
    
   

  _endif:



   ld b_color (iy), #reset_bullet_color  ;; Establezco el color de la bala a su color por defecto
   ld b_sta(iy), #b_shoot  ;; Actualizo el estado de la bala, a disparada
   
   _puntero_entidad_disparo = . + 1
   ld hl, #0x0000
   
   ld b_canon_l(iy), l
   ld b_canon_h(iy), h

	ret

;;INPUT A NIVEL DE VELOCIDAD DE BALAS
velocidad_balas::
  cp #1
jr z,_nivel_1_v
  cp #2
jr z,_nivel_2_v
  




_nivel_1_v:
  ld a, #_nivel_1x
  ld (velocidad_x), a
  ld a, #_nivel_1x_n
  ld (velocidad_x_n), a
  ld a, #_nivel_1y
  ld (velocidad_y), a
  ld a, #_nivel_1y_n
  ld (velocidad_y_n), a

  ret
_nivel_2_v:
  ld a, #_nivel_2x
  ld (velocidad_x), a
  ld a, #_nivel_2x_n
  ld (velocidad_x_n), a
  ld a, #_nivel_2y
  ld (velocidad_y), a
  ld a, #_nivel_2y_n
  ld (velocidad_y_n), a
  ret

  ret