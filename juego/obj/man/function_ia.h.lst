ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
