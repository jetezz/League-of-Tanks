ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_patrol
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "../man/entity_manager.h.s"
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



                              5 .include "../man/patrol_manager.h.s"
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



                              6 
                              7 
                              8 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              9 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             10 ;;PATRONES PARA EL SINGLE PLAYER;;
                             11 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             12 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             13 
                             14 
                             15 
                             16 
                             17 ;;;;;;;;;;;;;;;;;;
                             18 ;;MAPA 1 single;;;
                             19 ;;;;;;;;;;;;;;;;;;
                             20 
                             21 
   647F                      22 patrol_nivel_single1::
   647F CD 57 48      [17]   23 call entityman_getEntityVector_IX
                             24 
   6482 11 17 00      [10]   25 ld de, #siceof_e
   6485 DD 19         [15]   26 add ix, de
                             27 
   6487 CD 6A 41      [17]   28 call man_patrol_single_11_get
   648A DD 74 10      [19]   29 ld e_ia_puntero_patrol_h(ix), h
   648D DD 75 11      [19]   30 ld e_ia_puntero_patrol_l(ix), l
   6490 DD 19         [15]   31 add ix, de
                             32 
   6492 CD 6E 41      [17]   33 call man_patrol_single_12_get
   6495 DD 74 10      [19]   34 ld e_ia_puntero_patrol_h(ix), h
   6498 DD 75 11      [19]   35 ld e_ia_puntero_patrol_l(ix), l
   649B DD 19         [15]   36 add ix, de
                             37 
   649D CD 72 41      [17]   38 call man_patrol_single_13_get
   64A0 DD 74 10      [19]   39 ld e_ia_puntero_patrol_h(ix), h
   64A3 DD 75 11      [19]   40 ld e_ia_puntero_patrol_l(ix), l
                             41 
   64A6 C9            [10]   42 ret
                             43 ;;;;;;;;;;;;;;;;;;
                             44 ;;MAPA 2 single;;;
                             45 ;;;;;;;;;;;;;;;;;;
                             46 
                             47 
   64A7                      48 patrol_nivel_single2::
   64A7 CD 57 48      [17]   49 call entityman_getEntityVector_IX
                             50 
   64AA 11 17 00      [10]   51 ld de, #siceof_e
   64AD DD 19         [15]   52 add ix, de
                             53 
   64AF CD 76 41      [17]   54 call man_patrol_single_21_get
   64B2 DD 74 10      [19]   55 ld e_ia_puntero_patrol_h(ix), h
   64B5 DD 75 11      [19]   56 ld e_ia_puntero_patrol_l(ix), l
   64B8 DD 19         [15]   57 add ix, de
                             58 
   64BA CD 7A 41      [17]   59 call man_patrol_single_22_get
   64BD DD 74 10      [19]   60 ld e_ia_puntero_patrol_h(ix), h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   64C0 DD 75 11      [19]   61 ld e_ia_puntero_patrol_l(ix), l
   64C3 DD 19         [15]   62 add ix, de
                             63 
   64C5 CD 7E 41      [17]   64 call man_patrol_single_23_get
   64C8 DD 74 10      [19]   65 ld e_ia_puntero_patrol_h(ix), h
   64CB DD 75 11      [19]   66 ld e_ia_puntero_patrol_l(ix), l
                             67 
   64CE C9            [10]   68 ret
                             69 ;;;;;;;;;;;;;;;;;;
                             70 ;;MAPA 3 single;;;
                             71 ;;;;;;;;;;;;;;;;;;
                             72 
                             73 
   64CF                      74 patrol_nivel_single3::
   64CF CD 57 48      [17]   75 call entityman_getEntityVector_IX
                             76 
   64D2 11 17 00      [10]   77 ld de, #siceof_e
   64D5 DD 19         [15]   78 add ix, de
                             79 
   64D7 CD 82 41      [17]   80 call man_patrol_single_31_get
   64DA DD 74 10      [19]   81 ld e_ia_puntero_patrol_h(ix), h
   64DD DD 75 11      [19]   82 ld e_ia_puntero_patrol_l(ix), l
   64E0 DD 19         [15]   83 add ix, de
                             84 
   64E2 CD 86 41      [17]   85 call man_patrol_single_32_get
   64E5 DD 74 10      [19]   86 ld e_ia_puntero_patrol_h(ix), h
   64E8 DD 75 11      [19]   87 ld e_ia_puntero_patrol_l(ix), l
   64EB DD 19         [15]   88 add ix, de
                             89 
   64ED CD 8A 41      [17]   90 call man_patrol_single_33_get
   64F0 DD 74 10      [19]   91 ld e_ia_puntero_patrol_h(ix), h
   64F3 DD 75 11      [19]   92 ld e_ia_puntero_patrol_l(ix), l
                             93 
   64F6 C9            [10]   94 ret
                             95 
                             96 ;;;;;;;;;;;;;;;;;;
                             97 ;;MAPA 4 single;;;
                             98 ;;;;;;;;;;;;;;;;;;
                             99 
                            100 
   64F7                     101 patrol_nivel_single4::
   64F7 CD 57 48      [17]  102 call entityman_getEntityVector_IX
                            103 
   64FA 11 17 00      [10]  104 ld de, #siceof_e
   64FD DD 19         [15]  105 add ix, de
                            106 
   64FF CD 8E 41      [17]  107 call man_patrol_single_41_get
   6502 DD 74 10      [19]  108 ld e_ia_puntero_patrol_h(ix), h
   6505 DD 75 11      [19]  109 ld e_ia_puntero_patrol_l(ix), l
   6508 DD 19         [15]  110 add ix, de
                            111 
   650A CD 92 41      [17]  112 call man_patrol_single_42_get
   650D DD 74 10      [19]  113 ld e_ia_puntero_patrol_h(ix), h
   6510 DD 75 11      [19]  114 ld e_ia_puntero_patrol_l(ix), l
   6513 DD 19         [15]  115 add ix, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            116 
   6515 CD 96 41      [17]  117 call man_patrol_single_43_get
   6518 DD 74 10      [19]  118 ld e_ia_puntero_patrol_h(ix), h
   651B DD 75 11      [19]  119 ld e_ia_puntero_patrol_l(ix), l
                            120 
   651E C9            [10]  121 ret
                            122 ;;;;;;;;;;;;;;;;;;
                            123 ;;MAPA 5 single;;;
                            124 ;;;;;;;;;;;;;;;;;;
                            125 
                            126 
   651F                     127 patrol_nivel_single5::
   651F CD 57 48      [17]  128 call entityman_getEntityVector_IX
                            129 
   6522 11 17 00      [10]  130 ld de, #siceof_e
   6525 DD 19         [15]  131 add ix, de
                            132 
   6527 CD 9A 41      [17]  133 call man_patrol_single_51_get
   652A DD 74 10      [19]  134 ld e_ia_puntero_patrol_h(ix), h
   652D DD 75 11      [19]  135 ld e_ia_puntero_patrol_l(ix), l
   6530 DD 19         [15]  136 add ix, de
                            137 
   6532 CD 9E 41      [17]  138 call man_patrol_single_52_get
   6535 DD 74 10      [19]  139 ld e_ia_puntero_patrol_h(ix), h
   6538 DD 75 11      [19]  140 ld e_ia_puntero_patrol_l(ix), l
   653B DD 19         [15]  141 add ix, de
                            142 
   653D CD A2 41      [17]  143 call man_patrol_single_53_get
   6540 DD 74 10      [19]  144 ld e_ia_puntero_patrol_h(ix), h
   6543 DD 75 11      [19]  145 ld e_ia_puntero_patrol_l(ix), l
                            146 
   6546 C9            [10]  147 ret
                            148 ;;;;;;;;;;;;;;;;;;
                            149 ;;MAPA 6 single;;;
                            150 ;;;;;;;;;;;;;;;;;;
                            151 
                            152 
                            153 
   6547                     154 patrol_nivel_single6::
   6547 CD 57 48      [17]  155 call entityman_getEntityVector_IX
                            156 
   654A 11 17 00      [10]  157 ld de, #siceof_e
   654D DD 19         [15]  158 add ix, de
                            159 
   654F CD A6 41      [17]  160 call man_patrol_single_61_get
   6552 DD 74 10      [19]  161 ld e_ia_puntero_patrol_h(ix), h
   6555 DD 75 11      [19]  162 ld e_ia_puntero_patrol_l(ix), l
   6558 DD 19         [15]  163 add ix, de
                            164 
   655A CD AA 41      [17]  165 call man_patrol_single_62_get
   655D DD 74 10      [19]  166 ld e_ia_puntero_patrol_h(ix), h
   6560 DD 75 11      [19]  167 ld e_ia_puntero_patrol_l(ix), l
   6563 DD 19         [15]  168 add ix, de
                            169 
   6565 CD AE 41      [17]  170 call man_patrol_single_63_get
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   6568 DD 74 10      [19]  171 ld e_ia_puntero_patrol_h(ix), h
   656B DD 75 11      [19]  172 ld e_ia_puntero_patrol_l(ix), l
                            173 
   656E C9            [10]  174 ret
                            175 
                            176 
                            177 
                            178 
                            179 
                            180 
                            181 
                            182 
                            183 
                            184 
                            185 
                            186 
                            187 
                            188 
                            189 
                            190 
                            191 
                            192 
                            193 
                            194 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            195 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            196 ;;PATRONES PARA EL SINGLE PLAYER;;
                            197 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            198 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            199 
                            200 ;;;;;;;;;;;;;;;;;
                            201 ;;MAPA 1 MULTI;;;
                            202 ;;;;;;;;;;;;;;;;;
   656F                     203 patrol_nivel_multi1::
   656F CD 57 48      [17]  204 call entityman_getEntityVector_IX
                            205 
   6572 11 17 00      [10]  206 ld de, #siceof_e
   6575 DD 19         [15]  207 add ix, de
                            208 
   6577 CD B2 41      [17]  209 call man_patrol_multi_11_get
   657A DD 74 10      [19]  210 ld e_ia_puntero_patrol_h(ix), h
   657D DD 75 11      [19]  211 ld e_ia_puntero_patrol_l(ix), l
   6580 DD 19         [15]  212 add ix, de
                            213 
   6582 CD B6 41      [17]  214 call man_patrol_multi_12_get
   6585 DD 74 10      [19]  215 ld e_ia_puntero_patrol_h(ix), h
   6588 DD 75 11      [19]  216 ld e_ia_puntero_patrol_l(ix), l
   658B DD 19         [15]  217 add ix, de
                            218 
   658D CD BA 41      [17]  219 call man_patrol_multi_13_get
   6590 DD 74 10      [19]  220 ld e_ia_puntero_patrol_h(ix), h
   6593 DD 75 11      [19]  221 ld e_ia_puntero_patrol_l(ix), l
                            222 
   6596 C9            [10]  223 ret
                            224 
                            225 ;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            226 ;;MAPA 2 MULTI;;;
                            227 ;;;;;;;;;;;;;;;;;
   6597                     228 patrol_nivel_multi2::
   6597 CD 57 48      [17]  229 call entityman_getEntityVector_IX
                            230 
   659A 11 17 00      [10]  231 ld de, #siceof_e
   659D DD 19         [15]  232 add ix, de
                            233 
   659F CD BE 41      [17]  234 call man_patrol_multi_21_get
   65A2 DD 74 10      [19]  235 ld e_ia_puntero_patrol_h(ix), h
   65A5 DD 75 11      [19]  236 ld e_ia_puntero_patrol_l(ix), l
   65A8 DD 19         [15]  237 add ix, de
                            238 
   65AA CD C2 41      [17]  239 call man_patrol_multi_22_get
   65AD DD 74 10      [19]  240 ld e_ia_puntero_patrol_h(ix), h
   65B0 DD 75 11      [19]  241 ld e_ia_puntero_patrol_l(ix), l
   65B3 DD 19         [15]  242 add ix, de
                            243 
   65B5 CD C6 41      [17]  244 call man_patrol_multi_23_get
   65B8 DD 74 10      [19]  245 ld e_ia_puntero_patrol_h(ix), h
   65BB DD 75 11      [19]  246 ld e_ia_puntero_patrol_l(ix), l
                            247 
   65BE C9            [10]  248 ret
                            249 
                            250 ;;;;;;;;;;;;;;;;;
                            251 ;;MAPA 3 MULTI;;;
                            252 ;;;;;;;;;;;;;;;;;
                            253 
   65BF                     254 patrol_nivel_multi3::
   65BF CD 57 48      [17]  255 call entityman_getEntityVector_IX
                            256 
   65C2 11 17 00      [10]  257 ld de, #siceof_e
   65C5 DD 19         [15]  258 add ix, de
                            259 
   65C7 CD CA 41      [17]  260 call man_patrol_multi_31_get
   65CA DD 74 10      [19]  261 ld e_ia_puntero_patrol_h(ix), h
   65CD DD 75 11      [19]  262 ld e_ia_puntero_patrol_l(ix), l
   65D0 DD 19         [15]  263 add ix, de
                            264 
   65D2 CD CE 41      [17]  265 call man_patrol_multi_32_get
   65D5 DD 74 10      [19]  266 ld e_ia_puntero_patrol_h(ix), h
   65D8 DD 75 11      [19]  267 ld e_ia_puntero_patrol_l(ix), l
   65DB DD 19         [15]  268 add ix, de
                            269 
   65DD CD D2 41      [17]  270 call man_patrol_multi_33_get
   65E0 DD 74 10      [19]  271 ld e_ia_puntero_patrol_h(ix), h
   65E3 DD 75 11      [19]  272 ld e_ia_puntero_patrol_l(ix), l
                            273 
   65E6 C9            [10]  274 ret
                            275 
                            276 
                            277 
                            278 
                            279 
                            280 ;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            281 ;;MAPA 4 MULTI;;;
                            282 ;;;;;;;;;;;;;;;;;
                            283 
   65E7                     284 patrol_nivel_multi4::
   65E7 CD 57 48      [17]  285 call entityman_getEntityVector_IX
                            286 
   65EA 11 17 00      [10]  287 ld de, #siceof_e
   65ED DD 19         [15]  288 add ix, de
                            289 
   65EF CD D6 41      [17]  290 call man_patrol_multi_41_get
   65F2 DD 74 10      [19]  291 ld e_ia_puntero_patrol_h(ix), h
   65F5 DD 75 11      [19]  292 ld e_ia_puntero_patrol_l(ix), l
   65F8 DD 19         [15]  293 add ix, de
                            294 
   65FA CD DA 41      [17]  295 call man_patrol_multi_42_get
   65FD DD 74 10      [19]  296 ld e_ia_puntero_patrol_h(ix), h
   6600 DD 75 11      [19]  297 ld e_ia_puntero_patrol_l(ix), l
   6603 DD 19         [15]  298 add ix, de
                            299 
   6605 CD DE 41      [17]  300 call man_patrol_multi_43_get
   6608 DD 74 10      [19]  301 ld e_ia_puntero_patrol_h(ix), h
   660B DD 75 11      [19]  302 ld e_ia_puntero_patrol_l(ix), l
                            303 
   660E C9            [10]  304 ret
                            305 
                            306 
                            307 
                            308 
                            309 
                            310 
                            311 ;;;;;;;;;;;;;;;;;
                            312 ;;MAPA 5 MULTI;;;
                            313 ;;;;;;;;;;;;;;;;;
                            314 
                            315 
                            316 
                            317 
   660F                     318 patrol_nivel_multi5::
   660F CD 57 48      [17]  319 call entityman_getEntityVector_IX
                            320 
   6612 11 17 00      [10]  321 ld de, #siceof_e
   6615 DD 19         [15]  322 add ix, de
                            323 
   6617 CD E2 41      [17]  324 call man_patrol_multi_51_get
   661A DD 74 10      [19]  325 ld e_ia_puntero_patrol_h(ix), h
   661D DD 75 11      [19]  326 ld e_ia_puntero_patrol_l(ix), l
   6620 DD 19         [15]  327 add ix, de
                            328 
   6622 CD E6 41      [17]  329 call man_patrol_multi_52_get
   6625 DD 74 10      [19]  330 ld e_ia_puntero_patrol_h(ix), h
   6628 DD 75 11      [19]  331 ld e_ia_puntero_patrol_l(ix), l
   662B DD 19         [15]  332 add ix, de
                            333 
   662D CD EA 41      [17]  334 call man_patrol_multi_53_get
   6630 DD 74 10      [19]  335 ld e_ia_puntero_patrol_h(ix), h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   6633 DD 75 11      [19]  336 ld e_ia_puntero_patrol_l(ix), l
                            337 
   6636 C9            [10]  338 ret
                            339 
                            340 
                            341 
                            342 
                            343 ;;;;;;;;;;;;;;;;;
                            344 ;;MAPA 6 MULTI;;;
                            345 ;;;;;;;;;;;;;;;;;
                            346 
                            347 
   6637                     348 patrol_nivel_multi6::
   6637 CD 57 48      [17]  349 call entityman_getEntityVector_IX
                            350 
   663A 11 17 00      [10]  351 ld de, #siceof_e
   663D DD 19         [15]  352 add ix, de
                            353 
   663F CD EE 41      [17]  354 call man_patrol_multi_61_get
   6642 DD 74 10      [19]  355 ld e_ia_puntero_patrol_h(ix), h
   6645 DD 75 11      [19]  356 ld e_ia_puntero_patrol_l(ix), l
   6648 DD 19         [15]  357 add ix, de
                            358 
   664A CD F2 41      [17]  359 call man_patrol_multi_62_get
   664D DD 74 10      [19]  360 ld e_ia_puntero_patrol_h(ix), h
   6650 DD 75 11      [19]  361 ld e_ia_puntero_patrol_l(ix), l
   6653 DD 19         [15]  362 add ix, de
                            363 
   6655 CD F6 41      [17]  364 call man_patrol_multi_63_get
   6658 DD 74 10      [19]  365 ld e_ia_puntero_patrol_h(ix), h
   665B DD 75 11      [19]  366 ld e_ia_puntero_patrol_l(ix), l
                            367 
   665E C9            [10]  368 ret
