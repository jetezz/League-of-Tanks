ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_map_creator
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "mapas/mapa1.h.s"
                              1 ;;
                              2 ;; File src/mapas/source/mapa1.tmx converted to csv using cpct_tmx2data [Sun Oct 27 21:10:54 2019]
                              3 ;;   * Visible Layers:  1
                              4 ;;   * Layer Width:     20
                              5 ;;   * Layer Height:    25
                              6 ;;   * Bits per tile:   8
                              7 ;;   * Layer Bytes:     500 (20 x 25 items, 8 bits per item)
                              8 ;;   * Total Bytes:     500 (500 x 1, bytes per layer times layers)
                              9 ;;
                             10 ;;#### Width and height constants ####
                     0014    11 _mapa1_W == 20
                     0019    12 _mapa1_H == 25
                             13 
                             14 ;;#### Converted layer tilemaps ####
                             15 ;;   Visible layers: 1
                             16 ;;
                     01F4    17 _mapa1_SIZE == 500
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "cpct_functions.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              9 .include "man/st_game_over.h.s"
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



                             10     
                             11 
   57D5 00 00                12 _puntero_mapa: .dw #00
                             13 
                             14 
   57D7                      15 draw_map::
                             16 
                             17 
                             18 ;;Pintamos el mapa de manera inicial
                             19 
                             20    
                             21     
                             22     ;;Establecemos el tileset
                             23    
                             24 
   57D7 0E 14         [ 7]   25     ld    c,  #_mapa1_W
   57D9 06 19         [ 7]   26     ld    b,  #_mapa1_H
   57DB 11 14 00      [10]   27     ld    de, #_mapa1_W
   57DE 21 50 19      [10]   28     ld    hl, #_tileset_00
   57E1 CD 68 78      [17]   29     call cpct_etm_setDrawTilemap4x8_ag_asm
                             30  
                             31  
                             32 
                             33 
                             34     ;;Pintamos el mapa inicialmente
                             35   
   57E4 21 00 C0      [10]   36      ld    hl, #0xC000
   57E7 ED 5B D5 57   [20]   37      ld    de, (_puntero_mapa)
   57EB CD 11 76      [17]   38      call cpct_etm_drawTilemap4x8_ag_asm
                             39 
   57EE 21 00 80      [10]   40      ld    hl, #0x8000
   57F1 ED 5B D5 57   [20]   41      ld    de, (_puntero_mapa)
   57F5 CD 11 76      [17]   42      call cpct_etm_drawTilemap4x8_ag_asm
                             43 
                             44 
                             45    
                             46 
   57F8 C9            [10]   47 ret
                             48 
                             49 
                             50 
                             51 
   57F9                      52 draw_map_sinhud::
                             53 
                             54 
                             55 ;;Pintamos el mapa de manera inicial
                             56 
                             57    
                             58     
                             59     ;;Establecemos el tileset
                             60 
                             61     ;;Aqui se piinta con 3 tiles menos, los del hud
   57F9 0E 14         [ 7]   62     ld    c,  #_mapa1_W
   57FB 06 19         [ 7]   63     ld    b,  #_mapa1_H
   57FD 05            [ 4]   64     dec b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   57FE 05            [ 4]   65     dec b
   57FF 05            [ 4]   66     dec b
   5800 11 14 00      [10]   67     ld    de, #_mapa1_W
   5803 21 50 19      [10]   68     ld    hl, #_tileset_00
   5806 CD 68 78      [17]   69     call cpct_etm_setDrawTilemap4x8_ag_asm
                             70  
                             71  
                             72 
                             73 
                             74     ;;Pintamos el mapa inicialmente
                             75   
   5809 21 00 C0      [10]   76      ld    hl, #0xC000
   580C ED 5B D5 57   [20]   77      ld    de, (_puntero_mapa)
   5810 CD 11 76      [17]   78      call cpct_etm_drawTilemap4x8_ag_asm
                             79 
   5813 21 00 80      [10]   80      ld    hl, #0x8000
   5816 ED 5B D5 57   [20]   81      ld    de, (_puntero_mapa)
   581A CD 11 76      [17]   82      call cpct_etm_drawTilemap4x8_ag_asm
                             83 
                             84 
                             85    
                             86 
   581D C9            [10]   87 ret
                             88 
                             89 
   581E 00                   90 nivelActual: .db #00
                             91 
   581F                      92 reset_lvl::
                             93 
   581F 3E 00         [ 7]   94   ld a, #00
   5821 32 1E 58      [13]   95   ld (nivelActual), a
                             96 
   5824 C9            [10]   97 ret
   5825                      98 next_map::
                             99 
                            100 
                            101 
   5825 CD 37 44      [17]  102 call estado_game_over
   5828 3D            [ 4]  103 dec a
   5829 28 AC         [12]  104 jr z, draw_map
                            105 
                            106 
                            107     ;;Sumar un nivel
   582B 3A 1E 58      [13]  108     ld a, (nivelActual)
   582E 3C            [ 4]  109     inc a
   582F 32 1E 58      [13]  110     ld (nivelActual), a
                            111 
                            112 
   5832 3A 18 45      [13]  113     ld a, (_gamemode) 
   5835 FE 05         [ 7]  114     cp #5
   5837 CC 9B 58      [17]  115     call z, next_map_singlep
   583A 3A 18 45      [13]  116     ld a, (_gamemode) 
   583D FE 05         [ 7]  117     cp #5
   583F CC D7 57      [17]  118     call z, draw_map
   5842 3A 18 45      [13]  119     ld a, (_gamemode) 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5845 FE 05         [ 7]  120     cp #5
   5847 C8            [11]  121     ret z
                            122 
                            123 
   5848 CD 4F 58      [17]  124     call next_map_multi
   584B CD D7 57      [17]  125     call draw_map
                            126 
                            127 
   584E C9            [10]  128 ret
                            129 
                            130 
   584F                     131 next_map_multi:
                            132 
   584F 3A 1E 58      [13]  133     ld a, (nivelActual)
   5852 3D            [ 4]  134     dec a
   5853 CC 71 58      [17]  135     call z, set_map1
   5856 C8            [11]  136         ret z
   5857 3D            [ 4]  137     dec a
   5858 CC 78 58      [17]  138     call z, set_map2
   585B C8            [11]  139         ret z
   585C 3D            [ 4]  140     dec a
   585D CC 7F 58      [17]  141     call z, set_map3
   5860 C8            [11]  142         ret z
   5861 3D            [ 4]  143     dec a
   5862 CC 86 58      [17]  144     call z, set_map4
   5865 C8            [11]  145         ret z
   5866 3D            [ 4]  146     dec a
   5867 CC 8D 58      [17]  147     call z, set_map5
   586A C8            [11]  148         ret z
   586B 3D            [ 4]  149     dec a
   586C CC 94 58      [17]  150     call z, set_map6
   586F C8            [11]  151         ret z
                            152 
   5870 C9            [10]  153 ret
                            154 
   5871                     155 set_map1:
   5871 21 2C 3B      [10]  156     ld hl, #_mapa1
   5874 22 D5 57      [16]  157     ld (_puntero_mapa), hl
   5877 C9            [10]  158 ret
   5878                     159 set_map2:
   5878 21 38 39      [10]  160     ld hl, #_mapa2
   587B 22 D5 57      [16]  161     ld (_puntero_mapa), hl
   587E C9            [10]  162 ret
   587F                     163 set_map3:
   587F 21 44 37      [10]  164     ld hl, #_mapa3
   5882 22 D5 57      [16]  165     ld (_puntero_mapa), hl
   5885 C9            [10]  166 ret
   5886                     167 set_map4:
   5886 21 50 35      [10]  168     ld hl, #_mapa4
   5889 22 D5 57      [16]  169     ld (_puntero_mapa), hl
   588C C9            [10]  170 ret
   588D                     171 set_map5:
   588D 21 5C 33      [10]  172     ld hl, #_mapa5
   5890 22 D5 57      [16]  173     ld (_puntero_mapa), hl
   5893 C9            [10]  174 ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5894                     175 set_map6:
   5894 21 68 31      [10]  176     ld hl, #_mapa6
   5897 22 D5 57      [16]  177     ld (_puntero_mapa), hl
   589A C9            [10]  178 ret
   589B                     179 next_map_singlep:
                            180     
   589B 3A 1E 58      [13]  181     ld a, (nivelActual)
   589E 3D            [ 4]  182     dec a
   589F CC BD 58      [17]  183     call z, set_single_map1
   58A2 C8            [11]  184         ret z
   58A3 3D            [ 4]  185     dec a
   58A4 CC C4 58      [17]  186     call z, set_single_map2
   58A7 C8            [11]  187         ret z
   58A8 3D            [ 4]  188     dec a
   58A9 CC CB 58      [17]  189     call z, set_single_map3
   58AC C8            [11]  190         ret z
   58AD 3D            [ 4]  191     dec a
   58AE CC D2 58      [17]  192     call z, set_single_map4
   58B1 C8            [11]  193         ret z
   58B2 3D            [ 4]  194     dec a
   58B3 CC D9 58      [17]  195     call z, set_single_map5
   58B6 C8            [11]  196         ret z
   58B7 3D            [ 4]  197     dec a
   58B8 CC E0 58      [17]  198     call z, set_single_map6
   58BB C8            [11]  199         ret z
                            200 
   58BC C9            [10]  201 ret
   58BD                     202 set_single_map1:
   58BD 21 74 2F      [10]  203     ld hl, #_single_mapa1
   58C0 22 D5 57      [16]  204     ld (_puntero_mapa), hl
   58C3 C9            [10]  205 ret
   58C4                     206 set_single_map2:
   58C4 21 80 2D      [10]  207     ld hl, #_single_mapa2
   58C7 22 D5 57      [16]  208     ld (_puntero_mapa), hl
   58CA C9            [10]  209 ret
   58CB                     210 set_single_map3:
   58CB 21 8C 2B      [10]  211     ld hl, #_single_mapa3
   58CE 22 D5 57      [16]  212     ld (_puntero_mapa), hl
   58D1 C9            [10]  213 ret
   58D2                     214 set_single_map4:
   58D2 21 98 29      [10]  215     ld hl, #_single_mapa4
   58D5 22 D5 57      [16]  216     ld (_puntero_mapa), hl
   58D8 C9            [10]  217 ret
   58D9                     218 set_single_map5:
   58D9 21 A4 27      [10]  219     ld hl, #_single_mapa5
   58DC 22 D5 57      [16]  220     ld (_puntero_mapa), hl
   58DF C9            [10]  221 ret
   58E0                     222 set_single_map6:
   58E0 21 B0 25      [10]  223     ld hl, #_single_mapa6
   58E3 22 D5 57      [16]  224     ld (_puntero_mapa), hl
   58E6 C9            [10]  225 ret
                            226 
                            227 
                            228 
