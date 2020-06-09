;;
;;IA ENTITY CONTROL SYSTEM
;;

.include "man/entity_manager.h.s"
.include "man/patrol_manager.h.s"
.include "sys_create_bullet.h.s"
.include "sys_create_bullet_2.h.s"
.include "ia_control_sys.h.s"
.include "man/state_manager.h.s"
_iteraciones_ia: .db #_dificultad_ia_nive1
_contador_ia: .db #_iteraciones_ia

_vel_x_ia: .db #_nivel_1x
_vel_y_ia: .db #_nivel_1y
_vel_x_ia_n: .db #_nivel_1x_n
_vel_y_ia_n: .db #_nivel_1y_n



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;INIT
;;IX = PUNTERO AL ARRAY DE ENTIDADES 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_ai_control_init::
	ld hl , #_contador_ia

	ld a,(_iteraciones_ia)
	ld (hl), a

	ld hl , #_num_patrol
		ld (hl),#0


	_num_patrol: .db 0
	ld (_ent_array_prt),ix
	ld (_ent_array_inicio), ix


	call entityman_num_entities
	ld (_cont_entidad), a
	ld hl, #sys_ia_stand_by
_loop_init:
	

	ld e_ia_puntero_st_h (ix), h
	ld e_ia_puntero_st_l (ix), l



	dec a
	ret z

	
	ld de, #siceof_e
	add ix, de
	jr _loop_init
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;UPDATE
;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_ai_control_update::

_cont_entidad=.+1
ld a, #00	
ld (_ent_counter),a

_ent_array_prt = .+2
	ld ix, #0x0000

_ent_array_inicio = .+2
	ld iy, #0x0000

_loop:
	ld a,e_dead(ix)
	dec a
	jr z ,_canon_muerto
	ld a , e_ia_st(ix)   ;; estado de la entidad
	cp #e_ia_st_noIA
	jr z ,_no_ia_ent


_IA_ent::

		
	push af	
		push iy
			ld hl, #_contador_ia
			ld a, (hl)
			dec a
			jr z, _hacer_shot
			_no_hago_shot:
				jr  _no_disparamos
			_hacer_shot:
				ld a,(_iteraciones_ia)
				ld (hl), a


				call _compr_shoot	
				jr _continue
			_no_disparamos:
			ld (hl), a
			_continue:
		pop iy
	pop af


	ld  l,e_ia_puntero_st_l(ix)
	ld  h,e_ia_puntero_st_h(ix)
	ld (_puntero_a_stado), hl


	_puntero_a_stado =.+1
	call  0000
	

	

	

	
_no_ia_ent:
_canon_muerto:
_ent_counter =.+1
	ld a , #0
	dec a
	ret z

	ld (_ent_counter),a
	ld de, #siceof_e
	add ix, de
	
	jr _loop
	






;;;;;;;;;;;;;;;;;;;;;
;;FUNCIONES
;;;;;;;;;;;;;;;;;;;;;;

