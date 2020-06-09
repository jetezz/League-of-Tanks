;;
;;sys a
;;
.include "man/entity_manager.h.s"
.include "cpct_functions.h.s"
.include "man/manager_buffer.h.s"
.include "man/shot_manager.h.s"
.include "sys/sys_a.h.s"



.globl _balaExpl_sp_0
.globl _balaExpl_sp_1
.globl _balaExpl_sp_2
.globl _balaExpl_sp_3

.globl _canonExpl_0
.globl _canonExpl_1
.globl _canonExpl_2
.globl _canonExpl_3


BalaAni anib1 00,00,00,02,08
BalaAni anib2 00,00,00,02,08
BalaAni anib3 00,00,00,02,08
BalaAni anib4 00,00,00,02,08
BalaAni anib5 00,00,00,02,08
BalaAni anib6 00,00,00,02,08
BalaAni anib7 00,00,00,02,08
BalaAni anib8 00,00,00,02,08


CanonAni anic1 00,00,00,04,16
CanonAni anic2 00,00,00,04,16
CanonAni anic3 00,00,00,04,16
CanonAni anic4 00,00,00,04,16





_contador_balas: .db 00
_contador_canon: .db 00




















animar::

ld a, (_contador_balas)
or a
jr z, _no_hay_balas
_hay_balas:
	ld ix, #anib1
	_loop_aimacion_bala:
	
		push af

				
			call animacion_bala	
		pop af
		dec a
		jr z, _no_hay_balas
		ld de, #siceof_ae
		add ix,de
	jr _loop_aimacion_bala

_no_hay_balas:


ld a, (_contador_canon)
or a
jr z, _no_hay_canon
_hay_canon:
	ld ix, #anic1
	_loop_aimacion_canon:
	
		push af

				
			call animacion_bala	
		pop af
		dec a
		ret z
		ld de, #siceof_ae
		add ix,de
	jr _loop_aimacion_canon

_no_hay_canon:



ret


animacion_bala::


ld a, a_con(ix)
dec a
jr z, _transicion	
_actializar_cronometro_bala:

	ld a_con(ix),a	
	ret

_transicion:

ld l , a_punt_l(ix)
ld h , a_punt_h(ix)
ld (_siguiente_posicion_bala), hl

_siguiente_posicion_bala=.+1
jp 0000

_transicion_bala_1:
	 ld de, #0xC000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	 ld a, a_ani(ix)
	 or a
	 jr z, _es_bala
	 _es_canon:
	 ld hl,#_canonExpl_0
	 jr _salir_canon
	 _es_bala:
	  ld hl,#_balaExpl_sp_0
 	_salir_canon:
	  
	 call cpct_drawSprite_asm

	 ld de, #0x8000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	 ld a, a_ani(ix)
	 or a
	 jr z, _es_bala_01
	 _es_canon02:
	 ld hl,#_canonExpl_0
	 jr _salir_canon_01
	 _es_bala_01:
	  ld hl,#_balaExpl_sp_0
 	_salir_canon_01:
	  
	 call cpct_drawSprite_asm
	 

	 ld hl, #_transicion_bala_2
	ld  a_punt_l(ix), l
	ld  a_punt_h(ix), h

	 jp _reiniciar_contador_bala

_transicion_bala_2:
	 ld de, #0xC000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	  ld a, a_ani(ix)
	 or a
	 jr z, _es_bala1
	 _es_canon1:
	 ld hl,#_canonExpl_1
	 jr _salir_canon1
	 _es_bala1:
	  ld hl,#_balaExpl_sp_1
	   _salir_canon1:

	 call cpct_drawSprite_asm


	  ld de, #0x8000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	  ld a, a_ani(ix)
	 or a
	 jr z, _es_bala12
	 _es_canon12:
	 ld hl,#_canonExpl_1
	 jr _salir_canon12
	 _es_bala12:
	  ld hl,#_balaExpl_sp_1
	   _salir_canon12:

	 call cpct_drawSprite_asm
	

	 ld hl, #_transicion_bala_3
	 ld  a_punt_l(ix), l
	 ld  a_punt_h(ix), h

	  jp _reiniciar_contador_bala

_transicion_bala_3:

	 ld de, #0xC000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto
	
	ld a, a_ani(ix)
	 or a
	 jr z, _es_bala2
	 _es_canon2:
	 ld hl,#_canonExpl_2
	 jr _salir_canon2
	 _es_bala2:
	  ld hl,#_balaExpl_sp_2
	   _salir_canon2:

	 call cpct_drawSprite_asm


	  ld de, #0x8000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto
	
	ld a, a_ani(ix)
	 or a
	 jr z, _es_bala22
	 _es_canon22:
	 ld hl,#_canonExpl_2
	 jr _salir_canon22
	 _es_bala22:
	  ld hl,#_balaExpl_sp_2
	   _salir_canon22:

	 call cpct_drawSprite_asm
	

	  ld hl, #_transicion_bala_4
	  ld  a_punt_l(ix), l
	  ld  a_punt_h(ix), h

	  jp _reiniciar_contador_bala

