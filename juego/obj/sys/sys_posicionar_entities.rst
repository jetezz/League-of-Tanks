ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_posicionar_entities
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "sys_posicionar_entities.h.s"
                              1 ;;
                              2 ;;sys_posicionar entities h
                              3 ;;
                              4 .globl posicion_entities
                              5 .globl reiniciar_posiciones
                     0000     6 sin_posicion=0
                     0001     7 siguiente_posicion=1
                     0002     8 partida_terminada=2
                              9 
                     0000    10 hay_entidad=0
                     0001    11 no_hay_entidad=1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "man/state_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "man/entity_manager.h.s"
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



                              8 .include "man/st_game_over.h.s"
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



                              9 
   5BA9 00                   10 estado_posiciones: .db #00
                             11 
                             12 
                             13 
                             14 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             15 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             16 ;;POSICIONAR LOS CANONS EN SINGLE PLAYER;; 
                             17 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             19 
   5BAA                      20 posicion_entities::
   5BAA 3A A9 5B      [13]   21 ld a, (estado_posiciones)
   5BAD FE 00         [ 7]   22 cp #sin_posicion
   5BAF 20 1A         [12]   23 jr nz,_NO_inicializar_posicion ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
   5BB1                      24 _inicializar_posicion:	;; inicializo el nivel y lo pongo en el nivel_1
                             25 
   5BB1 CD 18 46      [17]   26 call get_gamemode
   5BB4 FE 05         [ 7]   27 cp #5
   5BB6 28 08         [12]   28 jr z,_posiciones_single			;;inicializo para ir al single o al multi
   5BB8                      29 _posiciones_multi:
                             30 
   5BB8 21 5C 5D      [10]   31 ld hl, #pos_entities_multi_1
   5BBB 22 D2 5B      [16]   32 ld(_puntero_posicion),hl
   5BBE 18 06         [12]   33 jr salir
                             34 
   5BC0                      35 _posiciones_single:
                             36 
   5BC0 21 D7 5B      [10]   37 ld hl, #pos_entities_single_1
   5BC3 22 D2 5B      [16]   38 ld(_puntero_posicion),hl
                             39 
   5BC6                      40 salir:
                             41 
   5BC6 3E 01         [ 7]   42 ld a, #siguiente_posicion ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
   5BC8 32 A9 5B      [13]   43 ld (estado_posiciones),a
                             44 
   5BCB                      45 _NO_inicializar_posicion: ;; salto al nivel que toca
                             46 
   5BCB CD 37 44      [17]   47 call estado_game_over
   5BCE 3D            [ 4]   48 dec a
   5BCF 28 03         [12]   49 jr z,_reiniciar_posiciones
                             50 
                             51 
                     0029    52  _puntero_posicion=.+1
   5BD1 C3 00 00      [10]   53  jp 0000
                             54 
                             55 
   5BD4                      56 _reiniciar_posiciones:
                     002C    57   _puntero_posicion_reinicio=.+1
   5BD4 C3 00 00      [10]   58  jp 0000
                             59  
                             60 
                             61 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             62 ;;POSICIONES PARA EL MAPA 1  single;;;;;;
                             63 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   5BD7                      64 pos_entities_single_1::
   5BD7 CD 57 48      [17]   65 call entityman_getEntityVector_IX
                             66 
                             67 ;;en ix posicion de la entidad
                             68 ;;cargamos en a si hay(0) o si no(1)
                             69 ;;cargamos en h posicion x 
                             70 ;;cargamos en l posicion y
                             71 
                             72 ;;posicion entidad 1
   5BDA 3E 00         [ 7]   73 ld a, #hay_entidad
   5BDC 26 08         [ 7]   74 ld h,#8
   5BDE 2E 10         [ 7]   75 ld l,#16
   5BE0 CD 78 5E      [17]   76 call colocamos_entidad
   003A                      77 NextEntity
   5BE3 11 17 00      [10]    1 ld de, #siceof_e
   5BE6 DD 19         [15]    2 	add ix, de
                             78 
                             79 
                             80 ;;posicion entidad 2
   5BE8 3E 01         [ 7]   81 ld a, #no_hay_entidad
   5BEA CD 78 5E      [17]   82 call colocamos_entidad
   0044                      83 NextEntity
   5BED 11 17 00      [10]    1 ld de, #siceof_e
   5BF0 DD 19         [15]    2 	add ix, de
                             84 
                             85 
                             86 ;;posicion entidad 3
   5BF2 3E 01         [ 7]   87 ld a, #no_hay_entidad
   5BF4 CD 78 5E      [17]   88 call colocamos_entidad
   004E                      89 NextEntity
   5BF7 11 17 00      [10]    1 ld de, #siceof_e
   5BFA DD 19         [15]    2 	add ix, de
                             90 
                             91 ;;posicion entidad 4
   5BFC 3E 00         [ 7]   92 ld a, #hay_entidad
   5BFE 26 48         [ 7]   93 ld h,#72
   5C00 2E 70         [ 7]   94 ld l,#112
   5C02 CD 78 5E      [17]   95 call colocamos_entidad
   005C                      96 NextEntity
   5C05 11 17 00      [10]    1 ld de, #siceof_e
   5C08 DD 19         [15]    2 	add ix, de
                             97 
                             98 
                             99 
                            100 
                            101 
                            102 
   5C0A 21 17 5C      [10]  103 ld hl, #pos_entities_single_2		;;preparo para ir al siguiente nivel
   5C0D 22 D2 5B      [16]  104 ld(_puntero_posicion),hl
                            105 
   5C10 21 D7 5B      [10]  106 ld hl ,#pos_entities_single_1
   5C13 22 D5 5B      [16]  107 ld (_puntero_posicion_reinicio),hl
   5C16 C9            [10]  108 ret
                            109 	
                            110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            111 
                            112 
                            113 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            114 ;;POSICIONES PARA EL MAPA 2;;;;;;
                            115 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5C17                     116 pos_entities_single_2::
   5C17 CD 57 48      [17]  117 call entityman_getEntityVector_IX
                            118 
                            119 ;;en ix posicion de la entidad
                            120 ;;cargamos en a si hay(0) o si no(1)
                            121 ;;cargamos en h posicion x 
                            122 ;;cargamos en l posicion y
                            123 
                            124 ;;posicion entidad 1
   5C1A 3E 00         [ 7]  125 ld a, #hay_entidad
   5C1C 26 48         [ 7]  126 ld h,#72
   5C1E 2E 18         [ 7]  127 ld l,#24
   5C20 CD 78 5E      [17]  128 call colocamos_entidad
   007A                     129 NextEntity
   5C23 11 17 00      [10]    1 ld de, #siceof_e
   5C26 DD 19         [15]    2 	add ix, de
                            130 
                            131 
                            132 ;;posicion entidad 2
   5C28 3E 00         [ 7]  133 ld a, #hay_entidad
   5C2A 26 38         [ 7]  134 ld h,#56
   5C2C 2E 40         [ 7]  135 ld l,#64
   5C2E CD 78 5E      [17]  136 call colocamos_entidad
   0088                     137 NextEntity
   5C31 11 17 00      [10]    1 ld de, #siceof_e
   5C34 DD 19         [15]    2 	add ix, de
                            138 
                            139 
                            140 ;;posicion entidad 3
   5C36 3E 01         [ 7]  141 ld a, #no_hay_entidad
                            142 
   5C38 CD 78 5E      [17]  143 call colocamos_entidad
   0092                     144 NextEntity
   5C3B 11 17 00      [10]    1 ld de, #siceof_e
   5C3E DD 19         [15]    2 	add ix, de
                            145 
                            146 ;;posicion entidad 4
   5C40 3E 00         [ 7]  147 ld a, #hay_entidad
   5C42 26 08         [ 7]  148 ld h,#8
   5C44 2E 90         [ 7]  149 ld l,#144
   5C46 CD 78 5E      [17]  150 call colocamos_entidad
                            151 
                            152 
   5C49 21 56 5C      [10]  153 ld hl, #pos_entities_single_3		;;preparo para ir al siguiente nivel
   5C4C 22 D2 5B      [16]  154 ld(_puntero_posicion),hl
                            155 
   5C4F 21 17 5C      [10]  156 ld hl ,#pos_entities_single_2
   5C52 22 D5 5B      [16]  157 ld (_puntero_posicion_reinicio),hl
   5C55 C9            [10]  158 ret
                            159 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            160 
                            161 
                            162 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            163 ;;POSICIONES PARA EL MAPA 3;;;;;;
                            164 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5C56                     165 pos_entities_single_3::
   5C56 CD 57 48      [17]  166 call entityman_getEntityVector_IX
                            167 
                            168 ;;en ix posicion de la entidad
                            169 ;;cargamos en a si hay(0) o si no(1)
                            170 ;;cargamos en h posicion x 
                            171 ;;cargamos en l posicion y
                            172 
                            173 
                            174 ;;posicion entidad 1
   5C59 3E 00         [ 7]  175 ld a, #hay_entidad
   5C5B 26 14         [ 7]  176 ld h,#20
   5C5D 2E 50         [ 7]  177 ld l,#80
   5C5F CD 78 5E      [17]  178 call colocamos_entidad
   00B9                     179 NextEntity
   5C62 11 17 00      [10]    1 ld de, #siceof_e
   5C65 DD 19         [15]    2 	add ix, de
                            180 
                            181 
                            182 ;;posicion entidad 2
   5C67 3E 00         [ 7]  183 ld a, #hay_entidad
   5C69 26 08         [ 7]  184 ld h,#8
   5C6B 2E 30         [ 7]  185 ld l,#48
   5C6D CD 78 5E      [17]  186 call colocamos_entidad
   00C7                     187 NextEntity
   5C70 11 17 00      [10]    1 ld de, #siceof_e
   5C73 DD 19         [15]    2 	add ix, de
                            188 
                            189 
                            190 ;;posicion entidad 3
   5C75 3E 00         [ 7]  191 ld a, #hay_entidad
   5C77 26 26         [ 7]  192 ld h,#38
   5C79 2E 80         [ 7]  193 ld l,#128
   5C7B CD 78 5E      [17]  194 call colocamos_entidad
   00D5                     195 NextEntity
   5C7E 11 17 00      [10]    1 ld de, #siceof_e
   5C81 DD 19         [15]    2 	add ix, de
                            196 
                            197 ;;posicion entidad 4
   5C83 3E 00         [ 7]  198 ld a, #hay_entidad
   5C85 26 44         [ 7]  199 ld h,#68
   5C87 2E 30         [ 7]  200 ld l,#48
   5C89 CD 78 5E      [17]  201 call colocamos_entidad
                            202 
                            203 
   5C8C 21 99 5C      [10]  204 ld hl, #pos_entities_single_4		;;preparo para ir al siguiente nivel
   5C8F 22 D2 5B      [16]  205 ld(_puntero_posicion),hl
                            206 
   5C92 21 56 5C      [10]  207 ld hl ,#pos_entities_single_3
   5C95 22 D5 5B      [16]  208 ld (_puntero_posicion_reinicio),hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   5C98 C9            [10]  209 ret
                            210 	
                            211 
                            212 
                            213 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            214 ;;POSICIONES PARA EL MAPA 4;;;;;;
                            215 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5C99                     216 pos_entities_single_4::
   5C99 CD 57 48      [17]  217 call entityman_getEntityVector_IX
                            218 
                            219 ;;en ix posicion de la entidad
                            220 ;;cargamos en a si hay(0) o si no(1)
                            221 ;;cargamos en h posicion x 
                            222 ;;cargamos en l posicion y
                            223 
                            224 
                            225 ;;posicion entidad 1
   5C9C 3E 00         [ 7]  226 ld a, #hay_entidad
   5C9E 26 06         [ 7]  227 ld h,#6
   5CA0 2E 70         [ 7]  228 ld l,#112
   5CA2 CD 78 5E      [17]  229 call colocamos_entidad
   00FC                     230 NextEntity
   5CA5 11 17 00      [10]    1 ld de, #siceof_e
   5CA8 DD 19         [15]    2 	add ix, de
                            231 
                            232 
                            233 ;;posicion entidad 2
   5CAA 3E 00         [ 7]  234 ld a, #hay_entidad
   5CAC 26 48         [ 7]  235 ld h,#72
   5CAE 2E 50         [ 7]  236 ld l,#80
   5CB0 CD 78 5E      [17]  237 call colocamos_entidad
   010A                     238 NextEntity
   5CB3 11 17 00      [10]    1 ld de, #siceof_e
   5CB6 DD 19         [15]    2 	add ix, de
                            239 
                            240 
                            241 ;;posicion entidad 3
   5CB8 3E 00         [ 7]  242 ld a, #hay_entidad
   5CBA 26 1A         [ 7]  243 ld h,#26
   5CBC 2E 50         [ 7]  244 ld l,#80
   5CBE CD 78 5E      [17]  245 call colocamos_entidad
   0118                     246 NextEntity
   5CC1 11 17 00      [10]    1 ld de, #siceof_e
   5CC4 DD 19         [15]    2 	add ix, de
                            247 
                            248 ;;posicion entidad 4
   5CC6 3E 00         [ 7]  249 ld a, #hay_entidad
   5CC8 26 30         [ 7]  250 ld h,#48
   5CCA 2E 50         [ 7]  251 ld l,#80
   5CCC CD 78 5E      [17]  252 call colocamos_entidad
                            253 
                            254 
                            255 
                            256 
   5CCF 21 DC 5C      [10]  257 ld hl, #pos_entities_single_5		;;preparo para ir al siguiente nivel
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   5CD2 22 D2 5B      [16]  258 ld(_puntero_posicion),hl
                            259 
   5CD5 21 99 5C      [10]  260 ld hl ,#pos_entities_single_4
   5CD8 22 D5 5B      [16]  261 ld (_puntero_posicion_reinicio),hl
   5CDB C9            [10]  262 ret
                            263 	
                            264 
                            265 
                            266 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            267 ;;POSICIONES PARA EL MAPA 5;;;;;;
                            268 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5CDC                     269 pos_entities_single_5::
   5CDC CD 57 48      [17]  270 call entityman_getEntityVector_IX
                            271 
                            272 ;;en ix posicion de la entidad
                            273 ;;cargamos en a si hay(0) o si no(1)
                            274 ;;cargamos en h posicion x 
                            275 ;;cargamos en l posicion y
                            276 
                            277 
                            278 ;;posicion entidad 1
   5CDF 3E 00         [ 7]  279 ld a, #hay_entidad
   5CE1 26 48         [ 7]  280 ld h,#72
   5CE3 2E 88         [ 7]  281 ld l,#136
   5CE5 CD 78 5E      [17]  282 call colocamos_entidad
   013F                     283 NextEntity
   5CE8 11 17 00      [10]    1 ld de, #siceof_e
   5CEB DD 19         [15]    2 	add ix, de
                            284 
                            285 
                            286 ;;posicion entidad 2
   5CED 3E 00         [ 7]  287 ld a, #hay_entidad
   5CEF 26 16         [ 7]  288 ld h,#22
   5CF1 2E 50         [ 7]  289 ld l,#80
   5CF3 CD 78 5E      [17]  290 call colocamos_entidad
   014D                     291 NextEntity
   5CF6 11 17 00      [10]    1 ld de, #siceof_e
   5CF9 DD 19         [15]    2 	add ix, de
                            292 
                            293 
                            294 ;;posicion entidad 3
   5CFB 3E 00         [ 7]  295 ld a, #hay_entidad
   5CFD 26 26         [ 7]  296 ld h,#38
   5CFF 2E 30         [ 7]  297 ld l,#48
   5D01 CD 78 5E      [17]  298 call colocamos_entidad
   015B                     299 NextEntity
   5D04 11 17 00      [10]    1 ld de, #siceof_e
   5D07 DD 19         [15]    2 	add ix, de
                            300 
                            301 ;;posicion entidad 4
   5D09 3E 00         [ 7]  302 ld a, #hay_entidad
   5D0B 26 36         [ 7]  303 ld h,#54
   5D0D 2E 10         [ 7]  304 ld l,#16
   5D0F CD 78 5E      [17]  305 call colocamos_entidad
                            306 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   5D12 21 1F 5D      [10]  307 ld hl, #pos_entities_single_6		;;preparo para ir al siguiente nivel
   5D15 22 D2 5B      [16]  308 ld(_puntero_posicion),hl
                            309 
   5D18 21 DC 5C      [10]  310 ld hl ,#pos_entities_single_5
   5D1B 22 D5 5B      [16]  311 ld (_puntero_posicion_reinicio),hl
   5D1E C9            [10]  312 ret
                            313 	
                            314 
                            315 
                            316 
                            317 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            318 ;;POSICIONES PARA EL MAPA 6;;;;;;
                            319 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5D1F                     320 pos_entities_single_6::
                            321 
   5D1F CD 57 48      [17]  322 call entityman_getEntityVector_IX
                            323 
                            324 ;;en ix posicion de la entidad
                            325 ;;cargamos en a si hay(0) o si no(1)
                            326 ;;cargamos en h posicion x 
                            327 ;;cargamos en l posicion y
                            328 
                            329 
                            330 ;;posicion entidad 1
   5D22 3E 00         [ 7]  331 ld a, #hay_entidad
   5D24 26 04         [ 7]  332 ld h,#4
   5D26 2E 90         [ 7]  333 ld l,#144
   5D28 CD 78 5E      [17]  334 call colocamos_entidad
   0182                     335 NextEntity
   5D2B 11 17 00      [10]    1 ld de, #siceof_e
   5D2E DD 19         [15]    2 	add ix, de
                            336 
                            337 
                            338 ;;posicion entidad 2
   5D30 3E 00         [ 7]  339 ld a, #hay_entidad
   5D32 26 16         [ 7]  340 ld h,#22
   5D34 2E 50         [ 7]  341 ld l,#80
   5D36 CD 78 5E      [17]  342 call colocamos_entidad
   0190                     343 NextEntity
   5D39 11 17 00      [10]    1 ld de, #siceof_e
   5D3C DD 19         [15]    2 	add ix, de
                            344 
                            345 
                            346 ;;posicion entidad 3
   5D3E 3E 00         [ 7]  347 ld a, #hay_entidad
   5D40 26 36         [ 7]  348 ld h,#54
   5D42 2E 50         [ 7]  349 ld l,#80
   5D44 CD 78 5E      [17]  350 call colocamos_entidad
   019E                     351 NextEntity
   5D47 11 17 00      [10]    1 ld de, #siceof_e
   5D4A DD 19         [15]    2 	add ix, de
                            352 
                            353 ;;posicion entidad 4
   5D4C 3E 00         [ 7]  354 ld a, #hay_entidad
   5D4E 26 48         [ 7]  355 ld h,#72
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   5D50 2E 10         [ 7]  356 ld l,#16
   5D52 CD 78 5E      [17]  357 call colocamos_entidad
                            358 
   5D55 21 1F 5D      [10]  359 ld hl ,#pos_entities_single_6
   5D58 22 D5 5B      [16]  360 ld (_puntero_posicion_reinicio),hl
                            361 
   5D5B C9            [10]  362 ret
                            363 
                            364 
                            365 
                            366 
                            367 
                            368 
                            369 
                            370 
                            371 
                            372 
                            373 
                            374 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                            375 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            376 ;;POSICIONAR LOS CANONS EN MULTIPLAYER;;;; 
                            377 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            378 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            379 
                            380 
                            381 
                            382 
                            383 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            384 ;;POSICIONES PARA EL MAPA 1;;;;;;
                            385 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5D5C                     386 pos_entities_multi_1::
                            387 
   5D5C CD 57 48      [17]  388 call entityman_getEntityVector_IX
                            389 
   5D5F 3E 00         [ 7]  390 ld a, #hay_entidad
   5D61 26 04         [ 7]  391 ld h,#4
   5D63 2E 10         [ 7]  392 ld l,#16
   5D65 CD 78 5E      [17]  393 call colocamos_entidad
   01BF                     394 NextEntity
   5D68 11 17 00      [10]    1 ld de, #siceof_e
   5D6B DD 19         [15]    2 	add ix, de
                            395 
                            396 
                            397 ;;posicion entidad 2
   5D6D 3E 00         [ 7]  398 ld a, #hay_entidad
   5D6F 26 04         [ 7]  399 ld h,#4
   5D71 2E 90         [ 7]  400 ld l,#144
   5D73 CD 78 5E      [17]  401 call colocamos_entidad
   01CD                     402 NextEntity
   5D76 11 17 00      [10]    1 ld de, #siceof_e
   5D79 DD 19         [15]    2 	add ix, de
                            403 
                            404 
                            405 ;;posicion entidad 3
   5D7B 3E 00         [ 7]  406 ld a, #hay_entidad
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   5D7D 26 48         [ 7]  407 ld h,#72
   5D7F 2E 10         [ 7]  408 ld l,#16
   5D81 CD 78 5E      [17]  409 call colocamos_entidad
   01DB                     410 NextEntity
   5D84 11 17 00      [10]    1 ld de, #siceof_e
   5D87 DD 19         [15]    2 	add ix, de
                            411 
                            412 ;;posicion entidad 4
   5D89 3E 00         [ 7]  413 ld a, #hay_entidad
   5D8B 26 48         [ 7]  414 ld h,#72
   5D8D 2E 90         [ 7]  415 ld l,#144
   5D8F CD 78 5E      [17]  416 call colocamos_entidad
   01E9                     417 NextEntity
   5D92 11 17 00      [10]    1 ld de, #siceof_e
   5D95 DD 19         [15]    2 	add ix, de
                            418 
                            419 
   5D97 21 9E 5D      [10]  420 ld hl, #pos_entities_multi_2		;;preparo para ir al siguiente nivel
   5D9A 22 D2 5B      [16]  421 ld(_puntero_posicion),hl
   5D9D C9            [10]  422 ret
                            423 
                            424 
                            425 
                            426 
                            427 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            428 ;;POSICIONES PARA EL MAPA 2;;;;;;
                            429 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5D9E                     430 pos_entities_multi_2::
                            431 
   5D9E CD 5C 5D      [17]  432 call #pos_entities_multi_1
                            433 
                            434 
   5DA1 21 A8 5D      [10]  435 ld hl, #pos_entities_multi_3		;;preparo para ir al siguiente nivel
   5DA4 22 D2 5B      [16]  436 ld(_puntero_posicion),hl
   5DA7 C9            [10]  437 ret
                            438 
                            439 
                            440 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            441 ;;POSICIONES PARA EL MAPA 3;;;;;;
                            442 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5DA8                     443 pos_entities_multi_3::
                            444 
   5DA8 CD 57 48      [17]  445 call entityman_getEntityVector_IX
                            446 
   5DAB 3E 00         [ 7]  447 ld a, #hay_entidad
   5DAD 26 04         [ 7]  448 ld h,#4
   5DAF 2E 20         [ 7]  449 ld l,#32
   5DB1 CD 78 5E      [17]  450 call colocamos_entidad
   020B                     451 NextEntity
   5DB4 11 17 00      [10]    1 ld de, #siceof_e
   5DB7 DD 19         [15]    2 	add ix, de
                            452 
                            453 
                            454 ;;posicion entidad 2
   5DB9 3E 00         [ 7]  455 ld a, #hay_entidad
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   5DBB 26 18         [ 7]  456 ld h,#24
   5DBD 2E 90         [ 7]  457 ld l,#144
   5DBF CD 78 5E      [17]  458 call colocamos_entidad
   0219                     459 NextEntity
   5DC2 11 17 00      [10]    1 ld de, #siceof_e
   5DC5 DD 19         [15]    2 	add ix, de
                            460 
                            461 
                            462 ;;posicion entidad 3
   5DC7 3E 00         [ 7]  463 ld a, #hay_entidad
   5DC9 26 34         [ 7]  464 ld h,#52
   5DCB 2E 10         [ 7]  465 ld l,#16
   5DCD CD 78 5E      [17]  466 call colocamos_entidad
   0227                     467 NextEntity
   5DD0 11 17 00      [10]    1 ld de, #siceof_e
   5DD3 DD 19         [15]    2 	add ix, de
                            468 
                            469 ;;posicion entidad 4
   5DD5 3E 00         [ 7]  470 ld a, #hay_entidad
   5DD7 26 48         [ 7]  471 ld h,#72
   5DD9 2E 80         [ 7]  472 ld l,#128
   5DDB CD 78 5E      [17]  473 call colocamos_entidad
   0235                     474 NextEntity
   5DDE 11 17 00      [10]    1 ld de, #siceof_e
   5DE1 DD 19         [15]    2 	add ix, de
                            475 
   5DE3 21 EA 5D      [10]  476 ld hl, #pos_entities_multi_4		;;preparo para ir al siguiente nivel
   5DE6 22 D2 5B      [16]  477 ld(_puntero_posicion),hl
   5DE9 C9            [10]  478 ret 
                            479 
                            480 
                            481 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            482 ;;POSICIONES PARA EL MAPA 4;;;;;;
                            483 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5DEA                     484 pos_entities_multi_4::
                            485 
   5DEA CD 5C 5D      [17]  486 call #pos_entities_multi_1
                            487 
                            488 
   5DED 21 F4 5D      [10]  489 ld hl, #pos_entities_multi_5		;;preparo para ir al siguiente nivel
   5DF0 22 D2 5B      [16]  490 ld(_puntero_posicion),hl
   5DF3 C9            [10]  491 ret 
                            492 
                            493 
                            494 
                            495 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            496 ;;POSICIONES PARA EL MAPA 5;;;;;;
                            497 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5DF4                     498 pos_entities_multi_5::
                            499 
   5DF4 CD 57 48      [17]  500 call entityman_getEntityVector_IX
                            501 
   5DF7 3E 00         [ 7]  502 ld a, #hay_entidad
   5DF9 26 24         [ 7]  503 ld h,#36
   5DFB 2E 10         [ 7]  504 ld l,#16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   5DFD CD 78 5E      [17]  505 call colocamos_entidad
   0257                     506 NextEntity
   5E00 11 17 00      [10]    1 ld de, #siceof_e
   5E03 DD 19         [15]    2 	add ix, de
                            507 
                            508 
                            509 ;;posicion entidad 2
   5E05 3E 00         [ 7]  510 ld a, #hay_entidad
   5E07 26 04         [ 7]  511 ld h,#4
   5E09 2E 90         [ 7]  512 ld l,#144
   5E0B CD 78 5E      [17]  513 call colocamos_entidad
   0265                     514 NextEntity
   5E0E 11 17 00      [10]    1 ld de, #siceof_e
   5E11 DD 19         [15]    2 	add ix, de
                            515 
                            516 
                            517 ;;posicion entidad 3
   5E13 3E 00         [ 7]  518 ld a, #hay_entidad
   5E15 26 48         [ 7]  519 ld h,#72
   5E17 2E 10         [ 7]  520 ld l,#16
   5E19 CD 78 5E      [17]  521 call colocamos_entidad
   0273                     522 NextEntity
   5E1C 11 17 00      [10]    1 ld de, #siceof_e
   5E1F DD 19         [15]    2 	add ix, de
                            523 
                            524 ;;posicion entidad 4
   5E21 3E 00         [ 7]  525 ld a, #hay_entidad
   5E23 26 28         [ 7]  526 ld h,#40
   5E25 2E 90         [ 7]  527 ld l,#144
   5E27 CD 78 5E      [17]  528 call colocamos_entidad
   0281                     529 NextEntity
   5E2A 11 17 00      [10]    1 ld de, #siceof_e
   5E2D DD 19         [15]    2 	add ix, de
                            530 
   5E2F 21 36 5E      [10]  531 ld hl, #pos_entities_multi_6		;;preparo para ir al siguiente nivel
   5E32 22 D2 5B      [16]  532 ld(_puntero_posicion),hl
   5E35 C9            [10]  533 ret 
                            534 
                            535 
                            536 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            537 ;;POSICIONES PARA EL MAPA 6;;;;;;
                            538 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   5E36                     539 pos_entities_multi_6::
   5E36 CD 57 48      [17]  540 call entityman_getEntityVector_IX
                            541 
   5E39 3E 00         [ 7]  542 ld a, #hay_entidad
   5E3B 26 04         [ 7]  543 ld h,#4
   5E3D 2E 10         [ 7]  544 ld l,#16
   5E3F CD 78 5E      [17]  545 call colocamos_entidad
   0299                     546 NextEntity
   5E42 11 17 00      [10]    1 ld de, #siceof_e
   5E45 DD 19         [15]    2 	add ix, de
                            547 
                            548 
                            549 ;;posicion entidad 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   5E47 3E 00         [ 7]  550 ld a, #hay_entidad
   5E49 26 04         [ 7]  551 ld h,#4
   5E4B 2E 90         [ 7]  552 ld l,#144
   5E4D CD 78 5E      [17]  553 call colocamos_entidad
   02A7                     554 NextEntity
   5E50 11 17 00      [10]    1 ld de, #siceof_e
   5E53 DD 19         [15]    2 	add ix, de
                            555 
                            556 
                            557 ;;posicion entidad 3
   5E55 3E 00         [ 7]  558 ld a, #hay_entidad
   5E57 26 48         [ 7]  559 ld h,#72
   5E59 2E 10         [ 7]  560 ld l,#16
   5E5B CD 78 5E      [17]  561 call colocamos_entidad
   02B5                     562 NextEntity
   5E5E 11 17 00      [10]    1 ld de, #siceof_e
   5E61 DD 19         [15]    2 	add ix, de
                            563 
                            564 ;;posicion entidad 4
   5E63 3E 00         [ 7]  565 ld a, #hay_entidad
   5E65 26 48         [ 7]  566 ld h,#72
   5E67 2E 90         [ 7]  567 ld l,#144
   5E69 CD 78 5E      [17]  568 call colocamos_entidad
   02C3                     569 NextEntity
   5E6C 11 17 00      [10]    1 ld de, #siceof_e
   5E6F DD 19         [15]    2 	add ix, de
                            570 
   5E71 21 5C 5D      [10]  571 ld hl, #pos_entities_multi_1		;;preparo para ir al siguiente nivel
   5E74 22 D2 5B      [16]  572 ld(_puntero_posicion),hl
   5E77 C9            [10]  573 ret 
                            574 
                            575 
   5E78                     576 colocamos_entidad:
   5E78 DD 74 00      [19]  577 ld e_x(ix),h
   5E7B DD 74 02      [19]  578 ld e_xl(ix),h 
   5E7E DD 74 04      [19]  579 ld e_xll(ix),h 
   5E81 DD 75 01      [19]  580 ld e_y(ix),l
   5E84 DD 75 03      [19]  581 ld e_yl(ix),l
   5E87 DD 75 05      [19]  582 ld e_yll(ix),l
   5E8A DD 77 0C      [19]  583 ld e_dead(ix), a
                            584 
                            585 
                            586 
   5E8D C9            [10]  587 ret
                            588 
                            589 
                            590 
   5E8E                     591 reiniciar_posiciones::
   5E8E 3E 00         [ 7]  592 	ld a ,#00
   5E90 32 A9 5B      [13]  593 	ld(estado_posiciones),a
   5E93 C9            [10]  594 ret
