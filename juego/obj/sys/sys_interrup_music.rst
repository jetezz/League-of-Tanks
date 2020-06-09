ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_interrup_music
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "../cpct_functions.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "sys_interrup_music.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              9 
                             10 
                             11 
   568C 00                   12 cancionactual: .db #0
   568D 01                   13 contador: .db #1
   568E 01                   14 tiempo  : .db #1
                             15 
   568F 01                   16 contadordis: .db #1
   5690 00                   17 estadodis: .db #00
                             18 
   5691 01                   19 contadormuer: .db #1
   5692 00                   20 estadomuer: .db #00
                             21 
   5693 01                   22 contadorwin: .db #1
   5694 00                   23 estadowin: .db #00
                             24 
   5695 01                   25 contadorintera: .db #1
   5696 00                   26 estadointera: .db #0
                             27 
                             28 
                             29 
                             30 
                             31 
   5697                      32 generate_music::
                             33 
                             34 
   5697 3A 8D 56      [13]   35 	ld a, (contador)
   569A 3D            [ 4]   36 	dec a
   569B 32 8D 56      [13]   37 	ld (contador),a
   569E 20 09         [12]   38 	jr nz,return
   56A0 CD C0 6C      [17]   39  		call cpct_akp_musicPlay_asm
   56A3 3A 8E 56      [13]   40  		ld a ,(tiempo)
   56A6 32 8D 56      [13]   41  		ld(contador), a
                             42 
   56A9                      43  	return:
                             44 
                             45 
   56A9 3A 90 56      [13]   46  	ld a ,(estadodis)
   56AC B7            [ 4]   47  	or a
   56AD 28 17         [12]   48  	jr z, return2
                             49 
   56AF 3A 8F 56      [13]   50  		ld a, (contadordis)
   56B2 3D            [ 4]   51 		dec a
   56B3 32 8F 56      [13]   52 		ld (contadordis),a
   56B6 20 0E         [12]   53 		jr nz,return2
   56B8 3A 90 56      [13]   54 			ld a,(estadodis)
   56BB CD 61 59      [17]   55  			call sfxdisp
                             56 			;;debuelvo el estado nuevo
   56BE 32 90 56      [13]   57  			ld (estadodis), a
   56C1 3E 06         [ 7]   58  			ld a ,#6
   56C3 32 8F 56      [13]   59  			ld (contadordis), a
                             60 
   56C6                      61  	return2:
                             62 
                             63 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   56C6 3A 92 56      [13]   64  	ld a ,(estadomuer)
   56C9 B7            [ 4]   65  	or a
   56CA 28 17         [12]   66  	jr z, return3
                             67 
   56CC 3A 91 56      [13]   68  		ld a, (contadormuer)
   56CF 3D            [ 4]   69 		dec a
   56D0 32 91 56      [13]   70 		ld (contadormuer),a
   56D3 20 0E         [12]   71 		jr nz,return3
   56D5 3A 92 56      [13]   72 			ld a,(estadomuer)
   56D8 CD D4 59      [17]   73  			call sfxdead
                             74 			;;debuelvo el estado nuevo
   56DB 32 92 56      [13]   75  			ld (estadomuer), a
   56DE 3E 1E         [ 7]   76  			ld a ,#30
   56E0 32 91 56      [13]   77  			ld (contadormuer), a
                             78 
   56E3                      79  	return3:
                             80 
                             81 
   56E3 3A 94 56      [13]   82  		ld a ,(estadowin)
   56E6 B7            [ 4]   83  	or a
   56E7 28 17         [12]   84  	jr z, return4
                             85 
   56E9 3A 93 56      [13]   86  		ld a, (contadorwin)
   56EC 3D            [ 4]   87 		dec a
   56ED 32 93 56      [13]   88 		ld (contadorwin),a
   56F0 20 0E         [12]   89 		jr nz,return4
   56F2 3A 94 56      [13]   90 			ld a,(estadowin)
   56F5 CD 44 5A      [17]   91  			call sfxwin
                             92 			;;debuelvo el estado nuevo
   56F8 32 94 56      [13]   93  			ld (estadowin), a
   56FB 3E 28         [ 7]   94  			ld a ,#40
   56FD 32 93 56      [13]   95  			ld (contadorwin), a
                             96 
   5700                      97  	return4:
                             98 
                             99 	
                            100 
                            101 
   5700                     102 _sfx_interacion::
   5700 3A 96 56      [13]  103 ld a ,(estadointera)
   5703 B7            [ 4]  104  	or a
   5704 28 17         [12]  105  	jr z, return5
                            106 
   5706 3A 95 56      [13]  107  		ld a, (contadorintera)
   5709 3D            [ 4]  108 		dec a
   570A 32 95 56      [13]  109 		ld (contadorintera),a
   570D 20 B7         [12]  110 		jr nz,return2
   570F 3A 96 56      [13]  111 			ld a,(estadointera)
   5712 CD 26 59      [17]  112  			call sfxinteraccion
                            113 			;;debuelvo el estado nuevo
   5715 32 96 56      [13]  114  			ld (estadointera), a
   5718 3E FF         [ 7]  115  			ld a ,#0xFF
   571A 32 95 56      [13]  116  			ld (contadorintera), a
                            117 
   571D                     118  	return5:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            119 
   571D C9            [10]  120 ret
                            121 
   571E                     122 sonido_disparo::
   571E 3A 90 56      [13]  123 	ld a, (estadodis)
   5721 B7            [ 4]  124 	or a
   5722 28 01         [12]  125 	jr z, _realizamos_sonido
   5724 C9            [10]  126 	ret
                            127 
   5725                     128 	_realizamos_sonido:
   5725 3E 01         [ 7]  129 	ld a, #1
   5727 32 90 56      [13]  130 	ld (estadodis), a
                            131 
   572A C9            [10]  132 ret
                            133 
   572B                     134 sonido_muerte::
   572B 3A 92 56      [13]  135 	ld a, (estadomuer)
   572E B7            [ 4]  136 	or a
   572F 28 01         [12]  137 	jr z, _realizamos_sonido2
   5731 C9            [10]  138 	ret
                            139 
   5732                     140 	_realizamos_sonido2:
   5732 3E 01         [ 7]  141 	ld a, #1
   5734 32 92 56      [13]  142 	ld (estadomuer), a
                            143 
   5737 C9            [10]  144 ret
                            145 
                            146 
                            147 
   5738                     148 sonido_win::
   5738 3A 94 56      [13]  149 	ld a, (estadowin)
   573B B7            [ 4]  150 	or a
   573C 28 01         [12]  151 	jr z, _realizamos_sonido3
   573E C9            [10]  152 	ret
                            153 
   573F                     154 	_realizamos_sonido3:
   573F 3E 01         [ 7]  155 	ld a, #1
   5741 32 94 56      [13]  156 	ld (estadowin), a
                            157 
   5744 C9            [10]  158 ret
                            159 
                            160 
   5745                     161 sonido_interaccion::
   5745 3A 96 56      [13]  162 	ld a, (estadointera)
   5748 B7            [ 4]  163 	or a
   5749 28 01         [12]  164 	jr z, _realizamos_sonido4
   574B C9            [10]  165 	ret
                            166 
   574C                     167 	_realizamos_sonido4:
   574C 3E 01         [ 7]  168 	ld a, #1
   574E 32 96 56      [13]  169 	ld (estadointera), a
                            170 
   5751 C9            [10]  171 ret
                            172 
                            173 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5752                     174 off_muerte::
   5752 3E 00         [ 7]  175  ld a, #0
   5754 32 92 56      [13]  176  ld (estadomuer), a
   5757 C9            [10]  177  ret
                            178 
                            179 
                            180 
   5758                     181 cancion1::
   5758 3E 06         [ 7]  182 	ld a,#6
   575A 32 8E 56      [13]  183 	ld (tiempo), a
   575D 32 8D 56      [13]  184 	ld (contador),a
                            185 	
   5760 11 40 00      [10]  186 	ld de, #_song
   5763 CD CA 73      [17]  187     call cpct_akp_musicInit_asm
                            188  
   5766 3E 01         [ 7]  189     ld a,#1
   5768 32 8C 56      [13]  190     ld (cancionactual),a
                            191 
   576B C9            [10]  192  ret
                            193 
   576C                     194 cancion2::
                            195 
   576C 3E 08         [ 7]  196 	ld a,#8
   576E 32 8E 56      [13]  197 	ld (tiempo), a	
   5771 32 8D 56      [13]  198 	ld (contador),a
                            199 
   5774 11 BD 01      [10]  200 	ld de, #_song2
   5777 CD CA 73      [17]  201     call cpct_akp_musicInit_asm
                            202 
   577A 3E 02         [ 7]  203      ld a,#2
   577C 32 8C 56      [13]  204     ld (cancionactual),a
                            205 
   577F C9            [10]  206  ret
   5780                     207 cancion3::
                            208 
   5780 3E 0A         [ 7]  209 	ld a,#10
   5782 32 8E 56      [13]  210 	ld (tiempo), a	
   5785 32 8D 56      [13]  211 	ld (contador),a
                            212 
   5788 11 9E 02      [10]  213 	ld de, #_song3
   578B CD CA 73      [17]  214     call cpct_akp_musicInit_asm
                            215 
   578E 3E 03         [ 7]  216          ld a,#3
   5790 32 8C 56      [13]  217     ld (cancionactual),a
                            218 
   5793 C9            [10]  219  ret
                            220 
   5794                     221 cancion4::
                            222 
   5794 3E 08         [ 7]  223 	ld a,#8
   5796 32 8E 56      [13]  224 	ld (tiempo), a	
   5799 32 8D 56      [13]  225 	ld (contador),a
                            226 
   579C 11 11 04      [10]  227 	ld de, #_song4
   579F CD CA 73      [17]  228     call cpct_akp_musicInit_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            229 
   57A2 3E 04         [ 7]  230        ld a,#4
   57A4 32 8C 56      [13]  231     ld (cancionactual),a
                            232 
   57A7 C9            [10]  233  ret
                            234 
   57A8                     235 stopmusic::
   57A8 CD 23 74      [17]  236 call cpct_akp_stop_asm
   57AB C9            [10]  237  ret
                            238 
                            239 
   57AC                     240 next_song::
   57AC CD A8 57      [17]  241 call stopmusic
                            242 	
   57AF CD 37 44      [17]  243 call estado_game_over
   57B2 3D            [ 4]  244 dec a
   57B3 28 1F         [12]  245 jr z,_reiniciar_posiciones
                            246 
                            247 	
                            248 
   57B5 3A 8C 56      [13]  249 	ld a,(cancionactual)
                            250 
   57B8 FE 01         [ 7]  251 	cp #1
   57BA 28 0C         [12]  252 	jr z,_song_2
   57BC FE 02         [ 7]  253 	cp #2
   57BE 28 0C         [12]  254 	jr z,_song_3
   57C0 FE 03         [ 7]  255 	cp #3
   57C2 28 0C         [12]  256 	jr z,_song_1
   57C4 FE 04         [ 7]  257 	cp #4
   57C6 28 08         [12]  258 	jr z,_song_1
                            259 
   57C8                     260 	_song_2:
   57C8 CD 6C 57      [17]  261 	call cancion2
   57CB C9            [10]  262 	ret
   57CC                     263 	_song_3:
   57CC CD 80 57      [17]  264 	call cancion3
   57CF C9            [10]  265 	ret
   57D0                     266 	_song_1:
   57D0 CD 58 57      [17]  267 	call cancion1
   57D3 C9            [10]  268 	ret
                            269 
   57D4                     270 _reiniciar_posiciones:
   57D4 C9            [10]  271 	ret
                            272 	
                            273 
                            274 
                            275 
