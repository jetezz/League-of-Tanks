;;
;;sys map colision
;;


.include "sys/sys_map_creator.h.s"
.include "assets.h.s"
.include "man/state_manager.h.s"
.include "sys_map_colision.h.s"
.include "man/st_game_over.h.s"




_puntero_mapa: .dw #_mapa1
estado_colisiones: .db #00

;;INPUT:

;;B POSICION EN X
;;C POSICION EN Y
;;D ANCHO
;;E ALTO
;;H direcion que mira el canon  (solo para canon) en balas h 0

;; comprobar colisiones 
comp_colisiones::


;; en b tengo x
;; en c tengo y	

	ld a ,h
		
		cp #1
		jr z, _left
		cp #2
		jr z, _up
		cp #3 
		jr z, _right
		cp #4 
		jr z, _down
ret
		

	
	

		_right:
			ld a, d    ;;(4)  	 SUMAMOS EL ANCHO
			add a,b
			ld b ,a

			push bc
			push de	
				call buscar_tile
			pop de	
			pop bc
			
			dec a 
			jr z, _el_primero_pasa
			inc a
			ret
			_el_primero_pasa:
			ld a, e      ;; 15 SUMAMOS EL ALTO
			dec a
			add a,c
			ld c ,a	
					
			call buscar_tile	
			ret
			

			
	
		_left:
			ld a, #-1
			add a,b
			ld b ,a
			push bc
			push de	
				call buscar_tile
			pop de	
			pop bc
			dec a 
			jr z, _el_primero_pasa
			inc a
			ret
		

	
	
		_down:
			ld a, e    ;;(16)    SUMAMOS EL ALTO
			add a,c
			ld c ,a
			push bc
			push de	
				call buscar_tile
			pop de	
			pop bc
			dec a
			jr z, _el_primero_pasa_y
			inc a
			ret
			_el_primero_pasa_y:
			ld a, d   ;;(3)   sumamos el ancho
			dec a
			add a,b
			ld b ,a
			call buscar_tile
			ret
			
		
		_up:
			
			ld a, #-1
			add a,c
			ld c ,a
			push bc
			push de	
				call buscar_tile
			pop de	
			pop bc
			dec a
			jr z, _el_primero_pasa_y
			inc a
			ret


		

	






buscar_tile::







 srl c
 srl c
 srl c


 


 srl b
 srl b
 	

 
call coger_puntero


ld a, c
	or a
		jr z, tile_0
		loop_y:
			ld de, #20
			add hl, de
			dec a	
		jr nz, loop_y

	tile_0:

	ld d, #0
	ld e, b
	add hl, de  ;; aqui tengo el tile que le hemos pedido

	ld a ,(hl)
	cp #01
	jr z , _puedes_pasar
	ld a ,#0
	ret
	_puedes_pasar:
	ld a, #1

	ret



coger_puntero::

ld hl, #_puntero_mapa
ld a, (hl)
ld e, a
inc hl
ld a, (hl)
ld d , a
ld h, d
ld l, e

	ret














cambiar_colisiones::



ld a, (estado_colisiones)
cp #sin_inicializar
jr nz,_NO_inicializar_colisiones ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
_inicializar_colisiones:	;; inicializo el nivel y lo pongo en el nivel_1

call get_gamemode				;;cojo el gamemode
cp #5
jr z,_colisiones_single			;;inicializo para ir al single o al multi
_colision_multi:

ld hl, #_mapa_1_multi
ld(_puntero_colision_siguiente),hl
jr salir

_colisiones_single:

ld hl, #_mapa_1_single
ld(_puntero_colision_siguiente),hl

salir:
ld a, #siguiente_colision ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
ld (estado_colisiones),a

_NO_inicializar_colisiones: ;; salto al nivel que toca


call estado_game_over
dec a
jr z,_reiniciar_posiciones

 _puntero_colision_siguiente=.+1
 jp 0000

_reiniciar_posiciones:
 _puntero_repetir_colision=.+1
 jp 0000


	

	_mapa_1_single:

	ld de, #_single_mapa1
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d



	ld hl, #_mapa_2_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_1_single		
	ld(_puntero_repetir_colision),hl


	ret
	_mapa_2_single:

	ld de, #_single_mapa2
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_3_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_2_single		
	ld(_puntero_repetir_colision),hl


	ret
	_mapa_3_single:

	ld de, #_single_mapa3
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_4_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_3_single		
	ld(_puntero_repetir_colision),hl


	ret
	_mapa_4_single:

	ld de, #_single_mapa4
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_5_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_4_single		
	ld(_puntero_repetir_colision),hl


	ret
	_mapa_5_single:

	ld de, #_single_mapa5
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_6_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_5_single		
	ld(_puntero_repetir_colision),hl


	ret
	_mapa_6_single:


	ld de, #_single_mapa6
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d

	ld hl, #_mapa_1_single		
	ld(_puntero_colision_siguiente),hl

	ld hl, #_mapa_6_single		
	ld(_puntero_repetir_colision),hl
	ret










	_mapa_1_multi:

	ld de, #_mapa1
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d

	ld hl, #_mapa_2_multi		
	ld(_puntero_colision_siguiente),hl



	ret
	_mapa_2_multi:

	ld de, #_mapa2
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d

	ld hl, #_mapa_3_multi		
	ld(_puntero_colision_siguiente),hl


	ret
	_mapa_3_multi:

	ld de, #_mapa3
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_4_multi		
	ld(_puntero_colision_siguiente),hl
	ret
	
	_mapa_4_multi:

	ld de, #_mapa4
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_5_multi		
	ld(_puntero_colision_siguiente),hl
	ret
	_mapa_5_multi:

	ld de, #_mapa5
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d


	ld hl, #_mapa_6_multi		
	ld(_puntero_colision_siguiente),hl
	ret
	_mapa_6_multi:

	ld de, #_mapa6
	ld hl , #_puntero_mapa
	ld (hl), e
	inc hl
	ld (hl), d

	ld hl, #_mapa_1_multi		
	ld(_puntero_colision_siguiente),hl
	ret
	

reiniciar_colisiones::
ld a,#0
ld (estado_colisiones),a
	ret