;;
;;conp_shoot
;;
;;INPUT
;;ix PUNTERO DEL CANON ACTUAL
;;iy PUNTERO AL PRIMER CANON
_compr_shoot::


	


	call entityman_num_entities
	ld d , a			;;contador de canons
	
	

	_loop_shot:

	ld a, e_dead(iy)
	dec a
	jp z, _canon_muerto_sh

	ld e, #0			;;el comprobador de x lo porngo a 0

	
	;; comprobar colision en x
	ld b, e_x(ix) 		;; esquina izquierda ix
	ld a, e_ancho(ix)
	add b
	ld c, a			;; izquierda derecha ix
	
	ld a, e_x(iy)		;; esquina izquierda iy
	sub c

	jr nc, _no_colision_x
	;; segunda comprobacion
	ld a, e_x(iy)
	add e_ancho(iy)
	sub b

	jr c, _no_colision_x		
	_hay_colision_en_x:
	ld e, #1			;; si la x es igual el comprobador de la x lo pongo a 1

	_no_colision_x:			
	

	;;comprobar colisiones en y

	ld b, e_y(ix) 
	ld a ,e_alto(ix)	
	add b
	ld c ,a

	ld a, e_y(iy)
	sub c
	jr nc , _no_colision_y
	;;segunda comprobacion
	ld a, e_y(iy)
	add e_alto(iy)
	sub b
	
	jr c, _no_colision_y
	dec e				;; la y es igual , compruebo la x
	jr z, _equals
		;; solo es igual en y
		ld a, e_x(iy) 		
		sub e_x(ix)			;; hago una resta de las posiciones en x
		jr nc, _posicion_menor
		_posicion_mayo:		;;estamos a la derecha	
			ld a, e_dir(ix)		
			cp #e_dir_left		;; compruebo si tiene dispara a la izquierda
			jr z, _disparamos
			jr  _salir_shot
			_disparamos:

			
			

			
			
			push ix
			push bc
			push iy
			ld a, e_ia_st(iy)
			cp #e_ia_st_noIA
			jr nz, _es_ia
			_no_es_ia:
				call hacer_disparo2
			_es_ia:

				call get_gamemode
				cp #5
				jr z,_no_disparar_ia
				_disparamos_ia:
					call hacer_disparo2
				_no_disparar_ia:

			pop iy
			pop bc			
			pop ix
			
			
		jr   _salir_shot
		_posicion_menor:
			ld a, e_dir(ix)		
			cp #e_dir_right		;; compruebo si tiene dispara a la izquierda
			jr z, _disparamos
			jr   _salir_shot
			
	
		
	_no_colision_y:		;; solo es 
	dec e				;; comprobamos si es igual en x
	jr nz, _no_equals
	;; solo es igual  en x
	ld a, e_y(iy) 		
		sub e_y(ix)			;; hago una resta de las posiciones en x
		jr nc, _posicion_arriba
		_posicion_abajo:		;;estamos a la abajo	
			ld a, e_dir(ix)		
			cp #e_dir_top		;; compruebo si tiene dispara a la izquierda
			jr z, _disparamos
			
				

		jr   _salir_shot
		_posicion_arriba:
			ld a, e_dir(ix)		
			cp #e_dir_bott		;; compruebo si tiene dispara a la izquierda
			jr z, _disparamos
		
			
	
		


	_salir_shot:
	_no_equals:
	_equals:
	_canon_muerto_sh:

	ld a, d
	dec a
	ret z

	
	ld de, #siceof_e
	add iy, de
	ld d, a
	
	jp _loop_shot
ret


;;
;; STAND BY
;;
sys_ia_stand_by::

	

	ld hl, #sys_ai_patrol

	
	ld e_ia_puntero_st_l(ix) ,l
	ld e_ia_puntero_st_h(ix) ,h

	


	ret



;;
;;MOVE TO
;;
sys_is_move_to::
	ld b, #1			;; valor para comprobar si en x hemos llegado
	ld a, e_ia_x(ix)    ;;a = x_objetivo
	sub e_x(ix)         ;;A= OBJ_X -X
	jr nc, _obj_greater_or_equal_x ;; if( obj _x - x >0)



_objx_lesser_x:

	ld e_vx(ix), #0
	ld a,e_dir(ix)
	cp #e_dir_left
	jr nz, _no_mira_izquierda
		ld a, (_vel_x_ia_n) 	
		ld e_vx(ix), a	
	_no_mira_izquierda:

	jr _endif_x


_obj_greater_or_equal_x:
	jr z,_arrived_x
		ld e_vx(ix), #0
		ld a,e_dir(ix)
		cp #e_dir_right 
		jr nz, _no_mira_derecha
			ld a, (_vel_x_ia)
			ld e_vx(ix), a
		_no_mira_derecha:
	
	jr _endif_x
_arrived_x:
	ld e_vx(ix), #0
	ld b, #0
	

_endif_x:
	



	ld a, e_ia_y(ix)    ;;a = x_objetivo
	sub e_y(ix)         ;;A= OBJ_X -X
	jr nc, _obj_greater_or_equal_y ;; if( obj _x - x >0)



_objx_lesser_y:
		ld e_vy(ix), #0
		ld a,e_dir(ix)
		cp #e_dir_top
		jr nz, _no_mira_arriba
			ld a,(_vel_y_ia_n)
			ld e_vy(ix), a
	
	
	_no_mira_arriba:
	jr _endif_y


