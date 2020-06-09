;;
;;entity Manager
;;



.globl create_entities
.globl entityman_getEntityVector_IX
.globl entityman_num_entities
.globl _num_entities
.globl init_entities


;; Entity definition macro


.macro Entity _name,_x,_y,_xl,_yl,_xll,_yll,_vx,_vy,_sh,_iast,_dir,_dead,_ancho,_alto
_name::
.db _x      ;;posicion x del tanque
.db _y	;;posicion y del tanque
.db _xl	;;posicion de la x anterior
.db _yl	;;posicion de la y anterior
.db _xll	;;posicion de la x 2 veces anterior
.db _yll	;;posicion de la x 2 veces anterior
.db _vx	;;velocidad en x
.db _vy	;;velocidad en y
.db _sh	;;shot 0 no 1 si
.db _iast;;type 0 jugador por teclas ,1 enemigo ia
.db _dir    ;;movimiento  
.db _sh     ;; si no dispara es 0 si dispara es 1
.db _dead;;canon 0 vivo 1 muere
.db 0x00, 0x00    ;;iax ia y
.db _iast  ;;Estado anterior de la ia 
.dw 0x0000	;; puntero de la patrulla que voy a realizar
.dw 0x0000 ;;puntero al estado que tengo que saltar
.db _ancho
.db _alto
.db 25  ;; contador cambio direcion del sprite






.endm 


.macro NextEntity
ld de, #siceof_e
	add ix, de
.endm
	

e_x  	= 0
e_y  	= 1
e_xl  = 2
e_yl  = 3
e_xll = 4
e_yll = 5
e_vx	= 6
e_vy	= 7
e_sh 	= 8
e_ia_st = 9
e_dir = 10
e_sh = 11
e_dead=12
e_ia_x= 13
e_ia_y= 14
e_ia_st_prev=15
e_ia_puntero_patrol_h=16
e_ia_puntero_patrol_l=17
e_ia_puntero_st_h=18
e_ia_puntero_st_l=19
e_ancho 	= 20
e_alto	= 21
e_clock     = 22
siceof_e 	= 23

;; Movimiento de la entidad
e_dir_right = 3
e_dir_top   = 2
e_dir_left  = 1
e_dir_bott  = 4

;; Dibujo que representa el movimiento de la entidad

 ;;      2
 ;;     1e3
 ;;      4


;;Estados ia
e_ia_st_noIA 	= 0
e_ia_st_stand_by	= 1
e_ia_st_move_to   = 2
e_ia_st_patron	= 3

