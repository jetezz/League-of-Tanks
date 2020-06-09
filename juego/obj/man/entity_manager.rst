ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;entity manager
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "entity_manager.h.s" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   46AA 04                    6 _num_entities:: .db #4  ;; ESTABLECEMOS EL NUMERO DE ENTIDADES QUE HABRA EN NUESTRO JUEGO
                              7 
   46AB 04                    8 _jugx: .db #4
   46AC 10                    9 _jugy: .db #16
                             10 
   46AD 04                   11 _jug2x: .db #4
   46AE 90                   12 _jug2y: .db #144
                             13 
   46AF 48                   14 _jug3x: .db #72
   46B0 10                   15 _jug3y: .db #16
                             16 
                             17 
   46B1 48                   18 _jug4x: .db #72
   46B2 90                   19 _jug4y: .db #144
                             20 
                             21 
   46B3 00                   22 _jugv: .db #00
   46B4 00                   23 _jugshot: .db #00
   46B5 03                   24 _jugdir:  .db #03
   46B6 00                   25 _jugdead: .db #00
                             26 
   46B7 00                   27 _jugia:  .db e_ia_st_noIA
   46B8 00                   28 _jug2ia: .db e_ia_st_noIA
   46B9 00                   29 _jug3ia: .db e_ia_st_noIA
   46BA 00                   30 _jug4ia: .db e_ia_st_noIA
   46BB                      31 set_gamemode_ia::
                             32 
                             33    ;;Cambiamos el color de lo que pintaremos
   46BB 3A 18 45      [13]   34    ld a, (_gamemode)
   46BE 3D            [ 4]   35    dec a ;;Gamemode es 1, es decir 1 jugador contra ia battle royale
   46BF CC D8 46      [17]   36    call z, set_1player_ia
   46C2 C8            [11]   37    ret z
                             38 
   46C3 3D            [ 4]   39    dec a ;;Gamemode es 2, es decir 2 jugador contra ia battle royale
   46C4 CC E4 46      [17]   40    call z, set_2player_ia
   46C7 C8            [11]   41    ret z
                             42 
   46C8 3D            [ 4]   43    dec a ;;Gamemode es 3, es decir 3 jugador contra ia battle royale
   46C9 CC F2 46      [17]   44    call z, set_3player_ia
   46CC C8            [11]   45    ret z
                             46 
                             47 
   46CD 3D            [ 4]   48    dec a ;;Gamemode es 4, es decir 4 jugador battle royale
   46CE CC 00 47      [17]   49    call z, set_4player_ia
   46D1 C8            [11]   50    ret z
                             51 
   46D2 3D            [ 4]   52    dec a ;;Gamemode es 5, es decir singleplayer
   46D3 CC 0C 47      [17]   53    call z, set_single_player_ia
   46D6 C8            [11]   54    ret z
                             55 
   46D7 C9            [10]   56 ret
   46D8                      57 set_1player_ia:
   46D8 3E 01         [ 7]   58  ld a, #e_ia_st_stand_by
   46DA 32 B8 46      [13]   59  ld (_jug2ia), a
   46DD 32 B9 46      [13]   60  ld (_jug3ia), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   46E0 32 BA 46      [13]   61  ld (_jug4ia), a
   46E3 C9            [10]   62 ret
   46E4                      63 set_2player_ia:
   46E4 3E 00         [ 7]   64  ld a, #e_ia_st_noIA
   46E6 32 B8 46      [13]   65  ld (_jug2ia), a
   46E9 3E 01         [ 7]   66  ld a, #e_ia_st_stand_by
   46EB 32 B9 46      [13]   67  ld (_jug3ia), a
   46EE 32 BA 46      [13]   68  ld (_jug4ia), a
   46F1 C9            [10]   69 ret
   46F2                      70 set_3player_ia:
   46F2 3E 00         [ 7]   71  ld a, #e_ia_st_noIA
   46F4 32 B8 46      [13]   72  ld (_jug2ia), a
   46F7 32 B9 46      [13]   73  ld (_jug3ia), a
   46FA 3E 01         [ 7]   74  ld a, #e_ia_st_stand_by
   46FC 32 BA 46      [13]   75  ld (_jug4ia), a
   46FF C9            [10]   76 ret
   4700                      77 set_4player_ia:
   4700 3E 00         [ 7]   78  ld a, #e_ia_st_noIA
   4702 32 B8 46      [13]   79  ld (_jug2ia), a
   4705 32 B9 46      [13]   80  ld (_jug3ia), a
   4708 32 BA 46      [13]   81  ld (_jug4ia), a
   470B C9            [10]   82 ret
   470C                      83 set_single_player_ia:
   470C 3E 01         [ 7]   84  ld a, #e_ia_st_stand_by
   470E 32 B8 46      [13]   85  ld (_jug2ia), a
   4711 32 B9 46      [13]   86  ld (_jug3ia), a
   4714 32 BA 46      [13]   87  ld (_jug4ia), a
   4717 C9            [10]   88 ret
                             89 
   4718                      90 init_entities::
   4718 CD BB 46      [17]   91 	call set_gamemode_ia
   471B CD 57 48      [17]   92 	call entityman_getEntityVector_IX
                             93 
                             94 
                             95 	;;Jugador 1
   471E 3A AB 46      [13]   96 	ld a, (_jugx)
   4721 DD 77 00      [19]   97 	ld e_x(ix), a
   4724 DD 77 02      [19]   98 	ld e_xl(ix), a
   4727 DD 77 04      [19]   99 	ld e_xll(ix), a
   472A 3A AC 46      [13]  100 	ld a, (_jugy)
   472D DD 77 01      [19]  101 	ld e_y(ix), a
   4730 DD 77 03      [19]  102 	ld e_yl(ix), a
   4733 DD 77 05      [19]  103 	ld e_yll(ix), a
   4736 3A B3 46      [13]  104 	ld a, (_jugv)
   4739 DD 77 06      [19]  105 	ld e_vx(ix), a
   473C DD 77 07      [19]  106 	ld e_vy(ix), a
   473F 3A B4 46      [13]  107 	ld a, (_jugshot)
   4742 DD 77 0B      [19]  108 	ld e_sh(ix), a
   4745 3A B7 46      [13]  109 	ld a, (_jugia)
   4748 DD 77 09      [19]  110 	ld e_ia_st(ix), a
   474B 3A B6 46      [13]  111 	ld a, (_jugdead)
   474E DD 77 0C      [19]  112 	ld e_dead(ix), a
                            113 
                            114 
   00A7                     115 	nextEntity
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4751 11 17 00      [10]    1 ld de, #siceof_e
   4754 DD 19         [15]    2 	add ix, de
                            116 
                            117 	;;Jugador 2
   4756 3A AD 46      [13]  118 	ld a, (_jug2x)
   4759 DD 77 00      [19]  119 	ld e_x(ix), a
   475C DD 77 02      [19]  120 	ld e_xl(ix), a
   475F DD 77 04      [19]  121 	ld e_xll(ix), a
   4762 3A AE 46      [13]  122 	ld a, (_jug2y)
   4765 DD 77 01      [19]  123 	ld e_y(ix), a
   4768 DD 77 03      [19]  124 	ld e_yl(ix), a
   476B DD 77 05      [19]  125 	ld e_yll(ix), a
   476E 3A B3 46      [13]  126 	ld a, (_jugv)
   4771 DD 77 06      [19]  127 	ld e_vx(ix), a
   4774 DD 77 07      [19]  128 	ld e_vy(ix), a
   4777 3A B4 46      [13]  129 	ld a, (_jugshot)
   477A DD 77 0B      [19]  130 	ld e_sh(ix), a
   477D 3A B8 46      [13]  131 	ld a, (_jug2ia)
   4780 DD 77 09      [19]  132 	ld e_ia_st(ix), a
   4783 3A B6 46      [13]  133 	ld a, (_jugdead)
   4786 DD 77 0C      [19]  134 	ld e_dead(ix), a
                            135 
   00DF                     136 	NextEntity
   4789 11 17 00      [10]    1 ld de, #siceof_e
   478C DD 19         [15]    2 	add ix, de
                            137 
                            138 	;;Jugador 3
   478E 3A AF 46      [13]  139 	ld a, (_jug3x)
   4791 DD 77 00      [19]  140 	ld e_x(ix), a
   4794 DD 77 02      [19]  141 	ld e_xl(ix), a
   4797 DD 77 04      [19]  142 	ld e_xll(ix), a
   479A 3A B0 46      [13]  143 	ld a, (_jug3y)
   479D DD 77 01      [19]  144 	ld e_y(ix), a
   47A0 DD 77 03      [19]  145 	ld e_yl(ix), a
   47A3 DD 77 05      [19]  146 	ld e_yll(ix), a
   47A6 3A B3 46      [13]  147 	ld a, (_jugv)
   47A9 DD 77 06      [19]  148 	ld e_vx(ix), a
   47AC DD 77 07      [19]  149 	ld e_vy(ix), a
   47AF 3A B4 46      [13]  150 	ld a, (_jugshot)
   47B2 DD 77 0B      [19]  151 	ld e_sh(ix), a
   47B5 3A B9 46      [13]  152 	ld a, (_jug3ia)
   47B8 DD 77 09      [19]  153 	ld e_ia_st(ix), a
   47BB 3A B6 46      [13]  154 	ld a, (_jugdead)
   47BE DD 77 0C      [19]  155 	ld e_dead(ix), a
                            156 
   0117                     157 	NextEntity
   47C1 11 17 00      [10]    1 ld de, #siceof_e
   47C4 DD 19         [15]    2 	add ix, de
                            158 
                            159 	;;Jugador 4
   47C6 3A B1 46      [13]  160 	ld a, (_jug4x)
   47C9 DD 77 00      [19]  161 	ld e_x(ix), a
   47CC DD 77 02      [19]  162 	ld e_xl(ix), a
   47CF DD 77 04      [19]  163 	ld e_xll(ix), a
   47D2 3A B2 46      [13]  164 	ld a, (_jug4y)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   47D5 DD 77 01      [19]  165 	ld e_y(ix), a
   47D8 DD 77 03      [19]  166 	ld e_yl(ix), a
   47DB DD 77 05      [19]  167 	ld e_yll(ix), a
   47DE 3A B3 46      [13]  168 	ld a, (_jugv)
   47E1 DD 77 06      [19]  169 	ld e_vx(ix), a
   47E4 DD 77 07      [19]  170 	ld e_vy(ix), a
   47E7 3A B4 46      [13]  171 	ld a, (_jugshot)
   47EA DD 77 0B      [19]  172 	ld e_sh(ix), a
   47ED 3A BA 46      [13]  173 	ld a, (_jug4ia)
   47F0 DD 77 09      [19]  174 	ld e_ia_st(ix), a
   47F3 3A B6 46      [13]  175 	ld a, (_jugdead)
   47F6 DD 77 0C      [19]  176 	ld e_dead(ix), a
                            177 
                            178 
                            179 
                            180 
   47F9 C9            [10]  181 ret
                            182 
   47FA                     183 create_entities::
                            184 
   47FA                     185   Entity jugador   00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_noIA    , 3, 0,4,16		;; explicados en la macro
   0150                       1 jugador::
   47FA 00                    2 .db 00      ;;posicion x del tanque
   47FB 00                    3 .db 00	;;posicion y del tanque
   47FC 00                    4 .db 00	;;posicion de la x anterior
   47FD 00                    5 .db 00	;;posicion de la y anterior
   47FE 00                    6 .db 00	;;posicion de la x 2 veces anterior
   47FF 00                    7 .db 00	;;posicion de la x 2 veces anterior
   4800 00                    8 .db 00	;;velocidad en x
   4801 00                    9 .db 00	;;velocidad en y
   4802 00                   10 .db 0	;;shot 0 no 1 si
   4803 00                   11 .db e_ia_st_noIA;;type 0 jugador por teclas ,1 enemigo ia
   4804 03                   12 .db 3    ;;movimiento  
   4805 00                   13 .db 0     ;; si no dispara es 0 si dispara es 1
   4806 00                   14 .db 0;;canon 0 vivo 1 muere
   4807 00 00                15 .db 0x00, 0x00    ;;iax ia y
   4809 00                   16 .db e_ia_st_noIA  ;;Estado anterior de la ia 
   480A 00 00                17 .dw 0x0000	;; puntero de la patrulla que voy a realizar
   480C 00 00                18 .dw 0x0000 ;;puntero al estado que tengo que saltar
   480E 04                   19 .db 4
   480F 10                   20 .db 16
   4810 19                   21 .db 25  ;; contador cambio direcion del sprite
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
   4811                     186   Entity jugador2  00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_noIA	   , 3, 0,4,16	   
   0167                       1 jugador2::
   4811 00                    2 .db 00      ;;posicion x del tanque
   4812 00                    3 .db 00	;;posicion y del tanque
   4813 00                    4 .db 00	;;posicion de la x anterior
   4814 00                    5 .db 00	;;posicion de la y anterior
   4815 00                    6 .db 00	;;posicion de la x 2 veces anterior
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4816 00                    7 .db 00	;;posicion de la x 2 veces anterior
   4817 00                    8 .db 00	;;velocidad en x
   4818 00                    9 .db 00	;;velocidad en y
   4819 00                   10 .db 0	;;shot 0 no 1 si
   481A 00                   11 .db e_ia_st_noIA;;type 0 jugador por teclas ,1 enemigo ia
   481B 03                   12 .db 3    ;;movimiento  
   481C 00                   13 .db 0     ;; si no dispara es 0 si dispara es 1
   481D 00                   14 .db 0;;canon 0 vivo 1 muere
   481E 00 00                15 .db 0x00, 0x00    ;;iax ia y
   4820 00                   16 .db e_ia_st_noIA  ;;Estado anterior de la ia 
   4821 00 00                17 .dw 0x0000	;; puntero de la patrulla que voy a realizar
   4823 00 00                18 .dw 0x0000 ;;puntero al estado que tengo que saltar
   4825 04                   19 .db 4
   4826 10                   20 .db 16
   4827 19                   21 .db 25  ;; contador cambio direcion del sprite
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
   4828                     187   Entity enemigo   00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_stand_by, 3, 0,4,16	               
   017E                       1 enemigo::
   4828 00                    2 .db 00      ;;posicion x del tanque
   4829 00                    3 .db 00	;;posicion y del tanque
   482A 00                    4 .db 00	;;posicion de la x anterior
   482B 00                    5 .db 00	;;posicion de la y anterior
   482C 00                    6 .db 00	;;posicion de la x 2 veces anterior
   482D 00                    7 .db 00	;;posicion de la x 2 veces anterior
   482E 00                    8 .db 00	;;velocidad en x
   482F 00                    9 .db 00	;;velocidad en y
   4830 00                   10 .db 0	;;shot 0 no 1 si
   4831 01                   11 .db e_ia_st_stand_by;;type 0 jugador por teclas ,1 enemigo ia
   4832 03                   12 .db 3    ;;movimiento  
   4833 00                   13 .db 0     ;; si no dispara es 0 si dispara es 1
   4834 00                   14 .db 0;;canon 0 vivo 1 muere
   4835 00 00                15 .db 0x00, 0x00    ;;iax ia y
   4837 01                   16 .db e_ia_st_stand_by  ;;Estado anterior de la ia 
   4838 00 00                17 .dw 0x0000	;; puntero de la patrulla que voy a realizar
   483A 00 00                18 .dw 0x0000 ;;puntero al estado que tengo que saltar
   483C 04                   19 .db 4
   483D 10                   20 .db 16
   483E 19                   21 .db 25  ;; contador cambio direcion del sprite
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
   483F                     188   Entity enemigo2  00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_stand_by, 3, 0,4,16	
   0195                       1 enemigo2::
   483F 00                    2 .db 00      ;;posicion x del tanque
   4840 00                    3 .db 00	;;posicion y del tanque
   4841 00                    4 .db 00	;;posicion de la x anterior
   4842 00                    5 .db 00	;;posicion de la y anterior
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   4843 00                    6 .db 00	;;posicion de la x 2 veces anterior
   4844 00                    7 .db 00	;;posicion de la x 2 veces anterior
   4845 00                    8 .db 00	;;velocidad en x
   4846 00                    9 .db 00	;;velocidad en y
   4847 00                   10 .db 0	;;shot 0 no 1 si
   4848 01                   11 .db e_ia_st_stand_by;;type 0 jugador por teclas ,1 enemigo ia
   4849 03                   12 .db 3    ;;movimiento  
   484A 00                   13 .db 0     ;; si no dispara es 0 si dispara es 1
   484B 00                   14 .db 0;;canon 0 vivo 1 muere
   484C 00 00                15 .db 0x00, 0x00    ;;iax ia y
   484E 01                   16 .db e_ia_st_stand_by  ;;Estado anterior de la ia 
   484F 00 00                17 .dw 0x0000	;; puntero de la patrulla que voy a realizar
   4851 00 00                18 .dw 0x0000 ;;puntero al estado que tengo que saltar
   4853 04                   19 .db 4
   4854 10                   20 .db 16
   4855 19                   21 .db 25  ;; contador cambio direcion del sprite
                             22 
                             23 
                             24 
                             25 
                             26 
                             27 
                            189 
   4856 C9            [10]  190   ret               
                            191 
                            192 
                            193 
   4857                     194 entityman_getEntityVector_IX:: ;;mandar el puntero al primer byte del array de tanques en xy
   4857 DD 21 FA 47   [14]  195  ld ix, #jugador
   485B C9            [10]  196 	ret
                            197 	
                            198 
   485C                     199 entityman_num_entities::      ;; mandar el numero de tanques que hay en a(no necesario siempre es 4)
   485C 3A AA 46      [13]  200  ld a, (_num_entities)
   485F C9            [10]  201  ret
                            202 
                            203 
