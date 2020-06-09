ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
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



                              6 .include "man/plant_manager.h.s"
                              1 ;;
                              2 ;;entity Manager
                              3 ;;
                              4 
                              5 
                              6 .globl plantman_getPlanta
                              7 .globl create_plant
                              8 
                              9 ;; Entity definition macro
                             10 
                             11 
                             12 .macro Plant _nombrePlanta,_x,_y,_sprite,_ancho,_alto,_livecont, _activa
                             13 _nombrePlanta::
                             14 .db _x      ;;posicion x del tanque
                             15 .db _y	;;posicion y del tanque
                             16 .dw _sprite
                             17 .db _ancho
                             18 .db _alto
                             19 .db _livecont  ;; contador cambio posicion
                             20 .db _activa
                             21 
                             22 .endm 
                             23 
                     0000    24 p_x  	= 0
                     0001    25 p_y  	= 1
                     0002    26 p_sprite = 2
                     0003    27 p_sprite2 = 3
                     0004    28 p_ancho = 4
                     0005    29 p_alto = 5
                     0006    30 p_cont = 6
                     0007    31 p_activa = 7
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "man/manager_buffer.h.s"
                              1 ;;
                              2 ;;Manager_buffer h
                              3 ;;
                              4 
                              5 .globl map_switchBuffers
                              6 .globl map_getVideoPrt
                              7 .globl map_firstBuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 .include "assets.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              9 
                             10 
                             11 
                             12 
                             13 
   566D                      14 plant_render::
                             15 
                             16   
   566D CD AC 44      [17]   17   call plantman_getPlanta ;;Devuelve en ix la planta
                             18 
   5670 CD AC 3F      [17]   19   call map_getVideoPrt
                             20 
   5673 EB            [ 4]   21   ex de, hl
   5674 DD 4E 00      [19]   22   ld   c, p_x(ix)  ;;x
   5677 DD 46 01      [19]   23   ld   b, p_y(ix)  ;;y
   567A CD 1B 78      [17]   24   call cpct_getScreenPtr_asm
   567D EB            [ 4]   25   ex de, hl
                             26 
   567E DD 6E 02      [19]   27  ld l, p_sprite(ix)
   5681 DD 66 03      [19]   28  ld h, p_sprite2(ix)
   5684 0E 04         [ 7]   29  ld c, #04  ;;ancho
   5686 06 10         [ 7]   30  ld b, #16  ;;alto
                             31  
   5688 CD 71 75      [17]   32  call cpct_drawSprite_asm
                             33  
   568B C9            [10]   34 ret
