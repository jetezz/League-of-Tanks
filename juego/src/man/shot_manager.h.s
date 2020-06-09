;;
;;shot manager h
;;

;; MACROS

.macro DefineBalesArray _nameb,_N
_nameb::
	.rept _N
DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
	.endm 
.endm

.macro DefineBalesAnnonimous _bx,_by,_bxl,_byl,_bxll,_byll,_bvx,_bvy,_bsta,_bwidth,_bheight,_bcolor
.db _bx           ;; posicion de la bala x          
.db _by		;; posicion de la bala y
.db _bxl		;; posicion anterior x
.db _byl		;; posicion anterior y
.db _bxll		;; posicion 2 veces anterior x
.db _byll		;; posicion 2 veces anterior y
.db _bvx 		;; velocidad bala en x
.db _bvy		;; belocidad bala en y
.db _bsta		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
.db _bwidth       ;; anchura de la bala
.db _bheight      ;; altura de la bala
.db _bcolor       ;; color de la bala
.db 0x00 ,0x00    ;; posicion de memoria del canon
 
.endm

;; CONSTANTES QUE REFERENCIAN LOS ATRIBUTOS DE LAS BALAS (USADOS POR LOS REGISTROS IX E IY, RESPECTIVAMENTE)

b_x       = 0
b_y       = 1
b_xl      = 2
b_yl      = 3
b_xll     = 4
b_yll     = 5
b_vx      = 6      ;; velocidad bala eje x
b_vy      = 7      ;; velocidad bala eje y
b_sta     = 8      ;; estado de la bala
b_h       = 9      ;; altura de la bala
b_w       = 10     ;; anchura de la bala
b_color   = 11     ;; color de la bala (sustituible por puntero a sprite)
b_canon_l = 12     ;; posicion de memoria del canon en l
b_canon_h = 13	 ;; posicion de memoria del canon en h
siceof_b  = 14


;; GLOBAL FUNCTIONS


.globl entityman_getArray_Bales
.globl entityman_num_Bales


;; CONSTANTES:

;; Numero maximo de balas

max_bales == 5

;; Posicionar centralmente la bala con respecto al sprite

b_inc_pos_x = 2
b_inc_pos_y = 6

;; DIMENSIONES POSIBLES DE LA BALA

;; Cuando va en horizontal

b_width      = 2   ;; anchura de la bala
b_height     = 8   ;; altura de la bala

;; Cuando va en vertical





;; Color por defecto de la bala

reset_bullet_color = 0xC0   ;; Color negro

;; Velocidades posibles de la bala

pos_vel_h = 1
neg_vel_h = -1
pos_vel_v = 4
neg_vel_v = -4
sin_vel = 0

;; Estados de la bala

b_no_shoot  = 0    ;; bala no disparada (estado por defecto)
b_shoot     = 1    ;; bala disparada
