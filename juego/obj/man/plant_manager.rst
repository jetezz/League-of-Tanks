ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;entity manager
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "plant_manager.h.s" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "man/state_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 
                              8 
   44A3                       9 create_plant::
                             10 
   44A3                      11   Plant planta     00,00, _plant_sp, 4, 16, 250, 0
   0000                       1 planta::
   44A3 00                    2 .db 00      ;;posicion x del tanque
   44A4 00                    3 .db 00	;;posicion y del tanque
   44A5 60 20                 4 .dw _plant_sp
   44A7 04                    5 .db 4
   44A8 10                    6 .db 16
   44A9 FA                    7 .db 250  ;; contador cambio posicion
   44AA 00                    8 .db 0
                              9 
                             12 
   44AB C9            [10]   13 ret
                             14 
   44AC                      15 plantman_getPlanta::
                             16 
   44AC DD 21 A3 44   [14]   17  ld ix, #planta
                             18 
   44B0 C9            [10]   19 ret
                             20 
                             21 
                             22 
