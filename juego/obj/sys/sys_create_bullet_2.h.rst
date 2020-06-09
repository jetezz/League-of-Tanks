ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys create balas 2 h
                              3 ;;
                              4 .globl sys_create_bullet_init2
                              5 .globl hacer_disparo2
                     0001     6 izquierda=1
                     0002     7 arriba =2
                     0003     8 derecha=3
                     0004     9 abajo =4
                             10 
                     0004    11 ancho_canon=4
                     0010    12 alto_canon=16
                             13 
                             14 
                     0001    15 _nivel_1x=1
                     0004    16 _nivel_1y=4
                     0002    17 _nivel_2x=2
                     0008    18 _nivel_2y=8
                             19 
                     FFFFFFFF    20 _nivel_1x_n=-1
                     FFFFFFFC    21 _nivel_1y_n=-4
                     FFFFFFFE    22 _nivel_2x_n=-2
                     FFFFFFF8    23 _nivel_2y_n=-8
