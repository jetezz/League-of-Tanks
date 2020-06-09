ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys map colision
                              3 ;;
                              4 
                              5 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              6 .include "sys/sys_map_creator.h.s"
                              1 ;;
                              2 ;;sys_map_creator h
                              3 ;;
                              4 
                              5 
                              6 
                              7 
                              8 .globl draw_map_sinhud
                              9 .globl draw_map
                             10 .globl next_map
                             11 .globl reset_lvl
                             12 .globl cambiar_colisiones
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              7 .include "assets.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              8 .include "man/state_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             10 .include "man/st_game_over.h.s"
                              1 ;;
                              2 ;;Draw map h
                              3 ;;
                              4 
                              5 .globl updategameover_init
                              6 .globl updategameover
                              7 .globl set_winner_pos
                              8 .globl estado_game_over
                              9 .globl reiniciar_gameover
                             10 .globl single_end_init
                             11 .globl single_end_update
                             12 .globl kill_all
                             13 
                     0001    14 single_muere=1
                     0000    15 mueren_todos=0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             11 
                             12 
                             13 
                             14 
   5E94 2C 3B                15 _puntero_mapa: .dw #_mapa1
   5E96 00                   16 estado_colisiones: .db #00
                             17 
                             18 ;;INPUT:
                             19 
                             20 ;;B POSICION EN X
                             21 ;;C POSICION EN Y
                             22 ;;D ANCHO
                             23 ;;E ALTO
                             24 ;;H direcion que mira el canon  (solo para canon) en balas h 0
                             25 
                             26 ;; comprobar colisiones 
   5E97                      27 comp_colisiones::
                             28 
                             29 
                             30 ;; en b tengo x
                             31 ;; en c tengo y	
                             32 
   5E97 7C            [ 4]   33 	ld a ,h
                             34 		
   5E98 FE 01         [ 7]   35 		cp #1
   5E9A 28 24         [12]   36 		jr z, _left
   5E9C FE 02         [ 7]   37 		cp #2
   5E9E 28 47         [12]   38 		jr z, _up
   5EA0 FE 03         [ 7]   39 		cp #3 
   5EA2 28 05         [12]   40 		jr z, _right
   5EA4 FE 04         [ 7]   41 		cp #4 
   5EA6 28 28         [12]   42 		jr z, _down
   5EA8 C9            [10]   43 ret
                             44 		
                             45 
                             46 	
                             47 	
                             48 
   5EA9                      49 		_right:
   5EA9 7A            [ 4]   50 			ld a, d    ;;(4)  	 SUMAMOS EL ANCHO
   5EAA 80            [ 4]   51 			add a,b
   5EAB 47            [ 4]   52 			ld b ,a
                             53 
   5EAC C5            [11]   54 			push bc
   5EAD D5            [11]   55 			push de	
   5EAE CD F7 5E      [17]   56 				call buscar_tile
   5EB1 D1            [10]   57 			pop de	
   5EB2 C1            [10]   58 			pop bc
                             59 			
   5EB3 3D            [ 4]   60 			dec a 
   5EB4 28 02         [12]   61 			jr z, _el_primero_pasa
   5EB6 3C            [ 4]   62 			inc a
   5EB7 C9            [10]   63 			ret
   5EB8                      64 			_el_primero_pasa:
   5EB8 7B            [ 4]   65 			ld a, e      ;; 15 SUMAMOS EL ALTO
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   5EB9 3D            [ 4]   66 			dec a
   5EBA 81            [ 4]   67 			add a,c
   5EBB 4F            [ 4]   68 			ld c ,a	
                             69 					
   5EBC CD F7 5E      [17]   70 			call buscar_tile	
   5EBF C9            [10]   71 			ret
                             72 			
                             73 
                             74 			
                             75 	
   5EC0                      76 		_left:
   5EC0 3E FF         [ 7]   77 			ld a, #-1
   5EC2 80            [ 4]   78 			add a,b
   5EC3 47            [ 4]   79 			ld b ,a
   5EC4 C5            [11]   80 			push bc
   5EC5 D5            [11]   81 			push de	
   5EC6 CD F7 5E      [17]   82 				call buscar_tile
   5EC9 D1            [10]   83 			pop de	
   5ECA C1            [10]   84 			pop bc
   5ECB 3D            [ 4]   85 			dec a 
   5ECC 28 EA         [12]   86 			jr z, _el_primero_pasa
   5ECE 3C            [ 4]   87 			inc a
   5ECF C9            [10]   88 			ret
                             89 		
                             90 
                             91 	
                             92 	
   5ED0                      93 		_down:
   5ED0 7B            [ 4]   94 			ld a, e    ;;(16)    SUMAMOS EL ALTO
   5ED1 81            [ 4]   95 			add a,c
   5ED2 4F            [ 4]   96 			ld c ,a
   5ED3 C5            [11]   97 			push bc
   5ED4 D5            [11]   98 			push de	
   5ED5 CD F7 5E      [17]   99 				call buscar_tile
   5ED8 D1            [10]  100 			pop de	
   5ED9 C1            [10]  101 			pop bc
   5EDA 3D            [ 4]  102 			dec a
   5EDB 28 02         [12]  103 			jr z, _el_primero_pasa_y
   5EDD 3C            [ 4]  104 			inc a
   5EDE C9            [10]  105 			ret
   5EDF                     106 			_el_primero_pasa_y:
   5EDF 7A            [ 4]  107 			ld a, d   ;;(3)   sumamos el ancho
   5EE0 3D            [ 4]  108 			dec a
   5EE1 80            [ 4]  109 			add a,b
   5EE2 47            [ 4]  110 			ld b ,a
   5EE3 CD F7 5E      [17]  111 			call buscar_tile
   5EE6 C9            [10]  112 			ret
                            113 			
                            114 		
   5EE7                     115 		_up:
                            116 			
   5EE7 3E FF         [ 7]  117 			ld a, #-1
   5EE9 81            [ 4]  118 			add a,c
   5EEA 4F            [ 4]  119 			ld c ,a
   5EEB C5            [11]  120 			push bc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5EEC D5            [11]  121 			push de	
   5EED CD F7 5E      [17]  122 				call buscar_tile
   5EF0 D1            [10]  123 			pop de	
   5EF1 C1            [10]  124 			pop bc
   5EF2 3D            [ 4]  125 			dec a
   5EF3 28 EA         [12]  126 			jr z, _el_primero_pasa_y
   5EF5 3C            [ 4]  127 			inc a
   5EF6 C9            [10]  128 			ret
                            129 
                            130 
                            131 		
                            132 
                            133 	
                            134 
                            135 
                            136 
                            137 
                            138 
                            139 
   5EF7                     140 buscar_tile::
                            141 
                            142 
                            143 
                            144 
                            145 
                            146 
                            147 
   5EF7 CB 39         [ 8]  148  srl c
   5EF9 CB 39         [ 8]  149  srl c
   5EFB CB 39         [ 8]  150  srl c
                            151 
                            152 
                            153  
                            154 
                            155 
   5EFD CB 38         [ 8]  156  srl b
   5EFF CB 38         [ 8]  157  srl b
                            158  	
                            159 
                            160  
   5F01 CD 1E 5F      [17]  161 call coger_puntero
                            162 
                            163 
   5F04 79            [ 4]  164 ld a, c
   5F05 B7            [ 4]  165 	or a
   5F06 28 07         [12]  166 		jr z, tile_0
   5F08                     167 		loop_y:
   5F08 11 14 00      [10]  168 			ld de, #20
   5F0B 19            [11]  169 			add hl, de
   5F0C 3D            [ 4]  170 			dec a	
   5F0D 20 F9         [12]  171 		jr nz, loop_y
                            172 
   5F0F                     173 	tile_0:
                            174 
   5F0F 16 00         [ 7]  175 	ld d, #0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5F11 58            [ 4]  176 	ld e, b
   5F12 19            [11]  177 	add hl, de  ;; aqui tengo el tile que le hemos pedido
                            178 
   5F13 7E            [ 7]  179 	ld a ,(hl)
   5F14 FE 01         [ 7]  180 	cp #01
   5F16 28 03         [12]  181 	jr z , _puedes_pasar
   5F18 3E 00         [ 7]  182 	ld a ,#0
   5F1A C9            [10]  183 	ret
   5F1B                     184 	_puedes_pasar:
   5F1B 3E 01         [ 7]  185 	ld a, #1
                            186 
   5F1D C9            [10]  187 	ret
                            188 
                            189 
                            190 
   5F1E                     191 coger_puntero::
                            192 
   5F1E 21 94 5E      [10]  193 ld hl, #_puntero_mapa
   5F21 7E            [ 7]  194 ld a, (hl)
   5F22 5F            [ 4]  195 ld e, a
   5F23 23            [ 6]  196 inc hl
   5F24 7E            [ 7]  197 ld a, (hl)
   5F25 57            [ 4]  198 ld d , a
   5F26 62            [ 4]  199 ld h, d
   5F27 6B            [ 4]  200 ld l, e
                            201 
   5F28 C9            [10]  202 	ret
                            203 
                            204 
                            205 
                            206 
                            207 
                            208 
                            209 
                            210 
                            211 
                            212 
                            213 
                            214 
                            215 
                            216 
   5F29                     217 cambiar_colisiones::
                            218 
                            219 
                            220 
   5F29 3A 96 5E      [13]  221 ld a, (estado_colisiones)
   5F2C FE 00         [ 7]  222 cp #sin_inicializar
   5F2E 20 1A         [12]  223 jr nz,_NO_inicializar_colisiones ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
   5F30                     224 _inicializar_colisiones:	;; inicializo el nivel y lo pongo en el nivel_1
                            225 
   5F30 CD 18 46      [17]  226 call get_gamemode				;;cojo el gamemode
   5F33 FE 05         [ 7]  227 cp #5
   5F35 28 08         [12]  228 jr z,_colisiones_single			;;inicializo para ir al single o al multi
   5F37                     229 _colision_multi:
                            230 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   5F37 21 DA 5F      [10]  231 ld hl, #_mapa_1_multi
   5F3A 22 51 5F      [16]  232 ld(_puntero_colision_siguiente),hl
   5F3D 18 06         [12]  233 jr salir
                            234 
   5F3F                     235 _colisiones_single:
                            236 
   5F3F 21 56 5F      [10]  237 ld hl, #_mapa_1_single
   5F42 22 51 5F      [16]  238 ld(_puntero_colision_siguiente),hl
                            239 
   5F45                     240 salir:
   5F45 3E 01         [ 7]  241 ld a, #siguiente_colision ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
   5F47 32 96 5E      [13]  242 ld (estado_colisiones),a
                            243 
   5F4A                     244 _NO_inicializar_colisiones: ;; salto al nivel que toca
                            245 
                            246 
   5F4A CD 37 44      [17]  247 call estado_game_over
   5F4D 3D            [ 4]  248 dec a
   5F4E 28 03         [12]  249 jr z,_reiniciar_posiciones
                            250 
                     00BD   251  _puntero_colision_siguiente=.+1
   5F50 C3 00 00      [10]  252  jp 0000
                            253 
   5F53                     254 _reiniciar_posiciones:
                     00C0   255  _puntero_repetir_colision=.+1
   5F53 C3 00 00      [10]  256  jp 0000
                            257 
                            258 
                            259 	
                            260 
   5F56                     261 	_mapa_1_single:
                            262 
   5F56 11 74 2F      [10]  263 	ld de, #_single_mapa1
   5F59 21 94 5E      [10]  264 	ld hl , #_puntero_mapa
   5F5C 73            [ 7]  265 	ld (hl), e
   5F5D 23            [ 6]  266 	inc hl
   5F5E 72            [ 7]  267 	ld (hl), d
                            268 
                            269 
                            270 
   5F5F 21 6C 5F      [10]  271 	ld hl, #_mapa_2_single		
   5F62 22 51 5F      [16]  272 	ld(_puntero_colision_siguiente),hl
                            273 
   5F65 21 56 5F      [10]  274 	ld hl, #_mapa_1_single		
   5F68 22 54 5F      [16]  275 	ld(_puntero_repetir_colision),hl
                            276 
                            277 
   5F6B C9            [10]  278 	ret
   5F6C                     279 	_mapa_2_single:
                            280 
   5F6C 11 80 2D      [10]  281 	ld de, #_single_mapa2
   5F6F 21 94 5E      [10]  282 	ld hl , #_puntero_mapa
   5F72 73            [ 7]  283 	ld (hl), e
   5F73 23            [ 6]  284 	inc hl
   5F74 72            [ 7]  285 	ld (hl), d
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            286 
                            287 
   5F75 21 82 5F      [10]  288 	ld hl, #_mapa_3_single		
   5F78 22 51 5F      [16]  289 	ld(_puntero_colision_siguiente),hl
                            290 
   5F7B 21 6C 5F      [10]  291 	ld hl, #_mapa_2_single		
   5F7E 22 54 5F      [16]  292 	ld(_puntero_repetir_colision),hl
                            293 
                            294 
   5F81 C9            [10]  295 	ret
   5F82                     296 	_mapa_3_single:
                            297 
   5F82 11 8C 2B      [10]  298 	ld de, #_single_mapa3
   5F85 21 94 5E      [10]  299 	ld hl , #_puntero_mapa
   5F88 73            [ 7]  300 	ld (hl), e
   5F89 23            [ 6]  301 	inc hl
   5F8A 72            [ 7]  302 	ld (hl), d
                            303 
                            304 
   5F8B 21 98 5F      [10]  305 	ld hl, #_mapa_4_single		
   5F8E 22 51 5F      [16]  306 	ld(_puntero_colision_siguiente),hl
                            307 
   5F91 21 82 5F      [10]  308 	ld hl, #_mapa_3_single		
   5F94 22 54 5F      [16]  309 	ld(_puntero_repetir_colision),hl
                            310 
                            311 
   5F97 C9            [10]  312 	ret
   5F98                     313 	_mapa_4_single:
                            314 
   5F98 11 98 29      [10]  315 	ld de, #_single_mapa4
   5F9B 21 94 5E      [10]  316 	ld hl , #_puntero_mapa
   5F9E 73            [ 7]  317 	ld (hl), e
   5F9F 23            [ 6]  318 	inc hl
   5FA0 72            [ 7]  319 	ld (hl), d
                            320 
                            321 
   5FA1 21 AE 5F      [10]  322 	ld hl, #_mapa_5_single		
   5FA4 22 51 5F      [16]  323 	ld(_puntero_colision_siguiente),hl
                            324 
   5FA7 21 98 5F      [10]  325 	ld hl, #_mapa_4_single		
   5FAA 22 54 5F      [16]  326 	ld(_puntero_repetir_colision),hl
                            327 
                            328 
   5FAD C9            [10]  329 	ret
   5FAE                     330 	_mapa_5_single:
                            331 
   5FAE 11 A4 27      [10]  332 	ld de, #_single_mapa5
   5FB1 21 94 5E      [10]  333 	ld hl , #_puntero_mapa
   5FB4 73            [ 7]  334 	ld (hl), e
   5FB5 23            [ 6]  335 	inc hl
   5FB6 72            [ 7]  336 	ld (hl), d
                            337 
                            338 
   5FB7 21 C4 5F      [10]  339 	ld hl, #_mapa_6_single		
   5FBA 22 51 5F      [16]  340 	ld(_puntero_colision_siguiente),hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            341 
   5FBD 21 AE 5F      [10]  342 	ld hl, #_mapa_5_single		
   5FC0 22 54 5F      [16]  343 	ld(_puntero_repetir_colision),hl
                            344 
                            345 
   5FC3 C9            [10]  346 	ret
   5FC4                     347 	_mapa_6_single:
                            348 
                            349 
   5FC4 11 B0 25      [10]  350 	ld de, #_single_mapa6
   5FC7 21 94 5E      [10]  351 	ld hl , #_puntero_mapa
   5FCA 73            [ 7]  352 	ld (hl), e
   5FCB 23            [ 6]  353 	inc hl
   5FCC 72            [ 7]  354 	ld (hl), d
                            355 
   5FCD 21 56 5F      [10]  356 	ld hl, #_mapa_1_single		
   5FD0 22 51 5F      [16]  357 	ld(_puntero_colision_siguiente),hl
                            358 
   5FD3 21 C4 5F      [10]  359 	ld hl, #_mapa_6_single		
   5FD6 22 54 5F      [16]  360 	ld(_puntero_repetir_colision),hl
   5FD9 C9            [10]  361 	ret
                            362 
                            363 
                            364 
                            365 
                            366 
                            367 
                            368 
                            369 
                            370 
                            371 
   5FDA                     372 	_mapa_1_multi:
                            373 
   5FDA 11 2C 3B      [10]  374 	ld de, #_mapa1
   5FDD 21 94 5E      [10]  375 	ld hl , #_puntero_mapa
   5FE0 73            [ 7]  376 	ld (hl), e
   5FE1 23            [ 6]  377 	inc hl
   5FE2 72            [ 7]  378 	ld (hl), d
                            379 
   5FE3 21 EA 5F      [10]  380 	ld hl, #_mapa_2_multi		
   5FE6 22 51 5F      [16]  381 	ld(_puntero_colision_siguiente),hl
                            382 
                            383 
                            384 
   5FE9 C9            [10]  385 	ret
   5FEA                     386 	_mapa_2_multi:
                            387 
   5FEA 11 38 39      [10]  388 	ld de, #_mapa2
   5FED 21 94 5E      [10]  389 	ld hl , #_puntero_mapa
   5FF0 73            [ 7]  390 	ld (hl), e
   5FF1 23            [ 6]  391 	inc hl
   5FF2 72            [ 7]  392 	ld (hl), d
                            393 
   5FF3 21 FA 5F      [10]  394 	ld hl, #_mapa_3_multi		
   5FF6 22 51 5F      [16]  395 	ld(_puntero_colision_siguiente),hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            396 
                            397 
   5FF9 C9            [10]  398 	ret
   5FFA                     399 	_mapa_3_multi:
                            400 
   5FFA 11 44 37      [10]  401 	ld de, #_mapa3
   5FFD 21 94 5E      [10]  402 	ld hl , #_puntero_mapa
   6000 73            [ 7]  403 	ld (hl), e
   6001 23            [ 6]  404 	inc hl
   6002 72            [ 7]  405 	ld (hl), d
                            406 
                            407 
   6003 21 0A 60      [10]  408 	ld hl, #_mapa_4_multi		
   6006 22 51 5F      [16]  409 	ld(_puntero_colision_siguiente),hl
   6009 C9            [10]  410 	ret
                            411 	
   600A                     412 	_mapa_4_multi:
                            413 
   600A 11 50 35      [10]  414 	ld de, #_mapa4
   600D 21 94 5E      [10]  415 	ld hl , #_puntero_mapa
   6010 73            [ 7]  416 	ld (hl), e
   6011 23            [ 6]  417 	inc hl
   6012 72            [ 7]  418 	ld (hl), d
                            419 
                            420 
   6013 21 1A 60      [10]  421 	ld hl, #_mapa_5_multi		
   6016 22 51 5F      [16]  422 	ld(_puntero_colision_siguiente),hl
   6019 C9            [10]  423 	ret
   601A                     424 	_mapa_5_multi:
                            425 
   601A 11 5C 33      [10]  426 	ld de, #_mapa5
   601D 21 94 5E      [10]  427 	ld hl , #_puntero_mapa
   6020 73            [ 7]  428 	ld (hl), e
   6021 23            [ 6]  429 	inc hl
   6022 72            [ 7]  430 	ld (hl), d
                            431 
                            432 
   6023 21 2A 60      [10]  433 	ld hl, #_mapa_6_multi		
   6026 22 51 5F      [16]  434 	ld(_puntero_colision_siguiente),hl
   6029 C9            [10]  435 	ret
   602A                     436 	_mapa_6_multi:
                            437 
   602A 11 68 31      [10]  438 	ld de, #_mapa6
   602D 21 94 5E      [10]  439 	ld hl , #_puntero_mapa
   6030 73            [ 7]  440 	ld (hl), e
   6031 23            [ 6]  441 	inc hl
   6032 72            [ 7]  442 	ld (hl), d
                            443 
   6033 21 DA 5F      [10]  444 	ld hl, #_mapa_1_multi		
   6036 22 51 5F      [16]  445 	ld(_puntero_colision_siguiente),hl
   6039 C9            [10]  446 	ret
                            447 	
                            448 
   603A                     449 reiniciar_colisiones::
   603A 3E 00         [ 7]  450 ld a,#0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   603C 32 96 5E      [13]  451 ld (estado_colisiones),a
   603F C9            [10]  452 	ret
