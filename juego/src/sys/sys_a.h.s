;;
;;sys a h
;;

.globl animar
.globl iniciar_animacion_bala
.globl iniciar_animacion_canon
.globl limpiar_animaciones












.macro BalaAni _name2,_x,_y,_con,_w,_h
_name2::
.db _x
.db _y
.db _con
.dw 0000
.db 00
.db _w
.db _h
.endm



.macro CanonAni _name3,_x,_y,_con,_w,_h
_name3::
.db _x
.db _y
.db _con
.dw 0000
.db 00
.db _w
.db _h
.endm


a_x  		= 0
a_y  		= 1
a_con  	= 2
a_punt_l	= 3
a_punt_h	= 4
a_ani		= 5
a_w		= 6
a_h		= 7
siceof_ae	= 8

duracion_animacion=5
maximo_balas_animacion=8
maximo_canon_animacion=4