_transicion_bala_4:

	 ld de, #0xC000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	ld a, a_ani(ix)
	 or a
	 jr z, _es_bala3
	 _es_canon3:
	 ld hl,#_canonExpl_3
	 jr _salir_canon3
	 _es_bala3:
	  ld hl,#_balaExpl_sp_3
	   _salir_canon3:

	 call cpct_drawSprite_asm



	 ld de, #0x8000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 
	 call cpct_getScreenPtr_asm
	 
	 ex de, hl
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto

	ld a, a_ani(ix)
	 or a
	 jr z, _es_bala32
	 _es_canon32:
	 ld hl,#_canonExpl_3
	 jr _salir_canon32
	 _es_bala32:
	  ld hl,#_balaExpl_sp_3
	   _salir_canon32:

	 call cpct_drawSprite_asm

	

	ld hl, #limpiar_b
	  ld  a_punt_l(ix), l
	  ld  a_punt_h(ix), h

	 jp _reiniciar_contador_bala


limpiar_b::

 ld de ,#0xc000

 	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 

	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	 ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto
	call cpct_drawSolidBox_asm

  ld de ,#0x8000
	 ld   c,  a_x(ix)	
	 ld   b,  a_y(ix) 

	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	  ld c, a_w(ix)  ;;ancho
	 ld b, a_h(ix) ;;alto
	call cpct_drawSolidBox_asm



	
	
	ld (_pasar_ix_hl), ix
	_pasar_ix_hl=.+1
	ld de, #0000
	ld hl, #siceof_ae
	add hl,de 
	 

	ld a, a_ani(ix)
	 or a
	 jr z, _limpiar_bala
	 _limpiar_canon:

	 ld b, #0	
		ld a, (_contador_canon)
	    	ld c, a
	    	dec c
	    	ld a, c
	    	or a
	    	jr z,_salimos_c
	    
	    
	    	ld c, #0
	    	_multi_c:
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		dec a
		jr nz, _multi_c
		
	    	ldir

	    
		_salimos_c:
	    	ld a, (_contador_canon)
	    	dec a
	    	ld (_contador_canon),a

	    	ret


	_limpiar_bala:
		ld b, #0	
		ld a, (_contador_balas)
	    	ld c, a
	    	dec c
	    	ld a, c
	    	or a
	    	jr z,_salimos
	    
	    
	    	ld c, #0
	    	_multi:
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		    	inc c
		dec a
		jr nz, _multi
		
	    	ldir

	    
		_salimos:
	    	ld a, (_contador_balas)
	    	dec a
	    	ld (_contador_balas),a


    	
    	


    
	

ret

_reiniciar_contador_bala:
	ld a, #duracion_animacion
	ld a_con(ix), a
ret

animacion_tanque:

ret



iniciar_animacion_bala::
ld iy, #anib1
ld a, (_contador_balas)
or a
jr z,_primera_posicion
	cp #maximo_balas_animacion
	jr nz,_no_maximo
	
	ret
	_no_maximo:
	loop_colocar:
		ld de, #siceof_ae
		add iy,de
		dec a
		jr z,_no_hay_mas
	jr loop_colocar


_no_hay_mas:

_primera_posicion:




ld a, e_x(ix)
ld a_x(iy), a
ld a, e_y(ix)
ld a_y(iy), a

ld a,#02
ld a_w(iy), a
ld a,#08
ld a_h(iy), a

ld hl, #_transicion_bala_1
ld  a_punt_l(iy), l
ld  a_punt_h(iy), h

ld a_con(iy), #duracion_animacion

ld a, (_contador_balas)
inc a
ld (_contador_balas),a 

ret







iniciar_animacion_canon::

ld ix, #anic1
ld a, (_contador_canon)
or a
jr z,_primera_posicion_canon
	cp #maximo_canon_animacion
	jr nz,_no_maximo_canon
	
	ret
	_no_maximo_canon:
	loop_colocar_canon:
		ld de, #siceof_ae
		add ix,de
		dec a
		jr z,_no_hay_mas_canon
	jr loop_colocar_canon


_no_hay_mas_canon:

_primera_posicion_canon:




ld a, b_x(iy)
ld a_x(ix), a
ld a, b_y(iy)
ld a_y(ix), a

ld a,#04
ld a_w(ix), a
ld a,#16
ld a_h(ix), a
ld a, #1
ld a_ani(ix), a

ld hl, #_transicion_bala_1
ld  a_punt_l(ix), l
ld  a_punt_h(ix), h

ld a_con(ix), #duracion_animacion

ld a, (_contador_canon)
inc a
ld (_contador_canon),a 

ret


limpiar_animaciones::
ld hl, #anib1
ex de, hl
ld hl, #anib1
inc de
ld (hl),#0
ld bc, #63
ldir

ld hl, #anic1
ex de, hl
ld hl, #anic1

inc de
ld (hl),#0
ld bc, #31
ldir

ld a, #0
ld (_contador_balas),a
ld (_contador_canon),a





ret