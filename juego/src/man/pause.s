;;
;;Game over
;;


.include "cpct_functions.h.s"
.include "assets.h.s"
.include "sys/sys_map_creator.h.s"
.include "man/state_manager.h.s"

pausestring: .asciz "Pause"


;;Quitar pausa
unPause::
  ld hl, #_pausa
  ld (hl), #00

  call draw_map_sinhud

ret
;;Poner pausa
Pause::
  ld hl, #_pausa
  ld (hl), #01

    ;;Escribimos el pause en pantalla
    ld de, #0xC000
    ld   c, #30  ;;x
    ld   b, #90  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #pausestring
    call cpct_drawStringM0_asm

    ld de, #0x8000
    ld   c, #30  ;;x
    ld   b, #90  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #pausestring 
    call cpct_drawStringM0_asm


ret
