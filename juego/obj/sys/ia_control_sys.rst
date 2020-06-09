ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;IA ENTITY CONTROL SYSTEM
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



                              6 .include "man/patrol_manager.h.s"
                              1 ;;
                              2 ;;Patrol manager h
                              3 ;;
                              4 
                              5 ;;
                     FFFFFFFF     6 patrol_invalid_move_x =-1
                              7 
                              8 .globl man_patrol_single_11_get
                              9 .globl man_patrol_single_12_get
                             10 .globl man_patrol_single_13_get
                             11 .globl man_patrol_single_21_get
                             12 .globl man_patrol_single_22_get
                             13 .globl man_patrol_single_23_get
                             14 .globl man_patrol_single_31_get
                             15 .globl man_patrol_single_32_get
                             16 .globl man_patrol_single_33_get
                             17 .globl man_patrol_single_41_get
                             18 .globl man_patrol_single_42_get
                             19 .globl man_patrol_single_43_get
                             20 .globl man_patrol_single_51_get
                             21 .globl man_patrol_single_52_get
                             22 .globl man_patrol_single_53_get
                             23 .globl man_patrol_single_61_get
                             24 .globl man_patrol_single_62_get
                             25 .globl man_patrol_single_63_get
                             26 
                             27 .globl man_patrol_multi_11_get
                             28 .globl man_patrol_multi_12_get
                             29 .globl man_patrol_multi_13_get
                             30 .globl man_patrol_multi_21_get
                             31 .globl man_patrol_multi_22_get
                             32 .globl man_patrol_multi_23_get
                             33 .globl man_patrol_multi_31_get
                             34 .globl man_patrol_multi_32_get
                             35 .globl man_patrol_multi_33_get
                             36 .globl man_patrol_multi_41_get
                             37 .globl man_patrol_multi_42_get
                             38 .globl man_patrol_multi_43_get
                             39 .globl man_patrol_multi_51_get
                             40 .globl man_patrol_multi_52_get
                             41 .globl man_patrol_multi_53_get
                             42 .globl man_patrol_multi_61_get
                             43 .globl man_patrol_multi_62_get
                             44 .globl man_patrol_multi_63_get
                             45 
                             46 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 .include "sys_create_bullet.h.s"
                              1 ;;
                              2 ;;sys create bullet h
                              3 ;;
                              4 
                              5 .globl sys_create_bullet_init
                              6 .globl create_bullets_array
                              7 .globl hacer_disparo
                              8 
                              9 
                             10 
                     0001    11 _nivel_1x=1
                     0004    12 _nivel_1y=4
                     0002    13 _nivel_2x=2
                     0008    14 _nivel_2y=8
                             15 
                     FFFFFFFF    16 _nivel_1x_n=-1
                     FFFFFFFC    17 _nivel_1y_n=-4
                     FFFFFFFE    18 _nivel_2x_n=-2
                     FFFFFFF8    19 _nivel_2y_n=-8
                             20 
                             21 
                             22 .globl velocidad_balas
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 .include "sys_create_bullet_2.h.s"
                              1 ;;
                              2 ;;sys create balas 2 h
                              3 ;;
                              4 .globl sys_create_bullet_init2
                              5 .globl hacer_disparo2
                     0001     6 izquierda=1
                     0002     7 arriba =2
                     0003     8 derecha=3
                     0004     9 abajo =4
                             10 
                     0004    11 ancho_canon=4
                     0010    12 alto_canon=16
                             13 
                             14 
                     0001    15 _nivel_1x=1
                     0004    16 _nivel_1y=4
                     0002    17 _nivel_2x=2
                     0008    18 _nivel_2y=8
                             19 
                     FFFFFFFF    20 _nivel_1x_n=-1
                     FFFFFFFC    21 _nivel_1y_n=-4
                     FFFFFFFE    22 _nivel_2x_n=-2
                     FFFFFFF8    23 _nivel_2y_n=-8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              9 .include "ia_control_sys.h.s"
                              1 ;;
                              2 ;;IA ENTITY CONTROL SYSTEM h
                              3 ;;
                              4 
                              5 
                              6 ;; siempre impar que sino la liamos 
                     0033     7 _dificultad_ia_nive1=51
                     0029     8 _dificultad_ia_nive2=41
                     0019     9 _dificultad_ia_nive3=25
                     000F    10 _dificultad_ia_nive4=15
                             11 
                     0001    12 _nivel_1x=1
                     0004    13 _nivel_1y=4
                     0002    14 _nivel_2x=2
                     0008    15 _nivel_2y=8
                             16 
                     FFFFFFFF    17 _nivel_1x_n=-1
                     FFFFFFFC    18 _nivel_1y_n=-4
                     FFFFFFFE    19 _nivel_2x_n=-2
                     FFFFFFF8    20 _nivel_2y_n=-8
                             21 
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
                             28 .globl sys_ai_control_update
                             29 .globl sys_ai_control_init
                             30 .globl sys_ai_patrol
                             31 .globl sys_ia_stand_by
                             32 
                             33 .globl cambiar_dificultad_ia
                             34 .globl cambiar_velocidad_ia
                             35 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   6A20 33                   11 _iteraciones_ia: .db #_dificultad_ia_nive1
   6A21 20                   12 _contador_ia: .db #_iteraciones_ia
                             13 
   6A22 01                   14 _vel_x_ia: .db #_nivel_1x
   6A23 04                   15 _vel_y_ia: .db #_nivel_1y
   6A24 FF                   16 _vel_x_ia_n: .db #_nivel_1x_n
   6A25 FC                   17 _vel_y_ia_n: .db #_nivel_1y_n
                             18 
                             19 
                             20 
                             21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             22 ;;INIT
                             23 ;;IX = PUNTERO AL ARRAY DE ENTIDADES 
                             24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   6A26                      25 sys_ai_control_init::
   6A26 21 21 6A      [10]   26 	ld hl , #_contador_ia
                             27 
   6A29 3A 20 6A      [13]   28 	ld a,(_iteraciones_ia)
   6A2C 77            [ 7]   29 	ld (hl), a
                             30 
   6A2D 21 32 6A      [10]   31 	ld hl , #_num_patrol
   6A30 36 00         [10]   32 		ld (hl),#0
                             33 
                             34 
   6A32 00                   35 	_num_patrol: .db 0
   6A33 DD 22 5A 6A   [20]   36 	ld (_ent_array_prt),ix
   6A37 DD 22 5E 6A   [20]   37 	ld (_ent_array_inicio), ix
                             38 
                             39 
   6A3B CD 5C 48      [17]   40 	call entityman_num_entities
   6A3E 32 54 6A      [13]   41 	ld (_cont_entidad), a
   6A41 21 42 6B      [10]   42 	ld hl, #sys_ia_stand_by
   6A44                      43 _loop_init:
                             44 	
                             45 
   6A44 DD 74 12      [19]   46 	ld e_ia_puntero_st_h (ix), h
   6A47 DD 75 13      [19]   47 	ld e_ia_puntero_st_l (ix), l
                             48 
                             49 
                             50 
   6A4A 3D            [ 4]   51 	dec a
   6A4B C8            [11]   52 	ret z
                             53 
                             54 	
   6A4C 11 17 00      [10]   55 	ld de, #siceof_e
   6A4F DD 19         [15]   56 	add ix, de
   6A51 18 F1         [12]   57 	jr _loop_init
                             58 	
                             59 
                             60 
                             61 
                             62 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             63 ;;UPDATE
                             64 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   6A53                      65 sys_ai_control_update::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             66 
                     0034    67 _cont_entidad=.+1
   6A53 3E 00         [ 7]   68 ld a, #00	
   6A55 32 93 6A      [13]   69 ld (_ent_counter),a
                             70 
                     003A    71 _ent_array_prt = .+2
   6A58 DD 21 00 00   [14]   72 	ld ix, #0x0000
                             73 
                     003E    74 _ent_array_inicio = .+2
   6A5C FD 21 00 00   [14]   75 	ld iy, #0x0000
                             76 
   6A60                      77 _loop:
   6A60 DD 7E 0C      [19]   78 	ld a,e_dead(ix)
   6A63 3D            [ 4]   79 	dec a
   6A64 28 2C         [12]   80 	jr z ,_canon_muerto
   6A66 DD 7E 09      [19]   81 	ld a , e_ia_st(ix)   ;; estado de la entidad
   6A69 FE 00         [ 7]   82 	cp #e_ia_st_noIA
   6A6B 28 25         [12]   83 	jr z ,_no_ia_ent
                             84 
                             85 
   6A6D                      86 _IA_ent::
                             87 
                             88 		
   6A6D F5            [11]   89 	push af	
   6A6E FD E5         [15]   90 		push iy
   6A70 21 21 6A      [10]   91 			ld hl, #_contador_ia
   6A73 7E            [ 7]   92 			ld a, (hl)
   6A74 3D            [ 4]   93 			dec a
   6A75 28 02         [12]   94 			jr z, _hacer_shot
   6A77                      95 			_no_hago_shot:
   6A77 18 09         [12]   96 				jr  _no_disparamos
   6A79                      97 			_hacer_shot:
   6A79 3A 20 6A      [13]   98 				ld a,(_iteraciones_ia)
   6A7C 77            [ 7]   99 				ld (hl), a
                            100 
                            101 
   6A7D CD A0 6A      [17]  102 				call _compr_shoot	
   6A80 18 01         [12]  103 				jr _continue
   6A82                     104 			_no_disparamos:
   6A82 77            [ 7]  105 			ld (hl), a
   6A83                     106 			_continue:
   6A83 FD E1         [14]  107 		pop iy
   6A85 F1            [10]  108 	pop af
                            109 
                            110 
   6A86 DD 6E 13      [19]  111 	ld  l,e_ia_puntero_st_l(ix)
   6A89 DD 66 12      [19]  112 	ld  h,e_ia_puntero_st_h(ix)
   6A8C 22 90 6A      [16]  113 	ld (_puntero_a_stado), hl
                            114 
                            115 
                     0070   116 	_puntero_a_stado =.+1
   6A8F CD 00 00      [17]  117 	call  0000
                            118 	
                            119 
                            120 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            121 
                            122 	
                            123 
                            124 	
   6A92                     125 _no_ia_ent:
   6A92                     126 _canon_muerto:
                     0073   127 _ent_counter =.+1
   6A92 3E 00         [ 7]  128 	ld a , #0
   6A94 3D            [ 4]  129 	dec a
   6A95 C8            [11]  130 	ret z
                            131 
   6A96 32 93 6A      [13]  132 	ld (_ent_counter),a
   6A99 11 17 00      [10]  133 	ld de, #siceof_e
   6A9C DD 19         [15]  134 	add ix, de
                            135 	
   6A9E 18 C0         [12]  136 	jr _loop
                            137 	
                            138 
                            139 
                            140 
                            141 
                            142 
                            143 
                            144 ;;;;;;;;;;;;;;;;;;;;;
                            145 ;;FUNCIONES
                            146 ;;;;;;;;;;;;;;;;;;;;;;
                            147 
                            148 ;;
                            149 ;;conp_shoot
                            150 ;;
                            151 ;;INPUT
                            152 ;;ix PUNTERO DEL CANON ACTUAL
                            153 ;;iy PUNTERO AL PRIMER CANON
   6AA0                     154 _compr_shoot::
                            155 
                            156 
                            157 	
                            158 
                            159 
   6AA0 CD 5C 48      [17]  160 	call entityman_num_entities
   6AA3 57            [ 4]  161 	ld d , a			;;contador de canons
                            162 	
                            163 	
                            164 
   6AA4                     165 	_loop_shot:
                            166 
   6AA4 FD 7E 0C      [19]  167 	ld a, e_dead(iy)
   6AA7 3D            [ 4]  168 	dec a
   6AA8 CA 35 6B      [10]  169 	jp z, _canon_muerto_sh
                            170 
   6AAB 1E 00         [ 7]  171 	ld e, #0			;;el comprobador de x lo porngo a 0
                            172 
                            173 	
                            174 	;; comprobar colision en x
   6AAD DD 46 00      [19]  175 	ld b, e_x(ix) 		;; esquina izquierda ix
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   6AB0 DD 7E 14      [19]  176 	ld a, e_ancho(ix)
   6AB3 80            [ 4]  177 	add b
   6AB4 4F            [ 4]  178 	ld c, a			;; izquierda derecha ix
                            179 	
   6AB5 FD 7E 00      [19]  180 	ld a, e_x(iy)		;; esquina izquierda iy
   6AB8 91            [ 4]  181 	sub c
                            182 
   6AB9 30 0B         [12]  183 	jr nc, _no_colision_x
                            184 	;; segunda comprobacion
   6ABB FD 7E 00      [19]  185 	ld a, e_x(iy)
   6ABE FD 86 14      [19]  186 	add e_ancho(iy)
   6AC1 90            [ 4]  187 	sub b
                            188 
   6AC2 38 02         [12]  189 	jr c, _no_colision_x		
   6AC4                     190 	_hay_colision_en_x:
   6AC4 1E 01         [ 7]  191 	ld e, #1			;; si la x es igual el comprobador de la x lo pongo a 1
                            192 
   6AC6                     193 	_no_colision_x:			
                            194 	
                            195 
                            196 	;;comprobar colisiones en y
                            197 
   6AC6 DD 46 01      [19]  198 	ld b, e_y(ix) 
   6AC9 DD 7E 15      [19]  199 	ld a ,e_alto(ix)	
   6ACC 80            [ 4]  200 	add b
   6ACD 4F            [ 4]  201 	ld c ,a
                            202 
   6ACE FD 7E 01      [19]  203 	ld a, e_y(iy)
   6AD1 91            [ 4]  204 	sub c
   6AD2 30 46         [12]  205 	jr nc , _no_colision_y
                            206 	;;segunda comprobacion
   6AD4 FD 7E 01      [19]  207 	ld a, e_y(iy)
   6AD7 FD 86 15      [19]  208 	add e_alto(iy)
   6ADA 90            [ 4]  209 	sub b
                            210 	
   6ADB 38 3D         [12]  211 	jr c, _no_colision_y
   6ADD 1D            [ 4]  212 	dec e				;; la y es igual , compruebo la x
   6ADE 28 55         [12]  213 	jr z, _equals
                            214 		;; solo es igual en y
   6AE0 FD 7E 00      [19]  215 		ld a, e_x(iy) 		
   6AE3 DD 96 00      [19]  216 		sub e_x(ix)			;; hago una resta de las posiciones en x
   6AE6 30 29         [12]  217 		jr nc, _posicion_menor
   6AE8                     218 		_posicion_mayo:		;;estamos a la derecha	
   6AE8 DD 7E 0A      [19]  219 			ld a, e_dir(ix)		
   6AEB FE 01         [ 7]  220 			cp #e_dir_left		;; compruebo si tiene dispara a la izquierda
   6AED 28 02         [12]  221 			jr z, _disparamos
   6AEF 18 44         [12]  222 			jr  _salir_shot
   6AF1                     223 			_disparamos:
                            224 
                            225 			
                            226 			
                            227 
                            228 			
                            229 			
   6AF1 DD E5         [15]  230 			push ix
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   6AF3 C5            [11]  231 			push bc
   6AF4 FD E5         [15]  232 			push iy
   6AF6 FD 7E 09      [19]  233 			ld a, e_ia_st(iy)
   6AF9 FE 00         [ 7]  234 			cp #e_ia_st_noIA
   6AFB 20 03         [12]  235 			jr nz, _es_ia
   6AFD                     236 			_no_es_ia:
   6AFD CD 41 53      [17]  237 				call hacer_disparo2
   6B00                     238 			_es_ia:
                            239 
   6B00 CD 18 46      [17]  240 				call get_gamemode
   6B03 FE 05         [ 7]  241 				cp #5
   6B05 28 03         [12]  242 				jr z,_no_disparar_ia
   6B07                     243 				_disparamos_ia:
   6B07 CD 41 53      [17]  244 					call hacer_disparo2
   6B0A                     245 				_no_disparar_ia:
                            246 
   6B0A FD E1         [14]  247 			pop iy
   6B0C C1            [10]  248 			pop bc			
   6B0D DD E1         [14]  249 			pop ix
                            250 			
                            251 			
   6B0F 18 24         [12]  252 		jr   _salir_shot
   6B11                     253 		_posicion_menor:
   6B11 DD 7E 0A      [19]  254 			ld a, e_dir(ix)		
   6B14 FE 03         [ 7]  255 			cp #e_dir_right		;; compruebo si tiene dispara a la izquierda
   6B16 28 D9         [12]  256 			jr z, _disparamos
   6B18 18 1B         [12]  257 			jr   _salir_shot
                            258 			
                            259 	
                            260 		
   6B1A                     261 	_no_colision_y:		;; solo es 
   6B1A 1D            [ 4]  262 	dec e				;; comprobamos si es igual en x
   6B1B 20 18         [12]  263 	jr nz, _no_equals
                            264 	;; solo es igual  en x
   6B1D FD 7E 01      [19]  265 	ld a, e_y(iy) 		
   6B20 DD 96 01      [19]  266 		sub e_y(ix)			;; hago una resta de las posiciones en x
   6B23 30 09         [12]  267 		jr nc, _posicion_arriba
   6B25                     268 		_posicion_abajo:		;;estamos a la abajo	
   6B25 DD 7E 0A      [19]  269 			ld a, e_dir(ix)		
   6B28 FE 02         [ 7]  270 			cp #e_dir_top		;; compruebo si tiene dispara a la izquierda
   6B2A 28 C5         [12]  271 			jr z, _disparamos
                            272 			
                            273 				
                            274 
   6B2C 18 07         [12]  275 		jr   _salir_shot
   6B2E                     276 		_posicion_arriba:
   6B2E DD 7E 0A      [19]  277 			ld a, e_dir(ix)		
   6B31 FE 04         [ 7]  278 			cp #e_dir_bott		;; compruebo si tiene dispara a la izquierda
   6B33 28 BC         [12]  279 			jr z, _disparamos
                            280 		
                            281 			
                            282 	
                            283 		
                            284 
                            285 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   6B35                     286 	_salir_shot:
   6B35                     287 	_no_equals:
   6B35                     288 	_equals:
   6B35                     289 	_canon_muerto_sh:
                            290 
   6B35 7A            [ 4]  291 	ld a, d
   6B36 3D            [ 4]  292 	dec a
   6B37 C8            [11]  293 	ret z
                            294 
                            295 	
   6B38 11 17 00      [10]  296 	ld de, #siceof_e
   6B3B FD 19         [15]  297 	add iy, de
   6B3D 57            [ 4]  298 	ld d, a
                            299 	
   6B3E C3 A4 6A      [10]  300 	jp _loop_shot
   6B41 C9            [10]  301 ret
                            302 
                            303 
                            304 ;;
                            305 ;; STAND BY
                            306 ;;
   6B42                     307 sys_ia_stand_by::
                            308 
                            309 	
                            310 
   6B42 21 C9 6B      [10]  311 	ld hl, #sys_ai_patrol
                            312 
                            313 	
   6B45 DD 75 13      [19]  314 	ld e_ia_puntero_st_l(ix) ,l
   6B48 DD 74 12      [19]  315 	ld e_ia_puntero_st_h(ix) ,h
                            316 
                            317 	
                            318 
                            319 
   6B4B C9            [10]  320 	ret
                            321 
                            322 
                            323 
                            324 ;;
                            325 ;;MOVE TO
                            326 ;;
   6B4C                     327 sys_is_move_to::
   6B4C 06 01         [ 7]  328 	ld b, #1			;; valor para comprobar si en x hemos llegado
   6B4E DD 7E 0D      [19]  329 	ld a, e_ia_x(ix)    ;;a = x_objetivo
   6B51 DD 96 00      [19]  330 	sub e_x(ix)         ;;A= OBJ_X -X
   6B54 30 13         [12]  331 	jr nc, _obj_greater_or_equal_x ;; if( obj _x - x >0)
                            332 
                            333 
                            334 
   6B56                     335 _objx_lesser_x:
                            336 
   6B56 DD 36 06 00   [19]  337 	ld e_vx(ix), #0
   6B5A DD 7E 0A      [19]  338 	ld a,e_dir(ix)
   6B5D FE 01         [ 7]  339 	cp #e_dir_left
   6B5F 20 06         [12]  340 	jr nz, _no_mira_izquierda
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   6B61 3A 24 6A      [13]  341 		ld a, (_vel_x_ia_n) 	
   6B64 DD 77 06      [19]  342 		ld e_vx(ix), a	
   6B67                     343 	_no_mira_izquierda:
                            344 
   6B67 18 1B         [12]  345 	jr _endif_x
                            346 
                            347 
   6B69                     348 _obj_greater_or_equal_x:
   6B69 28 13         [12]  349 	jr z,_arrived_x
   6B6B DD 36 06 00   [19]  350 		ld e_vx(ix), #0
   6B6F DD 7E 0A      [19]  351 		ld a,e_dir(ix)
   6B72 FE 03         [ 7]  352 		cp #e_dir_right 
   6B74 20 06         [12]  353 		jr nz, _no_mira_derecha
   6B76 3A 22 6A      [13]  354 			ld a, (_vel_x_ia)
   6B79 DD 77 06      [19]  355 			ld e_vx(ix), a
   6B7C                     356 		_no_mira_derecha:
                            357 	
   6B7C 18 06         [12]  358 	jr _endif_x
   6B7E                     359 _arrived_x:
   6B7E DD 36 06 00   [19]  360 	ld e_vx(ix), #0
   6B82 06 00         [ 7]  361 	ld b, #0
                            362 	
                            363 
   6B84                     364 _endif_x:
                            365 	
                            366 
                            367 
                            368 
   6B84 DD 7E 0E      [19]  369 	ld a, e_ia_y(ix)    ;;a = x_objetivo
   6B87 DD 96 01      [19]  370 	sub e_y(ix)         ;;A= OBJ_X -X
   6B8A 30 13         [12]  371 	jr nc, _obj_greater_or_equal_y ;; if( obj _x - x >0)
                            372 
                            373 
                            374 
   6B8C                     375 _objx_lesser_y:
   6B8C DD 36 07 00   [19]  376 		ld e_vy(ix), #0
   6B90 DD 7E 0A      [19]  377 		ld a,e_dir(ix)
   6B93 FE 02         [ 7]  378 		cp #e_dir_top
   6B95 20 06         [12]  379 		jr nz, _no_mira_arriba
   6B97 3A 25 6A      [13]  380 			ld a,(_vel_y_ia_n)
   6B9A DD 77 07      [19]  381 			ld e_vy(ix), a
                            382 	
                            383 	
   6B9D                     384 	_no_mira_arriba:
   6B9D 18 29         [12]  385 	jr _endif_y
                            386 
                            387 
   6B9F                     388 _obj_greater_or_equal_y:
   6B9F 28 13         [12]  389 	jr z,_arrived_y
   6BA1 DD 36 07 00   [19]  390 		ld e_vy(ix), #0
   6BA5 DD 7E 0A      [19]  391 		ld a,e_dir(ix)
   6BA8 FE 04         [ 7]  392 		cp #e_dir_bott
   6BAA 20 06         [12]  393 		jr nz, _no_mira_abajo
   6BAC 3A 23 6A      [13]  394 		ld a,(_vel_y_ia)
   6BAF DD 77 07      [19]  395 		ld e_vy(ix), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   6BB2                     396 		_no_mira_abajo:
                            397 
                            398 	
   6BB2 18 14         [12]  399 	jr _endif_y
   6BB4                     400 _arrived_y:
                            401 
   6BB4 DD 36 07 00   [19]  402 	ld e_vy(ix), #0	
                            403 	
   6BB8 B0            [ 4]  404 	or b
   6BB9 20 0D         [12]  405 	jr nz, _endif_y
                            406 	;; x e y son las dos 0
                            407 
   6BBB DD 7E 0F      [19]  408 	ld a , e_ia_st_prev(ix)				;; ponto en mi estado actual el anterior
   6BBE DD 77 09      [19]  409 	ld e_ia_st(ix), a
   6BC1 DD 36 0F 02   [19]  410 	ld e_ia_st_prev(ix), #e_ia_st_move_to	;; actualizo el estado 
   6BC5 CD 00 6C      [17]  411 	call actualizar_puntero
                            412 
                            413 	
                            414 
                            415 
                            416 
   6BC8                     417 _endif_y:
   6BC8 C9            [10]  418 ret
                            419 
                            420 
                            421 
                            422 ;;;;;;;;;;;;;
                            423 ;;PATROL;;;;
                            424 ;;;;;;;;;;;;
                            425 
   6BC9                     426 sys_ai_patrol::
                            427 	;; hl es el puntero al primer byte de la patrulla 
   6BC9 DD 66 10      [19]  428 	ld h , e_ia_puntero_patrol_h(ix)
   6BCC DD 6E 11      [19]  429 	ld l , e_ia_puntero_patrol_l(ix)
                            430 
                            431 
                            432 	;; cargar cordenadas x y
   6BCF 7E            [ 7]  433 	ld a, (hl)
   6BD0 FE FF         [ 7]  434 	cp #patrol_invalid_move_x	;; comprobar si es el final de la patrulla
   6BD2 28 21         [12]  435 	jr z, _reset_patrol					;; salimos 
                            436 
   6BD4 DD 77 0D      [19]  437 	ld e_ia_x(ix), a
   6BD7 23            [ 6]  438 	inc hl
   6BD8 7E            [ 7]  439 	ld a, (hl)
   6BD9 DD 77 0E      [19]  440 	ld e_ia_y(ix), a
                            441 
                            442 	;; cambiar el puntero a la siguiente posicion
   6BDC 23            [ 6]  443 	inc hl
   6BDD DD 74 10      [19]  444 	ld e_ia_puntero_patrol_h (ix), h
   6BE0 DD 75 11      [19]  445 	ld e_ia_puntero_patrol_l (ix), l
                            446 
                            447 	;; cambio al estado move to
   6BE3 DD 36 0F 03   [19]  448 	ld e_ia_st_prev(ix), #e_ia_st_patron
   6BE7 DD 36 09 02   [19]  449 	ld e_ia_st(ix), #e_ia_st_move_to
                            450 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   6BEB 21 4C 6B      [10]  451 	ld hl, #sys_is_move_to
                            452 	
                            453 
   6BEE DD 75 13      [19]  454 	ld e_ia_puntero_st_l(ix) ,l
   6BF1 DD 74 12      [19]  455 	ld e_ia_puntero_st_h(ix) ,h
                            456 
   6BF4 C9            [10]  457 	ret
                            458 
   6BF5                     459 _reset_patrol:
                            460 
   6BF5 23            [ 6]  461 	inc hl
   6BF6 7E            [ 7]  462 	ld a , (hl)
   6BF7 DD 77 11      [19]  463 	ld e_ia_puntero_patrol_l (ix), a
   6BFA 23            [ 6]  464 	inc hl
   6BFB 7E            [ 7]  465 	ld a , (hl)
   6BFC DD 77 10      [19]  466 	ld e_ia_puntero_patrol_h (ix), a
                            467 
                            468 
   6BFF C9            [10]  469 	ret
                            470 
                            471 
                            472 
   6C00                     473 actualizar_puntero:
   6C00 3D            [ 4]  474 	dec a
   6C01 28 06         [12]  475 	jr z, _stan
   6C03 3D            [ 4]  476 	dec a
   6C04 28 08         [12]  477 	jr z, _move_to	
   6C06 3D            [ 4]  478 	dec a
   6C07 28 0A         [12]  479 	jr z, _patron
                            480 
   6C09                     481 _stan:
   6C09 21 42 6B      [10]  482 	ld hl, #sys_ia_stand_by
   6C0C 18 08         [12]  483 	jr _salir_actualizar
                            484 
                            485 
   6C0E                     486 _move_to:
                            487 
   6C0E 21 4C 6B      [10]  488 	ld hl, #sys_is_move_to	
   6C11 18 03         [12]  489 	jr _salir_actualizar
                            490 
                            491 
   6C13                     492 _patron:
   6C13 21 C9 6B      [10]  493 	ld hl, #sys_ai_patrol
                            494 
   6C16                     495 _salir_actualizar:
                            496 	
   6C16 DD 75 13      [19]  497 	ld e_ia_puntero_st_l(ix) ,l
   6C19 DD 74 12      [19]  498 	ld e_ia_puntero_st_h(ix) ,h
                            499 	
                            500 	
   6C1C C9            [10]  501 	ret
                            502 
                            503 
                            504 
                            505 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            506 
                            507 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            508 ;;funciones para cambiar los parametros
                            509 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            510 
                            511 ;;INPUT A DIFICULTAD PARA LA IA
   6C1D                     512 cambiar_dificultad_ia::
   6C1D FE 01         [ 7]  513 	cp #1
   6C1F 28 0C         [12]  514 jr z,_nivel_1
   6C21 FE 02         [ 7]  515 	cp #2
   6C23 28 0E         [12]  516 jr z,_nivel_2
   6C25 FE 03         [ 7]  517 	cp #3
   6C27 28 10         [12]  518 jr z,_nivel_3
   6C29 FE 04         [ 7]  519 	cp #4
   6C2B 28 12         [12]  520 jr z,_nivel_4
                            521 
                            522 
   6C2D                     523 _nivel_1:
   6C2D 3E 33         [ 7]  524 	ld a, #_dificultad_ia_nive1
   6C2F 32 20 6A      [13]  525 	ld (_iteraciones_ia), a
   6C32 C9            [10]  526 	ret
   6C33                     527 _nivel_2:
   6C33 3E 29         [ 7]  528 	ld a, #_dificultad_ia_nive2
   6C35 32 20 6A      [13]  529 	ld (_iteraciones_ia), a
   6C38 C9            [10]  530 	ret
                            531 
   6C39                     532 _nivel_3:
   6C39 3E 19         [ 7]  533 	ld a, #_dificultad_ia_nive3
   6C3B 32 20 6A      [13]  534 	ld (_iteraciones_ia), a
   6C3E C9            [10]  535 	ret
   6C3F                     536 _nivel_4:
   6C3F 3E 0F         [ 7]  537 	ld a, #_dificultad_ia_nive4
   6C41 32 20 6A      [13]  538 	ld (_iteraciones_ia), a
                            539 
                            540 
   6C44 C9            [10]  541 ret
                            542 
                            543 
                            544 ;;INPUT A EL NIVEL DE VELOCIDAD PARA LA IA
   6C45                     545 cambiar_velocidad_ia::
                            546 
   6C45 FE 01         [ 7]  547 	cp #1
   6C47 28 04         [12]  548 jr z,_nivel_1_v
   6C49 FE 02         [ 7]  549 	cp #2
   6C4B 28 15         [12]  550 jr z,_nivel_2_v
                            551 	
                            552 
                            553 
                            554 
                            555 
   6C4D                     556 _nivel_1_v:
   6C4D 3E 01         [ 7]  557 	ld a, #_nivel_1x
   6C4F 32 22 6A      [13]  558 	ld (_vel_x_ia), a
   6C52 3E FF         [ 7]  559 	ld a, #_nivel_1x_n
   6C54 32 24 6A      [13]  560 	ld (_vel_x_ia_n), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   6C57 3E 04         [ 7]  561 	ld a, #_nivel_1y
   6C59 32 23 6A      [13]  562 	ld (_vel_y_ia), a
   6C5C 3E FC         [ 7]  563 	ld a, #_nivel_1y_n
   6C5E 32 25 6A      [13]  564 	ld (_vel_y_ia_n), a
                            565 
   6C61 C9            [10]  566 	ret
   6C62                     567 _nivel_2_v:
   6C62 3E 02         [ 7]  568 	ld a, #_nivel_2x
   6C64 32 22 6A      [13]  569 	ld (_vel_x_ia), a
   6C67 3E FE         [ 7]  570 	ld a, #_nivel_2x_n
   6C69 32 24 6A      [13]  571 	ld (_vel_x_ia_n), a
   6C6C 3E 08         [ 7]  572 	ld a, #_nivel_2y
   6C6E 32 23 6A      [13]  573 	ld (_vel_y_ia), a
   6C71 3E F8         [ 7]  574 	ld a, #_nivel_2y_n
   6C73 32 25 6A      [13]  575 	ld (_vel_y_ia_n), a
   6C76 C9            [10]  576 	ret
                            577 
