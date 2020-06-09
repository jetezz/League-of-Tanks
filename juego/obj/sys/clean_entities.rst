ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Clean entities h
                              3 ;;
                              4 
                              5 ;; IX: puntero de la entidad que queremos limpiar
                              6 ;; A: NUMBER OF ENTITIES TO RENDER 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              7 .include "cpct_functions.h.s"
                              1 ;;
                              2 ;;CPCTELERA FUNCTION
                              3 ;;
                              4 
                              5 
                              6 .globl cpct_getScreenPtr_asm
                              7 .globl cpct_drawSolidBox_asm
                              8 .globl cpct_setDrawCharM0_asm 
                              9 .globl cpct_drawStringM0_asm
                             10 .globl cpct_disableFirmware_asm
                             11 .globl cpct_scanKeyboard_asm
                             12 .globl cpct_isKeyPressed_asm
                             13 .globl cpct_setVideoMode_asm
                             14 .globl cpct_drawSprite_asm
                             15 .globl cpct_setPalette_asm
                             16 .globl cpct_setVideoMemoryPage_asm
                             17 .globl cpct_waitVSYNC_asm
                             18 .globl cpct_zx7b_decrunch_s_asm
                             19 .globl cpct_etm_setDrawTilemap4x8_ag_asm
                             20 .globl cpct_etm_drawTilemap4x8_ag_asm	
                             21 .globl cpct_waitHalts_asm
                             22 
                             23 .globl cpct_akp_musicPlay_asm
                             24 .globl cpct_akp_musicInit_asm
                             25 .globl cpct_setInterruptHandler_asm
                             26 .globl cpct_getRandom_mxor_u8_asm
                             27 
                             28 
                             29 
                             30 
                             31 
                             32 
                             33 
                             34 .globl cpct_akp_SFXPlay_asm
                             35 .globl cpct_akp_SFXInit_asm
                             36 .globl cpct_akp_SFXStopAll_asm
                             37 .globl cpct_akp_stop_asm
                             38 
                             39 
                             40 
                             41 
                             42 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              8 .include "man/entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              9 .include "man/shot_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 
                             12 
   5467                      13 clean_entities_init::
   5467 CD 57 48      [17]   14  call entityman_getEntityVector_IX
   546A CD 5C 48      [17]   15  call entityman_num_entities
                             16 
                             17 
   546D 32 8A 54      [13]   18 ld (_contador_entidades),a
   5470 DD 22 8D 54   [20]   19 ld (_puntero_entidades), ix
                             20 
                             21 
   5474 CD 40 49      [17]   22  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   5477 CD 45 49      [17]   23  call entityman_num_Bales
   547A 22 BD 54      [16]   24  ld (_contador_balas), hl
   547D DD 22 BA 54   [20]   25  ld (_puntero_balas), ix
   5481 C9            [10]   26 ret
                             27 
                             28 
   5482                      29 clean_entities::
                             30   
                             31 
   5482 CD 89 54      [17]   32  call _clean_canon
   5485 CD B8 54      [17]   33  call _clean_balas	
   5488 C9            [10]   34 ret
                             35 
                             36 
                             37 
                             38 
                             39 
   5489                      40 _clean_canon:
                             41 
                     0023    42 _contador_entidades=.+1
   5489 3E 00         [ 7]   43 	ld a, #00
                     0026    44 _puntero_entidades=.+2
   548B DD 21 00 00   [14]   45 ld ix, #0000
   548F                      46 _cleanloop:
                             47 
   548F F5            [11]   48 push af  
                             49 	
                             50 	
   5490 DD 7E 0C      [19]   51    ld a ,e_dead(ix)
   5493 3D            [ 4]   52   dec a
   5494 28 17         [12]   53   jr z, _canon_muerto 
                             54 
   5496 CD AC 3F      [17]   55  call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
   5499 EB            [ 4]   56   ex de, hl
                             57  
   549A DD 4E 04      [19]   58   ld   c, e_xll(ix)  
   549D DD 46 05      [19]   59   ld   b, e_yll(ix)  
   54A0 CD 1B 78      [17]   60   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   54A3 EB            [ 4]   61    ex  de,hl
                             62  
                             63 
                             64   
   54A4 3E 00         [ 7]   65 ld  a, #0x00  ;;color
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   54A6 0E 04         [ 7]   66 ld  c, #4 	;;width
   54A8 06 10         [ 7]   67 ld  b, #16	;;height
   54AA CD 26 77      [17]   68 call cpct_drawSolidBox_asm
                             69 
   54AD                      70 _canon_muerto:
                             71 
   54AD F1            [10]   72 pop af 
                             73 
                             74 
   54AE 3D            [ 4]   75 dec a
   54AF C8            [11]   76 ret z
                             77 
   54B0 01 17 00      [10]   78 ld bc, #siceof_e ;;byte de cada entidad
   54B3 DD 09         [15]   79 add ix, bc
   54B5 20 D8         [12]   80 jr nz, _cleanloop
                             81 
                             82 
   54B7 C9            [10]   83 ret
                             84 
                             85 
                             86 
                             87 
                             88 
   54B8                      89 _clean_balas::
                             90 
                     0053    91  _puntero_balas=.+2
   54B8 DD 21 00 00   [14]   92  ld ix, #0000
                     0056    93  _contador_balas=.+1
   54BC 21 00 00      [10]   94  ld hl, #0000
   54BF 7E            [ 7]   95  ld a ,(hl)
   54C0 B7            [ 4]   96  or a 
   54C1 28 24         [12]   97  	jr z, _no_hay_balas
                             98 
                             99 	
   54C3                     100 	_cleanloop_balas:
   54C3 F5            [11]  101 	push af
                            102 	   
   54C4 CD AC 3F      [17]  103 	 call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
   54C7 EB            [ 4]  104 	  ex de, hl
                            105 	 
   54C8 DD 4E 04      [19]  106 	  ld   c, b_xll(ix)  
   54CB DD 46 05      [19]  107 	  ld   b, b_yll(ix)  
   54CE CD 1B 78      [17]  108 	  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   54D1 EB            [ 4]  109 	   ex  de,hl
                            110 	 
                            111 
                            112 	  
   54D2 3E 00         [ 7]  113 	ld  a, #0x00   ;; color
   54D4 DD 4E 0A      [19]  114 	ld  c, b_w(ix)	;; width
   54D7 DD 46 09      [19]  115 	ld  b, b_h(ix)	;; height ;;**
   54DA CD 26 77      [17]  116 	call cpct_drawSolidBox_asm
                            117 
                            118 
   54DD F1            [10]  119 	pop af 
                            120 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   54DE 3D            [ 4]  121 	dec a
   54DF C8            [11]  122 	ret z
                            123 
   54E0 01 0E 00      [10]  124 	ld bc, #siceof_b ;;byte de cada BALA
   54E3 DD 09         [15]  125 	add ix, bc
   54E5 20 DC         [12]  126 	jr nz, _cleanloop_balas
   54E7                     127 _no_hay_balas:
                            128 
   54E7 C9            [10]  129 ret  
                            130 
                            131 
                            132 
                            133 
   54E8                     134 limpiar_ultimo::
                            135 
                            136 
                            137  ;;call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
                            138   ;;ex de, hl
   54E8 11 00 C0      [10]  139   ld de ,#0xc000
   54EB FD 4E 00      [19]  140   ld   c, e_x(iy)  
   54EE FD 46 01      [19]  141   ld   b, e_y(iy)  
   54F1 CD 1B 78      [17]  142   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   54F4 EB            [ 4]  143   ex  de,hl  
   54F5 3E 00         [ 7]  144  ld  a, #0x00  ;;color
   54F7 0E 04         [ 7]  145  ld  c, #4 	;;width
   54F9 06 10         [ 7]  146  ld  b, #16	;;height
   54FB CD 26 77      [17]  147  call cpct_drawSolidBox_asm
                            148 
                            149 
                            150 
   54FE 11 00 80      [10]  151  ld de ,#0x8000
   5501 FD 4E 00      [19]  152  ld   c, e_x(iy)  
   5504 FD 46 01      [19]  153  ld   b, e_y(iy)  
   5507 CD 1B 78      [17]  154  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   550A EB            [ 4]  155  ex  de,hl  
   550B 3E 00         [ 7]  156  ld  a, #0x00  ;;color
   550D 0E 04         [ 7]  157  ld  c, #4 	;;width
   550F 06 10         [ 7]  158  ld  b, #16	;;height
   5511 CD 26 77      [17]  159  call cpct_drawSolidBox_asm
                            160 
   5514 11 00 C0      [10]  161    ld de ,#0xc000
   5517 FD 4E 02      [19]  162   ld   c, e_xl(iy)  
   551A FD 46 03      [19]  163   ld   b, e_yl(iy)  
   551D CD 1B 78      [17]  164   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   5520 EB            [ 4]  165   ex  de,hl  
   5521 3E 00         [ 7]  166  ld  a, #0x00  ;;color
   5523 0E 04         [ 7]  167  ld  c, #4 	;;width
   5525 06 10         [ 7]  168  ld  b, #16	;;height
   5527 CD 26 77      [17]  169  call cpct_drawSolidBox_asm
                            170 
                            171 
                            172 
   552A 11 00 80      [10]  173  ld de ,#0x8000
   552D FD 4E 02      [19]  174  ld   c, e_xl(iy)  
   5530 FD 46 03      [19]  175  ld   b, e_yl(iy)  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   5533 CD 1B 78      [17]  176  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   5536 EB            [ 4]  177  ex  de,hl  
   5537 3E 00         [ 7]  178  ld  a, #0x00  ;;color
   5539 0E 04         [ 7]  179  ld  c, #4 	;;width
   553B 06 10         [ 7]  180  ld  b, #16	;;height
   553D CD 26 77      [17]  181  call cpct_drawSolidBox_asm
                            182 
   5540 11 00 C0      [10]  183    ld de ,#0xc000
   5543 FD 4E 04      [19]  184   ld   c, e_xll(iy)  
   5546 FD 46 05      [19]  185   ld   b, e_yll(iy)  
   5549 CD 1B 78      [17]  186   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   554C EB            [ 4]  187   ex  de,hl  
   554D 3E 00         [ 7]  188  ld  a, #0x00  ;;color
   554F 0E 04         [ 7]  189  ld  c, #4 	;;width
   5551 06 10         [ 7]  190  ld  b, #16	;;height
   5553 CD 26 77      [17]  191  call cpct_drawSolidBox_asm
                            192 
                            193 
                            194 
   5556 11 00 80      [10]  195  ld de ,#0x8000
   5559 FD 4E 04      [19]  196  ld   c, e_xll(iy)  
   555C FD 46 05      [19]  197  ld   b, e_yll(iy)  
   555F CD 1B 78      [17]  198  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   5562 EB            [ 4]  199  ex  de,hl  
   5563 3E 00         [ 7]  200  ld  a, #0x00  ;;color
   5565 0E 04         [ 7]  201  ld  c, #4 	;;width
   5567 06 10         [ 7]  202  ld  b, #16	;;height
   5569 CD 26 77      [17]  203  call cpct_drawSolidBox_asm
                            204 
   556C C9            [10]  205 ret
                            206 
                            207 
   556D                     208 limpiar_ultima::
                            209 
                            210 
                            211  ;;call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
                            212   ;;ex de, hl
                            213  
                            214 
   556D 11 00 C0      [10]  215 	 ld de ,#0xc000
                            216 
   5570 DD 4E 02      [19]  217  	ld   c, b_xl(ix)  
   5573 DD 46 03      [19]  218 	ld   b, b_yl(ix)  
                            219 
   5576 CD 1B 78      [17]  220 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   5579 EB            [ 4]  221 	 ex  de,hl	
   557A 3E 00         [ 7]  222 	ld  a, #0x00   ;; color
   557C DD 4E 0A      [19]  223 	ld  c, b_w(ix)	;; width
   557F DD 46 09      [19]  224 	ld  b, b_h(ix)	;; height ;;**
   5582 CD 26 77      [17]  225 	call cpct_drawSolidBox_asm
                            226 
   5585 11 00 80      [10]  227   ld de ,#0x8000
   5588 DD 4E 02      [19]  228 	ld   c, b_xl(ix)  
   558B DD 46 03      [19]  229 	ld   b, b_yl(ix)  
   558E CD 1B 78      [17]  230 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   5591 EB            [ 4]  231 	 ex  de,hl	
   5592 3E 00         [ 7]  232 	ld  a, #0x00   ;; color
   5594 DD 4E 0A      [19]  233 	ld  c, b_w(ix)	;; width
   5597 DD 46 09      [19]  234 	ld  b, b_h(ix)	;; height ;;**
   559A CD 26 77      [17]  235 	call cpct_drawSolidBox_asm
                            236 
                            237 	 
                            238 
   559D 11 00 C0      [10]  239 	  ld de ,#0xc000
                            240 
   55A0 DD 4E 04      [19]  241  	ld   c, b_xll(ix)  
   55A3 DD 46 05      [19]  242 	ld   b, b_yll(ix)  
   55A6 CD 1B 78      [17]  243 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   55A9 EB            [ 4]  244 	 ex  de,hl	
   55AA 3E 00         [ 7]  245 	ld  a, #0x00   ;; color
   55AC DD 4E 0A      [19]  246 	ld  c, b_w(ix)	;; width
   55AF DD 46 09      [19]  247 	ld  b, b_h(ix)	;; height ;;**
   55B2 CD 26 77      [17]  248 	call cpct_drawSolidBox_asm
                            249 
   55B5 11 00 80      [10]  250   ld de ,#0x8000
   55B8 DD 4E 04      [19]  251 	ld   c, b_xll(ix)  
   55BB DD 46 05      [19]  252 	ld   b, b_yll(ix)  
   55BE CD 1B 78      [17]  253 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   55C1 EB            [ 4]  254 	 ex  de,hl	
   55C2 3E 00         [ 7]  255 	ld  a, #0x00   ;; color
   55C4 DD 4E 0A      [19]  256 	ld  c, b_w(ix)	;; width
   55C7 DD 46 09      [19]  257 	ld  b, b_h(ix)	;; height ;;**
   55CA CD 26 77      [17]  258 	call cpct_drawSolidBox_asm
                            259 
   55CD 11 00 C0      [10]  260 	 ld de ,#0xc000
                            261 
                            262  	
                            263 
   55D0 C9            [10]  264 ret
                            265 
                            266 
