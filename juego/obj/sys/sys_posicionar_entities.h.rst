ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
