ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Draw map
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



                              6 .include "assets.h.s"
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



                              7 .include "sys/check_key.h.s"
                              1 ;;
                              2 ;;CHEK_KEY
                              3 ;;
                              4 
                              5 .globl check_key_init
                              6 .globl check_key
                              7 .globl check_game_begin
                              8 .globl check_restart
                              9 .globl check_Pause
                             10 .globl check_unPause
                             11 .globl check_nextGamemode
                             12 .globl check_Esc
                             13 
                             14 
                             15 .macro resetVelplayers _N
                             16 	 _puntero_entidades=.+2
                             17  	ld ix, #0000
                             18 	.rept _N
                             19 		ld e_vx(ix) ,#0
                             20 		ld e_vy(ix) ,#0
                             21 		nextEntity
                             22 	.endm
                             23 .endm
                             24 
                             25 
                             26 
                             27 
                             28 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 .include "state_manager.h.s"
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



                              9 .include "sys/sys_menu.h.s"
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
   461C 4C 45 41 47 55 45    27 title:            .asciz "LEAGUE OF TANKS";
        20 4F 46 20 54 41
        4E 4B 53 00
   462C 50 52 45 53 53 20    28 enter:            .asciz "PRESS ENTER TO PLAY";
        45 4E 54 45 52 20
        54 4F 20 50 4C 41
        59 00
   4640 53 69 6E 67 6C 65    29 Single_player:    .asciz "Single player";
        20 70 6C 61 79 65
        72 00
   464E 42 61 74 74 6C 65    30 battle_royale:    .asciz "Battle Royale"
        20 52 6F 79 61 6C
        65 00
   465C 31 20 50 6C 61 79    31 one_player:       .asciz "1 Player"
        65 72 00
   4665 32 20 50 6C 61 79    32 two_players:      .asciz "2 Players"
        65 72 73 00
   466F 33 20 50 6C 61 79    33 tres_players:     .asciz "3 Players"
        65 72 73 00
   4679 34 20 50 6C 61 79    34 cuatro_players:   .asciz "4 Players"
        65 72 73 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "sys/sys_interrup_music.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 
   4683                      12 init_zerostate::
   4683 CD C7 66      [17]   13   call zerostate_init ;;LLamar al inicializador del sistema
   4686 C9            [10]   14 ret
                             15 
   4687                      16 zerostate_update::
   4687 CD 78 4D      [17]   17     call check_game_begin
   468A CD 1A 4E      [17]   18     call check_nextGamemode
   468D C9            [10]   19 ret
                             20 
   468E                      21 next_gamemode::
                             22 
   468E 3A 18 45      [13]   23     ld a, (_gamemode)
   4691 3C            [ 4]   24     inc a
   4692 06 06         [ 7]   25     ld b, #06
   4694 B8            [ 4]   26     cp b
   4695 20 02         [12]   27     jr nz, _noover5
   4697 3E 01         [ 7]   28     ld a, #01
   4699                      29     _noover5:
   4699 32 18 45      [13]   30     ld (_gamemode), a
   469C CD AF 68      [17]   31     call print_selected_green ;;AQUI NECESITA a QUE ES EL ULTIMO SELECCIONADO
                             32 
                             33     
                             34    ;;Ponemos el color por defecto a negro
   469F 26 00         [ 7]   35    ld    h, #0         ;; D = Background PEN (0)
   46A1 2E 01         [ 7]   36    ld    l, #1         ;; E = Foreground PEN (3)
   46A3 CD F8 77      [17]   37    call cpct_setDrawCharM0_asm   ;; Set draw char colours
   46A6 CD 45 57      [17]   38    call sonido_interaccion
   46A9 C9            [10]   39 ret
                             40 
                             41 
                             42 
                             43 
                             44 
                             45 
