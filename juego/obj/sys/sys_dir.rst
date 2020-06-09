ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_dir
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "man/entity_manager.h.s"
                              1 ;;
                              2 ;;entity Manager
                              3 ;;
                              4 
                              5 
                              6 
                              7 .globl create_entities
                              8 .globl entityman_getEntityVector_IX
                              9 .globl entityman_num_entities
                             10 .globl _num_entities
                             11 .globl init_entities
                             12 
                             13 
                             14 ;; Entity definition macro
                             15 
                             16 
                             17 .macro Entity _name,_x,_y,_xl,_yl,_xll,_yll,_vx,_vy,_sh,_iast,_dir,_dead,_ancho,_alto
                             18 _name::
                             19 .db _x      ;;posicion x del tanque
                             20 .db _y	;;posicion y del tanque
                             21 .db _xl	;;posicion de la x anterior
                             22 .db _yl	;;posicion de la y anterior
                             23 .db _xll	;;posicion de la x 2 veces anterior
                             24 .db _yll	;;posicion de la x 2 veces anterior
                             25 .db _vx	;;velocidad en x
                             26 .db _vy	;;velocidad en y
                             27 .db _sh	;;shot 0 no 1 si
                             28 .db _iast;;type 0 jugador por teclas ,1 enemigo ia
                             29 .db _dir    ;;movimiento  
                             30 .db _sh     ;; si no dispara es 0 si dispara es 1
                             31 .db _dead;;canon 0 vivo 1 muere
                             32 .db 0x00, 0x00    ;;iax ia y
                             33 .db _iast  ;;Estado anterior de la ia 
                             34 .dw 0x0000	;; puntero de la patrulla que voy a realizar
                             35 .dw 0x0000 ;;puntero al estado que tengo que saltar
                             36 .db _ancho
                             37 .db _alto
                             38 .db 25  ;; contador cambio direcion del sprite
                             39 
                             40 
                             41 
                             42 
                             43 
                             44 
                             45 .endm 
                             46 
                             47 
                             48 .macro NextEntity
                             49 ld de, #siceof_e
                             50 	add ix, de
                             51 .endm
                             52 	
                             53 
                     0000    54 e_x  	= 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0001    55 e_y  	= 1
                     0002    56 e_xl  = 2
                     0003    57 e_yl  = 3
                     0004    58 e_xll = 4
                     0005    59 e_yll = 5
                     0006    60 e_vx	= 6
                     0007    61 e_vy	= 7
                     0008    62 e_sh 	= 8
                     0009    63 e_ia_st = 9
                     000A    64 e_dir = 10
                     000B    65 e_sh = 11
                     000C    66 e_dead=12
                     000D    67 e_ia_x= 13
                     000E    68 e_ia_y= 14
                     000F    69 e_ia_st_prev=15
                     0010    70 e_ia_puntero_patrol_h=16
                     0011    71 e_ia_puntero_patrol_l=17
                     0012    72 e_ia_puntero_st_h=18
                     0013    73 e_ia_puntero_st_l=19
                     0014    74 e_ancho 	= 20
                     0015    75 e_alto	= 21
                     0016    76 e_clock     = 22
                     0017    77 siceof_e 	= 23
                             78 
                             79 ;; Movimiento de la entidad
                     0003    80 e_dir_right = 3
                     0002    81 e_dir_top   = 2
                     0001    82 e_dir_left  = 1
                     0004    83 e_dir_bott  = 4
                             84 
                             85 ;; Dibujo que representa el movimiento de la entidad
                             86 
                             87  ;;      2
                             88  ;;     1e3
                             89  ;;      4
                             90 
                             91 
                             92 ;;Estados ia
                     0000    93 e_ia_st_noIA 	= 0
                     0001    94 e_ia_st_stand_by	= 1
                     0002    95 e_ia_st_move_to   = 2
                     0003    96 e_ia_st_patron	= 3
                             97 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "sys_dir.h.s"
                              1 ;;
                              2 ;;sys dir h
                              3 ;;
                              4 
                              5 
                              6 .globl modificar_sprite
                              7 
                              8 
                     0019     9 _contador_ciclos = 25
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 
   58E7                       8 modificar_sprite::
                              9 
                             10 
   58E7 DD 7E 09      [19]   11 ld a, e_ia_st(ix)
                             12 
   58EA FE 00         [ 7]   13   cp #e_ia_st_noIA
                             14 
   58EC 28 0A         [12]   15   jr z, sin_ia
                             16 
   58EE                      17   con_ia:
   58EE DD 46 16      [19]   18   ld b, e_clock(ix)
   58F1 05            [ 4]   19   dec b
   58F2 28 1A         [12]   20   jr z, _actualizo_dir
   58F4 DD 70 16      [19]   21   ld e_clock(ix),b
   58F7 C9            [10]   22   ret
   58F8                      23   sin_ia:
                             24 
   58F8 DD 46 16      [19]   25 ld b, e_clock(ix)
                             26 
   58FB DD 7E 06      [19]   27  ld a, e_vx(ix)
   58FE B7            [ 4]   28  or a
   58FF 20 20         [12]   29  jr nz, _salir
   5901 DD 7E 07      [19]   30   ld a, e_vy(ix)
   5904 B7            [ 4]   31   or a
   5905 20 1A         [12]   32   jr nz, _salir
   5907 05            [ 4]   33  dec b
   5908 28 04         [12]   34   jr z, _actualizo_dir
   590A                      35   _actualizo_clock:
   590A DD 70 16      [19]   36   ld e_clock(ix),b
   590D C9            [10]   37   ret
                             38 
   590E                      39 _actualizo_dir:
   590E DD 36 16 19   [19]   40   ld e_clock(ix), #_contador_ciclos
   5912 DD 7E 0A      [19]   41   ld a, e_dir(ix)
   5915 3D            [ 4]   42   dec a
   5916 28 04         [12]   43   jr z, _reinicio_dir
   5918                      44   _decremento_dir:
   5918 DD 77 0A      [19]   45 ld e_dir(ix), a
   591B C9            [10]   46   ret
                             47 
                             48 
   591C                      49  _reinicio_dir:
   591C DD 36 0A 04   [19]   50 ld e_dir(ix), #4
   5920 C9            [10]   51   ret
                             52 
                             53 
   5921                      54 _salir:
   5921 DD 36 16 01   [19]   55 	ld e_clock(ix),#1
   5925 C9            [10]   56 ret
