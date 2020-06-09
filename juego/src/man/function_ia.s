;;
;;man entity ia
;;

.include "function_ia.h.s"
.include "../sys/ia_control_sys.h.s"

_num_functions: .db #0
_punt_ultima_funcion: .dw 0x0000 

create_function_array::

Define_ia_punteros_funciones punt_ia, (_max_function)


funcion_ia_init:: ;; limpiar todas las posiciones del array de funciones

	ld hl , #create_function_array
	ld de, #create_function_array
	inc de
	ld (hl), #00
	ld bc,  #20  ;; limpio los 20 bytes que tiene el array de funciones
	ldir







	


	ret


;; recibe en hl el puntero a la funcion que queremos añadir 
function_inc_puntero::
	ld ix, (_punt_ultima_funcion)  ;; me guardo la posicion del ultimo puntero en el array en ix
	ld f_b_l(ix),l			;; me guardo la posicion que nos pasan en hl
	ld f_b_h(ix),h
	ld bc, #sice_of
	add ix, bc
	ld (_punt_ultima_funcion), ix
	ret





man_entity_get_funcion_array:: ;;devuelvo el puntero a las funciones en hl
	ld hl, #create_function_array
	ret