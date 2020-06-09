ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys create balas 2
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "../man/shot_manager.h.s"
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



                              6 .include "../man/entity_manager.h.s"
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



                              7 .include "sys/sys_create_bullet_2.h.s"
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



                              8 .include "../sys/sys_map_colision.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 .include "../sys/sys_interrup_music.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             10 
   532E 01                   11 velocidad_x:   .db  # _nivel_1x
   532F FF                   12 velocidad_x_n: .db  # _nivel_1x_n
   5330 04                   13 velocidad_y:   .db  # _nivel_1y
   5331 FC                   14 velocidad_y_n: .db  # _nivel_1y_n
   5332 00                   15 comprobaciones: .db #0
                             16 
   5333                      17 sys_create_bullet_init2::
                             18 
   5333 CD 40 49      [17]   19  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   5336 CD 45 49      [17]   20  call entityman_num_Bales	
   5339 22 51 53      [16]   21  ld (_contador_balas), hl
   533C DD 22 83 53   [20]   22  ld (_puntero_balas), ix
                             23 
   5340 C9            [10]   24  ret
                             25 
                             26 
                             27 
                             28 
                             29 ;;INPUT IX ENTIDAD QUE DISPARA
   5341                      30 hacer_disparo2::
   5341 3E 00         [ 7]   31 ld a, #0
   5343 32 32 53      [13]   32 ld (comprobaciones), a
                             33 
   5346 DD 7E 0B      [19]   34 ld a,e_sh(ix)
   5349 3D            [ 4]   35 dec a
   534A 28 03         [12]   36 jr z, _ya_ha_disparado        ;;compruebo si ha disparado o no
   534C                      37 _disparamos:
                             38 
   534C CD 50 53      [17]   39    call comprobar_bala            ;;no ha disparado y creo la bala
                             40  
   534F                      41 _ya_ha_disparado:
                             42 	
   534F C9            [10]   43 ret
                             44 
                             45 
                             46 
                             47 
   5350                      48 comprobar_bala::
                             49 
                             50 
                     0023    51 _contador_balas=.+1   
   5350 21 00 00      [10]   52 	ld hl, #0000 
   5353 7E            [ 7]   53 	ld a ,(hl) 
                             54 
   5354 FE 05         [ 7]   55 	cp #max_bales                            ;; numero maximo de balas que podemos tener
   5356 20 01         [12]   56 	jr nz , _No_maximo_balas  
   5358 C9            [10]   57 ret
   5359                      58 _No_maximo_balas:
                             59  							;;comprobar si choca contra la pared
                             60 
   5359 DD 46 00      [19]   61 ld b, e_x(ix) 
   535C DD 4E 01      [19]   62 ld c, e_y(ix)
   535F DD 66 0A      [19]   63 ld h, e_dir(ix)
   5362 CD BA 53      [17]   64 call coloocar_bala	  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5365 16 02         [ 7]   65 ld d, #b_width
   5367 1E 08         [ 7]   66 ld e, #b_height	
                             67 
                             68 						
   5369 CD 97 5E      [17]   69 	call comp_colisiones				;;compruebo si choca contra el mapa o no
   536C 3D            [ 4]   70 	dec a
   536D 28 01         [12]   71 	jr z,_crear_bala
                             72 	;;la bala choca con el mapa por lo que salgo de crear bala 
   536F C9            [10]   73   	ret
                             74 
                             75 
   5370                      76  	_crear_bala:
                             77 
                             78  
   5370 CD 1E 57      [17]   79 		call sonido_disparo
                             80 
   5373 CD 81 53      [17]   81 		call crear_bala
                             82 
                             83 		;;incremento el contador de bala
   5376 2A 51 53      [16]   84 		ld hl ,(_contador_balas)
   5379 7E            [ 7]   85 		ld a ,(hl)
   537A 3C            [ 4]   86 		inc a
   537B 77            [ 7]   87 		ld (hl),a
                             88 
                             89 		;;le ponemos el shot del canon a 1
   537C DD 36 0B 01   [19]   90 		ld e_sh(ix), #1
                             91 
                             92  
                             93 
                             94 
                             95   
   5380 C9            [10]   96 ret
                             97 
                             98 
                             99 
   5381                     100 crear_bala::
                            101 
                     0055   102 _puntero_balas=.+2		
   5381 FD 21 00 00   [14]  103 ld iy, #0000			;;IY PUNTERO AL ARRAY DE BALAS
                            104 					;;IX PUNTERO A CANON
   5385 2A 51 53      [16]  105 ld hl ,(_contador_balas)
   5388 7E            [ 7]  106 ld a, (hl)				;;A CONTADOR DE BALAS
                            107 
   5389 B7            [ 4]  108 or a
   538A 28 08         [12]  109 jr z, primera_bala
   538C 11 0E 00      [10]  110 ld de, #siceof_b
   538F                     111 _loop_posicionar_bala:
                            112 
   538F FD 19         [15]  113 	add iy, de
   5391 3D            [ 4]  114 	dec a
                            115 
   5392 20 FB         [12]  116 jr nz, _loop_posicionar_bala
                            117 
   5394                     118 primera_bala:
   5394 FD 22 BC 53   [20]  119 ld (_puntero_balas2),iy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            120 
                            121 
                            122 
   5398 DD 22 9D 53   [20]  123 ld (puntero_canon_hl), ix
                     006F   124 puntero_canon_hl=.+1
   539C 21 00 00      [10]  125 ld hl, #0000
                            126 
   539F FD 75 0C      [19]  127 ld b_canon_l(iy), l
   53A2 FD 74 0D      [19]  128 ld b_canon_h(iy), h
                            129 
                            130 
                            131 ;;comprobar direccion para ponerle la velocidad
   53A5 DD 46 00      [19]  132 ld b, e_x(ix) 
   53A8 DD 4E 01      [19]  133 ld c, e_y(ix)
   53AB DD 66 0A      [19]  134 ld h, e_dir(ix)
                            135 
   53AE 3E 01         [ 7]  136 ld a , #1
   53B0 32 32 53      [13]  137 ld (comprobaciones), a
   53B3 CD BA 53      [17]  138 call coloocar_bala
   53B6 CD 4C 54      [17]  139 call colocar_posicion
                            140 
   53B9 C9            [10]  141 ret
   53BA                     142 coloocar_bala::
                            143 
                     008E   144 _puntero_balas2=.+2		
   53BA FD 21 00 00   [14]  145 ld iy, #0000
   53BE 7C            [ 4]  146 ld a, h
                            147 
   53BF FE 01         [ 7]  148 cp #1
   53C1 28 0D         [12]  149 jr z,_izquierda
   53C3 FE 02         [ 7]  150 cp #2
   53C5 28 27         [12]  151 jr z,_arriba
   53C7 FE 03         [ 7]  152 cp #3
   53C9 28 44         [12]  153 jr z,_derecha
   53CB FE 04         [ 7]  154 cp #4
   53CD 28 60         [12]  155 jr z,_abajo 
   53CF C9            [10]  156 ret
                            157 
                            158 
   53D0                     159 _izquierda:
                            160 
   53D0 3A 32 53      [13]  161 	ld a, (comprobaciones)
   53D3 3D            [ 4]  162 	dec a
   53D4 20 0A         [12]  163 	jr nz, no_v_i
                            164 	;;velocidad
   53D6 3A 2F 53      [13]  165 	ld a, (velocidad_x_n)
   53D9 FD 77 06      [19]  166 	ld b_vx(iy),a
   53DC FD 36 07 00   [19]  167 	ld b_vy(iy),#0
                            168 	;;posicion
                            169 
   53E0                     170 	no_v_i:
                            171 
                            172 	.rept #3
                            173  	 dec b
                            174   	.endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   53E0 05            [ 4]    1  	 dec b
   53E1 05            [ 4]    1  	 dec b
   53E2 05            [ 4]    1  	 dec b
                            175 
   53E3 3E 10         [ 7]  176  	 ld a ,#alto_canon
   53E5 CB 3F         [ 8]  177  	 srl a
   53E7 81            [ 4]  178  	 add c
                            179 
                            180  	.rept #4
                            181  	 dec a
                            182   	.endm
   53E8 3D            [ 4]    1  	 dec a
   53E9 3D            [ 4]    1  	 dec a
   53EA 3D            [ 4]    1  	 dec a
   53EB 3D            [ 4]    1  	 dec a
   53EC 4F            [ 4]  183   	ld c,a
                            184  	 
                            185  		
                            186 
   53ED C9            [10]  187   	ret
                            188 
   53EE                     189 _arriba:
                            190 
                            191 
   53EE 3A 32 53      [13]  192 	ld a, (comprobaciones)
   53F1 3D            [ 4]  193 	dec a
   53F2 20 0A         [12]  194 	jr nz, no_v_a
                            195 	;;velocidad
   53F4 3A 31 53      [13]  196 	ld a, (velocidad_y_n)
   53F7 FD 36 06 00   [19]  197 	ld b_vx(iy),#0
   53FB FD 77 07      [19]  198 	ld b_vy(iy),a
                            199 	;;posicion
   53FE                     200 	no_v_a:
                            201 
                            202 	
                            203 
                            204 
   53FE 3E 04         [ 7]  205 	ld a ,#ancho_canon
   5400 CB 3F         [ 8]  206  	srl a
   5402 80            [ 4]  207   	add b 
   5403 3D            [ 4]  208   	dec a 
   5404 47            [ 4]  209   	ld b , a 
                            210 
                            211   	.rept #9
                            212   	dec c
                            213   	.endm
   5405 0D            [ 4]    1   	dec c
   5406 0D            [ 4]    1   	dec c
   5407 0D            [ 4]    1   	dec c
   5408 0D            [ 4]    1   	dec c
   5409 0D            [ 4]    1   	dec c
   540A 0D            [ 4]    1   	dec c
   540B 0D            [ 4]    1   	dec c
   540C 0D            [ 4]    1   	dec c
   540D 0D            [ 4]    1   	dec c
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            214   	
                            215 
                            216   		
   540E C9            [10]  217   	ret
                            218   	
   540F                     219 _derecha:
                            220 
                            221 
   540F 3A 32 53      [13]  222 	ld a, (comprobaciones)
   5412 3D            [ 4]  223 	dec a
   5413 20 0A         [12]  224 	jr nz, no_v_d
                            225 
                            226 	;;velocidad
   5415 3A 2E 53      [13]  227 	ld a, (velocidad_x)
   5418 FD 77 06      [19]  228 	ld b_vx(iy),a
   541B FD 36 07 00   [19]  229 	ld b_vy(iy),#0
                            230 	;;posicion
   541F                     231 	no_v_d:
                            232 
   541F 3E 04         [ 7]  233 	ld a ,#ancho_canon
   5421 80            [ 4]  234   	add b
   5422 3C            [ 4]  235  	inc a
   5423 47            [ 4]  236   	ld b,a
                            237 
   5424 3E 10         [ 7]  238   	ld a ,#alto_canon
   5426 CB 3F         [ 8]  239   	srl a  
   5428 81            [ 4]  240   	add c
                            241  
                            242   	.rept #4
                            243   	dec a
                            244   	.endm
   5429 3D            [ 4]    1   	dec a
   542A 3D            [ 4]    1   	dec a
   542B 3D            [ 4]    1   	dec a
   542C 3D            [ 4]    1   	dec a
   542D 4F            [ 4]  245   	ld c,a
                            246 
                            247   		
   542E C9            [10]  248   	ret
   542F                     249 _abajo:
                            250 
   542F 3A 32 53      [13]  251 	ld a, (comprobaciones)
   5432 3D            [ 4]  252 	dec a
   5433 20 0A         [12]  253 	jr nz, no_v_ab
                            254 
                            255 	;;velocidad
   5435 3A 30 53      [13]  256 	ld a, (velocidad_y)
   5438 FD 36 06 00   [19]  257 	ld b_vx(iy),#0
   543C FD 77 07      [19]  258 	ld b_vy(iy),a
                            259 	;;posicion
                            260 
   543F                     261 	no_v_ab:
   543F 3E 04         [ 7]  262 	ld a ,#ancho_canon
   5441 CB 3F         [ 8]  263 	srl a
   5443 80            [ 4]  264 	add b 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   5444 3D            [ 4]  265 	dec a
   5445 47            [ 4]  266 	ld b,a
                            267 
   5446 3E 10         [ 7]  268 	ld a ,#alto_canon 
   5448 81            [ 4]  269 	add c
   5449 3C            [ 4]  270 	inc a
   544A 4F            [ 4]  271 	ld c,a
                            272 
                            273   
   544B C9            [10]  274   	ret
                            275 
                            276 
                            277 
                            278 
                            279 
   544C                     280 colocar_posicion:
                            281 
   544C FD 70 00      [19]  282 	ld b_x(iy),b
   544F FD 70 02      [19]  283  	ld b_xl(iy),b
   5452 FD 70 04      [19]  284  	ld b_xll(iy),b
   5455 FD 71 01      [19]  285  	ld b_y(iy),c
   5458 FD 71 03      [19]  286  	ld b_yl(iy),c
   545B FD 71 05      [19]  287  	ld b_yll(iy),c
   545E FD 36 0A 02   [19]  288  	ld b_w(iy), #b_width
   5462 FD 36 09 08   [19]  289  	ld b_h(iy), #b_height
                            290 
   5466 C9            [10]  291 	ret
