ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
