ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_music
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "cpct_functions.h.s"
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



                              5 .include "sys_music.h.s"
                              1 ;;
                              2 ;;sys_music h
                              3 ;;
                              4 .globl sfxdisp
                              5 .globl sfxdead
                              6 .globl sfxwin
                              7 .globl sfxinteraccion
                              8 
                     0000     9 _parar=0
                     0001    10 _empezar=1
                     0002    11 _continuar=2
                             12 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                              7 
                              8 ;;(1B L ) sfx_num	Number of the instrument in the SFX Song (>0), same as the number given to the instrument in Arkos Tracker.
                              9 ;;(1B H ) volume	Volume [0-15], 0 = off, 15 = maximum volume.
                             10 ;;(1B E ) note	Note to be played with the given instrument [0-143]
                             11 ;;(1B D ) speed	Speed (0 = As original, [1-255] = new Speed (1 is fastest))
                             12 ;;(2B BC) inverted_pitch	Inverted Pitch (-0xFFFF -> 0xFFFF).  0 is no pitch.  The higher the pitch, the lower the sound.
                             13 ;;(1B A ) channel_bitmask	Bitmask representing channels to use for reproducing the sound (Ch.A = 001 (1), Ch.B = 010 (2), Ch.C = 100 (4))
                             14 
                             15 
                             16 
   5926                      17 sfxinteraccion::
                             18 
   5926 FE 01         [ 7]   19 cp #1
   5928 20 07         [12]   20 jr nz, _Noinicializar_intera
                             21 
   592A                      22 _inicializar_intera:
                             23 
   592A 11 34 59      [10]   24 ld de, #_estado4_1
   592D ED 53 32 59   [20]   25 ld(_siguiente_puntero_intera),de
                             26 
   5931                      27 _Noinicializar_intera:
                             28 
                     000C    29 _siguiente_puntero_intera=.+1
   5931 C3 00 00      [10]   30 jp 0000
                             31 
                             32 
                             33 
   5934                      34 	_estado4_1:
   5934 2E 02         [ 7]   35 		ld l ,#2
   5936 26 0F         [ 7]   36 		ld h, #15
   5938 1E 46         [ 7]   37 		ld e, #70
   593A 16 0A         [ 7]   38 		ld d, #10
   593C 01 00 00      [10]   39 		ld bc, #0000
   593F 3E 02         [ 7]   40 		ld a, #2
   5941 CD 7C 74      [17]   41 		call cpct_akp_SFXPlay_asm
                             42 
   5944 11 4E 59      [10]   43 		ld de, #_estado4_2
   5947 ED 53 32 59   [20]   44 		ld(_siguiente_puntero_intera),de
   594B 3E 02         [ 7]   45 		ld a, #_continuar
   594D C9            [10]   46 		ret
                             47 		
                             48 
   594E                      49 	_estado4_2:
   594E 2E 02         [ 7]   50 		ld l ,#2
   5950 26 0F         [ 7]   51 		ld h, #15
   5952 1E 4B         [ 7]   52 		ld e, #75
   5954 16 01         [ 7]   53 		ld d, #1
   5956 01 00 00      [10]   54 		ld bc, #0000
   5959 3E 02         [ 7]   55 		ld a, #2
   595B CD 7C 74      [17]   56 		call cpct_akp_SFXPlay_asm
                             57 
                             58 		
   595E 3E 00         [ 7]   59 		ld a, #_parar
                             60 		
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             61 
   5960 C9            [10]   62 ret
                             63 
                             64 
                             65 
   5961                      66 sfxdisp::
                             67 
                             68 
   5961 FE 01         [ 7]   69 	cp #1
   5963 20 07         [12]   70 jr nz, _Noinicializar_dis
                             71 
   5965                      72 _inicializar_disp:
                             73 
   5965 11 6F 59      [10]   74 ld de, #_estado_1
   5968 ED 53 6D 59   [20]   75 ld(_siguiente_puntero_disp),de
                             76 
   596C                      77 _Noinicializar_dis:
                             78 
                     0047    79 _siguiente_puntero_disp=.+1
   596C C3 00 00      [10]   80 jp 0000
                             81 
                             82 
                             83 
                             84 	
   596F                      85 	_estado_1:
   596F 2E 02         [ 7]   86 		ld l ,#2
   5971 26 0F         [ 7]   87 		ld h, #15
   5973 1E 3C         [ 7]   88 		ld e, #60
   5975 16 00         [ 7]   89 		ld d, #0
   5977 01 00 00      [10]   90 		ld bc, #0000
   597A 3E 02         [ 7]   91 		ld a, #2
   597C CD 7C 74      [17]   92 		call cpct_akp_SFXPlay_asm
                             93 
   597F 11 89 59      [10]   94 		ld de, #_estado_2
   5982 ED 53 6D 59   [20]   95 		ld(_siguiente_puntero_disp),de
   5986 3E 02         [ 7]   96 		ld a, #_continuar
   5988 C9            [10]   97 		ret
                             98 		
                             99 
   5989                     100 	_estado_2:
   5989 2E 02         [ 7]  101 		ld l ,#2
   598B 26 0F         [ 7]  102 		ld h, #15
   598D 1E 3F         [ 7]  103 		ld e, #63
   598F 16 00         [ 7]  104 		ld d, #0
   5991 01 00 00      [10]  105 		ld bc, #0000
   5994 3E 02         [ 7]  106 		ld a, #2
   5996 CD 7C 74      [17]  107 		call cpct_akp_SFXPlay_asm
                            108 
   5999 11 A3 59      [10]  109 		ld de, #_estado_3
   599C ED 53 6D 59   [20]  110 		ld(_siguiente_puntero_disp),de
   59A0 3E 02         [ 7]  111 		ld a, #_continuar
   59A2 C9            [10]  112 		ret
                            113 
   59A3                     114 	_estado_3:
   59A3 2E 02         [ 7]  115 		ld l ,#2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   59A5 26 0F         [ 7]  116 		ld h, #15
   59A7 1E 40         [ 7]  117 		ld e, #64
   59A9 16 00         [ 7]  118 		ld d, #0
   59AB 01 00 00      [10]  119 		ld bc, #0000
   59AE 3E 02         [ 7]  120 		ld a, #2
   59B0 CD 7C 74      [17]  121 		call cpct_akp_SFXPlay_asm
                            122 		
   59B3 11 BD 59      [10]  123 		ld de, #_estado_4
   59B6 ED 53 6D 59   [20]  124 		ld(_siguiente_puntero_disp),de
   59BA 3E 02         [ 7]  125 		ld a, #_continuar
   59BC C9            [10]  126 		ret
                            127 
   59BD                     128 	_estado_4:
                            129 
   59BD 2E 02         [ 7]  130 		ld l ,#2
   59BF 26 0F         [ 7]  131 		ld h, #15
   59C1 1E 41         [ 7]  132 		ld e, #65
   59C3 16 00         [ 7]  133 		ld d, #0
   59C5 01 00 00      [10]  134 		ld bc, #0000
   59C8 3E 02         [ 7]  135 		ld a, #2
   59CA CD 7C 74      [17]  136 		call cpct_akp_SFXPlay_asm
                            137 
                            138 		
   59CD ED 53 6D 59   [20]  139 		ld(_siguiente_puntero_disp),de
   59D1 3E 00         [ 7]  140 		ld a, #_parar
                            141 
                            142 
                            143 
                            144 
                            145 
   59D3 C9            [10]  146 	ret
                            147 
                            148 
   59D4                     149 sfxdead::
                            150 
                            151 
                            152 
   59D4 FE 01         [ 7]  153 	cp #1
   59D6 20 07         [12]  154 jr nz, _no_inicializar_muerte
   59D8                     155 _inicializar_muerte:
                            156 
   59D8 11 E2 59      [10]  157  ld de, #_estado2_1
   59DB ED 53 E0 59   [20]  158  ld(_siguiente_puntero_muerte),de
                            159 
   59DF                     160 _no_inicializar_muerte:
                            161 
                            162 
                     00BA   163 _siguiente_puntero_muerte=.+1
   59DF C3 00 00      [10]  164 	jp 0000
                            165 
                            166 	
   59E2                     167 	_estado2_1:
   59E2 2E 02         [ 7]  168 		ld l ,#2
   59E4 26 0F         [ 7]  169 		ld h, #15
   59E6 1E 46         [ 7]  170 		ld e, #70
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   59E8 16 00         [ 7]  171 		ld d, #0
   59EA 01 00 00      [10]  172 		ld bc, #0000
   59ED 3E 02         [ 7]  173 		ld a, #2
   59EF CD 7C 74      [17]  174 		call cpct_akp_SFXPlay_asm
                            175 		
   59F2 11 FC 59      [10]  176 		ld de, #_estado2_2
   59F5 ED 53 E0 59   [20]  177 		ld(_siguiente_puntero_muerte),de
   59F9 3E 02         [ 7]  178 		ld a, #_continuar
                            179 
   59FB C9            [10]  180 		ret
                            181 
   59FC                     182 	_estado2_2:
   59FC 2E 02         [ 7]  183 		ld l ,#2
   59FE 26 0F         [ 7]  184 		ld h, #15
   5A00 1E 3C         [ 7]  185 		ld e, #60
   5A02 16 00         [ 7]  186 		ld d, #0
   5A04 01 00 00      [10]  187 		ld bc, #0000
   5A07 3E 02         [ 7]  188 		ld a, #2
   5A09 CD 7C 74      [17]  189 		call cpct_akp_SFXPlay_asm
                            190 
   5A0C 11 16 5A      [10]  191 		ld de, #_estado2_3
   5A0F ED 53 E0 59   [20]  192 		ld(_siguiente_puntero_muerte),de
   5A13 3E 02         [ 7]  193 		ld a, #_continuar
                            194 		
   5A15 C9            [10]  195 		ret
   5A16                     196 	_estado2_3:
   5A16 2E 02         [ 7]  197 		ld l ,#2
   5A18 26 0F         [ 7]  198 		ld h, #15
   5A1A 1E 32         [ 7]  199 		ld e, #50
   5A1C 16 00         [ 7]  200 		ld d, #0
   5A1E 01 00 00      [10]  201 		ld bc, #0000
   5A21 3E 02         [ 7]  202 		ld a, #2
   5A23 CD 7C 74      [17]  203 		call cpct_akp_SFXPlay_asm
                            204 
   5A26 11 30 5A      [10]  205 		ld de, #_estado2_4
   5A29 ED 53 E0 59   [20]  206 		ld(_siguiente_puntero_muerte),de
   5A2D 3E 02         [ 7]  207 		ld a, #_continuar
                            208 		
   5A2F C9            [10]  209 		ret
   5A30                     210 	_estado2_4:
                            211 
   5A30 2E 02         [ 7]  212 		ld l ,#2
   5A32 26 0F         [ 7]  213 		ld h, #15
   5A34 1E 28         [ 7]  214 		ld e, #40
   5A36 16 00         [ 7]  215 		ld d, #0
   5A38 01 00 00      [10]  216 		ld bc, #0000
   5A3B 3E 02         [ 7]  217 		ld a, #2
   5A3D CD 7C 74      [17]  218 		call cpct_akp_SFXPlay_asm		
                            219 		
   5A40 3E 00         [ 7]  220 		ld a, #_parar
                            221 
   5A42 C9            [10]  222 		ret
                            223 
                            224 
                            225 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            226 
                            227 
                            228 
   5A43 C9            [10]  229 	ret
                            230 
                            231 
                            232 
   5A44                     233 sfxwin::
                            234 
                            235 
   5A44 FE 01         [ 7]  236 	cp #1
   5A46 20 07         [12]  237 jr nz, _no_inicializar_win
   5A48                     238 _inicializar_win:
                            239 
   5A48 11 52 5A      [10]  240  ld de, #_estado3_1
   5A4B ED 53 50 5A   [20]  241  ld(_siguiente_puntero_win),de
                            242 
   5A4F                     243 _no_inicializar_win:
                            244 
                            245 
                     012A   246 _siguiente_puntero_win=.+1
   5A4F C3 00 00      [10]  247 	jp 0000
                            248 
                            249 
                            250 
                            251 	
   5A52                     252 	_estado3_1:
   5A52 2E 01         [ 7]  253 		ld l ,#1
   5A54 26 0F         [ 7]  254 		ld h, #15
   5A56 1E 3C         [ 7]  255 		ld e, #60
   5A58 16 00         [ 7]  256 		ld d, #0
   5A5A 01 00 00      [10]  257 		ld bc, #0000
   5A5D 3E 00         [ 7]  258 		ld a, #0
   5A5F CD 7C 74      [17]  259 		call cpct_akp_SFXPlay_asm
                            260 		
   5A62 11 6C 5A      [10]  261 		ld de, #_estado3_2
   5A65 ED 53 50 5A   [20]  262 		ld(_siguiente_puntero_win),de
   5A69 3E 02         [ 7]  263 		ld a, #_continuar
                            264 		
                            265 
   5A6B C9            [10]  266 		ret
                            267 
   5A6C                     268 	_estado3_2:
   5A6C 2E 01         [ 7]  269 		ld l ,#1
   5A6E 26 0F         [ 7]  270 		ld h, #15
   5A70 1E 3F         [ 7]  271 		ld e, #63
   5A72 16 00         [ 7]  272 		ld d, #0
   5A74 01 00 00      [10]  273 		ld bc, #0000
   5A77 3E 02         [ 7]  274 		ld a, #2
   5A79 CD 7C 74      [17]  275 		call cpct_akp_SFXPlay_asm
                            276 		
   5A7C 11 86 5A      [10]  277 		ld de, #_estado3_3
   5A7F ED 53 50 5A   [20]  278 		ld(_siguiente_puntero_win),de
   5A83 3E 02         [ 7]  279 		ld a, #_continuar
                            280 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5A85 C9            [10]  281 		ret
                            282 
   5A86                     283 	_estado3_3:
   5A86 2E 01         [ 7]  284 		ld l ,#1
   5A88 26 0F         [ 7]  285 		ld h, #15
   5A8A 1E 41         [ 7]  286 		ld e, #65
   5A8C 16 00         [ 7]  287 		ld d, #0
   5A8E 01 00 00      [10]  288 		ld bc, #0000
   5A91 3E 02         [ 7]  289 		ld a, #2
   5A93 CD 7C 74      [17]  290 		call cpct_akp_SFXPlay_asm
                            291 		
   5A96 11 A0 5A      [10]  292 		ld de, #_estado3_4
   5A99 ED 53 50 5A   [20]  293 		ld(_siguiente_puntero_win),de
   5A9D 3E 02         [ 7]  294 		ld a, #_continuar
                            295 
   5A9F C9            [10]  296 		ret
                            297 
   5AA0                     298 	_estado3_4:
   5AA0 2E 01         [ 7]  299 		ld l ,#1
   5AA2 26 0F         [ 7]  300 		ld h, #15
   5AA4 1E 3F         [ 7]  301 		ld e, #63
   5AA6 16 00         [ 7]  302 		ld d, #0
   5AA8 01 00 00      [10]  303 		ld bc, #0000
   5AAB 3E 02         [ 7]  304 		ld a, #2
   5AAD CD 7C 74      [17]  305 		call cpct_akp_SFXPlay_asm
                            306 		
   5AB0 11 BA 5A      [10]  307 		ld de, #_estado3_5
   5AB3 ED 53 50 5A   [20]  308 		ld(_siguiente_puntero_win),de
   5AB7 3E 02         [ 7]  309 		ld a, #_continuar
                            310 
   5AB9 C9            [10]  311 		ret
                            312 
   5ABA                     313 	_estado3_5:
   5ABA 2E 01         [ 7]  314 		ld l ,#1
   5ABC 26 0F         [ 7]  315 		ld h, #15
   5ABE 1E 3C         [ 7]  316 		ld e, #60
   5AC0 16 00         [ 7]  317 		ld d, #0
   5AC2 01 00 00      [10]  318 		ld bc, #0000
   5AC5 3E 02         [ 7]  319 		ld a, #2
   5AC7 CD 7C 74      [17]  320 		call cpct_akp_SFXPlay_asm
                            321 
   5ACA 11 D4 5A      [10]  322 		ld de, #_estado3_6
   5ACD ED 53 50 5A   [20]  323 		ld(_siguiente_puntero_win),de
   5AD1 3E 02         [ 7]  324 		ld a, #_continuar
                            325 		
   5AD3 C9            [10]  326 		ret
                            327 
   5AD4                     328 	_estado3_6:
                            329 
   5AD4 2E 01         [ 7]  330 		ld l ,#1
   5AD6 26 0F         [ 7]  331 		ld h, #15
   5AD8 1E 3F         [ 7]  332 		ld e, #63
   5ADA 16 00         [ 7]  333 		ld d, #0
   5ADC 01 00 00      [10]  334 		ld bc, #0000
   5ADF 3E 02         [ 7]  335 		ld a, #2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5AE1 CD 7C 74      [17]  336 		call cpct_akp_SFXPlay_asm
                            337 			
   5AE4 11 EE 5A      [10]  338 		ld de, #_estado3_7
   5AE7 ED 53 50 5A   [20]  339 		ld(_siguiente_puntero_win),de
   5AEB 3E 02         [ 7]  340 		ld a, #_continuar
                            341 
   5AED C9            [10]  342 		ret
                            343 
   5AEE                     344 	_estado3_7:
                            345 
   5AEE 2E 01         [ 7]  346 		ld l ,#1
   5AF0 26 0F         [ 7]  347 		ld h, #15
   5AF2 1E 43         [ 7]  348 		ld e, #67
   5AF4 16 00         [ 7]  349 		ld d, #0
   5AF6 01 00 00      [10]  350 		ld bc, #0000
   5AF9 3E 02         [ 7]  351 		ld a, #2
   5AFB CD 7C 74      [17]  352 		call cpct_akp_SFXPlay_asm
                            353 		
   5AFE 11 08 5B      [10]  354 		ld de, #_estado3_8
   5B01 ED 53 50 5A   [20]  355 		ld(_siguiente_puntero_win),de
   5B05 3E 02         [ 7]  356 		ld a, #_continuar
                            357 
   5B07 C9            [10]  358 		ret
                            359 
   5B08                     360 	_estado3_8:
                            361 
   5B08 2E 01         [ 7]  362 		ld l ,#1
   5B0A 26 0F         [ 7]  363 		ld h, #15
   5B0C 1E 00         [ 7]  364 		ld e, #0
   5B0E 16 00         [ 7]  365 		ld d, #0
   5B10 01 00 00      [10]  366 		ld bc, #0000
   5B13 3E 02         [ 7]  367 		ld a, #2
   5B15 CD 7C 74      [17]  368 		call cpct_akp_SFXPlay_asm
                            369 
   5B18 11 22 5B      [10]  370 		ld de, #_estado3_9
   5B1B ED 53 50 5A   [20]  371 		ld(_siguiente_puntero_win),de
   5B1F 3E 02         [ 7]  372 		ld a, #_continuar
                            373 		
   5B21 C9            [10]  374 		ret
   5B22                     375 	_estado3_9:
                            376 
   5B22 2E 01         [ 7]  377 		ld l ,#1
   5B24 26 0F         [ 7]  378 		ld h, #15
   5B26 1E 41         [ 7]  379 		ld e, #65
   5B28 16 00         [ 7]  380 		ld d, #0
   5B2A 01 00 00      [10]  381 		ld bc, #0000
   5B2D 3E 02         [ 7]  382 		ld a, #2
   5B2F CD 7C 74      [17]  383 		call cpct_akp_SFXPlay_asm
                            384 
   5B32 11 3C 5B      [10]  385 		ld de, #_estado3_10
   5B35 ED 53 50 5A   [20]  386 		ld(_siguiente_puntero_win),de
   5B39 3E 02         [ 7]  387 		ld a, #_continuar
                            388 		
   5B3B C9            [10]  389 		ret
                            390 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   5B3C                     391 	_estado3_10:
                            392 
   5B3C 2E 01         [ 7]  393 		ld l ,#1
   5B3E 26 0F         [ 7]  394 		ld h, #15
   5B40 1E 44         [ 7]  395 		ld e, #68
   5B42 16 00         [ 7]  396 		ld d, #0
   5B44 01 00 00      [10]  397 		ld bc, #0000
   5B47 3E 02         [ 7]  398 		ld a, #2
   5B49 CD 7C 74      [17]  399 		call cpct_akp_SFXPlay_asm
                            400 		
                            401 
   5B4C 3E 00         [ 7]  402 		ld a, #_parar
                            403 		
                            404 
                            405 
                            406 
                            407 
                            408 
                            409 
                            410 
   5B4E C9            [10]  411 	ret
