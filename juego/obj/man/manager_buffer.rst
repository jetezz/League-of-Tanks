ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; Manager_buffer 
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



   3F88 00 80                 6 videoPrt:: .dw #0x8000
                              7 
   3F8A                       8 map_switchBuffers::
                     0003     9 	modifier=.+1
   3F8A 2E 20         [ 7]   10  ld l, #0x20
   3F8C CD B8 76      [17]   11  call cpct_setVideoMemoryPage_asm
   3F8F 21 8B 3F      [10]   12  ld hl, #modifier
   3F92 3E 10         [ 7]   13  ld a, #0x10
   3F94 AE            [ 7]   14  xor (hl)    ;; hace un xor con a
   3F95 32 8B 3F      [13]   15  ld (modifier), a
                             16 
                             17 
   3F98 21 89 3F      [10]   18  ld 	hl, #videoPrt+1  ;;valor del videoPrt
   3F9B 3E 40         [ 7]   19  ld 	a, #0x40
   3F9D AE            [ 7]   20  xor (hl)
   3F9E 32 89 3F      [13]   21  ld (videoPrt+1), a
                             22 
   3FA1 C9            [10]   23 ret
   3FA2                      24 map_firstBuffer::
                             25  
   3FA2 2A 88 3F      [16]   26  ld hl, (videoPrt)
   3FA5 7C            [ 4]   27  ld a, h
   3FA6 FE 80         [ 7]   28  cp #0x80
   3FA8 CC 8A 3F      [17]   29  call z, map_switchBuffers
                             30 
                             31 
   3FAB C9            [10]   32 ret
                             33 
                             34 
                             35 
   3FAC                      36 map_getVideoPrt::
   3FAC 2A 88 3F      [16]   37 	ld hl, (videoPrt)
   3FAF C9            [10]   38 	ret 
