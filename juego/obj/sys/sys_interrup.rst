ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;sys_interrup
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "../sys/sys_interrup_music.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 
                              7 
                              8 
                              9 
                             10 
   609A                      11 isr::
                             12 
   609A 08            [ 4]   13 	ex af,af'
   609B D9            [ 4]   14 	exx
   609C F5            [11]   15 	push af
   609D C5            [11]   16 	push bc
   609E D5            [11]   17 	push de
   609F E5            [11]   18 	push hl
   60A0 FD E5         [15]   19 	push iy
                             20 
   60A2 CD 97 56      [17]   21 	call generate_music
                             22 
                             23 
   60A5 FD E1         [14]   24  	pop iy
   60A7 E1            [10]   25  	pop hl
   60A8 D1            [10]   26  	pop de
   60A9 C1            [10]   27  	pop bc
   60AA F1            [10]   28  	pop af
   60AB D9            [ 4]   29  	exx
   60AC 08            [ 4]   30  	ex af, af'
   60AD C9            [10]   31 ret
                             32 
                             33 
