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



                              9 .include "sys/physical_system.h.s"
                              1 ;;
                              2 ;;Phisical_sistem h
                              3 ;;
                              4 
                              5 .globl move_entities_init
                              6 .globl move_entities
                              7 .globl check_gameover
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "sys/sys_comp_disp.h.s"
                              1 ;;
                              2 ;;sys_compr_disparo h
                              3 ;;
                              4 
                              5 
                              6 
                              7 
                              8 
                              9 .globl sys_comp_disp_init
                             10 
                             11 
                             12 .globl sys_comp_disp_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 .include "sys/ia_control_sys.h.s"
                              1 ;;
                              2 ;;IA ENTITY CONTROL SYSTEM h
                              3 ;;
                              4 
                              5 
                              6 ;; siempre impar que sino la liamos 
                     0033     7 _dificultad_ia_nive1=51
                     0029     8 _dificultad_ia_nive2=41
                     0019     9 _dificultad_ia_nive3=25
                     000F    10 _dificultad_ia_nive4=15
                             11 
                     0001    12 _nivel_1x=1
                     0004    13 _nivel_1y=4
                     0002    14 _nivel_2x=2
                     0008    15 _nivel_2y=8
                             16 
                     FFFFFFFF    17 _nivel_1x_n=-1
                     FFFFFFFC    18 _nivel_1y_n=-4
                     FFFFFFFE    19 _nivel_2x_n=-2
                     FFFFFFF8    20 _nivel_2y_n=-8
                             21 
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
                             28 .globl sys_ai_control_update
                             29 .globl sys_ai_control_init
                             30 .globl sys_ai_patrol
                             31 .globl sys_ia_stand_by
                             32 
                             33 .globl cambiar_dificultad_ia
                             34 .globl cambiar_velocidad_ia
                             35 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             12 .include "sys/clean_entities.h.s"
                              1 ;;
                              2 ;;CLEAN Entities
                              3 ;;
                              4 
                              5 .globl clean_entities_init
                              6 .globl clean_entities
                              7 .globl limpiar_ultimo
                              8 .globl limpiar_ultima
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             13 .include "sys/render_system.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             14 .include "sys/plant_physics.h.s"
                              1 ;;
                              2 ;;update plant SYSTEM
                              3 ;;
                              4 
                              5 
                              6 .globl plant_update
                              7 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             15 .include "sys/sys_a.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                             16   
                             17 
   4860                      18 ingame_update::
                             19 
                             20   ;; call a mover entidades (jugador/es y enemigos) (phisical_system) 
   4860 CD 64 49      [17]   21   call move_entities
                             22   ;; call comprobar si hay teclas pulsadas y modificar velocidad (check_key) // jesus 
   4863 CD 40 60      [17]   23   call plant_update
   4866 CD F1 4A      [17]   24   call check_key
                             25   ;; call sys_comp_disp_update para comprobar si las balas chocan o no con los canon
   4869 CD 7E 69      [17]   26   call sys_comp_disp_update
                             27   ;; call borrar posicion entidades en pantalla  (clean_entities) // Jesus
                             28   ;; call Pintar trozos de mapa borrados por el movimiento  (actualizar) (draw_map) // Emilio
                             29   ;; call calcular velocidades enemigos ¡¡¡¡IA¡¡¡¡ (ia_control_sys)
   486C CD 53 6A      [17]   30   call sys_ai_control_update
   486F CD 9B 4E      [17]   31   call animar
                             32  
                             33   ;; call sys_comp_disp_update para comprobar si las balas chocan o no con los canon
   4872 CD B6 4A      [17]   34   call check_gameover
                             35     
   4875 CD FA 4D      [17]   36   call check_Pause
   4878 CD B8 4D      [17]   37   call check_Esc
                             38 
   487B C9            [10]   39 ret
                             40 
   487C                      41 ingame_render::
                             42 
                             43   ;; call limpiar entidades
   487C CD 82 54      [17]   44   call clean_entities
                             45   ;; call render (personaje enemigos (objeros?))(render_system)
   487F CD CB 60      [17]   46   call rendersys_update
                             47 
   4882 C9            [10]   48 ret
