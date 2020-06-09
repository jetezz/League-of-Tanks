;;
;;man entity ia h
;;


_max_function == 10 ;; numero maximo de funciones que podemos crear en la ia

.macro Define_ia_punteros_funciones _name,_N
name::
	.rept _N
Define_aninomous 0xFF, 0xFF
	.endm
.endm

.macro Define_aninomous _bl,_bh
.db _bl		;;byte bajo
.db _bh           ;;byte alto         


.endm

f_b_l=0
f_b_h=1
sice_of=2



.globl funcion_ia_init
.globl function_inc_puntero
.globl man_entity_get_funcion_array


	