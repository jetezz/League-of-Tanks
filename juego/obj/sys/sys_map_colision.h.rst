ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
