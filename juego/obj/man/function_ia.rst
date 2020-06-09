ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;man entity ia
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "function_ia.h.s"
                              1 ;;
                              2 ;;man entity ia h
                              3 ;;
                              4 
                              5 
                     000A     6 _max_function == 10 ;; numero maximo de funciones que podemos crear en la ia
                              7 
                              8 .macro Define_ia_punteros_funciones _name,_N
                              9 name::
                             10 	.rept _N
                             11 Define_aninomous 0xFF, 0xFF
                             12 	.endm
                             13 .endm
                             14 
                             15 .macro Define_aninomous _bl,_bh
                             16 .db _bl		;;byte bajo
                             17 .db _bh           ;;byte alto         
                             18 
                             19 
                             20 .endm
                             21 
                     0000    22 f_b_l=0
                     0001    23 f_b_h=1
                     0002    24 sice_of=2
                             25 
                             26 
                             27 
                             28 .globl funcion_ia_init
                             29 .globl function_inc_puntero
                             30 .globl man_entity_get_funcion_array
                             31 
                             32 
                             33 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "../sys/ia_control_sys.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 
   48BA 00                    8 _num_functions: .db #0
   48BB 00 00                 9 _punt_ultima_funcion: .dw 0x0000 
                             10 
   48BD                      11 create_function_array::
                             12 
   48BD                      13 Define_ia_punteros_funciones punt_ia, (_max_function)
   0003                       1 name::
                              2 	.rept (_max_function)
                              3 Define_aninomous 0xFF, 0xFF
                              4 	.endm
   0003                       1 Define_aninomous 0xFF, 0xFF
   48BD FF                    1 .db 0xFF		;;byte bajo
   48BE FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   0005                       1 Define_aninomous 0xFF, 0xFF
   48BF FF                    1 .db 0xFF		;;byte bajo
   48C0 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   0007                       1 Define_aninomous 0xFF, 0xFF
   48C1 FF                    1 .db 0xFF		;;byte bajo
   48C2 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   0009                       1 Define_aninomous 0xFF, 0xFF
   48C3 FF                    1 .db 0xFF		;;byte bajo
   48C4 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   000B                       1 Define_aninomous 0xFF, 0xFF
   48C5 FF                    1 .db 0xFF		;;byte bajo
   48C6 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   000D                       1 Define_aninomous 0xFF, 0xFF
   48C7 FF                    1 .db 0xFF		;;byte bajo
   48C8 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   000F                       1 Define_aninomous 0xFF, 0xFF
   48C9 FF                    1 .db 0xFF		;;byte bajo
   48CA FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   0011                       1 Define_aninomous 0xFF, 0xFF
   48CB FF                    1 .db 0xFF		;;byte bajo
   48CC FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
   0013                       1 Define_aninomous 0xFF, 0xFF
   48CD FF                    1 .db 0xFF		;;byte bajo
   48CE FF                    2 .db 0xFF           ;;byte alto         
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              4 
   0015                       1 Define_aninomous 0xFF, 0xFF
   48CF FF                    1 .db 0xFF		;;byte bajo
   48D0 FF                    2 .db 0xFF           ;;byte alto         
                              3 
                              4 
                             14 
                             15 
   48D1                      16 funcion_ia_init:: ;; limpiar todas las posiciones del array de funciones
                             17 
   48D1 21 BD 48      [10]   18 	ld hl , #create_function_array
   48D4 11 BD 48      [10]   19 	ld de, #create_function_array
   48D7 13            [ 6]   20 	inc de
   48D8 36 00         [10]   21 	ld (hl), #00
   48DA 01 14 00      [10]   22 	ld bc,  #20  ;; limpio los 20 bytes que tiene el array de funciones
   48DD ED B0         [21]   23 	ldir
                             24 
                             25 
                             26 
                             27 
                             28 
                             29 
                             30 
                             31 	
                             32 
                             33 
   48DF C9            [10]   34 	ret
                             35 
                             36 
                             37 ;; recibe en hl el puntero a la funcion que queremos añadir 
   48E0                      38 function_inc_puntero::
   48E0 DD 2A BB 48   [20]   39 	ld ix, (_punt_ultima_funcion)  ;; me guardo la posicion del ultimo puntero en el array en ix
   48E4 DD 75 00      [19]   40 	ld f_b_l(ix),l			;; me guardo la posicion que nos pasan en hl
   48E7 DD 74 01      [19]   41 	ld f_b_h(ix),h
   48EA 01 02 00      [10]   42 	ld bc, #sice_of
   48ED DD 09         [15]   43 	add ix, bc
   48EF DD 22 BB 48   [20]   44 	ld (_punt_ultima_funcion), ix
   48F3 C9            [10]   45 	ret
                             46 
                             47 
                             48 
                             49 
                             50 
   48F4                      51 man_entity_get_funcion_array:: ;;devuelvo el puntero a las funciones en hl
   48F4 21 BD 48      [10]   52 	ld hl, #create_function_array
   48F7 C9            [10]   53 	ret
