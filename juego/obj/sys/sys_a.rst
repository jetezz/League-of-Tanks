ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys a
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "man/entity_manager.h.s"
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



                              5 .include "cpct_functions.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 .include "man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 .include "man/shot_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              8 .include "sys/sys_a.h.s"
                              1 ;;
                              2 ;;sys a h
                              3 ;;
                              4 
                              5 .globl animar
                              6 .globl iniciar_animacion_bala
                              7 .globl iniciar_animacion_canon
                              8 .globl limpiar_animaciones
                              9 
                             10 
                             11 
                             12 
                             13 
                             14 
                             15 
                             16 
                             17 
                             18 
                             19 
                             20 
                             21 .macro BalaAni _name2,_x,_y,_con,_w,_h
                             22 _name2::
                             23 .db _x
                             24 .db _y
                             25 .db _con
                             26 .dw 0000
                             27 .db 00
                             28 .db _w
                             29 .db _h
                             30 .endm
                             31 
                             32 
                             33 
                             34 .macro CanonAni _name3,_x,_y,_con,_w,_h
                             35 _name3::
                             36 .db _x
                             37 .db _y
                             38 .db _con
                             39 .dw 0000
                             40 .db 00
                             41 .db _w
                             42 .db _h
                             43 .endm
                             44 
                             45 
                     0000    46 a_x  		= 0
                     0001    47 a_y  		= 1
                     0002    48 a_con  	= 2
                     0003    49 a_punt_l	= 3
                     0004    50 a_punt_h	= 4
                     0005    51 a_ani		= 5
                     0006    52 a_w		= 6
                     0007    53 a_h		= 7
                     0008    54 siceof_ae	= 8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                              9 
                             10 
                             11 
                             12 .globl _balaExpl_sp_0
                             13 .globl _balaExpl_sp_1
                             14 .globl _balaExpl_sp_2
                             15 .globl _balaExpl_sp_3
                             16 
                             17 .globl _canonExpl_0
                             18 .globl _canonExpl_1
                             19 .globl _canonExpl_2
                             20 .globl _canonExpl_3
                             21 
                             22 
   4E39                      23 BalaAni anib1 00,00,00,02,08
   0000                       1 anib1::
   4E39 00                    2 .db 00
   4E3A 00                    3 .db 00
   4E3B 00                    4 .db 00
   4E3C 00 00                 5 .dw 0000
   4E3E 00                    6 .db 00
   4E3F 02                    7 .db 02
   4E40 08                    8 .db 08
   4E41                      24 BalaAni anib2 00,00,00,02,08
   0008                       1 anib2::
   4E41 00                    2 .db 00
   4E42 00                    3 .db 00
   4E43 00                    4 .db 00
   4E44 00 00                 5 .dw 0000
   4E46 00                    6 .db 00
   4E47 02                    7 .db 02
   4E48 08                    8 .db 08
   4E49                      25 BalaAni anib3 00,00,00,02,08
   0010                       1 anib3::
   4E49 00                    2 .db 00
   4E4A 00                    3 .db 00
   4E4B 00                    4 .db 00
   4E4C 00 00                 5 .dw 0000
   4E4E 00                    6 .db 00
   4E4F 02                    7 .db 02
   4E50 08                    8 .db 08
   4E51                      26 BalaAni anib4 00,00,00,02,08
   0018                       1 anib4::
   4E51 00                    2 .db 00
   4E52 00                    3 .db 00
   4E53 00                    4 .db 00
   4E54 00 00                 5 .dw 0000
   4E56 00                    6 .db 00
   4E57 02                    7 .db 02
   4E58 08                    8 .db 08
   4E59                      27 BalaAni anib5 00,00,00,02,08
   0020                       1 anib5::
   4E59 00                    2 .db 00
   4E5A 00                    3 .db 00
   4E5B 00                    4 .db 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4E5C 00 00                 5 .dw 0000
   4E5E 00                    6 .db 00
   4E5F 02                    7 .db 02
   4E60 08                    8 .db 08
   4E61                      28 BalaAni anib6 00,00,00,02,08
   0028                       1 anib6::
   4E61 00                    2 .db 00
   4E62 00                    3 .db 00
   4E63 00                    4 .db 00
   4E64 00 00                 5 .dw 0000
   4E66 00                    6 .db 00
   4E67 02                    7 .db 02
   4E68 08                    8 .db 08
   4E69                      29 BalaAni anib7 00,00,00,02,08
   0030                       1 anib7::
   4E69 00                    2 .db 00
   4E6A 00                    3 .db 00
   4E6B 00                    4 .db 00
   4E6C 00 00                 5 .dw 0000
   4E6E 00                    6 .db 00
   4E6F 02                    7 .db 02
   4E70 08                    8 .db 08
   4E71                      30 BalaAni anib8 00,00,00,02,08
   0038                       1 anib8::
   4E71 00                    2 .db 00
   4E72 00                    3 .db 00
   4E73 00                    4 .db 00
   4E74 00 00                 5 .dw 0000
   4E76 00                    6 .db 00
   4E77 02                    7 .db 02
   4E78 08                    8 .db 08
                             31 
                             32 
   4E79                      33 CanonAni anic1 00,00,00,04,16
   0040                       1 anic1::
   4E79 00                    2 .db 00
   4E7A 00                    3 .db 00
   4E7B 00                    4 .db 00
   4E7C 00 00                 5 .dw 0000
   4E7E 00                    6 .db 00
   4E7F 04                    7 .db 04
   4E80 10                    8 .db 16
   4E81                      34 CanonAni anic2 00,00,00,04,16
   0048                       1 anic2::
   4E81 00                    2 .db 00
   4E82 00                    3 .db 00
   4E83 00                    4 .db 00
   4E84 00 00                 5 .dw 0000
   4E86 00                    6 .db 00
   4E87 04                    7 .db 04
   4E88 10                    8 .db 16
   4E89                      35 CanonAni anic3 00,00,00,04,16
   0050                       1 anic3::
   4E89 00                    2 .db 00
   4E8A 00                    3 .db 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   4E8B 00                    4 .db 00
   4E8C 00 00                 5 .dw 0000
   4E8E 00                    6 .db 00
   4E8F 04                    7 .db 04
   4E90 10                    8 .db 16
   4E91                      36 CanonAni anic4 00,00,00,04,16
   0058                       1 anic4::
   4E91 00                    2 .db 00
   4E92 00                    3 .db 00
   4E93 00                    4 .db 00
   4E94 00 00                 5 .dw 0000
   4E96 00                    6 .db 00
   4E97 04                    7 .db 04
   4E98 10                    8 .db 16
                             37 
                             38 
                             39 
                             40 
                             41 
   4E99 00                   42 _contador_balas: .db 00
   4E9A 00                   43 _contador_canon: .db 00
                             44 
                             45 
                             46 
                             47 
                             48 
                             49 
                             50 
                             51 
                             52 
                             53 
                             54 
                             55 
                             56 
                             57 
                             58 
                             59 
                             60 
                             61 
                             62 
                             63 
   4E9B                      64 animar::
                             65 
   4E9B 3A 99 4E      [13]   66 ld a, (_contador_balas)
   4E9E B7            [ 4]   67 or a
   4E9F 28 13         [12]   68 jr z, _no_hay_balas
   4EA1                      69 _hay_balas:
   4EA1 DD 21 39 4E   [14]   70 	ld ix, #anib1
   4EA5                      71 	_loop_aimacion_bala:
                             72 	
   4EA5 F5            [11]   73 		push af
                             74 
                             75 				
   4EA6 CD CD 4E      [17]   76 			call animacion_bala	
   4EA9 F1            [10]   77 		pop af
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   4EAA 3D            [ 4]   78 		dec a
   4EAB 28 07         [12]   79 		jr z, _no_hay_balas
   4EAD 11 08 00      [10]   80 		ld de, #siceof_ae
   4EB0 DD 19         [15]   81 		add ix,de
   4EB2 18 F1         [12]   82 	jr _loop_aimacion_bala
                             83 
   4EB4                      84 _no_hay_balas:
                             85 
                             86 
   4EB4 3A 9A 4E      [13]   87 ld a, (_contador_canon)
   4EB7 B7            [ 4]   88 or a
   4EB8 28 12         [12]   89 jr z, _no_hay_canon
   4EBA                      90 _hay_canon:
   4EBA DD 21 79 4E   [14]   91 	ld ix, #anic1
   4EBE                      92 	_loop_aimacion_canon:
                             93 	
   4EBE F5            [11]   94 		push af
                             95 
                             96 				
   4EBF CD CD 4E      [17]   97 			call animacion_bala	
   4EC2 F1            [10]   98 		pop af
   4EC3 3D            [ 4]   99 		dec a
   4EC4 C8            [11]  100 		ret z
   4EC5 11 08 00      [10]  101 		ld de, #siceof_ae
   4EC8 DD 19         [15]  102 		add ix,de
   4ECA 18 F2         [12]  103 	jr _loop_aimacion_canon
                            104 
   4ECC                     105 _no_hay_canon:
                            106 
                            107 
                            108 
   4ECC C9            [10]  109 ret
                            110 
                            111 
   4ECD                     112 animacion_bala::
                            113 
                            114 
   4ECD DD 7E 02      [19]  115 ld a, a_con(ix)
   4ED0 3D            [ 4]  116 dec a
   4ED1 28 04         [12]  117 jr z, _transicion	
   4ED3                     118 _actializar_cronometro_bala:
                            119 
   4ED3 DD 77 02      [19]  120 	ld a_con(ix),a	
   4ED6 C9            [10]  121 	ret
                            122 
   4ED7                     123 _transicion:
                            124 
   4ED7 DD 6E 03      [19]  125 ld l , a_punt_l(ix)
   4EDA DD 66 04      [19]  126 ld h , a_punt_h(ix)
   4EDD 22 E1 4E      [16]  127 ld (_siguiente_posicion_bala), hl
                            128 
                     00A8   129 _siguiente_posicion_bala=.+1
   4EE0 C3 00 00      [10]  130 jp 0000
                            131 
   4EE3                     132 _transicion_bala_1:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   4EE3 11 00 C0      [10]  133 	 ld de, #0xC000
   4EE6 DD 4E 00      [19]  134 	 ld   c,  a_x(ix)	
   4EE9 DD 46 01      [19]  135 	 ld   b,  a_y(ix) 
   4EEC CD 1B 78      [17]  136 	 call cpct_getScreenPtr_asm
                            137 	 
   4EEF EB            [ 4]  138 	 ex de, hl
   4EF0 DD 4E 06      [19]  139 	 ld c, a_w(ix)  ;;ancho
   4EF3 DD 46 07      [19]  140 	 ld b, a_h(ix) ;;alto
                            141 
   4EF6 DD 7E 05      [19]  142 	 ld a, a_ani(ix)
   4EF9 B7            [ 4]  143 	 or a
   4EFA 28 05         [12]  144 	 jr z, _es_bala
   4EFC                     145 	 _es_canon:
   4EFC 21 50 1E      [10]  146 	 ld hl,#_canonExpl_0
   4EFF 18 03         [12]  147 	 jr _salir_canon
   4F01                     148 	 _es_bala:
   4F01 21 10 1E      [10]  149 	  ld hl,#_balaExpl_sp_0
   4F04                     150  	_salir_canon:
                            151 	  
   4F04 CD 71 75      [17]  152 	 call cpct_drawSprite_asm
                            153 
   4F07 11 00 80      [10]  154 	 ld de, #0x8000
   4F0A DD 4E 00      [19]  155 	 ld   c,  a_x(ix)	
   4F0D DD 46 01      [19]  156 	 ld   b,  a_y(ix) 
   4F10 CD 1B 78      [17]  157 	 call cpct_getScreenPtr_asm
                            158 	 
   4F13 EB            [ 4]  159 	 ex de, hl
   4F14 DD 4E 06      [19]  160 	 ld c, a_w(ix)  ;;ancho
   4F17 DD 46 07      [19]  161 	 ld b, a_h(ix) ;;alto
                            162 
   4F1A DD 7E 05      [19]  163 	 ld a, a_ani(ix)
   4F1D B7            [ 4]  164 	 or a
   4F1E 28 05         [12]  165 	 jr z, _es_bala_01
   4F20                     166 	 _es_canon02:
   4F20 21 50 1E      [10]  167 	 ld hl,#_canonExpl_0
   4F23 18 03         [12]  168 	 jr _salir_canon_01
   4F25                     169 	 _es_bala_01:
   4F25 21 10 1E      [10]  170 	  ld hl,#_balaExpl_sp_0
   4F28                     171  	_salir_canon_01:
                            172 	  
   4F28 CD 71 75      [17]  173 	 call cpct_drawSprite_asm
                            174 	 
                            175 
   4F2B 21 37 4F      [10]  176 	 ld hl, #_transicion_bala_2
   4F2E DD 75 03      [19]  177 	ld  a_punt_l(ix), l
   4F31 DD 74 04      [19]  178 	ld  a_punt_h(ix), h
                            179 
   4F34 C3 B8 50      [10]  180 	 jp _reiniciar_contador_bala
                            181 
   4F37                     182 _transicion_bala_2:
   4F37 11 00 C0      [10]  183 	 ld de, #0xC000
   4F3A DD 4E 00      [19]  184 	 ld   c,  a_x(ix)	
   4F3D DD 46 01      [19]  185 	 ld   b,  a_y(ix) 
   4F40 CD 1B 78      [17]  186 	 call cpct_getScreenPtr_asm
                            187 	 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   4F43 EB            [ 4]  188 	 ex de, hl
   4F44 DD 4E 06      [19]  189 	 ld c, a_w(ix)  ;;ancho
   4F47 DD 46 07      [19]  190 	 ld b, a_h(ix) ;;alto
                            191 
   4F4A DD 7E 05      [19]  192 	  ld a, a_ani(ix)
   4F4D B7            [ 4]  193 	 or a
   4F4E 28 05         [12]  194 	 jr z, _es_bala1
   4F50                     195 	 _es_canon1:
   4F50 21 90 1E      [10]  196 	 ld hl,#_canonExpl_1
   4F53 18 03         [12]  197 	 jr _salir_canon1
   4F55                     198 	 _es_bala1:
   4F55 21 20 1E      [10]  199 	  ld hl,#_balaExpl_sp_1
   4F58                     200 	   _salir_canon1:
                            201 
   4F58 CD 71 75      [17]  202 	 call cpct_drawSprite_asm
                            203 
                            204 
   4F5B 11 00 80      [10]  205 	  ld de, #0x8000
   4F5E DD 4E 00      [19]  206 	 ld   c,  a_x(ix)	
   4F61 DD 46 01      [19]  207 	 ld   b,  a_y(ix) 
   4F64 CD 1B 78      [17]  208 	 call cpct_getScreenPtr_asm
                            209 	 
   4F67 EB            [ 4]  210 	 ex de, hl
   4F68 DD 4E 06      [19]  211 	 ld c, a_w(ix)  ;;ancho
   4F6B DD 46 07      [19]  212 	 ld b, a_h(ix) ;;alto
                            213 
   4F6E DD 7E 05      [19]  214 	  ld a, a_ani(ix)
   4F71 B7            [ 4]  215 	 or a
   4F72 28 05         [12]  216 	 jr z, _es_bala12
   4F74                     217 	 _es_canon12:
   4F74 21 90 1E      [10]  218 	 ld hl,#_canonExpl_1
   4F77 18 03         [12]  219 	 jr _salir_canon12
   4F79                     220 	 _es_bala12:
   4F79 21 20 1E      [10]  221 	  ld hl,#_balaExpl_sp_1
   4F7C                     222 	   _salir_canon12:
                            223 
   4F7C CD 71 75      [17]  224 	 call cpct_drawSprite_asm
                            225 	
                            226 
   4F7F 21 8B 4F      [10]  227 	 ld hl, #_transicion_bala_3
   4F82 DD 75 03      [19]  228 	 ld  a_punt_l(ix), l
   4F85 DD 74 04      [19]  229 	 ld  a_punt_h(ix), h
                            230 
   4F88 C3 B8 50      [10]  231 	  jp _reiniciar_contador_bala
                            232 
   4F8B                     233 _transicion_bala_3:
                            234 
   4F8B 11 00 C0      [10]  235 	 ld de, #0xC000
   4F8E DD 4E 00      [19]  236 	 ld   c,  a_x(ix)	
   4F91 DD 46 01      [19]  237 	 ld   b,  a_y(ix) 
   4F94 CD 1B 78      [17]  238 	 call cpct_getScreenPtr_asm
                            239 	 
   4F97 EB            [ 4]  240 	 ex de, hl
   4F98 DD 4E 06      [19]  241 	 ld c, a_w(ix)  ;;ancho
   4F9B DD 46 07      [19]  242 	 ld b, a_h(ix) ;;alto
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            243 	
   4F9E DD 7E 05      [19]  244 	ld a, a_ani(ix)
   4FA1 B7            [ 4]  245 	 or a
   4FA2 28 05         [12]  246 	 jr z, _es_bala2
   4FA4                     247 	 _es_canon2:
   4FA4 21 D0 1E      [10]  248 	 ld hl,#_canonExpl_2
   4FA7 18 03         [12]  249 	 jr _salir_canon2
   4FA9                     250 	 _es_bala2:
   4FA9 21 30 1E      [10]  251 	  ld hl,#_balaExpl_sp_2
   4FAC                     252 	   _salir_canon2:
                            253 
   4FAC CD 71 75      [17]  254 	 call cpct_drawSprite_asm
                            255 
                            256 
   4FAF 11 00 80      [10]  257 	  ld de, #0x8000
   4FB2 DD 4E 00      [19]  258 	 ld   c,  a_x(ix)	
   4FB5 DD 46 01      [19]  259 	 ld   b,  a_y(ix) 
   4FB8 CD 1B 78      [17]  260 	 call cpct_getScreenPtr_asm
                            261 	 
   4FBB EB            [ 4]  262 	 ex de, hl
   4FBC DD 4E 06      [19]  263 	 ld c, a_w(ix)  ;;ancho
   4FBF DD 46 07      [19]  264 	 ld b, a_h(ix) ;;alto
                            265 	
   4FC2 DD 7E 05      [19]  266 	ld a, a_ani(ix)
   4FC5 B7            [ 4]  267 	 or a
   4FC6 28 05         [12]  268 	 jr z, _es_bala22
   4FC8                     269 	 _es_canon22:
   4FC8 21 D0 1E      [10]  270 	 ld hl,#_canonExpl_2
   4FCB 18 03         [12]  271 	 jr _salir_canon22
   4FCD                     272 	 _es_bala22:
   4FCD 21 30 1E      [10]  273 	  ld hl,#_balaExpl_sp_2
   4FD0                     274 	   _salir_canon22:
                            275 
   4FD0 CD 71 75      [17]  276 	 call cpct_drawSprite_asm
                            277 	
                            278 
   4FD3 21 DF 4F      [10]  279 	  ld hl, #_transicion_bala_4
   4FD6 DD 75 03      [19]  280 	  ld  a_punt_l(ix), l
   4FD9 DD 74 04      [19]  281 	  ld  a_punt_h(ix), h
                            282 
   4FDC C3 B8 50      [10]  283 	  jp _reiniciar_contador_bala
                            284 
   4FDF                     285 _transicion_bala_4:
                            286 
   4FDF 11 00 C0      [10]  287 	 ld de, #0xC000
   4FE2 DD 4E 00      [19]  288 	 ld   c,  a_x(ix)	
   4FE5 DD 46 01      [19]  289 	 ld   b,  a_y(ix) 
   4FE8 CD 1B 78      [17]  290 	 call cpct_getScreenPtr_asm
                            291 	 
   4FEB EB            [ 4]  292 	 ex de, hl
   4FEC DD 4E 06      [19]  293 	 ld c, a_w(ix)  ;;ancho
   4FEF DD 46 07      [19]  294 	 ld b, a_h(ix) ;;alto
                            295 
   4FF2 DD 7E 05      [19]  296 	ld a, a_ani(ix)
   4FF5 B7            [ 4]  297 	 or a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   4FF6 28 05         [12]  298 	 jr z, _es_bala3
   4FF8                     299 	 _es_canon3:
   4FF8 21 10 1F      [10]  300 	 ld hl,#_canonExpl_3
   4FFB 18 03         [12]  301 	 jr _salir_canon3
   4FFD                     302 	 _es_bala3:
   4FFD 21 40 1E      [10]  303 	  ld hl,#_balaExpl_sp_3
   5000                     304 	   _salir_canon3:
                            305 
   5000 CD 71 75      [17]  306 	 call cpct_drawSprite_asm
                            307 
                            308 
                            309 
   5003 11 00 80      [10]  310 	 ld de, #0x8000
   5006 DD 4E 00      [19]  311 	 ld   c,  a_x(ix)	
   5009 DD 46 01      [19]  312 	 ld   b,  a_y(ix) 
   500C CD 1B 78      [17]  313 	 call cpct_getScreenPtr_asm
                            314 	 
   500F EB            [ 4]  315 	 ex de, hl
   5010 DD 4E 06      [19]  316 	 ld c, a_w(ix)  ;;ancho
   5013 DD 46 07      [19]  317 	 ld b, a_h(ix) ;;alto
                            318 
   5016 DD 7E 05      [19]  319 	ld a, a_ani(ix)
   5019 B7            [ 4]  320 	 or a
   501A 28 05         [12]  321 	 jr z, _es_bala32
   501C                     322 	 _es_canon32:
   501C 21 10 1F      [10]  323 	 ld hl,#_canonExpl_3
   501F 18 03         [12]  324 	 jr _salir_canon32
   5021                     325 	 _es_bala32:
   5021 21 40 1E      [10]  326 	  ld hl,#_balaExpl_sp_3
   5024                     327 	   _salir_canon32:
                            328 
   5024 CD 71 75      [17]  329 	 call cpct_drawSprite_asm
                            330 
                            331 	
                            332 
   5027 21 33 50      [10]  333 	ld hl, #limpiar_b
   502A DD 75 03      [19]  334 	  ld  a_punt_l(ix), l
   502D DD 74 04      [19]  335 	  ld  a_punt_h(ix), h
                            336 
   5030 C3 B8 50      [10]  337 	 jp _reiniciar_contador_bala
                            338 
                            339 
   5033                     340 limpiar_b::
                            341 
   5033 11 00 C0      [10]  342  ld de ,#0xc000
                            343 
   5036 DD 4E 00      [19]  344  	 ld   c,  a_x(ix)	
   5039 DD 46 01      [19]  345 	 ld   b,  a_y(ix) 
                            346 
   503C CD 1B 78      [17]  347 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   503F EB            [ 4]  348 	 ex  de,hl	
   5040 3E 00         [ 7]  349 	ld  a, #0x00   ;; color
   5042 DD 4E 06      [19]  350 	 ld c, a_w(ix)  ;;ancho
   5045 DD 46 07      [19]  351 	 ld b, a_h(ix) ;;alto
   5048 CD 26 77      [17]  352 	call cpct_drawSolidBox_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            353 
   504B 11 00 80      [10]  354   ld de ,#0x8000
   504E DD 4E 00      [19]  355 	 ld   c,  a_x(ix)	
   5051 DD 46 01      [19]  356 	 ld   b,  a_y(ix) 
                            357 
   5054 CD 1B 78      [17]  358 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   5057 EB            [ 4]  359 	 ex  de,hl	
   5058 3E 00         [ 7]  360 	ld  a, #0x00   ;; color
   505A DD 4E 06      [19]  361 	  ld c, a_w(ix)  ;;ancho
   505D DD 46 07      [19]  362 	 ld b, a_h(ix) ;;alto
   5060 CD 26 77      [17]  363 	call cpct_drawSolidBox_asm
                            364 
                            365 
                            366 
                            367 	
                            368 	
   5063 DD 22 68 50   [20]  369 	ld (_pasar_ix_hl), ix
                     022F   370 	_pasar_ix_hl=.+1
   5067 11 00 00      [10]  371 	ld de, #0000
   506A 21 08 00      [10]  372 	ld hl, #siceof_ae
   506D 19            [11]  373 	add hl,de 
                            374 	 
                            375 
   506E DD 7E 05      [19]  376 	ld a, a_ani(ix)
   5071 B7            [ 4]  377 	 or a
   5072 28 22         [12]  378 	 jr z, _limpiar_bala
   5074                     379 	 _limpiar_canon:
                            380 
   5074 06 00         [ 7]  381 	 ld b, #0	
   5076 3A 9A 4E      [13]  382 		ld a, (_contador_canon)
   5079 4F            [ 4]  383 	    	ld c, a
   507A 0D            [ 4]  384 	    	dec c
   507B 79            [ 4]  385 	    	ld a, c
   507C B7            [ 4]  386 	    	or a
   507D 28 0F         [12]  387 	    	jr z,_salimos_c
                            388 	    
                            389 	    
   507F 0E 00         [ 7]  390 	    	ld c, #0
   5081                     391 	    	_multi_c:
   5081 0C            [ 4]  392 		    	inc c
   5082 0C            [ 4]  393 		    	inc c
   5083 0C            [ 4]  394 		    	inc c
   5084 0C            [ 4]  395 		    	inc c
   5085 0C            [ 4]  396 		    	inc c
   5086 0C            [ 4]  397 		    	inc c
   5087 0C            [ 4]  398 		    	inc c
   5088 0C            [ 4]  399 		    	inc c
   5089 3D            [ 4]  400 		dec a
   508A 20 F5         [12]  401 		jr nz, _multi_c
                            402 		
   508C ED B0         [21]  403 	    	ldir
                            404 
                            405 	    
   508E                     406 		_salimos_c:
   508E 3A 9A 4E      [13]  407 	    	ld a, (_contador_canon)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   5091 3D            [ 4]  408 	    	dec a
   5092 32 9A 4E      [13]  409 	    	ld (_contador_canon),a
                            410 
   5095 C9            [10]  411 	    	ret
                            412 
                            413 
   5096                     414 	_limpiar_bala:
   5096 06 00         [ 7]  415 		ld b, #0	
   5098 3A 99 4E      [13]  416 		ld a, (_contador_balas)
   509B 4F            [ 4]  417 	    	ld c, a
   509C 0D            [ 4]  418 	    	dec c
   509D 79            [ 4]  419 	    	ld a, c
   509E B7            [ 4]  420 	    	or a
   509F 28 0F         [12]  421 	    	jr z,_salimos
                            422 	    
                            423 	    
   50A1 0E 00         [ 7]  424 	    	ld c, #0
   50A3                     425 	    	_multi:
   50A3 0C            [ 4]  426 		    	inc c
   50A4 0C            [ 4]  427 		    	inc c
   50A5 0C            [ 4]  428 		    	inc c
   50A6 0C            [ 4]  429 		    	inc c
   50A7 0C            [ 4]  430 		    	inc c
   50A8 0C            [ 4]  431 		    	inc c
   50A9 0C            [ 4]  432 		    	inc c
   50AA 0C            [ 4]  433 		    	inc c
   50AB 3D            [ 4]  434 		dec a
   50AC 20 F5         [12]  435 		jr nz, _multi
                            436 		
   50AE ED B0         [21]  437 	    	ldir
                            438 
                            439 	    
   50B0                     440 		_salimos:
   50B0 3A 99 4E      [13]  441 	    	ld a, (_contador_balas)
   50B3 3D            [ 4]  442 	    	dec a
   50B4 32 99 4E      [13]  443 	    	ld (_contador_balas),a
                            444 
                            445 
                            446     	
                            447     	
                            448 
                            449 
                            450     
                            451 	
                            452 
   50B7 C9            [10]  453 ret
                            454 
   50B8                     455 _reiniciar_contador_bala:
   50B8 3E 05         [ 7]  456 	ld a, #duracion_animacion
   50BA DD 77 02      [19]  457 	ld a_con(ix), a
   50BD C9            [10]  458 ret
                            459 
   50BE                     460 animacion_tanque:
                            461 
   50BE C9            [10]  462 ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



                            463 
                            464 
                            465 
   50BF                     466 iniciar_animacion_bala::
   50BF FD 21 39 4E   [14]  467 ld iy, #anib1
   50C3 3A 99 4E      [13]  468 ld a, (_contador_balas)
   50C6 B7            [ 4]  469 or a
   50C7 28 0F         [12]  470 jr z,_primera_posicion
   50C9 FE 08         [ 7]  471 	cp #maximo_balas_animacion
   50CB 20 01         [12]  472 	jr nz,_no_maximo
                            473 	
   50CD C9            [10]  474 	ret
   50CE                     475 	_no_maximo:
   50CE                     476 	loop_colocar:
   50CE 11 08 00      [10]  477 		ld de, #siceof_ae
   50D1 FD 19         [15]  478 		add iy,de
   50D3 3D            [ 4]  479 		dec a
   50D4 28 02         [12]  480 		jr z,_no_hay_mas
   50D6 18 F6         [12]  481 	jr loop_colocar
                            482 
                            483 
   50D8                     484 _no_hay_mas:
                            485 
   50D8                     486 _primera_posicion:
                            487 
                            488 
                            489 
                            490 
   50D8 DD 7E 00      [19]  491 ld a, e_x(ix)
   50DB FD 77 00      [19]  492 ld a_x(iy), a
   50DE DD 7E 01      [19]  493 ld a, e_y(ix)
   50E1 FD 77 01      [19]  494 ld a_y(iy), a
                            495 
   50E4 3E 02         [ 7]  496 ld a,#02
   50E6 FD 77 06      [19]  497 ld a_w(iy), a
   50E9 3E 08         [ 7]  498 ld a,#08
   50EB FD 77 07      [19]  499 ld a_h(iy), a
                            500 
   50EE 21 E3 4E      [10]  501 ld hl, #_transicion_bala_1
   50F1 FD 75 03      [19]  502 ld  a_punt_l(iy), l
   50F4 FD 74 04      [19]  503 ld  a_punt_h(iy), h
                            504 
   50F7 FD 36 02 05   [19]  505 ld a_con(iy), #duracion_animacion
                            506 
   50FB 3A 99 4E      [13]  507 ld a, (_contador_balas)
   50FE 3C            [ 4]  508 inc a
   50FF 32 99 4E      [13]  509 ld (_contador_balas),a 
                            510 
   5102 C9            [10]  511 ret
                            512 
                            513 
                            514 
                            515 
                            516 
                            517 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



                            518 
   5103                     519 iniciar_animacion_canon::
                            520 
   5103 DD 21 79 4E   [14]  521 ld ix, #anic1
   5107 3A 9A 4E      [13]  522 ld a, (_contador_canon)
   510A B7            [ 4]  523 or a
   510B 28 0F         [12]  524 jr z,_primera_posicion_canon
   510D FE 04         [ 7]  525 	cp #maximo_canon_animacion
   510F 20 01         [12]  526 	jr nz,_no_maximo_canon
                            527 	
   5111 C9            [10]  528 	ret
   5112                     529 	_no_maximo_canon:
   5112                     530 	loop_colocar_canon:
   5112 11 08 00      [10]  531 		ld de, #siceof_ae
   5115 DD 19         [15]  532 		add ix,de
   5117 3D            [ 4]  533 		dec a
   5118 28 02         [12]  534 		jr z,_no_hay_mas_canon
   511A 18 F6         [12]  535 	jr loop_colocar_canon
                            536 
                            537 
   511C                     538 _no_hay_mas_canon:
                            539 
   511C                     540 _primera_posicion_canon:
                            541 
                            542 
                            543 
                            544 
   511C FD 7E 00      [19]  545 ld a, b_x(iy)
   511F DD 77 00      [19]  546 ld a_x(ix), a
   5122 FD 7E 01      [19]  547 ld a, b_y(iy)
   5125 DD 77 01      [19]  548 ld a_y(ix), a
                            549 
   5128 3E 04         [ 7]  550 ld a,#04
   512A DD 77 06      [19]  551 ld a_w(ix), a
   512D 3E 10         [ 7]  552 ld a,#16
   512F DD 77 07      [19]  553 ld a_h(ix), a
   5132 3E 01         [ 7]  554 ld a, #1
   5134 DD 77 05      [19]  555 ld a_ani(ix), a
                            556 
   5137 21 E3 4E      [10]  557 ld hl, #_transicion_bala_1
   513A DD 75 03      [19]  558 ld  a_punt_l(ix), l
   513D DD 74 04      [19]  559 ld  a_punt_h(ix), h
                            560 
   5140 DD 36 02 05   [19]  561 ld a_con(ix), #duracion_animacion
                            562 
   5144 3A 9A 4E      [13]  563 ld a, (_contador_canon)
   5147 3C            [ 4]  564 inc a
   5148 32 9A 4E      [13]  565 ld (_contador_canon),a 
                            566 
   514B C9            [10]  567 ret
                            568 
                            569 
   514C                     570 limpiar_animaciones::
   514C 21 39 4E      [10]  571 ld hl, #anib1
   514F EB            [ 4]  572 ex de, hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



   5150 21 39 4E      [10]  573 ld hl, #anib1
   5153 13            [ 6]  574 inc de
   5154 36 00         [10]  575 ld (hl),#0
   5156 01 3F 00      [10]  576 ld bc, #63
   5159 ED B0         [21]  577 ldir
                            578 
   515B 21 79 4E      [10]  579 ld hl, #anic1
   515E EB            [ 4]  580 ex de, hl
   515F 21 79 4E      [10]  581 ld hl, #anic1
                            582 
   5162 13            [ 6]  583 inc de
   5163 36 00         [10]  584 ld (hl),#0
   5165 01 1F 00      [10]  585 ld bc, #31
   5168 ED B0         [21]  586 ldir
                            587 
   516A 3E 00         [ 7]  588 ld a, #0
   516C 32 99 4E      [13]  589 ld (_contador_balas),a
   516F 32 9A 4E      [13]  590 ld (_contador_canon),a
                            591 
                            592 
                            593 
                            594 
                            595 
   5172 C9            [10]  596 ret
