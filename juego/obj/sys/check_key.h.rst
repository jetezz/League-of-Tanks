ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;CHEK_KEY
                              3 ;;
                              4 
                              5 .globl check_key_init
                              6 .globl check_key
                              7 .globl check_game_begin
                              8 .globl check_restart
                              9 .globl check_Pause
                             10 .globl check_unPause
                             11 .globl check_nextGamemode
                             12 .globl check_Esc
                             13 
                             14 
                             15 .macro resetVelplayers _N
                             16 	 _puntero_entidades=.+2
                             17  	ld ix, #0000
                             18 	.rept _N
                             19 		ld e_vx(ix) ,#0
                             20 		ld e_vy(ix) ,#0
                             21 		nextEntity
                             22 	.endm
                             23 .endm
                             24 
                             25 
                             26 
                             27 
                             28 
