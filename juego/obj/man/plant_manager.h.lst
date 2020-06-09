ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;entity Manager
                              3 ;;
                              4 
                              5 
                              6 .globl plantman_getPlanta
                              7 .globl create_plant
                              8 
                              9 ;; Entity definition macro
                             10 
                             11 
                             12 .macro Plant _nombrePlanta,_x,_y,_sprite,_ancho,_alto,_livecont, _activa
                             13 _nombrePlanta::
                             14 .db _x      ;;posicion x del tanque
                             15 .db _y	;;posicion y del tanque
                             16 .dw _sprite
                             17 .db _ancho
                             18 .db _alto
                             19 .db _livecont  ;; contador cambio posicion
                             20 .db _activa
                             21 
                             22 .endm 
                             23 
                     0000    24 p_x  	= 0
                     0001    25 p_y  	= 1
                     0002    26 p_sprite = 2
                     0003    27 p_sprite2 = 3
                     0004    28 p_ancho = 4
                     0005    29 p_alto = 5
                     0006    30 p_cont = 6
                     0007    31 p_activa = 7
