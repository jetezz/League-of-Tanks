;;
;;RENDER SYSTEM
;;

.include "cpct_functions.h.s"
.include "man/entity_manager.h.s"
.include "man/shot_manager.h.s"
.include "man/manager_buffer.h.s"
.include "sys/render_system.h.s"
.include "sys/plant_render.h.s"
.include "assets.h.s"


_contador:: .db #_contador_ciclos
_tipsprite:: .db #04


_P1_hudx = 15
_P2_hudx = 35
_P3_hudx = 55
_P4_hudx = 75

rendersys_init::  



 call entityman_getEntityVector_IX
 call entityman_num_entities  
ld (_contador_entidades),a
ld (_puntero_entidades), ix


 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix
ret




rendersys_update::

 call render_entities  	;;render para los tanques
 call plant_render
 call render_bales   ;;render para las balas
 
 ret


render_entities:
 _contador_entidades=.+1
 ld a, #00
 _puntero_entidades=.+2
 ld ix, #0000

	_renloop:
push af

  ld b ,e_dead(ix)
  dec b
  jp z, _canon_muerto

  call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl


push af
  ex de, hl
  ;;ld de, #0xC000
  ld   c, e_x(ix)  ;;x
  ld   b, e_y(ix)  ;;y
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
pop af






 ex  de,hl

 
 ld b ,e_dir(ix)




  dec a
  jr z, _pintar_cannon4
  dec a
  jr z, _pintar_cannon3
  dec a
  jr z, _pintar_cannon2
  jr _pintar_cannon1

;;;;;;;;;;;;;;;;;;
;;PINTAR CANON 1;;
;;;;;;;;;;;;;;;;;;

_pintar_cannon1:
 dec b
 jr z, _pintarc1_1
 dec b
 jr z, _pintarc1_2
 dec b
 jr z, _pintarc1_3
 dec b
 jr z, _pintarc1_4


 _pintarc1_1:
 ld hl,#_cannons_sp_00
 jr _saltar

 _pintarc1_2:
 ld hl,#_cannons_sp_01
 jr _saltar

 _pintarc1_3:
 ld hl,#_cannons_sp_02
 jr _saltar

 _pintarc1_4:
 ld hl,#_cannons_sp_03
 jr _saltar



;;;;;;;;;;;;;;;;;;
;;PINTAR CANON 2;;
;;;;;;;;;;;;;;;;;;

_pintar_cannon2:
 dec b
 jr z, _pintarc2_1
 dec b
 jr z, _pintarc2_2
 dec b
 jr z, _pintarc2_3
 dec b
 jr z, _pintarc2_4


 _pintarc2_1:
 ld hl,#_cannons_sp_05
 jr _saltar

 _pintarc2_2:
 ld hl,#_cannons_sp_06
 jr _saltar

 _pintarc2_3:
 ld hl,#_cannons_sp_07
 jr _saltar

 _pintarc2_4:
 ld hl,#_cannons_sp_08
 jr _saltar


;;;;;;;;;;;;;;;;;;
;;PINTAR CANON 3;;
;;;;;;;;;;;;;;;;;;

_pintar_cannon3:
 dec b
 jr z, _pintarc3_1
 dec b
 jr z, _pintarc3_2
 dec b
 jr z, _pintarc3_3
 dec b
 jr z, _pintarc3_4


 _pintarc3_1:
 ld hl,#_cannons_sp_10
 jr _saltar

 _pintarc3_2:
 ld hl,#_cannons_sp_11
 jr _saltar

 _pintarc3_3:
 ld hl,#_cannons_sp_12
 jr _saltar

 _pintarc3_4:
 ld hl,#_cannons_sp_13
 jr _saltar


;;;;;;;;;;;;;;;;;;
;;PINTAR CANON 4;;
;;;;;;;;;;;;;;;;;;

_pintar_cannon4:
 dec b
 jr z, _pintarc4_1
 dec b
 jr z, _pintarc4_2
 dec b
 jr z, _pintarc4_3
 dec b
 jr z, _pintarc4_4


 _pintarc4_1:
 ld hl,#_cannons_sp_15
 jr _saltar

 _pintarc4_2:
 ld hl,#_cannons_sp_16
 jr _saltar

 _pintarc4_3:
 ld hl,#_cannons_sp_17
 jr _saltar

 _pintarc4_4:
 ld hl,#_cannons_sp_18
 jr _saltar







 _saltar:


 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 
 call cpct_drawSprite_asm


_canon_muerto:
pop af 

dec a
ret z

