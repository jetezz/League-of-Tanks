ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; shot manager
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "shot_manager.h.s"
                              1 ;;
                              2 ;;shot manager h
                              3 ;;
                              4 
                              5 ;; MACROS
                              6 
                              7 .macro DefineBalesArray _nameb,_N
                              8 _nameb::
                              9 	.rept _N
                             10 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
                             11 	.endm 
                             12 .endm
                             13 
                             14 .macro DefineBalesAnnonimous _bx,_by,_bxl,_byl,_bxll,_byll,_bvx,_bvy,_bsta,_bwidth,_bheight,_bcolor
                             15 .db _bx           ;; posicion de la bala x          
                             16 .db _by		;; posicion de la bala y
                             17 .db _bxl		;; posicion anterior x
                             18 .db _byl		;; posicion anterior y
                             19 .db _bxll		;; posicion 2 veces anterior x
                             20 .db _byll		;; posicion 2 veces anterior y
                             21 .db _bvx 		;; velocidad bala en x
                             22 .db _bvy		;; belocidad bala en y
                             23 .db _bsta		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
                             24 .db _bwidth       ;; anchura de la bala
                             25 .db _bheight      ;; altura de la bala
                             26 .db _bcolor       ;; color de la bala
                             27 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             28  
                             29 .endm
                             30 
                             31 ;; CONSTANTES QUE REFERENCIAN LOS ATRIBUTOS DE LAS BALAS (USADOS POR LOS REGISTROS IX E IY, RESPECTIVAMENTE)
                             32 
                     0000    33 b_x       = 0
                     0001    34 b_y       = 1
                     0002    35 b_xl      = 2
                     0003    36 b_yl      = 3
                     0004    37 b_xll     = 4
                     0005    38 b_yll     = 5
                     0006    39 b_vx      = 6      ;; velocidad bala eje x
                     0007    40 b_vy      = 7      ;; velocidad bala eje y
                     0008    41 b_sta     = 8      ;; estado de la bala
                     0009    42 b_h       = 9      ;; altura de la bala
                     000A    43 b_w       = 10     ;; anchura de la bala
                     000B    44 b_color   = 11     ;; color de la bala (sustituible por puntero a sprite)
                     000C    45 b_canon_l = 12     ;; posicion de memoria del canon en l
                     000D    46 b_canon_h = 13	 ;; posicion de memoria del canon en h
                     000E    47 siceof_b  = 14
                             48 
                             49 
                             50 ;; GLOBAL FUNCTIONS
                             51 
                             52 
                             53 .globl entityman_getArray_Bales
                             54 .globl entityman_num_Bales
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 
                             56 
                             57 ;; CONSTANTES:
                             58 
                             59 ;; Numero maximo de balas
                             60 
                     0005    61 max_bales == 5
                             62 
                             63 ;; Posicionar centralmente la bala con respecto al sprite
                             64 
                     0002    65 b_inc_pos_x = 2
                     0006    66 b_inc_pos_y = 6
                             67 
                             68 ;; DIMENSIONES POSIBLES DE LA BALA
                             69 
                             70 ;; Cuando va en horizontal
                             71 
                     0002    72 b_width      = 2   ;; anchura de la bala
                     0008    73 b_height     = 8   ;; altura de la bala
                             74 
                             75 ;; Cuando va en vertical
                             76 
                             77 
                             78 
                             79 
                             80 
                             81 ;; Color por defecto de la bala
                             82 
                     00C0    83 reset_bullet_color = 0xC0   ;; Color negro
                             84 
                             85 ;; Velocidades posibles de la bala
                             86 
                     0001    87 pos_vel_h = 1
                     FFFFFFFF    88 neg_vel_h = -1
                     0004    89 pos_vel_v = 4
                     FFFFFFFC    90 neg_vel_v = -4
                     0000    91 sin_vel = 0
                             92 
                             93 ;; Estados de la bala
                             94 
                     0000    95 b_no_shoot  = 0    ;; bala no disparada (estado por defecto)
                     0001    96 b_shoot     = 1    ;; bala disparada
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 
                              8 
   48F8 00                    9 _num_bales:: .db #0  ;; ESTABLECEMOS UN CONTADOR PARA LAS BALAS QUE SE VAYAN CREANDO EN EL JUEGO (INICIALIZADO A 0, AL INICIO DEL MISMO)
                             10 
                             11 ;; FUNCION INIT, UTILIZADA PARA INICIALIZAR LAS BALAS QUE SE PRODUCIRAN EN EL JUEGO. ACTUALMENTE, SOLO RESERVARA EL ESPACIO PARA EL ARRAY DE BALAS DE LA ESCENA
                             12 
   48F9                      13 create_bullets_array::
                             14 
                             15   ;; RESERVAMOS MEMORIA PARA EL TOTAL DE BALAS
                             16    
   48F9                      17   DefineBalesArray bales_array, (max_bales)
   0001                       1 bales_array::
                              2 	.rept (max_bales)
                              3 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
                              4 	.endm 
   0001                       1 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
   48F9 FF                    1 .db -1           ;; posicion de la bala x          
   48FA 00                    2 .db 00		;; posicion de la bala y
   48FB 00                    3 .db 00		;; posicion anterior x
   48FC 00                    4 .db 00		;; posicion anterior y
   48FD 00                    5 .db 00		;; posicion 2 veces anterior x
   48FE 00                    6 .db 00		;; posicion 2 veces anterior y
   48FF 00                    7 .db 00 		;; velocidad bala en x
   4900 00                    8 .db 00		;; belocidad bala en y
   4901 00                    9 .db 00		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
   4902 00                   10 .db 00       ;; anchura de la bala
   4903 00                   11 .db 00      ;; altura de la bala
   4904 00                   12 .db 0x00       ;; color de la bala
   4905 00 00                13 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             14  
   000F                       1 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
   4907 FF                    1 .db -1           ;; posicion de la bala x          
   4908 00                    2 .db 00		;; posicion de la bala y
   4909 00                    3 .db 00		;; posicion anterior x
   490A 00                    4 .db 00		;; posicion anterior y
   490B 00                    5 .db 00		;; posicion 2 veces anterior x
   490C 00                    6 .db 00		;; posicion 2 veces anterior y
   490D 00                    7 .db 00 		;; velocidad bala en x
   490E 00                    8 .db 00		;; belocidad bala en y
   490F 00                    9 .db 00		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
   4910 00                   10 .db 00       ;; anchura de la bala
   4911 00                   11 .db 00      ;; altura de la bala
   4912 00                   12 .db 0x00       ;; color de la bala
   4913 00 00                13 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             14  
   001D                       1 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
   4915 FF                    1 .db -1           ;; posicion de la bala x          
   4916 00                    2 .db 00		;; posicion de la bala y
   4917 00                    3 .db 00		;; posicion anterior x
   4918 00                    4 .db 00		;; posicion anterior y
   4919 00                    5 .db 00		;; posicion 2 veces anterior x
   491A 00                    6 .db 00		;; posicion 2 veces anterior y
   491B 00                    7 .db 00 		;; velocidad bala en x
   491C 00                    8 .db 00		;; belocidad bala en y
   491D 00                    9 .db 00		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   491E 00                   10 .db 00       ;; anchura de la bala
   491F 00                   11 .db 00      ;; altura de la bala
   4920 00                   12 .db 0x00       ;; color de la bala
   4921 00 00                13 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             14  
   002B                       1 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
   4923 FF                    1 .db -1           ;; posicion de la bala x          
   4924 00                    2 .db 00		;; posicion de la bala y
   4925 00                    3 .db 00		;; posicion anterior x
   4926 00                    4 .db 00		;; posicion anterior y
   4927 00                    5 .db 00		;; posicion 2 veces anterior x
   4928 00                    6 .db 00		;; posicion 2 veces anterior y
   4929 00                    7 .db 00 		;; velocidad bala en x
   492A 00                    8 .db 00		;; belocidad bala en y
   492B 00                    9 .db 00		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
   492C 00                   10 .db 00       ;; anchura de la bala
   492D 00                   11 .db 00      ;; altura de la bala
   492E 00                   12 .db 0x00       ;; color de la bala
   492F 00 00                13 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             14  
   0039                       1 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
   4931 FF                    1 .db -1           ;; posicion de la bala x          
   4932 00                    2 .db 00		;; posicion de la bala y
   4933 00                    3 .db 00		;; posicion anterior x
   4934 00                    4 .db 00		;; posicion anterior y
   4935 00                    5 .db 00		;; posicion 2 veces anterior x
   4936 00                    6 .db 00		;; posicion 2 veces anterior y
   4937 00                    7 .db 00 		;; velocidad bala en x
   4938 00                    8 .db 00		;; belocidad bala en y
   4939 00                    9 .db 00		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
   493A 00                   10 .db 00       ;; anchura de la bala
   493B 00                   11 .db 00      ;; altura de la bala
   493C 00                   12 .db 0x00       ;; color de la bala
   493D 00 00                13 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             14  
                             18 
   493F C9            [10]   19   ret
                             20 
                             21 
   4940                      22 entityman_getArray_Bales::   ;; madar el puntero al primer byte del array de balas
   4940 DD 21 F9 48   [14]   23 ld ix, #bales_array
   4944 C9            [10]   24   ret
                             25 
   4945                      26 entityman_num_Bales::        ;; mandar el puntero al numero de balas que hay 
   4945 21 F8 48      [10]   27  ld hl, #_num_bales
   4948 C9            [10]   28  ret  
