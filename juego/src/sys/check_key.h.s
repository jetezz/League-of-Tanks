;;
;;CHEK_KEY
;;

.globl check_key_init
.globl check_key
.globl check_game_begin
.globl check_restart
.globl check_Pause
.globl check_unPause
.globl check_nextGamemode
.globl check_Esc


.macro resetVelplayers _N
	 _puntero_entidades=.+2
 	ld ix, #0000
	.rept _N
		ld e_vx(ix) ,#0
		ld e_vy(ix) ,#0
		nextEntity
	.endm
.endm