ld bc, #siceof_e    ;;NUMERO DE BYTES QUE TIENE CADA ENTIDAD
add ix, bc
jp  _renloop



render_bales:

 
  _contador_balas=.+1
  ld hl, #0000

 ld   a, (hl) 
	or a
 jr nz, _hay_balas
 ret

_hay_balas:



 _puntero_balas=.+2
  ld ix, #0000
  
 
 _renloop_b:


push af

call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
  ex de, hl
  ld   c, b_x(ix)  
  ld   b, b_y(ix)  
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL




 ex de, hl
 ld c, #02  ;;ancho
 ld b, #08  ;;alto
 ld hl,#_bala_sp
 call cpct_drawSprite_asm


pop af 

dec a
ret z

ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA BALA
add ix, bc
jr nz, _renloop_b



ret
	


jugador_muerto::

ld ix, (_puntero_entidades)


  ;;Comprobar si el muerto es la primera entidad
      ld a, e_dead(ix)
      dec a
      call z, dibujarplayer1_M
  
    ld bc, #siceof_e   
    add ix, bc 
  ;;Comprobar si el muerto es la segunda entidad
      ld a, e_dead(ix)
      dec a
      call z, dibujarplayer2_M
  
    ld bc, #siceof_e    
    add ix, bc
   ;;Comprobar si el muerto es la tercera entidad
      ld a, e_dead(ix)
      dec a
      call z, dibujarplayer3_M

    ld bc, #siceof_e    
    add ix, bc
    ;;Comprobar si el muerto es la cuearta entidad
      ld a, e_dead(ix)
      dec a
      call z, dibujarplayer4_M

ret

pintar_hud::

  call dibujarplayer1
  call dibujarplayer2
  call dibujarplayer3
  call dibujarplayer4

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Dibujar el jugador en el hud;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


dibujarplayer1:
 
 ld  de, #0xC000
 ld   c, #_P1_hudx    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_02
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P1_hudx    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_02
 call cpct_drawSprite_asm

ret

dibujarplayer2:
 ld  de, #0xC000
 ld   c, #_P2_hudx  ;;x
 ld   b, #180   ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_07
 call cpct_drawSprite_asm

  ld  de, #0x8000
 ld   c, #_P2_hudx  ;;x
 ld   b, #180   ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_07
 call cpct_drawSprite_asm

ret

dibujarplayer3:
 ld  de, #0xC000
 ld   c, #_P3_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_12
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P3_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_12
 call cpct_drawSprite_asm

ret

dibujarplayer4:
 ld  de, #0xC000
 ld   c, #_P4_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_17
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P4_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_17
 call cpct_drawSprite_asm

ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DIBUJAR EL HUB EL JUGADOR MUERTO;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dibujarplayer1_M:
 
 ld  de, #0xC000
 ld   c, #_P1_hudx    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_04
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P1_hudx    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_04
 call cpct_drawSprite_asm

ret

dibujarplayer2_M:
 ld  de, #0xC000
 ld   c, #_P2_hudx  ;;x
 ld   b, #180   ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_09
 call cpct_drawSprite_asm

  ld  de, #0x8000
 ld   c, #_P2_hudx  ;;x
 ld   b, #180   ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_09
 call cpct_drawSprite_asm

ret

dibujarplayer3_M:
 ld  de, #0xC000
 ld   c, #_P3_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_14
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P3_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_14
 call cpct_drawSprite_asm

ret

dibujarplayer4_M:
 ld  de, #0xC000
 ld   c, #_P4_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_19
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #_P4_hudx  ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm

 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_19
 call cpct_drawSprite_asm

ret

  

pintar_letras::

;;Jugador;;

ld  de, #0xC000
 ld   c, #1    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #1    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm



;;Jugador 2

ld  de, #0xC000
 ld   c, #20    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #20    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

;; Numero 2

 ld  de, #0xC000
 ld   c, #31    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr2
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #31    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr2
 call cpct_drawSprite_asm

 



;;Jugador 3

ld  de, #0xC000
 ld   c, #40    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #40    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

;; Numero 3

 ld  de, #0xC000
 ld   c, #51    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr3
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #51    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr3
 call cpct_drawSprite_asm



;;Jugador 4

ld  de, #0xC000
 ld   c, #60    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #60    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #16 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_player_sp
 call cpct_drawSprite_asm

;numero 4

ld  de, #0xC000
 ld   c, #71    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr4
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #71    ;;x
 ld   b, #180  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #4 ;;ancho
 ld b, #16  ;;alto
 ld hl,#_spr4
 call cpct_drawSprite_asm






ret

