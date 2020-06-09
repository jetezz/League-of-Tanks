;;
;;sys_compr_disparo
;;

.include "man/entity_manager.h.s"
.include "man/shot_manager.h.s"
.include "sys/sys_kill_bullet.h.s"
.include "sys/clean_entities.h.s"
.include "sys/render_system.h.s"
.include "../sys/sys_interrup_music.h.s"
.include "sys/sys_a.h.s"



sys_comp_disp_init::

	 call entityman_getEntityVector_IX
 	call entityman_num_entities	
	ld (_contador_entidades),a
	ld (_puntero_entidades), ix


	 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 	call entityman_num_Bales
 	ld (_contador_balas), hl
 	ld (_puntero_balas), ix
	



	ret




sys_comp_disp_update::

_contador_balas=.+1
 	ld hl, #0000
  ld a , (hl)
  or a
 jp z ,_no_hay_balas
 


	_puntero_entidades = .+2
	ld iy, #0x0000                   	;;Puntero a canon iy

	_puntero_balas = .+2
	ld ix, #0x0000				;; puntero a balas ix

	 
	 ld h , a                       ;;h  numero de balas
	 
	_contador_entidades=.+1
 	 ld a, #00
	 ld l, a 					;;l  numero de canon

	 	





	_loop_canon:

	ld a ,e_dead(iy)
	dec a
	jr z, _canon_muerto



	push hl
		call entityman_num_Bales
  		ld a , (hl)
	pop hl
		or a
		jr z,_no_hay_balas	
		ld h, a

		
		ld ix, (_puntero_balas)

		_loop_balas:
		 ld d ,#1 				;; 1 no choca en x 0 si choca en x


		 ;;comprobar si choca en x


		ld b , e_x(iy) 				;;b esquina izquierda en x canon
		ld c , e_ancho(iy)			 


		ld a, b
		add c
		ld c, a					;; c esquina derecha en x canon


		ld a , b_x(ix)				
		sub c						;; comprobamos si la esquina derecha de canon es mayor que la esquina izquierda de la bala 
		jr nc , _no_choca_x
		_segundo_caso_x:

			ld a, b_x(ix)
			add b_w(ix)	
			sub b

			jr c ,_no_choca_x
			_choca_en_x:
				ld d, #0	
		

		

		;; comprobamos la y

		;;b esquina arriba en y canon
		ld b , e_y(iy) 
		ld c , e_alto(iy)	
		ld a, b
		add c
		ld c, a					;; c esquina abajo en y canon
			
		ld a , b_y(ix)		
		sub c
		jr nc, _no_choca_y
		_segundo_caso_y:

			ld a, b_y(ix)
			add b_h(ix)	
			sub b
			jr c ,_no_choca_y
			_choca_en_y::
					ld a ,d
					or a
					jr nz, _no_choca_x			

					push hl
					push ix
					push iy
						
						
						call limpiar_ultimo
						call entityman_num_Bales   ;; Vuelvo a recuperar el numero de balas que hay, ya que, con la llamada anterior, he perdido dicho dato
  						ld a, (hl)                 ;; Cargo, en el registro A, el numero de balas que hay, con tal de pasarselo al sistema denominado kill_bullet
						ld e_dead(iy), #1

						push iy
							call kill_bullet				
						
							call jugador_muerto
						pop iy
						call sonido_muerte
						call iniciar_animacion_canon
					pop iy
					pop ix
					pop hl

					jr _repito_bala

		_no_choca_x:
		_no_choca_y:

		


		

		ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA BALA
		add ix, bc
		dec h
		jr nz, _loop_balas
		jr _no_hay_mas

		_repito_bala:

		
		ld a ,h
		dec h
		dec a

		jr z ,_no_hay_mas
		jr nz, _loop_balas

	_canon_muerto:
	_no_hay_mas:
	ld bc, #siceof_e    ;;NUMERO DE BYTES QUE TIENE CADA canon
	add iy, bc
	dec l
	jp nz, _loop_canon


_no_hay_balas:
	ret

