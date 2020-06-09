ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;man create nivel
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "man_create_nivel.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "sys/sys_map_creator.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "sys/ia_control_sys.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 .include "sys/sys_create_bullet.h.s"
                              1 ;;
                              2 ;;sys create bullet h
                              3 ;;
                              4 
                              5 .globl sys_create_bullet_init
                              6 .globl create_bullets_array
                              7 .globl hacer_disparo
                              8 
                              9 
                             10 
                     0001    11 _nivel_1x=1
                     0004    12 _nivel_1y=4
                     0002    13 _nivel_2x=2
                     0008    14 _nivel_2y=8
                             15 
                     FFFFFFFF    16 _nivel_1x_n=-1
                     FFFFFFFC    17 _nivel_1y_n=-4
                     FFFFFFFE    18 _nivel_2x_n=-2
                     FFFFFFF8    19 _nivel_2y_n=-8
                             20 
                             21 
                             22 .globl velocidad_balas
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              9 .include "sys/sys_interrup_music.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "sys/sys_map_colision.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 .include "sys/sys_patrol.h.s"
                              1 ;;
                              2 ;;sys_patrol.h.s
                              3 ;;
                              4 
                              5 .globl patrol_nivel_single1
                              6 .globl patrol_nivel_single2
                              7 .globl patrol_nivel_single3
                              8 .globl patrol_nivel_single4
                              9 .globl patrol_nivel_single5
                             10 .globl patrol_nivel_single6
                             11 
                             12 
                             13 .globl patrol_nivel_multi1
                             14 .globl patrol_nivel_multi2
                             15 .globl patrol_nivel_multi3
                             16 .globl patrol_nivel_multi4
                             17 .globl patrol_nivel_multi5
                             18 .globl patrol_nivel_multi6
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             12 .include "sys/sys_posicionar_entities.h.s"
                              1 ;;
                              2 ;;sys_posicionar entities h
                              3 ;;
                              4 .globl posicion_entities
                              5 .globl reiniciar_posiciones
                     0000     6 sin_posicion=0
                     0001     7 siguiente_posicion=1
                     0002     8 partida_terminada=2
                              9 
                     0000    10 hay_entidad=0
                     0001    11 no_hay_entidad=1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             13 .include "man/st_game_over.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             14 .include "sys/sys_kill_bullet.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             15 
   3DB2 00                   16 estado_nivel_single:: .db #00
   3DB3 00                   17 estado_nivel_multi: .db #00
                             18 ;; funcion para inicializar los niveles LLAMAR A ESTA FUNCION LA PRIMERA VEZ
                             19 
                             20 
                             21 
                             22 
                             23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             25 ;;GENERADOR NIVELES SINGLE_PLAYER;;;;;
                             26 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             27 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             28 
                             29 
                             30 
   3DB4                      31 crear_nivel_single::
                             32 
                             33 
                             34 
                             35 
                             36 
   3DB4 3A B2 3D      [13]   37 ld a, (estado_nivel_single)
   3DB7 FE 00         [ 7]   38 cp #sin_nivel
   3DB9 20 0B         [12]   39 jr nz,_NO_inicializar_nivel1 ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
   3DBB                      40 _inicializar_nivel1:	;; inicializo el nivel y lo pongo en el nivel_1
   3DBB 21 D2 3D      [10]   41 ld hl, #nivel_1
   3DBE 22 CD 3D      [16]   42 ld(_puntero_nivel),hl
                             43 
   3DC1 3E 01         [ 7]   44 ld a, #siguiente_nivel ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
   3DC3 32 B2 3D      [13]   45 ld (estado_nivel_single),a
                             46 
   3DC6                      47 _NO_inicializar_nivel1: ;; salto al nivel que toca
                             48 
   3DC6 CD 37 44      [17]   49 call estado_game_over
   3DC9 3D            [ 4]   50 dec a
   3DCA 28 03         [12]   51 jr z,_reiniciar_posiciones
                             52 
                             53 
                     001B    54  _puntero_nivel=.+1
   3DCC C3 00 00      [10]   55  jp 0000
                             56 
   3DCF                      57  _reiniciar_posiciones:
                             58 
                     001E    59   _puntero_nivel_reinicio=.+1
   3DCF C3 00 00      [10]   60  jp 0000
                             61  
                             62 ;;;;;;;;;;;;;;;;;;;;;;;;;
                             63 ;;NIVEL 1 single player;;
                             64 ;;;;;;;;;;;;;;;;;;;;;;;;;
                             65 
   3DD2                      66 nivel_1::
                             67 	
   3DD2 CD AA 5B      [17]   68  call posicion_entities
   3DD5 CD 7F 64      [17]   69  call patrol_nivel_single1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   3DD8 CD 29 5F      [17]   70  call cambiar_colisiones
                             71  
   3DDB CD 25 58      [17]   72  call next_map
                             73 
                             74  
   3DDE 3E 01         [ 7]   75  ld a, #dificultad1
   3DE0 CD 45 6C      [17]   76  call cambiar_velocidad_ia
                             77 
   3DE3 3E 01         [ 7]   78  ld a, #dificultad1
   3DE5 CD 1D 6C      [17]   79  call cambiar_dificultad_ia
                             80 
   3DE8 3E 01         [ 7]   81  ld a, #dificultad1 
   3DEA CD FB 52      [17]   82  call velocidad_balas
                             83 
                             84 
   3DED CD AC 57      [17]   85  call next_song
                             86 
   3DF0 21 FD 3D      [10]   87 ld hl, #nivel_2		;;preparo para ir al siguiente nivel
   3DF3 22 CD 3D      [16]   88 ld(_puntero_nivel),hl
                             89 
   3DF6 21 D2 3D      [10]   90 ld hl, #nivel_1		
   3DF9 22 D0 3D      [16]   91 ld(_puntero_nivel_reinicio),hl
                             92 
   3DFC C9            [10]   93 ret
                             94 
                             95 
                             96 ;;;;;;;;;;;;;;;;;;;;;;;;;
                             97 ;;NIVEL 2 single player;;
                             98 ;;;;;;;;;;;;;;;;;;;;;;;;;
                             99 
   3DFD                     100 nivel_2::
                            101  
   3DFD CD AA 5B      [17]  102  call posicion_entities
   3E00 CD A7 64      [17]  103   call patrol_nivel_single2
   3E03 CD 25 58      [17]  104  call next_map
   3E06 CD 29 5F      [17]  105  call cambiar_colisiones
                            106 
   3E09 3E 01         [ 7]  107  ld a, #dificultad1
   3E0B CD 45 6C      [17]  108  call cambiar_velocidad_ia
                            109 
   3E0E 3E 01         [ 7]  110  ld a, #dificultad1
   3E10 CD 1D 6C      [17]  111  call cambiar_dificultad_ia
                            112 
   3E13 3E 01         [ 7]  113  ld a, #dificultad1 
   3E15 CD FB 52      [17]  114  call velocidad_balas
                            115 
   3E18 21 25 3E      [10]  116 ld hl, #nivel_3		;;preparo para ir al siguiente nivel
   3E1B 22 CD 3D      [16]  117 ld(_puntero_nivel),hl
                            118 
   3E1E 21 FD 3D      [10]  119 ld hl, #nivel_2		
   3E21 22 D0 3D      [16]  120 ld(_puntero_nivel_reinicio),hl
   3E24 C9            [10]  121 ret
                            122 
                            123 
                            124 ;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            125 ;;NIVEL 3 single player;;
                            126 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3E25                     127 nivel_3::
                            128 
   3E25 CD AA 5B      [17]  129   call posicion_entities                
   3E28 CD CF 64      [17]  130  call patrol_nivel_single3
                            131 
   3E2B CD 29 5F      [17]  132  call cambiar_colisiones
                            133 
   3E2E CD 25 58      [17]  134  call next_map
                            135 
                            136 
   3E31 3E 01         [ 7]  137   ld a, #dificultad1
   3E33 CD 45 6C      [17]  138  call cambiar_velocidad_ia
                            139 
   3E36 3E 02         [ 7]  140  ld a, #dificultad2
   3E38 CD 1D 6C      [17]  141  call cambiar_dificultad_ia
                            142 
   3E3B 3E 01         [ 7]  143  ld a, #dificultad1 
   3E3D CD FB 52      [17]  144  call velocidad_balas
                            145 
   3E40 CD AC 57      [17]  146  call next_song
                            147 
                            148 
   3E43 21 50 3E      [10]  149 ld hl, #nivel_4		;;preparo para ir al siguiente nivel
   3E46 22 CD 3D      [16]  150 ld(_puntero_nivel),hl
                            151 
                            152 
   3E49 21 25 3E      [10]  153 ld hl, #nivel_3		
   3E4C 22 D0 3D      [16]  154 ld(_puntero_nivel_reinicio),hl
   3E4F C9            [10]  155 ret
                            156 
                            157 
                            158 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            159 ;;NIVEL 4 single player;;
                            160 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3E50                     161 nivel_4::
                            162 
   3E50 CD AA 5B      [17]  163   call posicion_entities               
   3E53 CD F7 64      [17]  164   call patrol_nivel_single4
                            165 
   3E56 CD 29 5F      [17]  166  call cambiar_colisiones
                            167 
   3E59 CD 25 58      [17]  168  call next_map
                            169 
                            170 
                            171 
   3E5C 3E 01         [ 7]  172   ld a, #dificultad1
   3E5E CD 45 6C      [17]  173  call cambiar_velocidad_ia
                            174 
   3E61 3E 03         [ 7]  175  ld a, #dificultad3
   3E63 CD 1D 6C      [17]  176  call cambiar_dificultad_ia
                            177 
   3E66 3E 01         [ 7]  178  ld a, #dificultad1 
   3E68 CD FB 52      [17]  179  call velocidad_balas
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            180 
   3E6B 21 78 3E      [10]  181 ld hl, #nivel_5		;;preparo para ir al siguiente nivel
   3E6E 22 CD 3D      [16]  182 ld(_puntero_nivel),hl
                            183 
                            184 
   3E71 21 50 3E      [10]  185 ld hl, #nivel_4		
   3E74 22 D0 3D      [16]  186 ld(_puntero_nivel_reinicio),hl
   3E77 C9            [10]  187 ret
                            188 
                            189 
                            190 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            191 ;;NIVEL 5 single player;;
                            192 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3E78                     193 nivel_5::
                            194 
                            195 
   3E78 CD AA 5B      [17]  196  call posicion_entities               
   3E7B CD 1F 65      [17]  197  call patrol_nivel_single5
                            198 
   3E7E CD 29 5F      [17]  199  call cambiar_colisiones
                            200 
   3E81 CD 25 58      [17]  201  call next_map
                            202 
   3E84 3E 02         [ 7]  203  ld a, #dificultad2
   3E86 CD 45 6C      [17]  204  call cambiar_velocidad_ia
                            205 
   3E89 3E 03         [ 7]  206  ld a, #dificultad3
   3E8B CD 1D 6C      [17]  207  call cambiar_dificultad_ia
                            208 
   3E8E 3E 02         [ 7]  209  ld a, #dificultad2 
   3E90 CD FB 52      [17]  210  call velocidad_balas
                            211 
   3E93 CD AC 57      [17]  212  call next_song
                            213 
   3E96 21 A3 3E      [10]  214 ld hl, #nivel_6		;;preparo para ir al siguiente nivel
   3E99 22 CD 3D      [16]  215 ld(_puntero_nivel),hl
                            216 
                            217 
   3E9C 21 78 3E      [10]  218 ld hl, #nivel_5		
   3E9F 22 D0 3D      [16]  219 ld(_puntero_nivel_reinicio),hl
                            220 
   3EA2 C9            [10]  221 ret
                            222 
                            223 
                            224 
                            225 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            226 ;;NIVEL 6 single player;;
                            227 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3EA3                     228 nivel_6::
                            229 
                            230  
                            231 
   3EA3 CD AA 5B      [17]  232  call posicion_entities               
   3EA6 CD 47 65      [17]  233  call patrol_nivel_single6
                            234 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   3EA9 CD 29 5F      [17]  235  call cambiar_colisiones
                            236 
   3EAC CD 25 58      [17]  237  call next_map
                            238 
   3EAF 3E 02         [ 7]  239  ld a, #dificultad2
   3EB1 CD 45 6C      [17]  240  call cambiar_velocidad_ia
                            241 
   3EB4 3E 04         [ 7]  242  ld a, #dificultad4
   3EB6 CD 1D 6C      [17]  243  call cambiar_dificultad_ia
                            244 
   3EB9 3E 02         [ 7]  245  ld a, #dificultad2 
   3EBB CD FB 52      [17]  246  call velocidad_balas
                            247 
                            248 
   3EBE 21 A3 3E      [10]  249 ld hl, #nivel_6		;;preparo para ir al siguiente nivel
   3EC1 22 CD 3D      [16]  250 ld(_puntero_nivel),hl
                            251 
   3EC4 3E 02         [ 7]  252 ld a, #partida_terminada ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
   3EC6 32 B2 3D      [13]  253 ld (estado_nivel_single),a
                            254 
                            255 
   3EC9 21 A3 3E      [10]  256 ld hl, #nivel_6		
   3ECC 22 D0 3D      [16]  257 ld(_puntero_nivel_reinicio),hl
                            258 
                            259 
   3ECF C9            [10]  260 ret
                            261 
                            262 
                            263 
                            264 
                            265 
                            266 
                            267 
                            268 
                            269 
                            270 
                            271 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            272 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            273 ;;GENERADOR NIVELES MULTIJUGADOR;;;;;;
                            274 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            275 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            276 
                            277 
   3ED0                     278 crear_nivel_multi::
                            279 
   3ED0 3A B3 3D      [13]  280 ld a, (estado_nivel_multi)
   3ED3 FE 00         [ 7]  281 cp #sin_nivel
   3ED5 20 0B         [12]  282 jr nz,_NO_inicializar_nivel_multi1 ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
   3ED7                     283 _inicializar_nivel_multi1:	;; inicializo el nivel y lo pongo en el nivel_1
   3ED7 21 E5 3E      [10]  284 ld hl, #nivel_multi_1
   3EDA 22 E3 3E      [16]  285 ld(_puntero_nivel_multi),hl
                            286 
   3EDD 3E 01         [ 7]  287 ld a, #siguiente_nivel ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
   3EDF 32 B3 3D      [13]  288 ld (estado_nivel_multi),a
                            289 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   3EE2                     290 _NO_inicializar_nivel_multi1: ;; salto al nivel que toca
                            291 
                     0131   292  _puntero_nivel_multi=.+1
   3EE2 C3 00 00      [10]  293  jp 0000
                            294  
                            295 
                            296 
                            297 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            298 ;;NIVEL 1 multiplayer  ;;
                            299 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3EE5                     300 nivel_multi_1::
                            301 
                            302  
   3EE5 CD 1F 58      [17]  303  call reset_lvl
                            304 
   3EE8 CD 6F 65      [17]  305  call patrol_nivel_multi1
                            306  
   3EEB CD AA 5B      [17]  307  call posicion_entities
                            308 
   3EEE CD 29 5F      [17]  309  call cambiar_colisiones
                            310 
                            311 
   3EF1 CD 25 58      [17]  312  call next_map
                            313 
                            314 
   3EF4 CD AC 57      [17]  315  call next_song
                            316 
                            317 
                            318 
   3EF7 21 FE 3E      [10]  319 ld hl, #nivel_multi_2		;;preparo para ir al siguiente nivel
   3EFA 22 E3 3E      [16]  320 ld (_puntero_nivel_multi),hl
                            321 
   3EFD C9            [10]  322 ret
                            323 
                            324 
                            325 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            326 ;;NIVEL 2 multiplayer  ;;
                            327 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3EFE                     328 nivel_multi_2::
                            329 
   3EFE CD AA 5B      [17]  330  call posicion_entities
                            331 
   3F01 CD 97 65      [17]  332  call patrol_nivel_multi2
                            333 
   3F04 CD 29 5F      [17]  334  call cambiar_colisiones
                            335 
   3F07 CD 25 58      [17]  336  call next_map
                            337 
                            338 
                            339 
                            340 
                            341 
   3F0A 21 11 3F      [10]  342 ld hl, #nivel_multi_3		;;preparo para ir al siguiente nivel
   3F0D 22 E3 3E      [16]  343 ld(_puntero_nivel_multi),hl
   3F10 C9            [10]  344 ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            345 
                            346 
                            347 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            348 ;;NIVEL 3 multiplayer  ;;
                            349 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3F11                     350 nivel_multi_3::
                            351 
   3F11 CD AA 5B      [17]  352  call posicion_entities
                            353 
   3F14 CD BF 65      [17]  354  call patrol_nivel_multi3
                            355 
   3F17 CD 29 5F      [17]  356  call cambiar_colisiones
                            357 
   3F1A CD 25 58      [17]  358  call next_map
   3F1D CD AC 57      [17]  359  call next_song
                            360 
                            361 
   3F20 21 27 3F      [10]  362 ld hl, #nivel_multi_4		;;preparo para ir al siguiente nivel
   3F23 22 E3 3E      [16]  363 ld(_puntero_nivel_multi),hl
   3F26 C9            [10]  364 ret
                            365 
                            366 
                            367 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            368 ;;NIVEL 4 multiplayer  ;;
                            369 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3F27                     370 nivel_multi_4::
                            371 
   3F27 CD AA 5B      [17]  372  call posicion_entities
                            373 
   3F2A CD E7 65      [17]  374  call patrol_nivel_multi4
                            375 
   3F2D CD 29 5F      [17]  376  call cambiar_colisiones
                            377 
   3F30 CD 25 58      [17]  378  call next_map
                            379 
                            380 
                            381 
   3F33 21 3A 3F      [10]  382 ld hl, #nivel_multi_5		;;preparo para ir al siguiente nivel
   3F36 22 E3 3E      [16]  383 ld(_puntero_nivel_multi),hl
   3F39 C9            [10]  384 ret
                            385 
                            386 
                            387 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            388 ;;NIVEL 5 multiplayer  ;;
                            389 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3F3A                     390 nivel_multi_5::
                            391 
   3F3A CD AA 5B      [17]  392  call posicion_entities
                            393 
   3F3D CD 0F 66      [17]  394  call patrol_nivel_multi5
                            395 
   3F40 CD 29 5F      [17]  396  call cambiar_colisiones
                            397 
   3F43 CD 25 58      [17]  398  call next_map
   3F46 CD AC 57      [17]  399  call next_song
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            400 
   3F49 21 51 3F      [10]  401 ld hl, #nivel_multi_6		;;preparo para ir al siguiente nivel
   3F4C 22 E3 3E      [16]  402 ld(_puntero_nivel_multi),hl
   3F4F C9            [10]  403 ret
                            404 
   3F50 C9            [10]  405 ret
                            406 
                            407 
                            408 ;;;;;;;;;;;;;;;;;;;;;;;;;
                            409 ;;NIVEL 6 multiplayer  ;;
                            410 ;;;;;;;;;;;;;;;;;;;;;;;;;
   3F51                     411 nivel_multi_6:
                            412 
   3F51 CD 37 66      [17]  413  call patrol_nivel_multi6
                            414 
   3F54 CD 29 5F      [17]  415  call cambiar_colisiones
                            416 
   3F57 CD 25 58      [17]  417  call next_map
                            418 
                            419 
   3F5A 21 E5 3E      [10]  420 ld hl, #nivel_multi_1		;;preparo para ir al siguiente nivel
   3F5D 22 E3 3E      [16]  421 ld (_puntero_nivel_multi),hl
   3F60 C9            [10]  422 ret
                            423 
                            424 
                            425 
                            426 
   3F61                     427 sistema_reiniciar_niveles::
                            428 
   3F61 3E 00         [ 7]  429 ld a,#0
   3F63 32 B2 3D      [13]  430 ld (estado_nivel_single), a
   3F66 32 B3 3D      [13]  431 ld (estado_nivel_multi), a
                            432 
   3F69 CD 81 44      [17]  433 call reiniciar_gameover
   3F6C CD 8E 5E      [17]  434 call reiniciar_posiciones
   3F6F CD 1F 58      [17]  435 call reset_lvl
   3F72 CD 3A 60      [17]  436 call reiniciar_colisiones
   3F75 CD 4E 56      [17]  437 call kill_bullet_all
                            438 
   3F78 3E 01         [ 7]  439 ld a, #dificultad1
   3F7A CD 45 6C      [17]  440  call cambiar_velocidad_ia
                            441 
   3F7D 3E 01         [ 7]  442  ld a, #dificultad1
   3F7F CD 1D 6C      [17]  443  call cambiar_dificultad_ia
                            444 
   3F82 3E 01         [ 7]  445  ld a, #dificultad1 
   3F84 CD FB 52      [17]  446  call velocidad_balas
                            447 	
   3F87 C9            [10]  448 	ret
