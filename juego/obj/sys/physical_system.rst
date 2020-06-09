ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Phisical_sistem
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



                              6 .include "man/shot_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 .include "sys_kill_bullet.h.s"
                              1 ;;
                              2 ;;sys_kill_bullet h
                              3 ;;
                              4 
                              5 
                              6 ;; FUNCIONES GLOBALES
                              7 .globl kill_bullet_init
                              8 .globl kill_bullet
                              9 .globl kill_bullet_all
                             10 
                             11 
                             12 ;; CONSTANTES
                             13 
                     FFFFFFFF    14 _bala_disponible = -1
                     0004    15 _id_last_bullet = 4      ;; NUMERO MAXIMO DE BALAS - 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 .include "sys_kill_bullet_2.h.s"	
                              1 ;;
                              2 ;;kill bullet 2 h
                              3 ;;
                              4 
                              5 .globl kill_bullet_init_2
                              6 .globl kill_bullet_2
                              7 
                              8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 .include "sys_map_colision.h.s"
                              1 ;;
                              2 ;;sys map colision h
                              3 ;;
                              4 
                              5 
                     0000     6 sin_inicializar=0
                     0001     7 siguiente_colision=1
                     0002     8 partida_terminada=2
                              9 
                             10 .globl comp_colisiones
                             11 .globl buscar_tile
                             12 .globl reiniciar_colisiones
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             10 .include "man/state_manager.h.s"
                              1 ;;
                              2 ;;Draw map h
                              3 ;;
                              4 
                              5 
                              6 
                              7 .globl manage_game
                              8 .globl jugandostate_init
                              9 .globl set_Ingame
                             10 .globl set_Gameover
                             11 .globl set_Inicio
                             12 .globl _pausa
                             13 .globl _gamemode
                             14 
                             15 .globl get_gamemode
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             11 .include "sys_dir.h.s"
                              1 ;;
                              2 ;;sys dir h
                              3 ;;
                              4 
                              5 
                              6 .globl modificar_sprite
                              7 
                              8 
                     0019     9 _contador_ciclos = 25
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             12 
                             13 
   4949                      14 move_entities_init::
   4949 CD 57 48      [17]   15  call entityman_getEntityVector_IX
   494C CD 5C 48      [17]   16  call entityman_num_entities	
   494F 32 6C 49      [13]   17 ld (_contador_entidades),a
   4952 DD 22 6F 49   [20]   18 ld (_puntero_entidades), ix
                             19 
                             20 
   4956 CD 40 49      [17]   21  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   4959 CD 45 49      [17]   22  call entityman_num_Bales
   495C 22 04 4A      [16]   23  ld (_contador_balas), hl
   495F DD 22 01 4A   [20]   24  ld (_puntero_balas), ix
   4963 C9            [10]   25 ret
                             26 
                             27 
                             28 
   4964                      29 move_entities::
                             30 
   4964 CD 6B 49      [17]   31 call _move_canon
   4967 CD FF 49      [17]   32 call _move_balas	
   496A C9            [10]   33 ret
                             34 
   496B                      35 _move_canon::
                     0023    36  _contador_entidades=.+1
   496B 3E 00         [ 7]   37  ld a, #00
                     0026    38  _puntero_entidades=.+2
   496D DD 21 00 00   [14]   39  ld ix, #0000
                             40 
   4971                      41  _loop:
   4971 F5            [11]   42 	push af
                             43 
                             44 	
   4972 CD E7 58      [17]   45 call modificar_sprite
   4975 DD 46 02      [19]   46 	ld   b, e_xl(ix)
   4978 DD 4E 03      [19]   47 	ld   c, e_yl(ix)
                             48 
                             49 
   497B DD 70 04      [19]   50 	ld   e_xll(ix), b 
   497E DD 71 05      [19]   51 	ld   e_yll(ix), c
                             52 
   4981 DD 46 00      [19]   53 	ld   b, e_x(ix)
   4984 DD 4E 01      [19]   54 	ld   c, e_y(ix)
                             55 
   4987 DD 70 02      [19]   56 	ld   e_xl(ix), b 
   498A DD 71 03      [19]   57 	ld   e_yl(ix), c
                             58 
                             59 
                             60 
   498D DD 46 00      [19]   61 	ld 	b, e_x(ix)
   4990 DD 4E 01      [19]   62 	ld 	c, e_y(ix)
   4993 DD 56 14      [19]   63 	ld   	d, e_ancho(ix)
   4996 DD 5E 15      [19]   64 	ld	e, e_alto(ix)
                             65 
                             66 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             67 
   4999 DD 7E 06      [19]   68 	ld   a, e_vx(ix)
   499C B7            [ 4]   69 	or a
   499D 28 27         [12]   70 	jr z ,_no_move_x
                             71 	
   499F FA B5 49      [10]   72 		jp m ,_izquierda
   49A2                      73 		_derecha:
   49A2 26 03         [ 7]   74 			ld h,#3
                             75 
   49A4 CD 97 5E      [17]   76 			call comp_colisiones
   49A7 3D            [ 4]   77 			dec a
   49A8 20 49         [12]   78 			jr nz, _out
                             79 
   49AA DD 7E 00      [19]   80 			ld a, e_x(ix)
   49AD DD 86 06      [19]   81 			add e_vx(ix)
                             82 			
   49B0 DD 77 00      [19]   83 			ld e_x(ix),a	
   49B3 18 3E         [12]   84 			jr _out		
   49B5                      85 		_izquierda:
   49B5 26 01         [ 7]   86 			ld h,#1
   49B7 CD 97 5E      [17]   87 			call comp_colisiones
   49BA 3D            [ 4]   88 			dec a
   49BB 20 36         [12]   89 			jr nz, _out	
                             90 
   49BD DD 7E 00      [19]   91 			ld a, e_x(ix)
   49C0 DD 86 06      [19]   92 			add e_vx(ix)
                             93 			
   49C3 DD 77 00      [19]   94 			ld e_x(ix),a
   49C6                      95 	_no_move_x:
                             96 
                             97 
   49C6 DD 7E 07      [19]   98 	ld   a, e_vy(ix)
   49C9 B7            [ 4]   99 	or a
   49CA 28 27         [12]  100 	jr z,_no_move_y
                            101 		
   49CC FA E2 49      [10]  102 		jp m,_arriba
   49CF                     103 		_abajo:
   49CF 26 04         [ 7]  104 			ld h,#4
   49D1 CD 97 5E      [17]  105 			call comp_colisiones
   49D4 3D            [ 4]  106 			dec a
   49D5 20 1C         [12]  107 			jr nz, _out
                            108 			
   49D7 DD 7E 01      [19]  109 			ld a, e_y(ix)
   49DA DD 86 07      [19]  110 			add e_vy(ix)
                            111 			
   49DD DD 77 01      [19]  112 			ld e_y(ix),a
   49E0 18 11         [12]  113 			jr _out
   49E2                     114 		_arriba:
   49E2 26 02         [ 7]  115 			ld h,#2
   49E4 CD 97 5E      [17]  116 			call comp_colisiones
   49E7 3D            [ 4]  117 			dec a
   49E8 20 09         [12]  118 			jr nz, _out
                            119 
   49EA DD 7E 01      [19]  120 			ld a, e_y(ix)
   49ED DD 86 07      [19]  121 			add e_vy(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            122 
   49F0 DD 77 01      [19]  123 			ld e_y(ix),a
   49F3                     124 	_no_move_y:
                            125 
   49F3                     126 _out:
                            127 
                            128 
                            129 
   49F3 F1            [10]  130 	pop af
   49F4 3D            [ 4]  131 	dec a
   49F5 C8            [11]  132 	ret z
                            133 
                            134 	
   49F6 11 17 00      [10]  135 	ld de, #siceof_e
   49F9 DD 19         [15]  136 	add ix, de
                            137 	
   49FB C3 71 49      [10]  138 	jp _loop
   49FE C9            [10]  139 ret
                            140 
                            141 
   49FF                     142 _move_balas::
                     00B8   143 	 _puntero_balas=.+2
   49FF DD 21 00 00   [14]  144  	ld ix, #0000
                     00BB   145  	_contador_balas=.+1
   4A03 21 00 00      [10]  146  	ld hl, #0000	
                            147 
   4A06 7E            [ 7]  148 	ld a, (hl)
                            149 	
   4A07 6F            [ 4]  150 	ld l ,a			;numero de balas 
   4A08 B7            [ 4]  151  	or a
   4A09 CA B5 4A      [10]  152  	jp z, _no_hay_balas
                            153  	;;hay balas
                            154 
                            155 		
                            156 					
   4A0C                     157 	_balloop:
                            158 
                            159 
                            160 	
   4A0C DD 46 02      [19]  161 			ld   b, b_xl(ix)
   4A0F DD 4E 03      [19]  162 			ld   c, b_yl(ix)
                            163 
                            164 
   4A12 DD 70 04      [19]  165 			ld   b_xll(ix), b 
   4A15 DD 71 05      [19]  166 			ld   b_yll(ix), c
                            167 
   4A18 DD 46 00      [19]  168 			ld   b, b_x(ix)
   4A1B DD 4E 01      [19]  169 			ld   c, b_y(ix)
                            170 
   4A1E DD 70 02      [19]  171 			ld   b_xl(ix), b 
   4A21 DD 71 03      [19]  172 			ld   b_yl(ix), c
                            173 
   4A24 DD 56 0A      [19]  174 			ld   d ,b_w(ix)
   4A27 DD 5E 09      [19]  175 			ld   e ,b_h(ix)
                            176 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            177 					
                            178 
                            179 			
   4A2A DD 7E 06      [19]  180 			ld a , b_vx(ix)
   4A2D B7            [ 4]  181 			or a
   4A2E 28 3C         [12]  182 			jr z ,_no_move_x_bales
   4A30 FE 01         [ 7]  183 				cp #1
   4A32 20 22         [12]  184 				jr nz, _bala_izquierda 
   4A34                     185 				_bala_derecha:
   4A34 26 03         [ 7]  186 					ld h,#3
   4A36 E5            [11]  187 					push hl
   4A37 CD 97 5E      [17]  188 					call comp_colisiones
   4A3A E1            [10]  189 					pop hl
   4A3B 3D            [ 4]  190 					dec a
   4A3C 20 0C         [12]  191 					jr nz, _matar
   4A3E DD 7E 06      [19]  192 					ld a ,b_vx(ix)
   4A41 DD 46 00      [19]  193 					ld   b, b_x(ix)
   4A44 80            [ 4]  194 					add b
   4A45 DD 77 00      [19]  195 					ld b_x(ix), a
   4A48 18 58         [12]  196 					jr _siguiente
                            197 
   4A4A                     198 					_matar:
   4A4A 7D            [ 4]  199 					ld a, l
   4A4B E5            [11]  200 					push hl
   4A4C DD E5         [15]  201 					push ix
   4A4E CD DF 55      [17]  202 					call kill_bullet
   4A51 DD E1         [14]  203 					pop ix
   4A53 E1            [10]  204 					pop hl
                            205 
   4A54 18 58         [12]  206 					jr _siguiente_matando
                            207 
   4A56                     208 				_bala_izquierda:
   4A56 26 01         [ 7]  209 					ld h,#1
   4A58 E5            [11]  210 					push hl
   4A59 CD 97 5E      [17]  211 					call comp_colisiones
   4A5C E1            [10]  212 					pop hl
   4A5D 3D            [ 4]  213 					dec a
   4A5E 20 EA         [12]  214 					jr nz, _matar
   4A60 DD 7E 06      [19]  215 					ld a ,b_vx(ix)
   4A63 DD 46 00      [19]  216 					ld   b, b_x(ix)
   4A66 80            [ 4]  217 					add b
   4A67 DD 77 00      [19]  218 					ld b_x(ix), a
   4A6A 18 36         [12]  219 					jr _siguiente
   4A6C                     220 			_no_move_x_bales:
                            221 
   4A6C DD 7E 07      [19]  222 			ld a , b_vy(ix)
   4A6F B7            [ 4]  223 			or a
   4A70 28 30         [12]  224 			jr z ,_no_move_y_bales
   4A72 FE 04         [ 7]  225 				cp #4
   4A74 20 16         [12]  226 				jr nz, _bala_arriba
   4A76                     227 				_bala_abajo:
   4A76 26 04         [ 7]  228 					ld h,#4
   4A78 E5            [11]  229 					push hl
   4A79 CD 97 5E      [17]  230 					call comp_colisiones
   4A7C E1            [10]  231 					pop hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   4A7D 3D            [ 4]  232 					dec a
   4A7E 20 CA         [12]  233 					jr nz, _matar
   4A80 DD 7E 07      [19]  234 					ld a ,b_vy(ix)
   4A83 DD 4E 01      [19]  235 					ld   c, b_y(ix)
   4A86 81            [ 4]  236 					add c
                            237 					
   4A87 DD 77 01      [19]  238 					ld b_y(ix), a
   4A8A 18 16         [12]  239 					jr _siguiente
   4A8C                     240 				_bala_arriba:
   4A8C 26 01         [ 7]  241 					ld h,#1
   4A8E E5            [11]  242 					push hl
   4A8F CD 97 5E      [17]  243 					call comp_colisiones
   4A92 E1            [10]  244 					pop hl
   4A93 3D            [ 4]  245 					dec a
   4A94 20 B4         [12]  246 					jr nz, _matar
   4A96 DD 7E 07      [19]  247 					ld a ,b_vy(ix)
   4A99 DD 4E 01      [19]  248 					ld   c, b_y(ix)					
   4A9C 81            [ 4]  249 					add c
   4A9D DD 77 01      [19]  250 					ld   b_y(ix), a
                            251 
   4AA0 18 00         [12]  252 					jr _siguiente
   4AA2                     253 			_no_move_y_bales:
                            254 
                            255 
   4AA2                     256 	_siguiente:
   4AA2 7D            [ 4]  257 	ld a, l
   4AA3 3D            [ 4]  258 	dec a
   4AA4 C8            [11]  259 	ret z
                            260 
   4AA5 6F            [ 4]  261 	ld l, a	
   4AA6 11 0E 00      [10]  262 	ld de, #siceof_b
   4AA9 DD 19         [15]  263 	add ix, de
                            264 	
   4AAB C3 0C 4A      [10]  265 	jp _balloop
                            266 			
   4AAE                     267 _siguiente_matando:
                            268 
   4AAE 7D            [ 4]  269 	ld a, l
   4AAF 3D            [ 4]  270 	dec a
   4AB0 C8            [11]  271 	ret z
                            272 
   4AB1 6F            [ 4]  273 	ld l, a
   4AB2 C3 0C 4A      [10]  274 	jp _balloop
                            275 		
   4AB5                     276 	_no_hay_balas:
   4AB5 C9            [10]  277 	ret
                            278 
                            279 
                            280 
                            281 
                            282 
   4AB6                     283 check_gameover::
                            284 
                            285 	;;Bucle que va contando en h el numero de muertos, si alfinal solo queda uno vivo pasa a state game over
                            286 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   4AB6 DD 2A 6F 49   [20]  287 	ld ix, (_puntero_entidades)
                            288  	
                            289 
                            290 
   4ABA CD 18 46      [17]  291  	call get_gamemode
   4ABD FE 05         [ 7]  292  	cp #5
   4ABF 28 1E         [12]  293  	jr z, _single_player
                            294 
   4AC1                     295  	_comprobar_otro:
   4AC1 3A 6C 49      [13]  296  	ld a, (_contador_entidades)
   4AC4 26 04         [ 7]  297       ld h, #04
   4AC6                     298       _loopMuerte:
                            299 
                            300 	
   4AC6 DD 46 0C      [19]  301 	ld b, e_dead(ix)
   4AC9 05            [ 4]  302       dec b
   4ACA 20 01         [12]  303  	jr nz, _nomuerto
   4ACC 25            [ 4]  304  	dec h
   4ACD                     305  	_nomuerto:
                            306 
   0184                     307       NextEntity
   4ACD 11 17 00      [10]    1 ld de, #siceof_e
   4AD0 DD 19         [15]    2 	add ix, de
   4AD2 3D            [ 4]  308       dec a
   4AD3 20 F1         [12]  309       jr nz, _loopMuerte
                            310 
   4AD5 7C            [ 4]  311       ld a, h
   4AD6 B7            [ 4]  312       or a
   4AD7 CC 63 45      [17]  313       call z, set_Gameover
   4ADA 3D            [ 4]  314       dec a
   4ADB CC 63 45      [17]  315       call z, set_Gameover
                            316       
                            317 
                            318 
   4ADE C9            [10]  319 ret
                            320 
                            321 
                            322 
   4ADF                     323 _single_player:
   4ADF DD 7E 0C      [19]  324 ld a, e_dead(ix)
   4AE2 3D            [ 4]  325 dec a
   4AE3 20 DC         [12]  326 jr nz, _comprobar_otro    ;;complueba si mueren todos 
   4AE5                     327 _muere_player_1:		;;muere el player 1 en el single
   4AE5 CC 63 45      [17]  328 	call z, set_Gameover
   4AE8 C9            [10]  329 ret
