;;
;;Phisical_sistem
;;

.include "man/entity_manager.h.s"
.include "man/shot_manager.h.s"
.include "sys_kill_bullet.h.s"
.include "sys_kill_bullet_2.h.s"	
.include "sys_map_colision.h.s"
.include "man/state_manager.h.s"
.include "sys_dir.h.s"


move_entities_init::
 call entityman_getEntityVector_IX
 call entityman_num_entities	
ld (_contador_entidades),a
ld (_puntero_entidades), ix


 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix
ret



move_entities::

call _move_canon
call _move_balas	
ret

_move_canon::
 _contador_entidades=.+1
 ld a, #00
 _puntero_entidades=.+2
 ld ix, #0000

 _loop:
	push af

	
call modificar_sprite
	ld   b, e_xl(ix)
	ld   c, e_yl(ix)


	ld   e_xll(ix), b 
	ld   e_yll(ix), c

	ld   b, e_x(ix)
	ld   c, e_y(ix)

	ld   e_xl(ix), b 
	ld   e_yl(ix), c



	ld 	b, e_x(ix)
	ld 	c, e_y(ix)
	ld   	d, e_ancho(ix)
	ld	e, e_alto(ix)



	ld   a, e_vx(ix)
	or a
	jr z ,_no_move_x
	
		jp m ,_izquierda
		_derecha:
			ld h,#3

			call comp_colisiones
			dec a
			jr nz, _out

			ld a, e_x(ix)
			add e_vx(ix)
			
			ld e_x(ix),a	
			jr _out		
		_izquierda:
			ld h,#1
			call comp_colisiones
			dec a
			jr nz, _out	

			ld a, e_x(ix)
			add e_vx(ix)
			
			ld e_x(ix),a
	_no_move_x:


	ld   a, e_vy(ix)
	or a
	jr z,_no_move_y
		
		jp m,_arriba
		_abajo:
			ld h,#4
			call comp_colisiones
			dec a
			jr nz, _out
			
			ld a, e_y(ix)
			add e_vy(ix)
			
			ld e_y(ix),a
			jr _out
		_arriba:
			ld h,#2
			call comp_colisiones
			dec a
			jr nz, _out

			ld a, e_y(ix)
			add e_vy(ix)

			ld e_y(ix),a
	_no_move_y:

_out:



	pop af
	dec a
	ret z

	
	ld de, #siceof_e
	add ix, de
	
	jp _loop
ret


_move_balas::
	 _puntero_balas=.+2
 	ld ix, #0000
 	_contador_balas=.+1
 	ld hl, #0000	

	ld a, (hl)
	
	ld l ,a			;numero de balas 
 	or a
 	jp z, _no_hay_balas
 	;;hay balas

		
					
	_balloop:


	
			ld   b, b_xl(ix)
			ld   c, b_yl(ix)


			ld   b_xll(ix), b 
			ld   b_yll(ix), c

			ld   b, b_x(ix)
			ld   c, b_y(ix)

			ld   b_xl(ix), b 
			ld   b_yl(ix), c

			ld   d ,b_w(ix)
			ld   e ,b_h(ix)

					

			
			ld a , b_vx(ix)
			or a
			jr z ,_no_move_x_bales
				cp #1
				jr nz, _bala_izquierda 
				_bala_derecha:
					ld h,#3
					push hl
					call comp_colisiones
					pop hl
					dec a
					jr nz, _matar
					ld a ,b_vx(ix)
					ld   b, b_x(ix)
					add b
					ld b_x(ix), a
					jr _siguiente

					_matar:
					ld a, l
					push hl
					push ix
					call kill_bullet
					pop ix
					pop hl

					jr _siguiente_matando

				_bala_izquierda:
					ld h,#1
					push hl
					call comp_colisiones
					pop hl
					dec a
					jr nz, _matar
					ld a ,b_vx(ix)
					ld   b, b_x(ix)
					add b
					ld b_x(ix), a
					jr _siguiente
			_no_move_x_bales:

			ld a , b_vy(ix)
			or a
			jr z ,_no_move_y_bales
				cp #4
				jr nz, _bala_arriba
				_bala_abajo:
					ld h,#4
					push hl
					call comp_colisiones
					pop hl
					dec a
					jr nz, _matar
					ld a ,b_vy(ix)
					ld   c, b_y(ix)
					add c
					
					ld b_y(ix), a
					jr _siguiente
				_bala_arriba:
					ld h,#1
					push hl
					call comp_colisiones
					pop hl
					dec a
					jr nz, _matar
					ld a ,b_vy(ix)
					ld   c, b_y(ix)					
					add c
					ld   b_y(ix), a

					jr _siguiente
			_no_move_y_bales:


	_siguiente:
	ld a, l
	dec a
	ret z

	ld l, a	
	ld de, #siceof_b
	add ix, de
	
	jp _balloop
			
_siguiente_matando:

	ld a, l
	dec a
	ret z

	ld l, a
	jp _balloop
		
	_no_hay_balas:
	ret





check_gameover::

	;;Bucle que va contando en h el numero de muertos, si alfinal solo queda uno vivo pasa a state game over

	ld ix, (_puntero_entidades)
 	


 	call get_gamemode
 	cp #5
 	jr z, _single_player

 	_comprobar_otro:
 	ld a, (_contador_entidades)
      ld h, #04
      _loopMuerte:

	
	ld b, e_dead(ix)
      dec b
 	jr nz, _nomuerto
 	dec h
 	_nomuerto:

      NextEntity
      dec a
      jr nz, _loopMuerte

      ld a, h
      or a
      call z, set_Gameover
      dec a
      call z, set_Gameover
      


ret



_single_player:
ld a, e_dead(ix)
dec a
jr nz, _comprobar_otro    ;;complueba si mueren todos 
_muere_player_1:		;;muere el player 1 en el single
	call z, set_Gameover
ret