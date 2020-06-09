ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "man/entity_manager.h.s"
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



                              8 .include "man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 .include "sys/render_system.h.s"
                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
                              5 .globl render_entities
                              6 .globl rendersys_update
                              7 .globl rendersys_init
                              8 .globl pintar_hud
                              9 .globl jugador_muerto
                             10 .globl pintar_letras
                     0019    11 _contador_ciclos = 25
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             10 .include "sys/plant_render.h.s"
                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
                              5 
                              6 .globl plant_render
                              7 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             11 .include "assets.h.s"
                              1 ;;
                              2 ;;Assets globals
                              3 ;;
                              4 
                              5 .globl _cannons_sp_00
                              6 .globl _cannons_sp_01
                              7 .globl _cannons_sp_02
                              8 .globl _cannons_sp_03
                              9 .globl _cannons_sp_04
                             10 .globl _cannons_sp_05
                             11 .globl _cannons_sp_06
                             12 .globl _cannons_sp_07
                             13 .globl _cannons_sp_08
                             14 .globl _cannons_sp_09
                             15 .globl _cannons_sp_10
                             16 .globl _cannons_sp_11
                             17 .globl _cannons_sp_12
                             18 .globl _cannons_sp_13
                             19 .globl _cannons_sp_14
                             20 .globl _cannons_sp_15
                             21 .globl _cannons_sp_16
                             22 .globl _cannons_sp_17
                             23 .globl _cannons_sp_18
                             24 .globl _cannons_sp_19
                             25 .globl _player_sp
                             26 .globl _spr2
                             27 .globl _spr3
                             28 .globl _spr4
                             29 .globl _mapa1
                             30 .globl _mapa2
                             31 .globl _mapa3
                             32 .globl _mapa4
                             33 .globl _mapa5
                             34 .globl _mapa6
                             35 .globl _single_mapa1
                             36 .globl _single_mapa2
                             37 .globl _single_mapa3
                             38 .globl _single_mapa4
                             39 .globl _single_mapa5
                             40 .globl _single_mapa6
                             41 .globl _plant_sp
                             42 
                             43 .globl _tileset_00
                             44 .globl _bala_sp
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             12 
                             13 
   60AE 19                   14 _contador:: .db #_contador_ciclos
   60AF 04                   15 _tipsprite:: .db #04
                             16 
                             17 
                     000F    18 _P1_hudx = 15
                     0023    19 _P2_hudx = 35
                     0037    20 _P3_hudx = 55
                     004B    21 _P4_hudx = 75
                             22 
   60B0                      23 rendersys_init::  
                             24 
                             25 
                             26 
   60B0 CD 57 48      [17]   27  call entityman_getEntityVector_IX
   60B3 CD 5C 48      [17]   28  call entityman_num_entities  
   60B6 32 D6 60      [13]   29 ld (_contador_entidades),a
   60B9 DD 22 D9 60   [20]   30 ld (_puntero_entidades), ix
                             31 
                             32 
   60BD CD 40 49      [17]   33  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   60C0 CD 45 49      [17]   34  call entityman_num_Bales
   60C3 22 94 61      [16]   35  ld (_contador_balas), hl
   60C6 DD 22 9D 61   [20]   36  ld (_puntero_balas), ix
   60CA C9            [10]   37 ret
                             38 
                             39 
                             40 
                             41 
   60CB                      42 rendersys_update::
                             43 
   60CB CD D5 60      [17]   44  call render_entities  	;;render para los tanques
   60CE CD 6D 56      [17]   45  call plant_render
   60D1 CD 93 61      [17]   46  call render_bales   ;;render para las balas
                             47  
   60D4 C9            [10]   48  ret
                             49 
                             50 
   60D5                      51 render_entities:
                     0028    52  _contador_entidades=.+1
   60D5 3E 00         [ 7]   53  ld a, #00
                     002B    54  _puntero_entidades=.+2
   60D7 DD 21 00 00   [14]   55  ld ix, #0000
                             56 
   60DB                      57 	_renloop:
   60DB F5            [11]   58 push af
                             59 
   60DC DD 46 0C      [19]   60   ld b ,e_dead(ix)
   60DF 05            [ 4]   61   dec b
   60E0 CA 88 61      [10]   62   jp z, _canon_muerto
                             63 
   60E3 CD AC 3F      [17]   64   call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
                             65 
                             66 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   60E6 F5            [11]   67 push af
   60E7 EB            [ 4]   68   ex de, hl
                             69   ;;ld de, #0xC000
   60E8 DD 4E 00      [19]   70   ld   c, e_x(ix)  ;;x
   60EB DD 46 01      [19]   71   ld   b, e_y(ix)  ;;y
   60EE CD 1B 78      [17]   72   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   60F1 F1            [10]   73 pop af
                             74 
                             75 
                             76 
                             77 
                             78 
                             79 
   60F2 EB            [ 4]   80  ex  de,hl
                             81 
                             82  
   60F3 DD 46 0A      [19]   83  ld b ,e_dir(ix)
                             84 
                             85 
                             86 
                             87 
   60F6 3D            [ 4]   88   dec a
   60F7 28 68         [12]   89   jr z, _pintar_cannon4
   60F9 3D            [ 4]   90   dec a
   60FA 28 45         [12]   91   jr z, _pintar_cannon3
   60FC 3D            [ 4]   92   dec a
   60FD 28 22         [12]   93   jr z, _pintar_cannon2
   60FF 18 00         [12]   94   jr _pintar_cannon1
                             95 
                             96 ;;;;;;;;;;;;;;;;;;
                             97 ;;PINTAR CANON 1;;
                             98 ;;;;;;;;;;;;;;;;;;
                             99 
   6101                     100 _pintar_cannon1:
   6101 05            [ 4]  101  dec b
   6102 28 09         [12]  102  jr z, _pintarc1_1
   6104 05            [ 4]  103  dec b
   6105 28 0B         [12]  104  jr z, _pintarc1_2
   6107 05            [ 4]  105  dec b
   6108 28 0D         [12]  106  jr z, _pintarc1_3
   610A 05            [ 4]  107  dec b
   610B 28 0F         [12]  108  jr z, _pintarc1_4
                            109 
                            110 
   610D                     111  _pintarc1_1:
   610D 21 B0 20      [10]  112  ld hl,#_cannons_sp_00
   6110 18 6F         [12]  113  jr _saltar
                            114 
   6112                     115  _pintarc1_2:
   6112 21 F0 20      [10]  116  ld hl,#_cannons_sp_01
   6115 18 6A         [12]  117  jr _saltar
                            118 
   6117                     119  _pintarc1_3:
   6117 21 30 21      [10]  120  ld hl,#_cannons_sp_02
   611A 18 65         [12]  121  jr _saltar
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            122 
   611C                     123  _pintarc1_4:
   611C 21 70 21      [10]  124  ld hl,#_cannons_sp_03
   611F 18 60         [12]  125  jr _saltar
                            126 
                            127 
                            128 
                            129 ;;;;;;;;;;;;;;;;;;
                            130 ;;PINTAR CANON 2;;
                            131 ;;;;;;;;;;;;;;;;;;
                            132 
   6121                     133 _pintar_cannon2:
   6121 05            [ 4]  134  dec b
   6122 28 09         [12]  135  jr z, _pintarc2_1
   6124 05            [ 4]  136  dec b
   6125 28 0B         [12]  137  jr z, _pintarc2_2
   6127 05            [ 4]  138  dec b
   6128 28 0D         [12]  139  jr z, _pintarc2_3
   612A 05            [ 4]  140  dec b
   612B 28 0F         [12]  141  jr z, _pintarc2_4
                            142 
                            143 
   612D                     144  _pintarc2_1:
   612D 21 F0 21      [10]  145  ld hl,#_cannons_sp_05
   6130 18 4F         [12]  146  jr _saltar
                            147 
   6132                     148  _pintarc2_2:
   6132 21 30 22      [10]  149  ld hl,#_cannons_sp_06
   6135 18 4A         [12]  150  jr _saltar
                            151 
   6137                     152  _pintarc2_3:
   6137 21 70 22      [10]  153  ld hl,#_cannons_sp_07
   613A 18 45         [12]  154  jr _saltar
                            155 
   613C                     156  _pintarc2_4:
   613C 21 B0 22      [10]  157  ld hl,#_cannons_sp_08
   613F 18 40         [12]  158  jr _saltar
                            159 
                            160 
                            161 ;;;;;;;;;;;;;;;;;;
                            162 ;;PINTAR CANON 3;;
                            163 ;;;;;;;;;;;;;;;;;;
                            164 
   6141                     165 _pintar_cannon3:
   6141 05            [ 4]  166  dec b
   6142 28 09         [12]  167  jr z, _pintarc3_1
   6144 05            [ 4]  168  dec b
   6145 28 0B         [12]  169  jr z, _pintarc3_2
   6147 05            [ 4]  170  dec b
   6148 28 0D         [12]  171  jr z, _pintarc3_3
   614A 05            [ 4]  172  dec b
   614B 28 0F         [12]  173  jr z, _pintarc3_4
                            174 
                            175 
   614D                     176  _pintarc3_1:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   614D 21 30 23      [10]  177  ld hl,#_cannons_sp_10
   6150 18 2F         [12]  178  jr _saltar
                            179 
   6152                     180  _pintarc3_2:
   6152 21 70 23      [10]  181  ld hl,#_cannons_sp_11
   6155 18 2A         [12]  182  jr _saltar
                            183 
   6157                     184  _pintarc3_3:
   6157 21 B0 23      [10]  185  ld hl,#_cannons_sp_12
   615A 18 25         [12]  186  jr _saltar
                            187 
   615C                     188  _pintarc3_4:
   615C 21 F0 23      [10]  189  ld hl,#_cannons_sp_13
   615F 18 20         [12]  190  jr _saltar
                            191 
                            192 
                            193 ;;;;;;;;;;;;;;;;;;
                            194 ;;PINTAR CANON 4;;
                            195 ;;;;;;;;;;;;;;;;;;
                            196 
   6161                     197 _pintar_cannon4:
   6161 05            [ 4]  198  dec b
   6162 28 09         [12]  199  jr z, _pintarc4_1
   6164 05            [ 4]  200  dec b
   6165 28 0B         [12]  201  jr z, _pintarc4_2
   6167 05            [ 4]  202  dec b
   6168 28 0D         [12]  203  jr z, _pintarc4_3
   616A 05            [ 4]  204  dec b
   616B 28 0F         [12]  205  jr z, _pintarc4_4
                            206 
                            207 
   616D                     208  _pintarc4_1:
   616D 21 70 24      [10]  209  ld hl,#_cannons_sp_15
   6170 18 0F         [12]  210  jr _saltar
                            211 
   6172                     212  _pintarc4_2:
   6172 21 B0 24      [10]  213  ld hl,#_cannons_sp_16
   6175 18 0A         [12]  214  jr _saltar
                            215 
   6177                     216  _pintarc4_3:
   6177 21 F0 24      [10]  217  ld hl,#_cannons_sp_17
   617A 18 05         [12]  218  jr _saltar
                            219 
   617C                     220  _pintarc4_4:
   617C 21 30 25      [10]  221  ld hl,#_cannons_sp_18
   617F 18 00         [12]  222  jr _saltar
                            223 
                            224 
                            225 
                            226 
                            227 
                            228 
                            229 
   6181                     230  _saltar:
                            231 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            232 
   6181 0E 04         [ 7]  233  ld c, #04  ;;ancho
   6183 06 10         [ 7]  234  ld b, #16  ;;alto
                            235  
   6185 CD 71 75      [17]  236  call cpct_drawSprite_asm
                            237 
                            238 
   6188                     239 _canon_muerto:
   6188 F1            [10]  240 pop af 
                            241 
   6189 3D            [ 4]  242 dec a
   618A C8            [11]  243 ret z
                            244 
   618B 01 17 00      [10]  245 ld bc, #siceof_e    ;;NUMERO DE BYTES QUE TIENE CADA ENTIDAD
   618E DD 09         [15]  246 add ix, bc
   6190 C3 DB 60      [10]  247 jp  _renloop
                            248 
                            249 
                            250 
   6193                     251 render_bales:
                            252 
                            253  
                     00E6   254   _contador_balas=.+1
   6193 21 00 00      [10]  255   ld hl, #0000
                            256 
   6196 7E            [ 7]  257  ld   a, (hl) 
   6197 B7            [ 4]  258 	or a
   6198 20 01         [12]  259  jr nz, _hay_balas
   619A C9            [10]  260  ret
                            261 
   619B                     262 _hay_balas:
                            263 
                            264 
                            265 
                     00EF   266  _puntero_balas=.+2
   619B DD 21 00 00   [14]  267   ld ix, #0000
                            268   
                            269  
   619F                     270  _renloop_b:
                            271 
                            272 
   619F F5            [11]  273 push af
                            274 
   61A0 CD AC 3F      [17]  275 call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
   61A3 EB            [ 4]  276   ex de, hl
   61A4 DD 4E 00      [19]  277   ld   c, b_x(ix)  
   61A7 DD 46 01      [19]  278   ld   b, b_y(ix)  
   61AA CD 1B 78      [17]  279   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            280 
                            281 
                            282 
                            283 
   61AD EB            [ 4]  284  ex de, hl
   61AE 0E 02         [ 7]  285  ld c, #02  ;;ancho
   61B0 06 08         [ 7]  286  ld b, #08  ;;alto
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   61B2 21 50 1F      [10]  287  ld hl,#_bala_sp
   61B5 CD 71 75      [17]  288  call cpct_drawSprite_asm
                            289 
                            290 
   61B8 F1            [10]  291 pop af 
                            292 
   61B9 3D            [ 4]  293 dec a
   61BA C8            [11]  294 ret z
                            295 
   61BB 01 0E 00      [10]  296 ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA BALA
   61BE DD 09         [15]  297 add ix, bc
   61C0 20 DD         [12]  298 jr nz, _renloop_b
                            299 
                            300 
                            301 
   61C2 C9            [10]  302 ret
                            303 	
                            304 
                            305 
   61C3                     306 jugador_muerto::
                            307 
   61C3 DD 2A D9 60   [20]  308 ld ix, (_puntero_entidades)
                            309 
                            310 
                            311   ;;Comprobar si el muerto es la primera entidad
   61C7 DD 7E 0C      [19]  312       ld a, e_dead(ix)
   61CA 3D            [ 4]  313       dec a
   61CB CC AC 62      [17]  314       call z, dibujarplayer1_M
                            315   
   61CE 01 17 00      [10]  316     ld bc, #siceof_e   
   61D1 DD 09         [15]  317     add ix, bc 
                            318   ;;Comprobar si el muerto es la segunda entidad
   61D3 DD 7E 0C      [19]  319       ld a, e_dead(ix)
   61D6 3D            [ 4]  320       dec a
   61D7 CC D7 62      [17]  321       call z, dibujarplayer2_M
                            322   
   61DA 01 17 00      [10]  323     ld bc, #siceof_e    
   61DD DD 09         [15]  324     add ix, bc
                            325    ;;Comprobar si el muerto es la tercera entidad
   61DF DD 7E 0C      [19]  326       ld a, e_dead(ix)
   61E2 3D            [ 4]  327       dec a
   61E3 CC 02 63      [17]  328       call z, dibujarplayer3_M
                            329 
   61E6 01 17 00      [10]  330     ld bc, #siceof_e    
   61E9 DD 09         [15]  331     add ix, bc
                            332     ;;Comprobar si el muerto es la cuearta entidad
   61EB DD 7E 0C      [19]  333       ld a, e_dead(ix)
   61EE 3D            [ 4]  334       dec a
   61EF CC 2D 63      [17]  335       call z, dibujarplayer4_M
                            336 
   61F2 C9            [10]  337 ret
                            338 
   61F3                     339 pintar_hud::
                            340 
   61F3 CD 00 62      [17]  341   call dibujarplayer1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   61F6 CD 2B 62      [17]  342   call dibujarplayer2
   61F9 CD 56 62      [17]  343   call dibujarplayer3
   61FC CD 81 62      [17]  344   call dibujarplayer4
                            345 
   61FF C9            [10]  346 ret
                            347 
                            348 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            349 ;;Dibujar el jugador en el hud;;
                            350 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            351 
                            352 
   6200                     353 dibujarplayer1:
                            354  
   6200 11 00 C0      [10]  355  ld  de, #0xC000
   6203 0E 0F         [ 7]  356  ld   c, #_P1_hudx    ;;x
   6205 06 B4         [ 7]  357  ld   b, #180  ;;y
   6207 CD 1B 78      [17]  358  call cpct_getScreenPtr_asm
                            359  
   620A EB            [ 4]  360  ex de, hl
   620B 0E 04         [ 7]  361  ld c, #04  ;;ancho
   620D 06 10         [ 7]  362  ld b, #16  ;;alto
   620F 21 30 21      [10]  363  ld hl,#_cannons_sp_02
   6212 CD 71 75      [17]  364  call cpct_drawSprite_asm
                            365 
   6215 11 00 80      [10]  366  ld  de, #0x8000
   6218 0E 0F         [ 7]  367  ld   c, #_P1_hudx    ;;x
   621A 06 B4         [ 7]  368  ld   b, #180  ;;y
   621C CD 1B 78      [17]  369  call cpct_getScreenPtr_asm
                            370  
   621F EB            [ 4]  371  ex de, hl
   6220 0E 04         [ 7]  372  ld c, #04  ;;ancho
   6222 06 10         [ 7]  373  ld b, #16  ;;alto
   6224 21 30 21      [10]  374  ld hl,#_cannons_sp_02
   6227 CD 71 75      [17]  375  call cpct_drawSprite_asm
                            376 
   622A C9            [10]  377 ret
                            378 
   622B                     379 dibujarplayer2:
   622B 11 00 C0      [10]  380  ld  de, #0xC000
   622E 0E 23         [ 7]  381  ld   c, #_P2_hudx  ;;x
   6230 06 B4         [ 7]  382  ld   b, #180   ;;y
   6232 CD 1B 78      [17]  383  call cpct_getScreenPtr_asm
                            384 
   6235 EB            [ 4]  385  ex de, hl
   6236 0E 04         [ 7]  386  ld c, #04  ;;ancho
   6238 06 10         [ 7]  387  ld b, #16  ;;alto
   623A 21 70 22      [10]  388  ld hl,#_cannons_sp_07
   623D CD 71 75      [17]  389  call cpct_drawSprite_asm
                            390 
   6240 11 00 80      [10]  391   ld  de, #0x8000
   6243 0E 23         [ 7]  392  ld   c, #_P2_hudx  ;;x
   6245 06 B4         [ 7]  393  ld   b, #180   ;;y
   6247 CD 1B 78      [17]  394  call cpct_getScreenPtr_asm
                            395 
   624A EB            [ 4]  396  ex de, hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   624B 0E 04         [ 7]  397  ld c, #04  ;;ancho
   624D 06 10         [ 7]  398  ld b, #16  ;;alto
   624F 21 70 22      [10]  399  ld hl,#_cannons_sp_07
   6252 CD 71 75      [17]  400  call cpct_drawSprite_asm
                            401 
   6255 C9            [10]  402 ret
                            403 
   6256                     404 dibujarplayer3:
   6256 11 00 C0      [10]  405  ld  de, #0xC000
   6259 0E 37         [ 7]  406  ld   c, #_P3_hudx  ;;x
   625B 06 B4         [ 7]  407  ld   b, #180  ;;y
   625D CD 1B 78      [17]  408  call cpct_getScreenPtr_asm
                            409 
   6260 EB            [ 4]  410  ex de, hl
   6261 0E 04         [ 7]  411  ld c, #04  ;;ancho
   6263 06 10         [ 7]  412  ld b, #16  ;;alto
   6265 21 B0 23      [10]  413  ld hl,#_cannons_sp_12
   6268 CD 71 75      [17]  414  call cpct_drawSprite_asm
                            415 
   626B 11 00 80      [10]  416  ld  de, #0x8000
   626E 0E 37         [ 7]  417  ld   c, #_P3_hudx  ;;x
   6270 06 B4         [ 7]  418  ld   b, #180  ;;y
   6272 CD 1B 78      [17]  419  call cpct_getScreenPtr_asm
                            420 
   6275 EB            [ 4]  421  ex de, hl
   6276 0E 04         [ 7]  422  ld c, #04  ;;ancho
   6278 06 10         [ 7]  423  ld b, #16  ;;alto
   627A 21 B0 23      [10]  424  ld hl,#_cannons_sp_12
   627D CD 71 75      [17]  425  call cpct_drawSprite_asm
                            426 
   6280 C9            [10]  427 ret
                            428 
   6281                     429 dibujarplayer4:
   6281 11 00 C0      [10]  430  ld  de, #0xC000
   6284 0E 4B         [ 7]  431  ld   c, #_P4_hudx  ;;x
   6286 06 B4         [ 7]  432  ld   b, #180  ;;y
   6288 CD 1B 78      [17]  433  call cpct_getScreenPtr_asm
                            434 
   628B EB            [ 4]  435  ex de, hl
   628C 0E 04         [ 7]  436  ld c, #04  ;;ancho
   628E 06 10         [ 7]  437  ld b, #16  ;;alto
   6290 21 F0 24      [10]  438  ld hl,#_cannons_sp_17
   6293 CD 71 75      [17]  439  call cpct_drawSprite_asm
                            440 
   6296 11 00 80      [10]  441  ld  de, #0x8000
   6299 0E 4B         [ 7]  442  ld   c, #_P4_hudx  ;;x
   629B 06 B4         [ 7]  443  ld   b, #180  ;;y
   629D CD 1B 78      [17]  444  call cpct_getScreenPtr_asm
                            445 
   62A0 EB            [ 4]  446  ex de, hl
   62A1 0E 04         [ 7]  447  ld c, #04  ;;ancho
   62A3 06 10         [ 7]  448  ld b, #16  ;;alto
   62A5 21 F0 24      [10]  449  ld hl,#_cannons_sp_17
   62A8 CD 71 75      [17]  450  call cpct_drawSprite_asm
                            451 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   62AB C9            [10]  452 ret
                            453 
                            454 
                            455 
                            456 
                            457 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            458 ;;DIBUJAR EL HUB EL JUGADOR MUERTO;;
                            459 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   62AC                     460 dibujarplayer1_M:
                            461  
   62AC 11 00 C0      [10]  462  ld  de, #0xC000
   62AF 0E 0F         [ 7]  463  ld   c, #_P1_hudx    ;;x
   62B1 06 B4         [ 7]  464  ld   b, #180  ;;y
   62B3 CD 1B 78      [17]  465  call cpct_getScreenPtr_asm
                            466  
   62B6 EB            [ 4]  467  ex de, hl
   62B7 0E 04         [ 7]  468  ld c, #04  ;;ancho
   62B9 06 10         [ 7]  469  ld b, #16  ;;alto
   62BB 21 B0 21      [10]  470  ld hl,#_cannons_sp_04
   62BE CD 71 75      [17]  471  call cpct_drawSprite_asm
                            472 
   62C1 11 00 80      [10]  473  ld  de, #0x8000
   62C4 0E 0F         [ 7]  474  ld   c, #_P1_hudx    ;;x
   62C6 06 B4         [ 7]  475  ld   b, #180  ;;y
   62C8 CD 1B 78      [17]  476  call cpct_getScreenPtr_asm
                            477  
   62CB EB            [ 4]  478  ex de, hl
   62CC 0E 04         [ 7]  479  ld c, #04  ;;ancho
   62CE 06 10         [ 7]  480  ld b, #16  ;;alto
   62D0 21 B0 21      [10]  481  ld hl,#_cannons_sp_04
   62D3 CD 71 75      [17]  482  call cpct_drawSprite_asm
                            483 
   62D6 C9            [10]  484 ret
                            485 
   62D7                     486 dibujarplayer2_M:
   62D7 11 00 C0      [10]  487  ld  de, #0xC000
   62DA 0E 23         [ 7]  488  ld   c, #_P2_hudx  ;;x
   62DC 06 B4         [ 7]  489  ld   b, #180   ;;y
   62DE CD 1B 78      [17]  490  call cpct_getScreenPtr_asm
                            491 
   62E1 EB            [ 4]  492  ex de, hl
   62E2 0E 04         [ 7]  493  ld c, #04  ;;ancho
   62E4 06 10         [ 7]  494  ld b, #16  ;;alto
   62E6 21 F0 22      [10]  495  ld hl,#_cannons_sp_09
   62E9 CD 71 75      [17]  496  call cpct_drawSprite_asm
                            497 
   62EC 11 00 80      [10]  498   ld  de, #0x8000
   62EF 0E 23         [ 7]  499  ld   c, #_P2_hudx  ;;x
   62F1 06 B4         [ 7]  500  ld   b, #180   ;;y
   62F3 CD 1B 78      [17]  501  call cpct_getScreenPtr_asm
                            502 
   62F6 EB            [ 4]  503  ex de, hl
   62F7 0E 04         [ 7]  504  ld c, #04  ;;ancho
   62F9 06 10         [ 7]  505  ld b, #16  ;;alto
   62FB 21 F0 22      [10]  506  ld hl,#_cannons_sp_09
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   62FE CD 71 75      [17]  507  call cpct_drawSprite_asm
                            508 
   6301 C9            [10]  509 ret
                            510 
   6302                     511 dibujarplayer3_M:
   6302 11 00 C0      [10]  512  ld  de, #0xC000
   6305 0E 37         [ 7]  513  ld   c, #_P3_hudx  ;;x
   6307 06 B4         [ 7]  514  ld   b, #180  ;;y
   6309 CD 1B 78      [17]  515  call cpct_getScreenPtr_asm
                            516 
   630C EB            [ 4]  517  ex de, hl
   630D 0E 04         [ 7]  518  ld c, #04  ;;ancho
   630F 06 10         [ 7]  519  ld b, #16  ;;alto
   6311 21 30 24      [10]  520  ld hl,#_cannons_sp_14
   6314 CD 71 75      [17]  521  call cpct_drawSprite_asm
                            522 
   6317 11 00 80      [10]  523  ld  de, #0x8000
   631A 0E 37         [ 7]  524  ld   c, #_P3_hudx  ;;x
   631C 06 B4         [ 7]  525  ld   b, #180  ;;y
   631E CD 1B 78      [17]  526  call cpct_getScreenPtr_asm
                            527 
   6321 EB            [ 4]  528  ex de, hl
   6322 0E 04         [ 7]  529  ld c, #04  ;;ancho
   6324 06 10         [ 7]  530  ld b, #16  ;;alto
   6326 21 30 24      [10]  531  ld hl,#_cannons_sp_14
   6329 CD 71 75      [17]  532  call cpct_drawSprite_asm
                            533 
   632C C9            [10]  534 ret
                            535 
   632D                     536 dibujarplayer4_M:
   632D 11 00 C0      [10]  537  ld  de, #0xC000
   6330 0E 4B         [ 7]  538  ld   c, #_P4_hudx  ;;x
   6332 06 B4         [ 7]  539  ld   b, #180  ;;y
   6334 CD 1B 78      [17]  540  call cpct_getScreenPtr_asm
                            541 
   6337 EB            [ 4]  542  ex de, hl
   6338 0E 04         [ 7]  543  ld c, #04  ;;ancho
   633A 06 10         [ 7]  544  ld b, #16  ;;alto
   633C 21 70 25      [10]  545  ld hl,#_cannons_sp_19
   633F CD 71 75      [17]  546  call cpct_drawSprite_asm
                            547 
   6342 11 00 80      [10]  548  ld  de, #0x8000
   6345 0E 4B         [ 7]  549  ld   c, #_P4_hudx  ;;x
   6347 06 B4         [ 7]  550  ld   b, #180  ;;y
   6349 CD 1B 78      [17]  551  call cpct_getScreenPtr_asm
                            552 
   634C EB            [ 4]  553  ex de, hl
   634D 0E 04         [ 7]  554  ld c, #04  ;;ancho
   634F 06 10         [ 7]  555  ld b, #16  ;;alto
   6351 21 70 25      [10]  556  ld hl,#_cannons_sp_19
   6354 CD 71 75      [17]  557  call cpct_drawSprite_asm
                            558 
   6357 C9            [10]  559 ret
                            560 
                            561   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



                            562 
   6358                     563 pintar_letras::
                            564 
                            565 ;;Jugador;;
                            566 
   6358 11 00 C0      [10]  567 ld  de, #0xC000
   635B 0E 01         [ 7]  568  ld   c, #1    ;;x
   635D 06 B4         [ 7]  569  ld   b, #180  ;;y
   635F CD 1B 78      [17]  570  call cpct_getScreenPtr_asm
                            571  
   6362 EB            [ 4]  572  ex de, hl
   6363 0E 10         [ 7]  573  ld c, #16  ;;ancho
   6365 06 10         [ 7]  574  ld b, #16  ;;alto
   6367 21 60 1F      [10]  575  ld hl,#_player_sp
   636A CD 71 75      [17]  576  call cpct_drawSprite_asm
                            577 
   636D 11 00 80      [10]  578  ld  de, #0x8000
   6370 0E 01         [ 7]  579  ld   c, #1    ;;x
   6372 06 B4         [ 7]  580  ld   b, #180  ;;y
   6374 CD 1B 78      [17]  581  call cpct_getScreenPtr_asm
                            582  
   6377 EB            [ 4]  583  ex de, hl
   6378 0E 10         [ 7]  584  ld c, #16 ;;ancho
   637A 06 10         [ 7]  585  ld b, #16  ;;alto
   637C 21 60 1F      [10]  586  ld hl,#_player_sp
   637F CD 71 75      [17]  587  call cpct_drawSprite_asm
                            588 
                            589 
                            590 
                            591 ;;Jugador 2
                            592 
   6382 11 00 C0      [10]  593 ld  de, #0xC000
   6385 0E 14         [ 7]  594  ld   c, #20    ;;x
   6387 06 B4         [ 7]  595  ld   b, #180  ;;y
   6389 CD 1B 78      [17]  596  call cpct_getScreenPtr_asm
                            597  
   638C EB            [ 4]  598  ex de, hl
   638D 0E 10         [ 7]  599  ld c, #16  ;;ancho
   638F 06 10         [ 7]  600  ld b, #16  ;;alto
   6391 21 60 1F      [10]  601  ld hl,#_player_sp
   6394 CD 71 75      [17]  602  call cpct_drawSprite_asm
                            603 
   6397 11 00 80      [10]  604  ld  de, #0x8000
   639A 0E 14         [ 7]  605  ld   c, #20    ;;x
   639C 06 B4         [ 7]  606  ld   b, #180  ;;y
   639E CD 1B 78      [17]  607  call cpct_getScreenPtr_asm
                            608  
   63A1 EB            [ 4]  609  ex de, hl
   63A2 0E 10         [ 7]  610  ld c, #16 ;;ancho
   63A4 06 10         [ 7]  611  ld b, #16  ;;alto
   63A6 21 60 1F      [10]  612  ld hl,#_player_sp
   63A9 CD 71 75      [17]  613  call cpct_drawSprite_asm
                            614 
                            615 ;; Numero 2
                            616 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



   63AC 11 00 C0      [10]  617  ld  de, #0xC000
   63AF 0E 1F         [ 7]  618  ld   c, #31    ;;x
   63B1 06 B4         [ 7]  619  ld   b, #180  ;;y
   63B3 CD 1B 78      [17]  620  call cpct_getScreenPtr_asm
                            621  
   63B6 EB            [ 4]  622  ex de, hl
   63B7 0E 04         [ 7]  623  ld c, #4  ;;ancho
   63B9 06 10         [ 7]  624  ld b, #16  ;;alto
   63BB 21 D0 1D      [10]  625  ld hl,#_spr2
   63BE CD 71 75      [17]  626  call cpct_drawSprite_asm
                            627 
   63C1 11 00 80      [10]  628  ld  de, #0x8000
   63C4 0E 1F         [ 7]  629  ld   c, #31    ;;x
   63C6 06 B4         [ 7]  630  ld   b, #180  ;;y
   63C8 CD 1B 78      [17]  631  call cpct_getScreenPtr_asm
                            632  
   63CB EB            [ 4]  633  ex de, hl
   63CC 0E 04         [ 7]  634  ld c, #4 ;;ancho
   63CE 06 10         [ 7]  635  ld b, #16  ;;alto
   63D0 21 D0 1D      [10]  636  ld hl,#_spr2
   63D3 CD 71 75      [17]  637  call cpct_drawSprite_asm
                            638 
                            639  
                            640 
                            641 
                            642 
                            643 ;;Jugador 3
                            644 
   63D6 11 00 C0      [10]  645 ld  de, #0xC000
   63D9 0E 28         [ 7]  646  ld   c, #40    ;;x
   63DB 06 B4         [ 7]  647  ld   b, #180  ;;y
   63DD CD 1B 78      [17]  648  call cpct_getScreenPtr_asm
                            649  
   63E0 EB            [ 4]  650  ex de, hl
   63E1 0E 10         [ 7]  651  ld c, #16  ;;ancho
   63E3 06 10         [ 7]  652  ld b, #16  ;;alto
   63E5 21 60 1F      [10]  653  ld hl,#_player_sp
   63E8 CD 71 75      [17]  654  call cpct_drawSprite_asm
                            655 
   63EB 11 00 80      [10]  656  ld  de, #0x8000
   63EE 0E 28         [ 7]  657  ld   c, #40    ;;x
   63F0 06 B4         [ 7]  658  ld   b, #180  ;;y
   63F2 CD 1B 78      [17]  659  call cpct_getScreenPtr_asm
                            660  
   63F5 EB            [ 4]  661  ex de, hl
   63F6 0E 10         [ 7]  662  ld c, #16 ;;ancho
   63F8 06 10         [ 7]  663  ld b, #16  ;;alto
   63FA 21 60 1F      [10]  664  ld hl,#_player_sp
   63FD CD 71 75      [17]  665  call cpct_drawSprite_asm
                            666 
                            667 ;; Numero 3
                            668 
   6400 11 00 C0      [10]  669  ld  de, #0xC000
   6403 0E 33         [ 7]  670  ld   c, #51    ;;x
   6405 06 B4         [ 7]  671  ld   b, #180  ;;y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



   6407 CD 1B 78      [17]  672  call cpct_getScreenPtr_asm
                            673  
   640A EB            [ 4]  674  ex de, hl
   640B 0E 04         [ 7]  675  ld c, #4  ;;ancho
   640D 06 10         [ 7]  676  ld b, #16  ;;alto
   640F 21 90 1D      [10]  677  ld hl,#_spr3
   6412 CD 71 75      [17]  678  call cpct_drawSprite_asm
                            679 
   6415 11 00 80      [10]  680  ld  de, #0x8000
   6418 0E 33         [ 7]  681  ld   c, #51    ;;x
   641A 06 B4         [ 7]  682  ld   b, #180  ;;y
   641C CD 1B 78      [17]  683  call cpct_getScreenPtr_asm
                            684  
   641F EB            [ 4]  685  ex de, hl
   6420 0E 04         [ 7]  686  ld c, #4 ;;ancho
   6422 06 10         [ 7]  687  ld b, #16  ;;alto
   6424 21 90 1D      [10]  688  ld hl,#_spr3
   6427 CD 71 75      [17]  689  call cpct_drawSprite_asm
                            690 
                            691 
                            692 
                            693 ;;Jugador 4
                            694 
   642A 11 00 C0      [10]  695 ld  de, #0xC000
   642D 0E 3C         [ 7]  696  ld   c, #60    ;;x
   642F 06 B4         [ 7]  697  ld   b, #180  ;;y
   6431 CD 1B 78      [17]  698  call cpct_getScreenPtr_asm
                            699  
   6434 EB            [ 4]  700  ex de, hl
   6435 0E 10         [ 7]  701  ld c, #16  ;;ancho
   6437 06 10         [ 7]  702  ld b, #16  ;;alto
   6439 21 60 1F      [10]  703  ld hl,#_player_sp
   643C CD 71 75      [17]  704  call cpct_drawSprite_asm
                            705 
   643F 11 00 80      [10]  706  ld  de, #0x8000
   6442 0E 3C         [ 7]  707  ld   c, #60    ;;x
   6444 06 B4         [ 7]  708  ld   b, #180  ;;y
   6446 CD 1B 78      [17]  709  call cpct_getScreenPtr_asm
                            710  
   6449 EB            [ 4]  711  ex de, hl
   644A 0E 10         [ 7]  712  ld c, #16 ;;ancho
   644C 06 10         [ 7]  713  ld b, #16  ;;alto
   644E 21 60 1F      [10]  714  ld hl,#_player_sp
   6451 CD 71 75      [17]  715  call cpct_drawSprite_asm
                            716 
                            717 ;numero 4
                            718 
   6454 11 00 C0      [10]  719 ld  de, #0xC000
   6457 0E 47         [ 7]  720  ld   c, #71    ;;x
   6459 06 B4         [ 7]  721  ld   b, #180  ;;y
   645B CD 1B 78      [17]  722  call cpct_getScreenPtr_asm
                            723  
   645E EB            [ 4]  724  ex de, hl
   645F 0E 04         [ 7]  725  ld c, #4  ;;ancho
   6461 06 10         [ 7]  726  ld b, #16  ;;alto
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



   6463 21 50 1D      [10]  727  ld hl,#_spr4
   6466 CD 71 75      [17]  728  call cpct_drawSprite_asm
                            729 
   6469 11 00 80      [10]  730  ld  de, #0x8000
   646C 0E 47         [ 7]  731  ld   c, #71    ;;x
   646E 06 B4         [ 7]  732  ld   b, #180  ;;y
   6470 CD 1B 78      [17]  733  call cpct_getScreenPtr_asm
                            734  
   6473 EB            [ 4]  735  ex de, hl
   6474 0E 04         [ 7]  736  ld c, #4 ;;ancho
   6476 06 10         [ 7]  737  ld b, #16  ;;alto
   6478 21 50 1D      [10]  738  ld hl,#_spr4
   647B CD 71 75      [17]  739  call cpct_drawSprite_asm
                            740 
                            741 
                            742 
                            743 
                            744 
                            745 
   647E C9            [10]  746 ret
                            747 
