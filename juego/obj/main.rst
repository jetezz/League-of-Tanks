ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Juego Amstrad
                              3 ;;
                              4 
                              5 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              7 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              8 .include "man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              9 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             11 .include "sys/sys_menu.h.s"
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
   3D20 4C 45 41 47 55 45    27 title:            .asciz "LEAGUE OF TANKS";
        20 4F 46 20 54 41
        4E 4B 53 00
   3D30 50 52 45 53 53 20    28 enter:            .asciz "PRESS ENTER TO PLAY";
        45 4E 54 45 52 20
        54 4F 20 50 4C 41
        59 00
   3D44 53 69 6E 67 6C 65    29 Single_player:    .asciz "Single player";
        20 70 6C 61 79 65
        72 00
   3D52 42 61 74 74 6C 65    30 battle_royale:    .asciz "Battle Royale"
        20 52 6F 79 61 6C
        65 00
   3D60 31 20 50 6C 61 79    31 one_player:       .asciz "1 Player"
        65 72 00
   3D69 32 20 50 6C 61 79    32 two_players:      .asciz "2 Players"
        65 72 73 00
   3D73 33 20 50 6C 61 79    33 tres_players:     .asciz "3 Players"
        65 72 73 00
   3D7D 34 20 50 6C 61 79    34 cuatro_players:   .asciz "4 Players"
        65 72 73 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             12 .include "sys/sys_interrup.h.s"
                              1 ;;
                              2 ;;sys_interrup h
                              3 ;;
                              4 
                              5 
                              6 .globl isr
                              7 
                              8 
                              9 
                             10 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             13 
                             14 
                             15 
                             16 
                             17 
                             18 
                             19 
                             20 .globl _canons_pal2
                             21 .globl _song
                             22 
                             23 
                             24 
                             25 
                             26 .area _DATA
                             27 .area _CODE
                             28 
                             29 
                             30 
                             31 
                             32 
                             33 
                             34 
                             35 
                             36 
                             37  
                             38 
                             39 
   3D87                      40 _main::
                             41 	
   3D87 31 00 80      [10]   42 ld sp, #0x8000
                             43    
                             44     ;; Disable firmware to prevent it from interfering with string drawing
   3D8A CD 16 77      [17]   45     call cpct_disableFirmware_asm
                             46   
   3D8D 0E 00         [ 7]   47     ld c, #0
   3D8F CD C1 76      [17]   48     call cpct_setVideoMode_asm
                             49   
   3D92 21 A0 20      [10]   50     ld hl, #_canons_pal2
   3D95 11 10 00      [10]   51     ld de, #16
   3D98 CD AB 6C      [17]   52     call cpct_setPalette_asm
                             53 
                             54    
                             55   
                             56 
   3D9B 11 40 00      [10]   57     ld de, #_song
   3D9E CD 56 74      [17]   58     call cpct_akp_SFXInit_asm
                             59 
   3DA1 21 9A 60      [10]   60     ld hl,#isr
   3DA4 CD 77 6C      [17]   61     call cpct_setInterruptHandler_asm
                             62 
   3DA7 CD C7 66      [17]   63     call zerostate_init   ;; inicialmente, cargamos el menu del juego
                             64  
   3DAA                      65 loop: ;; loop infinito 
                             66 
                             67 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   3DAA CD 1B 45      [17]   68    call manage_game
                             69  
                             70   ;;cambiamos los buffer (manager_buffer)
                             71 
   3DAD CD CE 76      [17]   72    call cpct_waitVSYNC_asm
                             73    
                             74  
                             75 
   3DB0 18 F8         [12]   76 jr loop
                             77 
                             78 
                             79 
                             80  
                             81 
                             82 
                             83 
                             84 
                             85 
                             86 
                             87 
                             88 
                             89 
                             90 
                             91 
                             92 
                             93 
                             94 
                             95 
                             96 
                             97 
                             98 
                             99 
                            100 
                            101 
                            102 
                            103 
                            104 
                            105 
                            106 
                            107 
                            108 
                            109 
                            110 
                            111 