_obj_greater_or_equal_y:
	jr z,_arrived_y
		ld e_vy(ix), #0
		ld a,e_dir(ix)
		cp #e_dir_bott
		jr nz, _no_mira_abajo
		ld a,(_vel_y_ia)
		ld e_vy(ix), a
		_no_mira_abajo:

	
	jr _endif_y
_arrived_y:

	ld e_vy(ix), #0	
	
	or b
	jr nz, _endif_y
	;; x e y son las dos 0

	ld a , e_ia_st_prev(ix)				;; ponto en mi estado actual el anterior
	ld e_ia_st(ix), a
	ld e_ia_st_prev(ix), #e_ia_st_move_to	;; actualizo el estado 
	call actualizar_puntero

	



_endif_y:
ret



;;;;;;;;;;;;;
;;PATROL;;;;
;;;;;;;;;;;;

sys_ai_patrol::
	;; hl es el puntero al primer byte de la patrulla 
	ld h , e_ia_puntero_patrol_h(ix)
	ld l , e_ia_puntero_patrol_l(ix)


	;; cargar cordenadas x y
	ld a, (hl)
	cp #patrol_invalid_move_x	;; comprobar si es el final de la patrulla
	jr z, _reset_patrol					;; salimos 

	ld e_ia_x(ix), a
	inc hl
	ld a, (hl)
	ld e_ia_y(ix), a

	;; cambiar el puntero a la siguiente posicion
	inc hl
	ld e_ia_puntero_patrol_h (ix), h
	ld e_ia_puntero_patrol_l (ix), l

	;; cambio al estado move to
	ld e_ia_st_prev(ix), #e_ia_st_patron
	ld e_ia_st(ix), #e_ia_st_move_to

	ld hl, #sys_is_move_to
	

	ld e_ia_puntero_st_l(ix) ,l
	ld e_ia_puntero_st_h(ix) ,h

	ret

_reset_patrol:

	inc hl
	ld a , (hl)
	ld e_ia_puntero_patrol_l (ix), a
	inc hl
	ld a , (hl)
	ld e_ia_puntero_patrol_h (ix), a


	ret



actualizar_puntero:
	dec a
	jr z, _stan
	dec a
	jr z, _move_to	
	dec a
	jr z, _patron

_stan:
	ld hl, #sys_ia_stand_by
	jr _salir_actualizar


_move_to:

	ld hl, #sys_is_move_to	
	jr _salir_actualizar


_patron:
	ld hl, #sys_ai_patrol

_salir_actualizar:
	
	ld e_ia_puntero_st_l(ix) ,l
	ld e_ia_puntero_st_h(ix) ,h
	
	
	ret





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;funciones para cambiar los parametros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;INPUT A DIFICULTAD PARA LA IA
cambiar_dificultad_ia::
	cp #1
jr z,_nivel_1
	cp #2
jr z,_nivel_2
	cp #3
jr z,_nivel_3
	cp #4
jr z,_nivel_4


_nivel_1:
	ld a, #_dificultad_ia_nive1
	ld (_iteraciones_ia), a
	ret
_nivel_2:
	ld a, #_dificultad_ia_nive2
	ld (_iteraciones_ia), a
	ret

_nivel_3:
	ld a, #_dificultad_ia_nive3
	ld (_iteraciones_ia), a
	ret
_nivel_4:
	ld a, #_dificultad_ia_nive4
	ld (_iteraciones_ia), a


ret


;;INPUT A EL NIVEL DE VELOCIDAD PARA LA IA
cambiar_velocidad_ia::

	cp #1
jr z,_nivel_1_v
	cp #2
jr z,_nivel_2_v
	




_nivel_1_v:
	ld a, #_nivel_1x
	ld (_vel_x_ia), a
	ld a, #_nivel_1x_n
	ld (_vel_x_ia_n), a
	ld a, #_nivel_1y
	ld (_vel_y_ia), a
	ld a, #_nivel_1y_n
	ld (_vel_y_ia_n), a

	ret
_nivel_2_v:
	ld a, #_nivel_2x
	ld (_vel_x_ia), a
	ld a, #_nivel_2x_n
	ld (_vel_x_ia_n), a
	ld a, #_nivel_2y
	ld (_vel_y_ia), a
	ld a, #_nivel_2y_n
	ld (_vel_y_ia_n), a
	ret

