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



                              8 .include "sys/sys_map_colision.h.s"
                              1 ;;
                              2 ;;sys map colision h
                              3 ;;
                              4 
                              5 
                     0000     6 sin_inicializar=0
                     0001     7 siguiente_colision=1
                     0002     8 partida_terminada=2
                              9 
                             10 .globl comp_colisiones
                             11 .globl buscar_tile
                             12 .globl reiniciar_colisiones
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



                             10 
                             11 
                             12 
                             13 
   6040                      14 plant_update::
                             15 
                             16 
   6040 CD AC 44      [17]   17   call plantman_getPlanta ;;Devuelve en ix la planta
   6043 DD 7E 06      [19]   18   ld a, p_cont(ix)
   6046 3D            [ 4]   19   dec a
   6047 DD 77 06      [19]   20   ld p_cont(ix), a
   604A 20 0A         [12]   21   jr nz, nocambio
   604C 3E FA         [ 7]   22   ld a, #250
   604E DD 77 06      [19]   23   ld p_cont(ix), a
   6051 3E 00         [ 7]   24   ld a, #0
   6053 DD 77 07      [19]   25   ld p_activa(ix), a
   6056                      26   nocambio:
                             27 
                             28   
   6056 DD 7E 07      [19]   29   ld a, p_activa(ix)
   6059 3D            [ 4]   30   dec a
   605A 20 01         [12]   31   jr nz, _novalido
   605C C9            [10]   32   ret 
                             33 
                             34 
                             35 
                             36 
                             37 
   605D                      38   _novalido:
                             39 
   605D                      40   _incorrecto_lmayorquea:
   605D CD D2 77      [17]   41   call cpct_getRandom_mxor_u8_asm
   6060 3E 4A         [ 7]   42   ld a, #74
   6062 95            [ 4]   43   sub l
   6063 38 F8         [12]   44   jr c, _incorrecto_lmayorquea
   6065 45            [ 4]   45   ld b, l
                             46 
                             47 
   6066                      48     _incorrecto_lmayorquea2:
   6066 CD D2 77      [17]   49   call cpct_getRandom_mxor_u8_asm
   6069 3E 90         [ 7]   50   ld a, #144
   606B 95            [ 4]   51   sub l
   606C 38 F8         [12]   52   jr c, _incorrecto_lmayorquea2
   606E 4D            [ 4]   53   ld c, l
   606F 16 04         [ 7]   54   ld d, #4
   6071 1E 10         [ 7]   55   ld e, #16
                             56 
   6073 26 03         [ 7]   57   ld h, #3
                             58 
                             59 
   6075 D5            [11]   60   push de
   6076 C5            [11]   61   push bc
   6077 05            [ 4]   62   dec b
   6078 CD 97 5E      [17]   63   call comp_colisiones ;devuelve en a 1 si no hay colision
   607B C1            [10]   64   pop bc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   607C D1            [10]   65   pop de
                             66 
   607D 3D            [ 4]   67   dec a
   607E 20 DD         [12]   68   jr nz, _novalido
   6080 26 01         [ 7]   69   ld h, #1
   6082 C5            [11]   70   push bc
   6083 04            [ 4]   71   inc b 
   6084 CD 97 5E      [17]   72   call comp_colisiones ;devuelve en a 1 si no hay colision
   6087 C1            [10]   73   pop bc
   6088 3D            [ 4]   74   dec a
   6089 20 D2         [12]   75   jr nz, _novalido
                             76 
                             77 
                             78 
   608B CD AC 44      [17]   79   call plantman_getPlanta ;;Devuelve en ix la planta
                             80 
                             81 
   608E DD 70 00      [19]   82   ld   p_x(ix), b ;;x
   6091 DD 71 01      [19]   83   ld   p_y(ix), c;;y
   6094 3E 01         [ 7]   84   ld   a, #1
   6096 DD 77 07      [19]   85   ld   p_activa(ix), a
                             86 
                             87 
                             88  
   6099 C9            [10]   89 ret
