;;
;;sys menu h
;;



.globl zerostate_init
.globl print_selected_green

.macro textoNegro

   ld    h, #0         ;; D = Background PEN (0)
   ld    l, #1         ;; E = Foreground PEN (3)
   call cpct_setDrawCharM0_asm   ;; Set draw char colours

.endm

.macro textoVerde


   ld    h, #00         ;; D = Background PEN (0)
   ld    l, #07        ;; E = Foreground PEN (3)

   call cpct_setDrawCharM0_asm   ;; Set draw char colours
 .endm

title:            .asciz "LEAGUE OF TANKS";
enter:            .asciz "PRESS ENTER TO PLAY";
Single_player:    .asciz "Single player";
battle_royale:    .asciz "Battle Royale"
one_player:       .asciz "1 Player"
two_players:      .asciz "2 Players"
tres_players:     .asciz "3 Players"
cuatro_players:   .asciz "4 Players"
