ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_compr_disparo
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



                              7 .include "sys/sys_kill_bullet.h.s"
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



                              8 .include "sys/clean_entities.h.s"
                              1 ;;
                              2 ;;CLEAN Entities
                              3 ;;
                              4 
                              5 .globl clean_entities_init
                              6 .globl clean_entities
                              7 .globl limpiar_ultimo
                              8 .globl limpiar_ultima
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



                             10 .include "../sys/sys_interrup_music.h.s"
                              1 ;;
                              2 ;;sys_interrup_music h
                              3 ;;
                              4 
                              5 
                              6 ;;canciones
                              7 .globl _song
                              8 .globl _song2
                              9 .globl _song3
                             10 .globl _song4
                             11 
                             12 
                             13 
                             14 ;;funciones
                             15 .globl generate_music
                             16 
                             17 
                             18 .globl sonido_disparo
                             19 .globl sonido_muerte
                             20 .globl sonido_win
                             21 .globl sonido_interaccion
                             22 
                             23 .globl off_muerte
                             24 
                             25 
                             26 .globl cancion1
                             27 .globl cancion2
                             28 .globl cancion3
                             29 .globl cancion4
                             30 
                             31 .globl stopmusic
                             32 .globl next_song
                             33 
                             34 
                             35 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             11 .include "sys/sys_a.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             12 
                             13 
                             14 
   6963                      15 sys_comp_disp_init::
                             16 
   6963 CD 57 48      [17]   17 	 call entityman_getEntityVector_IX
   6966 CD 5C 48      [17]   18  	call entityman_num_entities	
   6969 32 90 69      [13]   19 	ld (_contador_entidades),a
   696C DD 22 88 69   [20]   20 	ld (_puntero_entidades), ix
                             21 
                             22 
   6970 CD 40 49      [17]   23 	 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   6973 CD 45 49      [17]   24  	call entityman_num_Bales
   6976 22 7F 69      [16]   25  	ld (_contador_balas), hl
   6979 DD 22 8C 69   [20]   26  	ld (_puntero_balas), ix
                             27 	
                             28 
                             29 
                             30 
   697D C9            [10]   31 	ret
                             32 
                             33 
                             34 
                             35 
   697E                      36 sys_comp_disp_update::
                             37 
                     001C    38 _contador_balas=.+1
   697E 21 00 00      [10]   39  	ld hl, #0000
   6981 7E            [ 7]   40   ld a , (hl)
   6982 B7            [ 4]   41   or a
   6983 CA 1F 6A      [10]   42  jp z ,_no_hay_balas
                             43  
                             44 
                             45 
                     0025    46 	_puntero_entidades = .+2
   6986 FD 21 00 00   [14]   47 	ld iy, #0x0000                   	;;Puntero a canon iy
                             48 
                     0029    49 	_puntero_balas = .+2
   698A DD 21 00 00   [14]   50 	ld ix, #0x0000				;; puntero a balas ix
                             51 
                             52 	 
   698E 67            [ 4]   53 	 ld h , a                       ;;h  numero de balas
                             54 	 
                     002D    55 	_contador_entidades=.+1
   698F 3E 00         [ 7]   56  	 ld a, #00
   6991 6F            [ 4]   57 	 ld l, a 					;;l  numero de canon
                             58 
                             59 	 	
                             60 
                             61 
                             62 
                             63 
                             64 
   6992                      65 	_loop_canon:
                             66 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   6992 FD 7E 0C      [19]   67 	ld a ,e_dead(iy)
   6995 3D            [ 4]   68 	dec a
   6996 28 7E         [12]   69 	jr z, _canon_muerto
                             70 
                             71 
                             72 
   6998 E5            [11]   73 	push hl
   6999 CD 45 49      [17]   74 		call entityman_num_Bales
   699C 7E            [ 7]   75   		ld a , (hl)
   699D E1            [10]   76 	pop hl
   699E B7            [ 4]   77 		or a
   699F 28 7E         [12]   78 		jr z,_no_hay_balas	
   69A1 67            [ 4]   79 		ld h, a
                             80 
                             81 		
   69A2 DD 2A 8C 69   [20]   82 		ld ix, (_puntero_balas)
                             83 
   69A6                      84 		_loop_balas:
   69A6 16 01         [ 7]   85 		 ld d ,#1 				;; 1 no choca en x 0 si choca en x
                             86 
                             87 
                             88 		 ;;comprobar si choca en x
                             89 
                             90 
   69A8 FD 46 00      [19]   91 		ld b , e_x(iy) 				;;b esquina izquierda en x canon
   69AB FD 4E 14      [19]   92 		ld c , e_ancho(iy)			 
                             93 
                             94 
   69AE 78            [ 4]   95 		ld a, b
   69AF 81            [ 4]   96 		add c
   69B0 4F            [ 4]   97 		ld c, a					;; c esquina derecha en x canon
                             98 
                             99 
   69B1 DD 7E 00      [19]  100 		ld a , b_x(ix)				
   69B4 91            [ 4]  101 		sub c						;; comprobamos si la esquina derecha de canon es mayor que la esquina izquierda de la bala 
   69B5 30 4E         [12]  102 		jr nc , _no_choca_x
   69B7                     103 		_segundo_caso_x:
                            104 
   69B7 DD 7E 00      [19]  105 			ld a, b_x(ix)
   69BA DD 86 0A      [19]  106 			add b_w(ix)	
   69BD 90            [ 4]  107 			sub b
                            108 
   69BE 38 45         [12]  109 			jr c ,_no_choca_x
   69C0                     110 			_choca_en_x:
   69C0 16 00         [ 7]  111 				ld d, #0	
                            112 		
                            113 
                            114 		
                            115 
                            116 		;; comprobamos la y
                            117 
                            118 		;;b esquina arriba en y canon
   69C2 FD 46 01      [19]  119 		ld b , e_y(iy) 
   69C5 FD 4E 15      [19]  120 		ld c , e_alto(iy)	
   69C8 78            [ 4]  121 		ld a, b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   69C9 81            [ 4]  122 		add c
   69CA 4F            [ 4]  123 		ld c, a					;; c esquina abajo en y canon
                            124 			
   69CB DD 7E 01      [19]  125 		ld a , b_y(ix)		
   69CE 91            [ 4]  126 		sub c
   69CF 30 34         [12]  127 		jr nc, _no_choca_y
   69D1                     128 		_segundo_caso_y:
                            129 
   69D1 DD 7E 01      [19]  130 			ld a, b_y(ix)
   69D4 DD 86 09      [19]  131 			add b_h(ix)	
   69D7 90            [ 4]  132 			sub b
   69D8 38 2B         [12]  133 			jr c ,_no_choca_y
   69DA                     134 			_choca_en_y::
   69DA 7A            [ 4]  135 					ld a ,d
   69DB B7            [ 4]  136 					or a
   69DC 20 27         [12]  137 					jr nz, _no_choca_x			
                            138 
   69DE E5            [11]  139 					push hl
   69DF DD E5         [15]  140 					push ix
   69E1 FD E5         [15]  141 					push iy
                            142 						
                            143 						
   69E3 CD E8 54      [17]  144 						call limpiar_ultimo
   69E6 CD 45 49      [17]  145 						call entityman_num_Bales   ;; Vuelvo a recuperar el numero de balas que hay, ya que, con la llamada anterior, he perdido dicho dato
   69E9 7E            [ 7]  146   						ld a, (hl)                 ;; Cargo, en el registro A, el numero de balas que hay, con tal de pasarselo al sistema denominado kill_bullet
   69EA FD 36 0C 01   [19]  147 						ld e_dead(iy), #1
                            148 
   69EE FD E5         [15]  149 						push iy
   69F0 CD DF 55      [17]  150 							call kill_bullet				
                            151 						
   69F3 CD C3 61      [17]  152 							call jugador_muerto
   69F6 FD E1         [14]  153 						pop iy
   69F8 CD 2B 57      [17]  154 						call sonido_muerte
   69FB CD 03 51      [17]  155 						call iniciar_animacion_canon
   69FE FD E1         [14]  156 					pop iy
   6A00 DD E1         [14]  157 					pop ix
   6A02 E1            [10]  158 					pop hl
                            159 
   6A03 18 0A         [12]  160 					jr _repito_bala
                            161 
   6A05                     162 		_no_choca_x:
   6A05                     163 		_no_choca_y:
                            164 
                            165 		
                            166 
                            167 
                            168 		
                            169 
   6A05 01 0E 00      [10]  170 		ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA BALA
   6A08 DD 09         [15]  171 		add ix, bc
   6A0A 25            [ 4]  172 		dec h
   6A0B 20 99         [12]  173 		jr nz, _loop_balas
   6A0D 18 07         [12]  174 		jr _no_hay_mas
                            175 
   6A0F                     176 		_repito_bala:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            177 
                            178 		
   6A0F 7C            [ 4]  179 		ld a ,h
   6A10 25            [ 4]  180 		dec h
   6A11 3D            [ 4]  181 		dec a
                            182 
   6A12 28 02         [12]  183 		jr z ,_no_hay_mas
   6A14 20 90         [12]  184 		jr nz, _loop_balas
                            185 
   6A16                     186 	_canon_muerto:
   6A16                     187 	_no_hay_mas:
   6A16 01 17 00      [10]  188 	ld bc, #siceof_e    ;;NUMERO DE BYTES QUE TIENE CADA canon
   6A19 FD 09         [15]  189 	add iy, bc
   6A1B 2D            [ 4]  190 	dec l
   6A1C C2 92 69      [10]  191 	jp nz, _loop_canon
                            192 
                            193 
   6A1F                     194 _no_hay_balas:
   6A1F C9            [10]  195 	ret
                            196 
