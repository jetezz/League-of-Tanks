ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_menu
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "cpct_functions.h.s"
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



                              6 .include "sys/render_system.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "../man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 .include "sys_menu.h.s"
                              1 ;;
                              2 ;;sys menu h
                              3 ;;
                              4 
                              5 
                              6 
                              7 .globl zerostate_init
                              8 .globl print_selected_green
                              9 
                             10 .macro textoNegro
                             11 
                             12    ld    h, #0         ;; D = Background PEN (0)
                             13    ld    l, #1         ;; E = Foreground PEN (3)
                             14    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                             15 
                             16 .endm
                             17 
                             18 .macro textoVerde
                             19 
                             20 
                             21    ld    h, #00         ;; D = Background PEN (0)
                             22    ld    l, #07        ;; E = Foreground PEN (3)
                             23 
                             24    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                             25  .endm
                             26 
   665F 4C 45 41 47 55 45    27 title:            .asciz "LEAGUE OF TANKS";
        20 4F 46 20 54 41
        4E 4B 53 00
   666F 50 52 45 53 53 20    28 enter:            .asciz "PRESS ENTER TO PLAY";
        45 4E 54 45 52 20
        54 4F 20 50 4C 41
        59 00
   6683 53 69 6E 67 6C 65    29 Single_player:    .asciz "Single player";
        20 70 6C 61 79 65
        72 00
   6691 42 61 74 74 6C 65    30 battle_royale:    .asciz "Battle Royale"
        20 52 6F 79 61 6C
        65 00
   669F 31 20 50 6C 61 79    31 one_player:       .asciz "1 Player"
        65 72 00
   66A8 32 20 50 6C 61 79    32 two_players:      .asciz "2 Players"
        65 72 73 00
   66B2 33 20 50 6C 61 79    33 tres_players:     .asciz "3 Players"
        65 72 73 00
   66BC 34 20 50 6C 61 79    34 cuatro_players:   .asciz "4 Players"
        65 72 73 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              9 .include "assets.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "../man/state_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 .include "../sys/sys_map_creator.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             12 .include "sys/sys_interrup_music.h.s"
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



                             13 .include "sys/sys_a.h.s"
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



                             14    
                             15 
   66C6 01                   16 first_time: .db #01
                             17 
   66C7                      18 zerostate_init::
                             19 
   66C7 3A C6 66      [13]   20    ld a, (first_time)
   66CA 3D            [ 4]   21    dec a
   66CB C4 A2 3F      [17]   22    call nz, map_firstBuffer
   66CE 3E 00         [ 7]   23    ld a, #00
   66D0 32 C6 66      [13]   24    ld (first_time), a
                             25 
                             26    
   66D3 21 00 80      [10]   27     ld hl, #0x8000  ;; limpiar fireware
   66D6 11 01 80      [10]   28     ld de, #0x8001
   66D9 36 00         [10]   29     ld (hl), #0x00
   66DB 01 00 80      [10]   30     ld bc, #0x8000
   66DE ED B0         [21]   31     ldir
                             32 
                             33 
   66E0 CD A8 57      [17]   34    call stopmusic
   66E3 CD 94 57      [17]   35    call cancion4
   66E6 CD 4C 51      [17]   36    call limpiar_animaciones
                             37 
                             38    
                             39 
   66E9 11 00 C0      [10]   40    ld de, #0XC000
   66EC 06 05         [ 7]   41    ld    b, #5                 ;; B = y coordinate (24 = 0x18)
   66EE 0E 0A         [ 7]   42    ld    c, #10           
   66F0 CD 1B 78      [17]   43    call cpct_getScreenPtr_asm
                             44 
   66F3 EB            [ 4]   45    ex   de, hl
   66F4 21 60 20      [10]   46    ld hl,#_plant_sp
   66F7 0E 04         [ 7]   47    ld c, #04  ;;ancho
   66F9 06 10         [ 7]   48    ld b, #16  ;;alto
   66FB CD 71 75      [17]   49    call cpct_drawSprite_asm
                             50 
                             51 
                             52 
                             53 
                             54 
                             55 
   66FE CD 16 67      [17]   56    call pintar_tituloenter
                             57 
   00A2                      58    textoNegro
                              1 
   6701 26 00         [ 7]    2    ld    h, #0         ;; D = Background PEN (0)
   6703 2E 01         [ 7]    3    ld    l, #1         ;; E = Foreground PEN (3)
   6705 CD F8 77      [17]    4    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                              5 
                             59 
   6708 CD 47 67      [17]   60    call print_tanks
   670B CD AF 68      [17]   61    call print_selected_green
                             62 
   00AF                      63    textoNegro
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                              1 
   670E 26 00         [ 7]    2    ld    h, #0         ;; D = Background PEN (0)
   6710 2E 01         [ 7]    3    ld    l, #1         ;; E = Foreground PEN (3)
   6712 CD F8 77      [17]    4    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                              5 
                             64   
                             65 
   6715 C9            [10]   66 ret
                             67 
   6716                      68 pintar_tituloenter:
                             69 
                             70 
                             71 ;; call rendersys_init
                             72 
                             73     ;; Set up draw char colours before calling draw string
   6716 26 00         [ 7]   74    ld    h, #0         ;; D = Background PEN (0)
   6718 2E 0E         [ 7]   75    ld    l, #14         ;; E = Foreground PEN (3)
                             76 
   671A CD F8 77      [17]   77    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                             78 
                             79 
                             80    ;; Calculate a video-memory location for printing a string
   671D 11 00 C0      [10]   81    ld de, #0XC000
   6720 06 0F         [ 7]   82    ld    b, #15                  ;; B = y coordinate (24 = 0x18)
   6722 0E 0A         [ 7]   83    ld    c, #10                  ;; C = x coordinate (16 = 0x10)
                             84 
   6724 CD 1B 78      [17]   85    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                             86 
                             87    ;; Print the string in video memory
                             88    ;; HL already points to video memory, as it is the return
                             89    ;; value from cpct_getScreenPtr_asm
                             90    
   6727 FD 21 5F 66   [14]   91    ld iy, #title    ;; IY = Pointer to the string 
                             92 
   672B CD E7 74      [17]   93    call cpct_drawStringM0_asm  ;; Draw the string
                             94 
                             95     ;; Set up draw char colours before calling draw string
   672E 26 00         [ 7]   96    ld    h, #0         ;; D = Background PEN (0)
   6730 2E 06         [ 7]   97    ld    l, #6         ;; E = Foreground PEN (3)
                             98 
   6732 CD F8 77      [17]   99    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                            100 
                            101 
                            102    ;; Calculate a video-memory location for printing a string
   6735 11 00 C0      [10]  103    ld de, #0XC000
   6738 06 28         [ 7]  104    ld    b, #40                  ;; B = y coordinate (24 = 0x18)
   673A 0E 03         [ 7]  105    ld    c, #03                  ;; C = x coordinate (16 = 0x10)
                            106 
   673C CD 1B 78      [17]  107    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            108 
                            109    ;; Print the string in video memory
                            110    ;; HL already points to video memory, as it is the return
                            111    ;; value from cpct_getScreenPtr_asm
                            112    
   673F FD 21 6F 66   [14]  113    ld iy, #enter    ;; IY = Pointer to the string 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            114 
   6743 CD E7 74      [17]  115    call cpct_drawStringM0_asm  ;; Draw the string
                            116 
                            117 
   6746 C9            [10]  118 ret
                            119 
                            120 
                            121 
                            122 
                            123 
                            124 
   6747                     125 print_tanks:
                            126 
                            127 
   6747 CD 69 67      [17]  128    call print_singlePlayertank
   674A CD A3 67      [17]  129    call print1playertanks
   674D CD CB 67      [17]  130    call print2playertanks
   6750 CD 08 68      [17]  131    call print3playertanks
   6753 CD 5A 68      [17]  132    call print4playertanks
                            133 
                            134 
   6756 C9            [10]  135 ret
                            136 
   6757                     137 print_singlePlayer:
                            138 
   6757 11 00 C0      [10]  139    ld de, #0XC000
   675A 06 41         [ 7]  140    ld    b, #65                  ;; B = y coordinate (24 = 0x18)
   675C 0E 0F         [ 7]  141    ld    c, #15                  ;; C = x coordinate (16 = 0x10)
                            142 
   675E CD 1B 78      [17]  143    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
                            144 
                            145 
   6761 FD 21 83 66   [14]  146    ld iy, #Single_player    ;; IY = Pointer to the string 
                            147 
   6765 CD E7 74      [17]  148    call cpct_drawStringM0_asm  ;; Draw the string
                            149 
   6768 C9            [10]  150 ret
                            151 
   6769                     152 print_singlePlayertank:
                            153 
                            154 ;;Pintar TANKE SINGLE PLAYER;;
   6769 11 00 C0      [10]  155    ld de, #0XC000
   676C 06 50         [ 7]  156    ld    b, #80                 ;; B = y coordinate (24 = 0x18)
   676E 0E 26         [ 7]  157    ld    c, #38           
   6770 CD 1B 78      [17]  158    call cpct_getScreenPtr_asm
                            159 
   6773 EB            [ 4]  160    ex   de, hl
   6774 21 30 21      [10]  161    ld hl,#_cannons_sp_02
   6777 0E 04         [ 7]  162    ld c, #04  ;;ancho
   6779 06 10         [ 7]  163    ld b, #16  ;;alto
   677B CD 71 75      [17]  164    call cpct_drawSprite_asm
                            165 
   677E C9            [10]  166 ret
                            167 
   677F                     168 printbattleroyale:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            169  ;; Calculate a video-memory location for printing a string
   677F 11 00 C0      [10]  170    ld de, #0XC000
   6782 06 69         [ 7]  171    ld    b, #105                  ;; B = y coordinate (24 = 0x18)
   6784 0E 0F         [ 7]  172    ld    c, #15                  ;; C = x coordinate (16 = 0x10)
                            173 
   6786 CD 1B 78      [17]  174    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            175 
                            176    ;; Print the string in video memory
                            177    ;; HL already points to video memory, as it is the return
                            178    ;; value from cpct_getScreenPtr_asm
                            179    
   6789 FD 21 91 66   [14]  180    ld iy, #battle_royale    ;; IY = Pointer to the string 
                            181 
   678D CD E7 74      [17]  182    call cpct_drawStringM0_asm  ;; Draw the string
                            183 
   6790 C9            [10]  184 ret
                            185 
   6791                     186 print1player:
                            187 
                            188    ;;Pintar "1 Player"
   6791 11 00 C0      [10]  189    ld de, #0XC000
   6794 06 7B         [ 7]  190    ld    b, #123                 ;; B = y coordinate (24 = 0x18)
   6796 0E 02         [ 7]  191    ld    c, #2                  ;; C = x coordinate (16 = 0x10)
                            192 
   6798 CD 1B 78      [17]  193    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            194    
   679B FD 21 9F 66   [14]  195    ld iy, #one_player    ;; IY = Pointer to the string 
                            196 
   679F CD E7 74      [17]  197    call cpct_drawStringM0_asm  ;; Draw the string
                            198 
   67A2 C9            [10]  199 ret
                            200 
   67A3                     201 print1playertanks:
                            202 
                            203       ;;Pintar JUGADOR 1;;
   67A3 11 00 C0      [10]  204    ld de, #0XC000
   67A6 06 87         [ 7]  205    ld    b, #135                 ;; B = y coordinate (24 = 0x18)
   67A8 0E 12         [ 7]  206    ld    c, #18           
   67AA CD 1B 78      [17]  207    call cpct_getScreenPtr_asm
                            208 
   67AD EB            [ 4]  209    ex   de, hl
   67AE 21 30 21      [10]  210    ld hl,#_cannons_sp_02
   67B1 0E 04         [ 7]  211    ld c, #04  ;;ancho
   67B3 06 10         [ 7]  212    ld b, #16  ;;alto
   67B5 CD 71 75      [17]  213    call cpct_drawSprite_asm
                            214 
                            215 
   67B8 C9            [10]  216 ret
                            217 
                            218 
   67B9                     219 print2player:
                            220 
                            221    ;;Pintar "2 Players"
   67B9 11 00 C0      [10]  222    ld de, #0XC000
   67BC 06 7B         [ 7]  223    ld    b, #123                 ;; B = y coordinate (24 = 0x18)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   67BE 0E 2A         [ 7]  224    ld    c, #42                 ;; C = x coordinate (16 = 0x10)
                            225 
   67C0 CD 1B 78      [17]  226    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            227    
   67C3 FD 21 A8 66   [14]  228    ld iy, #two_players    ;; IY = Pointer to the string 
                            229 
   67C7 CD E7 74      [17]  230    call cpct_drawStringM0_asm  ;; Draw the string
                            231 
   67CA C9            [10]  232 ret
                            233 
   67CB                     234 print2playertanks:
                            235 
                            236 
                            237       ;;Pintar tankes jugador 2;;
   67CB 11 00 C0      [10]  238       ld de, #0XC000
   67CE 06 87         [ 7]  239       ld    b, #135                 ;; B = y coordinate (24 = 0x18)
   67D0 0E 37         [ 7]  240       ld    c, #55           
   67D2 CD 1B 78      [17]  241       call cpct_getScreenPtr_asm
                            242 
   67D5 EB            [ 4]  243       ex   de, hl
   67D6 21 30 21      [10]  244       ld hl,#_cannons_sp_02
   67D9 0E 04         [ 7]  245       ld c, #04  ;;ancho
   67DB 06 10         [ 7]  246       ld b, #16  ;;alto
   67DD CD 71 75      [17]  247       call cpct_drawSprite_asm
                            248 
   67E0 11 00 C0      [10]  249       ld de, #0XC000
   67E3 06 87         [ 7]  250       ld    b, #135                 ;; B = y coordinate (24 = 0x18)
   67E5 0E 3C         [ 7]  251       ld    c, #60           
   67E7 CD 1B 78      [17]  252       call cpct_getScreenPtr_asm
                            253 
   67EA EB            [ 4]  254       ex   de, hl
   67EB 21 70 22      [10]  255       ld hl,#_cannons_sp_07
   67EE 0E 04         [ 7]  256       ld c, #04  ;;ancho
   67F0 06 10         [ 7]  257       ld b, #16  ;;alto
   67F2 CD 71 75      [17]  258       call cpct_drawSprite_asm
                            259 
                            260 
   67F5 C9            [10]  261 ret
                            262 
                            263 
                            264 
                            265 
                            266 
   67F6                     267 print3player:
                            268 
                            269   ;;Pintar "3 Player"
   67F6 11 00 C0      [10]  270    ld de, #0XC000
   67F9 06 A0         [ 7]  271    ld    b, #160                 ;; B = y coordinate (24 = 0x18)
   67FB 0E 02         [ 7]  272    ld    c, #2                  ;; C = x coordinate (16 = 0x10)
                            273 
   67FD CD 1B 78      [17]  274    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            275    
   6800 FD 21 B2 66   [14]  276    ld iy, #tres_players    ;; IY = Pointer to the string 
                            277 
   6804 CD E7 74      [17]  278    call cpct_drawStringM0_asm  ;; Draw the string
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            279 
   6807 C9            [10]  280 ret
                            281 
   6808                     282 print3playertanks:
                            283 
                            284    ;;Pintar 1 tankes
   6808 11 00 C0      [10]  285    ld de, #0XC000
   680B 06 AA         [ 7]  286    ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   680D 0E 0D         [ 7]  287    ld    c, #13           
   680F CD 1B 78      [17]  288    call cpct_getScreenPtr_asm
                            289 
   6812 EB            [ 4]  290    ex   de, hl
   6813 21 30 21      [10]  291    ld hl,#_cannons_sp_02
   6816 0E 04         [ 7]  292    ld c, #04  ;;ancho
   6818 06 10         [ 7]  293    ld b, #16  ;;alto
   681A CD 71 75      [17]  294    call cpct_drawSprite_asm
                            295 
                            296    ;;Pintar segundo tanke
   681D 11 00 C0      [10]  297    ld de, #0XC000
   6820 06 AA         [ 7]  298    ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   6822 0E 12         [ 7]  299    ld    c, #18           
   6824 CD 1B 78      [17]  300    call cpct_getScreenPtr_asm
                            301 
   6827 EB            [ 4]  302    ex   de, hl
   6828 21 70 22      [10]  303    ld hl,#_cannons_sp_07
   682B 0E 04         [ 7]  304    ld c, #04  ;;ancho
   682D 06 10         [ 7]  305    ld b, #16  ;;alto
   682F CD 71 75      [17]  306    call cpct_drawSprite_asm
                            307 
                            308    ;;Pintar tercer tanke
   6832 11 00 C0      [10]  309    ld de, #0XC000
   6835 06 AA         [ 7]  310    ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   6837 0E 17         [ 7]  311    ld    c, #23           
   6839 CD 1B 78      [17]  312    call cpct_getScreenPtr_asm
                            313 
   683C EB            [ 4]  314    ex   de, hl
   683D 21 B0 23      [10]  315    ld hl,#_cannons_sp_12
   6840 0E 04         [ 7]  316    ld c, #04  ;;ancho
   6842 06 10         [ 7]  317    ld b, #16  ;;alto
   6844 CD 71 75      [17]  318    call cpct_drawSprite_asm
                            319 
   6847 C9            [10]  320 ret
                            321 
                            322 
   6848                     323 print4player:
                            324 
                            325    ;;Pintar "2 Players"
   6848 11 00 C0      [10]  326    ld de, #0XC000
   684B 06 A0         [ 7]  327    ld    b, #160                 ;; B = y coordinate (24 = 0x18)
   684D 0E 2A         [ 7]  328    ld    c, #42                 ;; C = x coordinate (16 = 0x10)
                            329 
   684F CD 1B 78      [17]  330    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                            331    
   6852 FD 21 BC 66   [14]  332    ld iy, #cuatro_players    ;; IY = Pointer to the string 
                            333 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   6856 CD E7 74      [17]  334    call cpct_drawStringM0_asm  ;; Draw the string
                            335 
   6859 C9            [10]  336 ret
                            337 
                            338 
   685A                     339 print4playertanks:
                            340 
                            341 
                            342       ;;Pintar tankes jugador 4;;
   685A 11 00 C0      [10]  343       ld de, #0XC000
   685D 06 AA         [ 7]  344       ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   685F 0E 32         [ 7]  345       ld    c, #50           
   6861 CD 1B 78      [17]  346       call cpct_getScreenPtr_asm
                            347 
   6864 EB            [ 4]  348       ex   de, hl
   6865 21 30 21      [10]  349       ld hl,#_cannons_sp_02
   6868 0E 04         [ 7]  350       ld c, #04  ;;ancho
   686A 06 10         [ 7]  351       ld b, #16  ;;alto
   686C CD 71 75      [17]  352       call cpct_drawSprite_asm
                            353       ;;Segundo tanke
   686F 11 00 C0      [10]  354       ld de, #0XC000
   6872 06 AA         [ 7]  355       ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   6874 0E 37         [ 7]  356       ld    c, #55           
   6876 CD 1B 78      [17]  357       call cpct_getScreenPtr_asm
                            358 
   6879 EB            [ 4]  359       ex   de, hl
   687A 21 70 22      [10]  360       ld hl,#_cannons_sp_07
   687D 0E 04         [ 7]  361       ld c, #04  ;;ancho
   687F 06 10         [ 7]  362       ld b, #16  ;;alto
   6881 CD 71 75      [17]  363       call cpct_drawSprite_asm
                            364         ;;Tercer tanke
   6884 11 00 C0      [10]  365       ld de, #0XC000
   6887 06 AA         [ 7]  366       ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   6889 0E 3C         [ 7]  367       ld    c, #60           
   688B CD 1B 78      [17]  368       call cpct_getScreenPtr_asm
                            369 
   688E EB            [ 4]  370       ex   de, hl
   688F 21 B0 23      [10]  371       ld hl,#_cannons_sp_12
   6892 0E 04         [ 7]  372       ld c, #04  ;;ancho
   6894 06 10         [ 7]  373       ld b, #16  ;;alto
   6896 CD 71 75      [17]  374       call cpct_drawSprite_asm
                            375         ;;Cuarto tanke
   6899 11 00 C0      [10]  376       ld de, #0XC000
   689C 06 AA         [ 7]  377       ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   689E 0E 41         [ 7]  378       ld    c, #65          
   68A0 CD 1B 78      [17]  379       call cpct_getScreenPtr_asm
                            380 
   68A3 EB            [ 4]  381       ex   de, hl
   68A4 21 F0 24      [10]  382       ld hl,#_cannons_sp_17
   68A7 0E 04         [ 7]  383       ld c, #04  ;;ancho
   68A9 06 10         [ 7]  384       ld b, #16  ;;alto
   68AB CD 71 75      [17]  385       call cpct_drawSprite_asm
                            386 
   68AE C9            [10]  387 ret
                            388 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            389 
                            390 
   68AF                     391 print_selected_green::
                            392 
   68AF CD E2 68      [17]  393    call pintarSelecciones
                            394 
   0253                     395    textoVerde
                              1 
                              2 
   68B2 26 00         [ 7]    3    ld    h, #00         ;; D = Background PEN (0)
   68B4 2E 07         [ 7]    4    ld    l, #07        ;; E = Foreground PEN (3)
                              5 
   68B6 CD F8 77      [17]    6    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                            396    
                            397    ;;Cambiamos el color de lo que pintaremos
   68B9 3A 18 45      [13]  398    ld a, (_gamemode)
   68BC 3D            [ 4]  399    dec a ;;Gamemode es 1, es decir 1 jugador contra ia battle royale
   68BD CC 91 67      [17]  400    call z, print1player
   68C0 CC 7F 67      [17]  401    call z, printbattleroyale
   68C3 C8            [11]  402    ret z
                            403 
   68C4 3D            [ 4]  404    dec a ;;Gamemode es 2, es decir 2 jugador contra ia battle royale
   68C5 CC B9 67      [17]  405    call z, print2player
   68C8 CC 7F 67      [17]  406    call z, printbattleroyale
   68CB C8            [11]  407    ret z
                            408 
   68CC 3D            [ 4]  409    dec a ;;Gamemode es 3, es decir 3 jugador contra ia battle royale
   68CD CC F6 67      [17]  410    call z, print3player
   68D0 CC 7F 67      [17]  411    call z, printbattleroyale
   68D3 C8            [11]  412    ret z
                            413 
                            414 
   68D4 3D            [ 4]  415    dec a ;;Gamemode es 4, es decir 4 jugador contra ia battle royale
   68D5 CC 48 68      [17]  416    call z, print4player
   68D8 CC 7F 67      [17]  417    call z, printbattleroyale
   68DB C8            [11]  418    ret z
                            419 
   68DC 3D            [ 4]  420    dec a ;;Gamemode es 5, es decir singleplayer
   68DD CC 57 67      [17]  421    call z, print_singlePlayer
   68E0 C8            [11]  422    ret z
                            423 
                            424 
   68E1 C9            [10]  425 ret
                            426 
                            427 
                            428 
                            429 
   68E2                     430 pintarSelecciones:
                            431 
   68E2 26 00         [ 7]  432    ld    h, #00         ;; D = Background PEN (0)
   68E4 2E 01         [ 7]  433    ld    l, #01        ;; E = Foreground PEN (3)
                            434 
   68E6 CD F8 77      [17]  435    call cpct_setDrawCharM0_asm   ;; Set draw char colours
                            436 
   68E9 CD 57 67      [17]  437 call print_singlePlayer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   68EC CD 7F 67      [17]  438 call printbattleroyale
   68EF CD 91 67      [17]  439 call print1player
   68F2 CD B9 67      [17]  440 call print2player
   68F5 CD F6 67      [17]  441 call print3player
   68F8 CD 48 68      [17]  442 call print4player
                            443 
                            444 
                            445 
   68FB C9            [10]  446 ret
                            447 
                            448 
                            449 
                            450 
                            451 
                            452 
                            453 
                            454 
                            455 
                            456 
                            457 
