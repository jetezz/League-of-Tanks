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



                              8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              9 .include "sys/check_key.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             10 .include "sys/sys_dir.h.s"
                              1 ;;
                              2 ;;sys dir h
                              3 ;;
                              4 
                              5 
                              6 .globl modificar_sprite
                              7 
                              8 
                     0019     9 _contador_ciclos = 25
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             11 .include "sys/sys_kill_bullet.h.s"
                              1 ;;
                              2 ;;sys_kill_bullet h
                              3 ;;
                              4 
                              5 
                              6 ;; FUNCIONES GLOBALES
                              7 .globl kill_bullet_init
                              8 .globl kill_bullet
                              9 .globl kill_bullet_all
                             10 
                             11 
                             12 ;; CONSTANTES
                             13 
                     FFFFFFFF    14 _bala_disponible = -1
                     0004    15 _id_last_bullet = 4      ;; NUMERO MAXIMO DE BALAS - 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             14 .include "man/entity_manager.h.s"
                              1 ;;
                              2 ;;entity Manager
                              3 ;;
                              4 
                              5 
                              6 
                              7 .globl create_entities
                              8 .globl entityman_getEntityVector_IX
                              9 .globl entityman_num_entities
                             10 .globl _num_entities
                             11 .globl init_entities
                             12 
                             13 
                             14 ;; Entity definition macro
                             15 
                             16 
                             17 .macro Entity _name,_x,_y,_xl,_yl,_xll,_yll,_vx,_vy,_sh,_iast,_dir,_dead,_ancho,_alto
                             18 _name::
                             19 .db _x      ;;posicion x del tanque
                             20 .db _y	;;posicion y del tanque
                             21 .db _xl	;;posicion de la x anterior
                             22 .db _yl	;;posicion de la y anterior
                             23 .db _xll	;;posicion de la x 2 veces anterior
                             24 .db _yll	;;posicion de la x 2 veces anterior
                             25 .db _vx	;;velocidad en x
                             26 .db _vy	;;velocidad en y
                             27 .db _sh	;;shot 0 no 1 si
                             28 .db _iast;;type 0 jugador por teclas ,1 enemigo ia
                             29 .db _dir    ;;movimiento  
                             30 .db _sh     ;; si no dispara es 0 si dispara es 1
                             31 .db _dead;;canon 0 vivo 1 muere
                             32 .db 0x00, 0x00    ;;iax ia y
                             33 .db _iast  ;;Estado anterior de la ia 
                             34 .dw 0x0000	;; puntero de la patrulla que voy a realizar
                             35 .dw 0x0000 ;;puntero al estado que tengo que saltar
                             36 .db _ancho
                             37 .db _alto
                             38 .db 25  ;; contador cambio direcion del sprite
                             39 
                             40 
                             41 
                             42 
                             43 
                             44 
                             45 .endm 
                             46 
                             47 
                             48 .macro NextEntity
                             49 ld de, #siceof_e
                             50 	add ix, de
                             51 .endm
                             52 	
                             53 
                     0000    54 e_x  	= 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                     0001    55 e_y  	= 1
                     0002    56 e_xl  = 2
                     0003    57 e_yl  = 3
                     0004    58 e_xll = 4
                     0005    59 e_yll = 5
                     0006    60 e_vx	= 6
                     0007    61 e_vy	= 7
                     0008    62 e_sh 	= 8
                     0009    63 e_ia_st = 9
                     000A    64 e_dir = 10
                     000B    65 e_sh = 11
                     000C    66 e_dead=12
                     000D    67 e_ia_x= 13
                     000E    68 e_ia_y= 14
                     000F    69 e_ia_st_prev=15
                     0010    70 e_ia_puntero_patrol_h=16
                     0011    71 e_ia_puntero_patrol_l=17
                     0012    72 e_ia_puntero_st_h=18
                     0013    73 e_ia_puntero_st_l=19
                     0014    74 e_ancho 	= 20
                     0015    75 e_alto	= 21
                     0016    76 e_clock     = 22
                     0017    77 siceof_e 	= 23
                             78 
                             79 ;; Movimiento de la entidad
                     0003    80 e_dir_right = 3
                     0002    81 e_dir_top   = 2
                     0001    82 e_dir_left  = 1
                     0004    83 e_dir_bott  = 4
                             84 
                             85 ;; Dibujo que representa el movimiento de la entidad
                             86 
                             87  ;;      2
                             88  ;;     1e3
                             89  ;;      4
                             90 
                             91 
                             92 ;;Estados ia
                     0000    93 e_ia_st_noIA 	= 0
                     0001    94 e_ia_st_stand_by	= 1
                     0002    95 e_ia_st_move_to   = 2
                     0003    96 e_ia_st_patron	= 3
                             97 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             15 .include "man/state_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             16 .include "man/man_create_nivel.h.s"
                              1 ;;
                              2 ;;man create nivel h
                              3 ;;
                              4 
                              5 
                     0000     6 sin_nivel=0
                     0001     7 siguiente_nivel=1
                     0002     8 partida_terminada=2
                              9 
                             10 ;; EN VELOCIDAD DE LA IA MAXIMO DIFICULTAD 2
                             11 ;; EN VELOCIDAD DE LA BALA MAXIMO DIFICULTAD 2
                             12 ;; EN NIVEL IA MAXIMO DIFICULTAD 4
                     0001    13 dificultad1=1
                     0002    14 dificultad2=2
                     0003    15 dificultad3=3
                     0004    16 dificultad4=4
                             17 
                     0001    18 mapa_1=1
                     0002    19 mapa_2=2
                     0003    20 mapa_3=3
                     0004    21 mapa_4=4
                     0005    22 mapa_5=5
                     0006    23 mapa_6=6
                     0007    24 mapa_single_1=7
                     0008    25 mapa_single_2=8
                     0009    26 mapa_single_3=9
                     000A    27 mapa_single_4=10
                     000B    28 mapa_single_5=11
                     000C    29 mapa_single_6=12
                             30 
                             31 
                             32 .globl crear_nivel_single
                             33 .globl crear_nivel_multi
                             34 .globl sistema_reiniciar_niveles
                             35 .globl estado_nivel_single
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                             17 .include "man/st_game_over.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                             18 .include "sys/sys_a.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                             19 
                             20 
                             21 
                             22 
   41FA 57 65 6C 6C 20 70    23 jugwin: .asciz "Well played"
        6C 61 79 65 64 00
   4206 54 72 79 20 61 67    24 julose: .asciz "Try again"
        61 69 6E 00
   4210 59 6F 75 20 77 6F    25 youwon: .asciz "You won single game"
        6E 20 73 69 6E 67
        6C 65 20 67 61 6D
        65 00
                             26 
   4224 52 65 73 74 61 72    27 restart: .asciz "Restart with enter"
        74 20 77 69 74 68
        20 65 6E 74 65 72
        00
   4237 43 6F 6E 74 69 6E    28 continue: .asciz "Continue with enter"
        75 65 20 77 69 74
        68 20 65 6E 74 65
        72 00
   424B 4D 61 69 6E 20 6D    29 esc: .asciz "Main menu with Esc"
        65 6E 75 20 77 69
        74 68 20 45 73 63
        00
                             30 
   425E 00                   31 _stado_game_over: .db #0    ;;1 single_muere    0 multi
                             32 
                             33 
                             34 
   425F                      35 updategameover_init::
                             36 
   425F 21 00 80      [10]   37     ld hl, #0x8000  ;; limpiar fireware
   4262 11 01 80      [10]   38     ld de, #0x8001
   4265 36 00         [10]   39     ld (hl), #0x00
   4267 01 00 80      [10]   40     ld bc, #0x8000
   426A ED B0         [21]   41     ldir
                             42 
   426C CD 4C 51      [17]   43     call limpiar_animaciones
   426F CD 4E 56      [17]   44     call kill_bullet_all
                             45 
   4272 CD 18 46      [17]   46     call get_gamemode
   4275 FE 05         [ 7]   47     cp #5
   4277 28 3F         [12]   48     jr z,_single_player
                             49 
                             50 
   4279                      51 _no_muere_1:
                             52 
   4279 CD 18 46      [17]   53     call get_gamemode
   427C FE 05         [ 7]   54     cp #5
   427E 28 12         [12]   55     jr z,_single_player_gana
                             56 
   4280 CD EC 42      [17]   57     call set_winner_pos
   4283 CD 23 43      [17]   58     call draw_winText
                             59 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   4286 CD 52 57      [17]   60     call off_muerte
   4289 CD 38 57      [17]   61     call sonido_win
                             62 
   428C 3E 00         [ 7]   63      ld a, #mueren_todos
   428E 32 5E 42      [13]   64     ld (_stado_game_over), a
   4291 C9            [10]   65     ret
   4292                      66 _single_player_gana:
                             67 
   4292 3A B2 3D      [13]   68     ld a, (estado_nivel_single)
   4295 FE 02         [ 7]   69     cp #2
   4297 28 12         [12]   70     jr z, _single_end_text ;;Comprobar si es el ultimo nivel de single
                             71 
   4299 CD EC 42      [17]   72     call set_winner_pos   
   429C CD AD 43      [17]   73     call draw_continueText
   429F CD 52 57      [17]   74     call off_muerte
   42A2 CD 38 57      [17]   75     call sonido_win
                             76     
   42A5 3E 00         [ 7]   77     ld a, #mueren_todos
   42A7 32 5E 42      [13]   78     ld (_stado_game_over), a
   42AA C9            [10]   79     ret
                             80 
   42AB                      81     _single_end_text: ;;pintar ultimo nivel single
                             82 
   42AB CD EC 42      [17]   83     call set_winner_pos   
   42AE CD F2 43      [17]   84     call draw_single_end_text
   42B1 CD 52 57      [17]   85     call off_muerte
   42B4 CD 38 57      [17]   86     call sonido_win
                             87 
   42B7 C9            [10]   88     ret
                             89 
   42B8                      90     _single_player:
   42B8 CD 57 48      [17]   91     call entityman_getEntityVector_IX
   42BB DD 7E 0C      [19]   92     ld a, e_dead(ix)
   42BE 3D            [ 4]   93     dec a
   42BF 20 B8         [12]   94     jr nz,_no_muere_1
   42C1                      95     _muere_single:  ;;muere el jugador 1 en single
                             96 
   42C1 CD 68 43      [17]   97     call draw_lostText
   42C4 CD 56 44      [17]   98     call dibujar_sprite_muerto
   42C7 CD 3B 44      [17]   99     call kill_all
                            100 
                            101 
   42CA 3E 01         [ 7]  102     ld a, #single_muere
   42CC 32 5E 42      [13]  103     ld (_stado_game_over), a
                            104 
   42CF C9            [10]  105     ret
                            106 
   42D0                     107 updategameover::
                            108 
                            109 
   42D0 3A 5E 42      [13]  110 ld a, (_stado_game_over)
                            111 
   42D3 FE 01         [ 7]  112 cp #single_muere
   42D5 20 07         [12]  113 jr nz,_update_multi
   42D7                     114 _update_single:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            115 
                            116 
   42D7 CD 98 4D      [17]  117  call check_restart
   42DA CD B8 4D      [17]  118     call check_Esc
                            119 
   42DD C9            [10]  120 ret
                            121 
                            122 
                            123 
                            124 
                            125 
                            126 
   42DE                     127 _update_multi:
                            128 
                            129 
                     00E6   130  _puntero_ganador=.+2
   42DE DD 21 00 00   [14]  131  ld ix, #0000
   42E2 CD E7 58      [17]  132  call modificar_sprite
   42E5 CD 98 4D      [17]  133  call check_restart
   42E8 CD B8 4D      [17]  134  call check_Esc
   42EB C9            [10]  135 ret
                            136 
                            137 
                            138 
   42EC                     139 set_winner_pos::
                            140 
                            141 
                            142 
   42EC CD 57 48      [17]  143     call entityman_getEntityVector_IX
   42EF CD 5C 48      [17]  144     call entityman_num_entities
                            145   
   42F2                     146       _loopcheckdead:
                            147 
                            148     
   42F2 DD 46 0C      [19]  149     ld b, e_dead(ix)
   42F5 05            [ 4]  150       dec b
   42F6 20 08         [12]  151       jr nz, _ganador
                            152     
   00FE                     153  NextEntity
   42F8 11 17 00      [10]    1 ld de, #siceof_e
   42FB DD 19         [15]    2 	add ix, de
   42FD 3D            [ 4]  154       dec a
   42FE 20 F2         [12]  155       jr nz, _loopcheckdead
                            156 
   4300                     157     _ganador:
                            158 
   4300 0E 26         [ 7]  159     ld   c, #38  ;;x
   4302 06 85         [ 7]  160     ld   b, #133  ;;y
                            161 
   4304 DD 36 06 00   [19]  162     ld e_vx(ix), #00
   4308 DD 36 07 00   [19]  163     ld e_vy(ix), #00
                            164 
   430C DD 71 00      [19]  165     ld e_x(ix), c
   430F DD 71 02      [19]  166     ld e_xl(ix), c
   4312 DD 71 04      [19]  167     ld e_xll(ix), c
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



                            168 
   4315 DD 70 01      [19]  169     ld e_y(ix), b
   4318 DD 70 03      [19]  170     ld e_yl(ix), b
   431B DD 70 05      [19]  171     ld e_yll(ix), b
                            172     
                            173 
   431E DD 22 E0 42   [20]  174    ld (_puntero_ganador),ix
                            175 
                            176     
                            177 
                            178 
   4322 C9            [10]  179 ret
                            180 
                            181 
   4323                     182 draw_winText::
                            183     
   4323 11 00 C0      [10]  184     ld de, #0xC000
   4326 0E 03         [ 7]  185     ld   c, #3  ;;x
   4328 06 1E         [ 7]  186     ld   b, #30  ;;y
   432A CD 1B 78      [17]  187     call cpct_getScreenPtr_asm
   432D FD 21 24 42   [14]  188     ld iy, #restart
   4331 CD E7 74      [17]  189     call cpct_drawStringM0_asm
                            190 
   4334 11 00 80      [10]  191     ld de, #0x8000
   4337 0E 03         [ 7]  192     ld   c, #3  ;;x
   4339 06 1E         [ 7]  193     ld   b, #30  ;;y
   433B CD 1B 78      [17]  194     call cpct_getScreenPtr_asm
   433E FD 21 24 42   [14]  195     ld iy, #restart 
   4342 CD E7 74      [17]  196     call cpct_drawStringM0_asm
                            197 
                            198 
   4345 11 00 C0      [10]  199     ld de, #0xC000
   4348 0E 14         [ 7]  200     ld   c, #20  ;;x
   434A 06 64         [ 7]  201     ld   b, #100  ;;y
   434C CD 1B 78      [17]  202     call cpct_getScreenPtr_asm
   434F FD 21 FA 41   [14]  203     ld iy, #jugwin
   4353 CD E7 74      [17]  204     call cpct_drawStringM0_asm
                            205    
   4356 11 00 80      [10]  206     ld de, #0x8000
   4359 0E 14         [ 7]  207     ld   c, #20  ;;x
   435B 06 64         [ 7]  208     ld   b, #100  ;;y
   435D CD 1B 78      [17]  209     call cpct_getScreenPtr_asm
   4360 FD 21 FA 41   [14]  210     ld iy, #jugwin
   4364 CD E7 74      [17]  211     call cpct_drawStringM0_asm
                            212 
                            213 
   4367 C9            [10]  214 ret
                            215 
   4368                     216 draw_lostText::
                            217     
   4368 11 00 C0      [10]  218     ld de, #0xC000
   436B 0E 03         [ 7]  219     ld   c, #3  ;;x
   436D 06 1E         [ 7]  220     ld   b, #30  ;;y
   436F CD 1B 78      [17]  221     call cpct_getScreenPtr_asm
   4372 FD 21 24 42   [14]  222     ld iy, #restart
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



   4376 CD E7 74      [17]  223     call cpct_drawStringM0_asm
                            224 
   4379 11 00 80      [10]  225     ld de, #0x8000
   437C 0E 03         [ 7]  226     ld   c, #3  ;;x
   437E 06 1E         [ 7]  227     ld   b, #30  ;;y
   4380 CD 1B 78      [17]  228     call cpct_getScreenPtr_asm
   4383 FD 21 24 42   [14]  229     ld iy, #restart 
   4387 CD E7 74      [17]  230     call cpct_drawStringM0_asm
                            231 
                            232 
   438A 11 00 C0      [10]  233     ld de, #0xC000
   438D 0E 16         [ 7]  234     ld   c, #22  ;;x
   438F 06 64         [ 7]  235     ld   b, #100  ;;y
   4391 CD 1B 78      [17]  236     call cpct_getScreenPtr_asm
   4394 FD 21 06 42   [14]  237     ld iy, #julose
   4398 CD E7 74      [17]  238     call cpct_drawStringM0_asm
                            239    
   439B 11 00 80      [10]  240     ld de, #0x8000
   439E 0E 16         [ 7]  241     ld   c, #22  ;;x
   43A0 06 64         [ 7]  242     ld   b, #100  ;;y
   43A2 CD 1B 78      [17]  243     call cpct_getScreenPtr_asm
   43A5 FD 21 06 42   [14]  244     ld iy, #julose
   43A9 CD E7 74      [17]  245     call cpct_drawStringM0_asm
                            246 
                            247 
   43AC C9            [10]  248 ret
                            249 
   43AD                     250 draw_continueText::
                            251     
   43AD 11 00 C0      [10]  252     ld de, #0xC000
   43B0 0E 03         [ 7]  253     ld   c, #3  ;;x
   43B2 06 1E         [ 7]  254     ld   b, #30  ;;y
   43B4 CD 1B 78      [17]  255     call cpct_getScreenPtr_asm
   43B7 FD 21 37 42   [14]  256     ld iy, #continue
   43BB CD E7 74      [17]  257     call cpct_drawStringM0_asm
                            258 
   43BE 11 00 80      [10]  259     ld de, #0x8000
   43C1 0E 03         [ 7]  260     ld   c, #3  ;;x
   43C3 06 1E         [ 7]  261     ld   b, #30  ;;y
   43C5 CD 1B 78      [17]  262     call cpct_getScreenPtr_asm
   43C8 FD 21 37 42   [14]  263     ld iy, #continue 
   43CC CD E7 74      [17]  264     call cpct_drawStringM0_asm
                            265 
                            266 
   43CF 11 00 C0      [10]  267     ld de, #0xC000
   43D2 0E 16         [ 7]  268     ld   c, #22  ;;x
   43D4 06 64         [ 7]  269     ld   b, #100  ;;y
   43D6 CD 1B 78      [17]  270     call cpct_getScreenPtr_asm
   43D9 FD 21 FA 41   [14]  271     ld iy, #jugwin
   43DD CD E7 74      [17]  272     call cpct_drawStringM0_asm
                            273    
   43E0 11 00 80      [10]  274     ld de, #0x8000
   43E3 0E 16         [ 7]  275     ld   c, #22  ;;x
   43E5 06 64         [ 7]  276     ld   b, #100  ;;y
   43E7 CD 1B 78      [17]  277     call cpct_getScreenPtr_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



   43EA FD 21 FA 41   [14]  278     ld iy, #jugwin
   43EE CD E7 74      [17]  279     call cpct_drawStringM0_asm
                            280 
                            281 
   43F1 C9            [10]  282 ret
                            283 
   43F2                     284 draw_single_end_text::
                            285     
   43F2 11 00 C0      [10]  286     ld de, #0xC000
   43F5 0E 03         [ 7]  287     ld   c, #3  ;;x
   43F7 06 1E         [ 7]  288     ld   b, #30  ;;y
   43F9 CD 1B 78      [17]  289     call cpct_getScreenPtr_asm
   43FC FD 21 4B 42   [14]  290     ld iy, #esc
   4400 CD E7 74      [17]  291     call cpct_drawStringM0_asm
                            292 
   4403 11 00 80      [10]  293     ld de, #0x8000
   4406 0E 03         [ 7]  294     ld   c, #3  ;;x
   4408 06 1E         [ 7]  295     ld   b, #30  ;;y
   440A CD 1B 78      [17]  296     call cpct_getScreenPtr_asm
   440D FD 21 4B 42   [14]  297     ld iy, #esc 
   4411 CD E7 74      [17]  298     call cpct_drawStringM0_asm
                            299 
                            300 
   4414 11 00 C0      [10]  301     ld de, #0xC000
   4417 0E 02         [ 7]  302     ld   c, #2  ;;x
   4419 06 64         [ 7]  303     ld   b, #100  ;;y
   441B CD 1B 78      [17]  304     call cpct_getScreenPtr_asm
   441E FD 21 10 42   [14]  305     ld iy, #youwon
   4422 CD E7 74      [17]  306     call cpct_drawStringM0_asm
                            307    
   4425 11 00 80      [10]  308     ld de, #0x8000
   4428 0E 02         [ 7]  309     ld   c, #2  ;;x
   442A 06 64         [ 7]  310     ld   b, #100  ;;y
   442C CD 1B 78      [17]  311     call cpct_getScreenPtr_asm
   442F FD 21 10 42   [14]  312     ld iy, #youwon
   4433 CD E7 74      [17]  313     call cpct_drawStringM0_asm
                            314 
                            315 
   4436 C9            [10]  316 ret
                            317 
                            318 
   4437                     319 estado_game_over::
   4437 3A 5E 42      [13]  320    ld a,(_stado_game_over)
   443A C9            [10]  321 ret
                            322 
                            323 
   443B                     324 kill_all::
                            325 
                            326 
   443B CD 57 48      [17]  327  call entityman_getEntityVector_IX
   443E CD 5C 48      [17]  328  call entityman_num_entities
                            329   
   4441                     330       _loop_matar:
                            331 
                            332     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



   4441 DD 46 0C      [19]  333     ld b, e_dead(ix)
   4444 05            [ 4]  334       dec b
   4445 20 09         [12]  335       jr nz, _matar
                            336     
   024D                     337  NextEntity
   4447 11 17 00      [10]    1 ld de, #siceof_e
   444A DD 19         [15]    2 	add ix, de
   444C 3D            [ 4]  338       dec a
   444D C8            [11]  339       ret z
   444E 18 F1         [12]  340       jr  _loop_matar
                            341 
   4450                     342     _matar:
   4450 DD 36 0C 01   [19]  343     ld  e_dead(ix), #1
                            344    
   4454 18 EB         [12]  345      jr  _loop_matar
                            346   
                            347 
                            348 
   4456                     349 dibujar_sprite_muerto:
   4456 11 00 C0      [10]  350 ld  de, #0xC000
   4459 0E 25         [ 7]  351  ld   c, #37    ;;x
   445B 06 82         [ 7]  352  ld   b, #130  ;;y
   445D CD 1B 78      [17]  353  call cpct_getScreenPtr_asm
                            354  
   4460 EB            [ 4]  355  ex de, hl
   4461 0E 04         [ 7]  356  ld c, #04  ;;ancho
   4463 06 10         [ 7]  357  ld b, #16  ;;alto
   4465 21 B0 21      [10]  358  ld hl,#_cannons_sp_04
   4468 CD 71 75      [17]  359  call cpct_drawSprite_asm
                            360 
   446B 11 00 80      [10]  361  ld  de, #0x8000
   446E 0E 25         [ 7]  362  ld   c, #37  ;;x
   4470 06 82         [ 7]  363  ld   b, #130  ;;y
   4472 CD 1B 78      [17]  364  call cpct_getScreenPtr_asm
                            365  
   4475 EB            [ 4]  366  ex de, hl
   4476 0E 04         [ 7]  367  ld c, #04  ;;ancho
   4478 06 10         [ 7]  368  ld b, #16  ;;alto
   447A 21 B0 21      [10]  369  ld hl,#_cannons_sp_04
   447D CD 71 75      [17]  370  call cpct_drawSprite_asm
                            371 
   4480 C9            [10]  372  ret
                            373 
                            374 
   4481                     375  reiniciar_gameover::
   4481 3E 00         [ 7]  376 ld a, #0
   4483 32 5E 42      [13]  377     ld (_stado_game_over), a
   4486 C9            [10]  378  ret
                            379 
                            380 
                            381 
                            382 
   4487                     383 single_end_init::
                            384 
                            385 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



   4487 21 00 80      [10]  386     ld hl, #0x8000  ;; limpiar fireware
   448A 11 01 80      [10]  387     ld de, #0x8001
   448D 36 00         [10]  388     ld (hl), #0x00
   448F 01 00 80      [10]  389     ld bc, #0x8000
   4492 ED B0         [21]  390     ldir
                            391 
                            392 
   4494 CD 4E 56      [17]  393     call kill_bullet_all
                            394 
   4497 C9            [10]  395 ret
                            396 
                            397 
   4498                     398 single_end_update::
                            399 
   4498 DD 2A E0 42   [20]  400      ld ix, (_puntero_ganador)
   449C CD E7 58      [17]  401      call modificar_sprite
   449F CD B8 4D      [17]  402     call check_Esc
                            403 
   44A2 C9            [10]  404 ret
