;;
;;entity Manager
;;


.globl plantman_getPlanta
.globl create_plant

;; Entity definition macro


.macro Plant _nombrePlanta,_x,_y,_sprite,_ancho,_alto,_livecont, _activa
_nombrePlanta::
.db _x      ;;posicion x del tanque
.db _y	;;posicion y del tanque
.dw _sprite
.db _ancho
.db _alto
.db _livecont  ;; contador cambio posicion
.db _activa

.endm 

p_x  	= 0
p_y  	= 1
p_sprite = 2
p_sprite2 = 3
p_ancho = 4
p_alto = 5
p_cont = 6
p_activa = 7
