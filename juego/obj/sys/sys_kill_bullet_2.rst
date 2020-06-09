ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;kill bullet 2
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "man/entity_manager.h.s"
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



                              5 .include "man/shot_manager.h.s"	
                              1 ;;
                              2 ;;shot manager h
                              3 ;;
                              4 
                              5 ;; MACROS
                              6 
                              7 .macro DefineBalesArray _nameb,_N
                              8 _nameb::
                              9 	.rept _N
                             10 DefineBalesAnnonimous -1,00,00,00,00,00,00,00,00,00,00,0x00
                             11 	.endm 
                             12 .endm
                             13 
                             14 .macro DefineBalesAnnonimous _bx,_by,_bxl,_byl,_bxll,_byll,_bvx,_bvy,_bsta,_bwidth,_bheight,_bcolor
                             15 .db _bx           ;; posicion de la bala x          
                             16 .db _by		;; posicion de la bala y
                             17 .db _bxl		;; posicion anterior x
                             18 .db _byl		;; posicion anterior y
                             19 .db _bxll		;; posicion 2 veces anterior x
                             20 .db _byll		;; posicion 2 veces anterior y
                             21 .db _bvx 		;; velocidad bala en x
                             22 .db _bvy		;; belocidad bala en y
                             23 .db _bsta		;; estado de la bala   ¡¡¡¡¡YA NO SIRVEE¡¡¡¡¡¡
                             24 .db _bwidth       ;; anchura de la bala
                             25 .db _bheight      ;; altura de la bala
                             26 .db _bcolor       ;; color de la bala
                             27 .db 0x00 ,0x00    ;; posicion de memoria del canon
                             28  
                             29 .endm
                             30 
                             31 ;; CONSTANTES QUE REFERENCIAN LOS ATRIBUTOS DE LAS BALAS (USADOS POR LOS REGISTROS IX E IY, RESPECTIVAMENTE)
                             32 
                     0000    33 b_x       = 0
                     0001    34 b_y       = 1
                     0002    35 b_xl      = 2
                     0003    36 b_yl      = 3
                     0004    37 b_xll     = 4
                     0005    38 b_yll     = 5
                     0006    39 b_vx      = 6      ;; velocidad bala eje x
                     0007    40 b_vy      = 7      ;; velocidad bala eje y
                     0008    41 b_sta     = 8      ;; estado de la bala
                     0009    42 b_h       = 9      ;; altura de la bala
                     000A    43 b_w       = 10     ;; anchura de la bala
                     000B    44 b_color   = 11     ;; color de la bala (sustituible por puntero a sprite)
                     000C    45 b_canon_l = 12     ;; posicion de memoria del canon en l
                     000D    46 b_canon_h = 13	 ;; posicion de memoria del canon en h
                     000E    47 siceof_b  = 14
                             48 
                             49 
                             50 ;; GLOBAL FUNCTIONS
                             51 
                             52 
                             53 .globl entityman_getArray_Bales
                             54 .globl entityman_num_Bales
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             55 
                             56 
                             57 ;; CONSTANTES:
                             58 
                             59 ;; Numero maximo de balas
                             60 
                     0005    61 max_bales == 5
                             62 
                             63 ;; Posicionar centralmente la bala con respecto al sprite
                             64 
                     0002    65 b_inc_pos_x = 2
                     0006    66 b_inc_pos_y = 6
                             67 
                             68 ;; DIMENSIONES POSIBLES DE LA BALA
                             69 
                             70 ;; Cuando va en horizontal
                             71 
                     0002    72 b_width      = 2   ;; anchura de la bala
                     0008    73 b_height     = 8   ;; altura de la bala
                             74 
                             75 ;; Cuando va en vertical
                             76 
                             77 
                             78 
                             79 
                             80 
                             81 ;; Color por defecto de la bala
                             82 
                     00C0    83 reset_bullet_color = 0xC0   ;; Color negro
                             84 
                             85 ;; Velocidades posibles de la bala
                             86 
                     0001    87 pos_vel_h = 1
                     FFFFFFFF    88 neg_vel_h = -1
                     0004    89 pos_vel_v = 4
                     FFFFFFFC    90 neg_vel_v = -4
                     0000    91 sin_vel = 0
                             92 
                             93 ;; Estados de la bala
                             94 
                     0000    95 b_no_shoot  = 0    ;; bala no disparada (estado por defecto)
                     0001    96 b_shoot     = 1    ;; bala disparada
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              6 .include "sys/sys_a.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              7 .include "sys/clean_entities.h.s"
                              1 ;;
                              2 ;;CLEAN Entities
                              3 ;;
                              4 
                              5 .globl clean_entities_init
                              6 .globl clean_entities
                              7 .globl limpiar_ultimo
                              8 .globl limpiar_ultima
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                              8 	
                              9 
                             10 
   5B4F                      11 kill_bullet_init_2::
                             12 
   5B4F CD 40 49      [17]   13  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   5B52 CD 45 49      [17]   14  call entityman_num_Bales
   5B55 22 96 5B      [16]   15  ld (_contador_balas), hl
   5B58 DD 22 6B 5B   [20]   16  ld (_puntero_balas), ix
                             17 
   5B5C C9            [10]   18   ret
                             19 
                             20 
                             21 
   5B5D                      22 kill_bullet_2::
   5B5D F5            [11]   23 push af
   5B5E CD BF 50      [17]   24  call iniciar_animacion_bala
   5B61 CD 6D 55      [17]   25  call limpiar_ultima
   5B64 F1            [10]   26 pop af
   5B65 4F            [ 4]   27 ld c, a
                             28 
   5B66 CD 9C 5B      [17]   29 call devolver_tiro
                             30 
                     001C    31 _puntero_balas=.+2
   5B69 DD 21 00 00   [14]   32 ld ix, #0000
                             33 
                             34 
   5B6D 3D            [ 4]   35 dec a
   5B6E B7            [ 4]   36 or a
   5B6F 28 08         [12]   37 jr z,_eliminamos_primera_bala
                             38 
   5B71 11 0E 00      [10]   39 ld de, #siceof_b
   5B74                      40 loop_posicionar:
                             41 
                             42 
   5B74 DD 19         [15]   43 add ix, de
   5B76 3D            [ 4]   44 dec a
                             45 
   5B77 20 FB         [12]   46 jr nz, loop_posicionar
                             47 
   5B79                      48 _eliminamos_primera_bala:
                             49 ;; aqui tengo el puntero a la bala que hay que eliminar
   5B79 DD 22 84 5B   [20]   50 ld (puntero_entidad_a_eliminar), ix
   5B7D CD 9C 5B      [17]   51 call devolver_tiro
                             52 
                             53 
   5B80 3E 05         [ 7]   54 ld a, #max_bales
   5B82 91            [ 4]   55 sub c
                             56 ;; aqui tengo el numero de entidades que tengo que mover
                             57 
                             58 
                     0035    59 puntero_entidad_a_eliminar=.+1
   5B83 11 00 00      [10]   60 ld de, #0000
   5B86 2A 84 5B      [16]   61 ld hl ,(puntero_entidad_a_eliminar)
   5B89 01 0E 00      [10]   62 ld bc ,#siceof_b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5B8C 09            [11]   63 add hl,bc
                             64 
                             65 
   5B8D                      66 _seguimos_limpiando:
   5B8D 01 0E 00      [10]   67 ld bc ,#siceof_b
   5B90 ED B0         [21]   68 ldir
   5B92 3D            [ 4]   69 dec a
   5B93 20 F8         [12]   70 jr nz, _seguimos_limpiando
                             71 
                             72 
                             73 
                             74 
                             75 
                     0047    76 _contador_balas=.+1
   5B95 21 00 00      [10]   77 ld hl ,#0000
   5B98 7E            [ 7]   78 ld a,(hl)
   5B99 3D            [ 4]   79 dec a
   5B9A 77            [ 7]   80 ld (hl), a
                             81 
                             82 
                             83  	
                             84 
                             85 
                             86 
                             87 
                             88 
                             89 
   5B9B C9            [10]   90  ret
                             91 
                             92 
   5B9C                      93 devolver_tiro:
                             94 
   5B9C DD 66 0D      [19]   95 ld h, b_canon_h(ix)
   5B9F DD 6E 0C      [19]   96 ld l, b_canon_l(ix)
   5BA2 11 0B 00      [10]   97 ld de, #e_sh
   5BA5 19            [11]   98 add hl, de
   5BA6 36 00         [10]   99 ld (hl), #0
                            100 
   5BA8 C9            [10]  101  ret
