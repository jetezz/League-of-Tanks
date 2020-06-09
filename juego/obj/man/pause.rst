ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Game over
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



                              8 .include "sys/sys_map_creator.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              9 .include "man/state_manager.h.s"
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



                             10 
   4883 50 61 75 73 65 00    11 pausestring: .asciz "Pause"
                             12 
                             13 
                             14 ;;Quitar pausa
   4889                      15 unPause::
   4889 21 19 45      [10]   16   ld hl, #_pausa
   488C 36 00         [10]   17   ld (hl), #00
                             18 
   488E CD F9 57      [17]   19   call draw_map_sinhud
                             20 
   4891 C9            [10]   21 ret
                             22 ;;Poner pausa
   4892                      23 Pause::
   4892 21 19 45      [10]   24   ld hl, #_pausa
   4895 36 01         [10]   25   ld (hl), #01
                             26 
                             27     ;;Escribimos el pause en pantalla
   4897 11 00 C0      [10]   28     ld de, #0xC000
   489A 0E 1E         [ 7]   29     ld   c, #30  ;;x
   489C 06 5A         [ 7]   30     ld   b, #90  ;;y
   489E CD 1B 78      [17]   31     call cpct_getScreenPtr_asm
   48A1 FD 21 83 48   [14]   32     ld iy, #pausestring
   48A5 CD E7 74      [17]   33     call cpct_drawStringM0_asm
                             34 
   48A8 11 00 80      [10]   35     ld de, #0x8000
   48AB 0E 1E         [ 7]   36     ld   c, #30  ;;x
   48AD 06 5A         [ 7]   37     ld   b, #90  ;;y
   48AF CD 1B 78      [17]   38     call cpct_getScreenPtr_asm
   48B2 FD 21 83 48   [14]   39     ld iy, #pausestring 
   48B6 CD E7 74      [17]   40     call cpct_drawStringM0_asm
                             41 
                             42 
   48B9 C9            [10]   43 ret
