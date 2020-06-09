ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; FUNCTION: Redimensiona el array de balas, cuando una de las balas ha coliionado o con un enemigo, o con el escenario
                              3 ;; INPUT: Bala a eliminar (IX) y Numero de bala a borrar (H)
                              4 ;; CHANGE: Memoria reservada para las balas en el entity manager
                              5 ;;
                              6 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              7 .include "sys_kill_bullet.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              8 .include "man/shot_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              9 .include "man/entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             10 .include "sys/clean_entities.h.s"
                              1 ;;
                              2 ;;CLEAN Entities
                              3 ;;
                              4 
                              5 .globl clean_entities_init
                              6 .globl clean_entities
                              7 .globl limpiar_ultimo
                              8 .globl limpiar_ultima
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             11 .include "sys/sys_a.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             55 
                     0005    56 duracion_animacion=5
                     0008    57 maximo_balas_animacion=8
                     0004    58 maximo_canon_animacion=4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             12 
   55D1                      13 kill_bullet_init::
                             14 
   55D1 CD 40 49      [17]   15  call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
   55D4 CD 45 49      [17]   16  call entityman_num_Bales
   55D7 22 48 56      [16]   17  ld (_contador_balas), hl
   55DA DD 22 50 56   [20]   18  ld (_puntero_balas), ix
                             19 
   55DE C9            [10]   20   ret
                             21 
                             22 
   55DF                      23 kill_bullet::
                             24   
                             25   ;; Me guardo el numero de balas que me han pasado por parametro (ya que la funcion "limpiar_ultima" me corrompe dicho dato)
                             26 
   55DF F5            [11]   27 push af
                             28 
                             29 
                             30 
   55E0 CD BF 50      [17]   31 call iniciar_animacion_bala
                             32 
                             33 
   55E3 F1            [10]   34 pop af
                             35 
   55E4 F5            [11]   36   push af
                             37 
                             38   ;; Realizo el limpiado del rastro de la bala
                             39 
   55E5 DD 6E 0C      [19]   40   ld l, b_canon_l(ix)
   55E8 DD 66 0D      [19]   41   ld h, b_canon_h(ix)
   55EB 11 0B 00      [10]   42   ld de, #e_sh
   55EE 19            [11]   43   add hl, de
   55EF 36 00         [10]   44   ld (hl),#0
                             45 
   55F1 CD 6D 55      [17]   46   call limpiar_ultima
                             47 
                             48   ;; ME GUARDO LA BALA QUE TENGO QUE ELIMINAR (SU DIRECCION DE MEMORIA)
                             49 
   55F4 DD 22 F9 55   [20]   50   ld (_puntero_bala_inicial), ix
                     0028    51   _puntero_bala_inicial = . + 1
   55F8 11 00 00      [10]   52   ld de, #0x0000
                             53 
                             54   ;; COMPRUEBO SI LA BALA A BORRAR ES LA ULTIMA DEL ARRAY
                             55 
   55FB F1            [10]   56   pop af   ;; Recupero el numero de balas que he guardado en la pila con tal de realizar comprobaciones, como saber, si la bala que va a eliminarse, es la ultima del array o no
   55FC 4F            [ 4]   57   ld c, a  ;; Cargo en el registro C, el numero de balas (registro A) con tal de saber el numero de desplazamientos que tendre que realizar en la memoria para borrar la/s bala/s
                             58            ;; correspondiente/s
                             59 
   55FD FE 04         [ 7]   60   cp #_id_last_bullet     ;; NUMERO MAXIMO DE BALAS - 1
   55FF 28 16         [12]   61   jr z, _ultima_bala
                             62 
                             63   ;; OBTENGO LOS DESPLAZAMIENTOS A REALIZAR EN LA MEMORIA
                             64 
   5601 3E 04         [ 7]   65   ld a, #_id_last_bullet
   5603 91            [ 4]   66   sub c
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             67 
   5604                      68   _actualizar_memoria:
   5604 01 0E 00      [10]   69      ld bc, #siceof_b    ;;NUMERO DE BYTES QUE TIENE CADA ENTIDAD
   5607 DD 09         [15]   70      add ix, bc
   5609 DD 22 0E 56   [20]   71      ld (_puntero_bala_incremento_ix), ix
                     003D    72      _puntero_bala_incremento_ix = . + 1
   560D 21 00 00      [10]   73      ld hl, #0x0000
   5610 ED B0         [21]   74      ldir
   5612 3D            [ 4]   75      dec a
   5613 20 EF         [12]   76     jr nz, _actualizar_memoria
                             77     
   5615 18 30         [12]   78   jr _actualizar_num_balas
                             79   ;; AL SALIR DEL BUCLE, HE DE ENTRAR EN ULTIMA BALA PARA BORRAR LA ULTIMA BALA COPIADA, YA QUE LDIR, NO BORRA NADA, SOLO COPIA DE UNA DIRECCION DE MEMORIA A OTRA
                             80  
   5617                      81  _ultima_bala:
   5617 DD 22 1C 56   [20]   82      ld (_puntero_bala_final), ix       ;; CARGO EN HL, LA DIRECCION DE MEMORIA A LA QUE APUNTA IX PARA PODER IR INCREMENTANDO SU POSICION CON TAL DE BORRAR LA BALA CREADA. DESPUES,
                     004B    83      _puntero_bala_final = . + 1        ;; REALIZO EL MISMO NUMERO DE INCREMENTOS QUE EL TAMANYO TOTAL DE LA ENTIDAD BALA Y VOY PONIENDO EN CADA POSICION DE MEMORIA UN 0. CON ESTO ME
   561B 21 00 00      [10]   84      ld hl, #0x0000                     ;; EVITO EL COPIAR ZONAS DE MEMORIA (A LA QUE APUNTABA HL ORIGINALMENTE CUANDO NO SE MODIFICABA AL ENTRAR EN ESTA PARTE DEL CODIGO) QUE PUEDEN
   561E 36 FF         [10]   85      ld (hl), #-1                       ;; ESTAR VACIAS, O NO
                             86      .rept #siceof_b -1                    
                             87         inc hl
                             88         ld (hl), #00
                             89      .endm
   5620 23            [ 6]    1         inc hl
   5621 36 00         [10]    2         ld (hl), #00
   5623 23            [ 6]    1         inc hl
   5624 36 00         [10]    2         ld (hl), #00
   5626 23            [ 6]    1         inc hl
   5627 36 00         [10]    2         ld (hl), #00
   5629 23            [ 6]    1         inc hl
   562A 36 00         [10]    2         ld (hl), #00
   562C 23            [ 6]    1         inc hl
   562D 36 00         [10]    2         ld (hl), #00
   562F 23            [ 6]    1         inc hl
   5630 36 00         [10]    2         ld (hl), #00
   5632 23            [ 6]    1         inc hl
   5633 36 00         [10]    2         ld (hl), #00
   5635 23            [ 6]    1         inc hl
   5636 36 00         [10]    2         ld (hl), #00
   5638 23            [ 6]    1         inc hl
   5639 36 00         [10]    2         ld (hl), #00
   563B 23            [ 6]    1         inc hl
   563C 36 00         [10]    2         ld (hl), #00
   563E 23            [ 6]    1         inc hl
   563F 36 00         [10]    2         ld (hl), #00
   5641 23            [ 6]    1         inc hl
   5642 36 00         [10]    2         ld (hl), #00
   5644 23            [ 6]    1         inc hl
   5645 36 00         [10]    2         ld (hl), #00
                             90    
   5647                      91  _actualizar_num_balas:
                             92   ;; ACTUALIZO EL CONTADOR DE BALAS
                     0077    93    _contador_balas=.+1
   5647 21 00 00      [10]   94   ld hl, #0000                ;; Obtengo en hl el numero de balas
   564A 7E            [ 7]   95    ld a, (hl)                ;; Guardo en A el numero de balas
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   564B 3D            [ 4]   96    dec a                     ;; Decremento el numero de balas que hay
   564C 77            [ 7]   97    ld (hl), a                ;; Actualizo las balas que hay una vez se elimina una
                             98 
   564D C9            [10]   99   ret
                            100 
                            101 
   564E                     102 kill_bullet_all::
                            103 
                     007F   104  _puntero_balas=.+2
   564E DD 21 00 00   [14]  105   ld ix, #0000
   5652 2A 48 56      [16]  106  ld hl ,(_contador_balas)
   5655 77            [ 7]  107  ld (hl),a
   5656 B7            [ 4]  108  or a
   5657 20 01         [12]  109  jr nz, _limpiamos_array_de_balas
   5659 C9            [10]  110 ret
                            111 
   565A                     112 _limpiamos_array_de_balas:
   565A                     113   _loop_clean:
   565A DD 22 5F 56   [20]  114    ld (_puntero_limpiar), ix
                     008E   115      _puntero_limpiar = . + 1
   565E 11 00 00      [10]  116      ld de, #0x0000
   5661 EB            [ 4]  117      ex de,hl
   5662 13            [ 6]  118      inc de
   5663 01 0E 00      [10]  119      ld bc, #siceof_b
   5666 ED B0         [21]  120      ldir
   5668 3D            [ 4]  121      dec a
   5669 C8            [11]  122      ret z
   566A 18 EE         [12]  123      jr _limpiamos_array_de_balas
                            124 
   566C C9            [10]  125   ret
