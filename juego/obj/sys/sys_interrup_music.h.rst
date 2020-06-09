ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
