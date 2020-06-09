;;
;;Juego Amstrad
;;


.include "cpct_functions.h.s"

.include "man/manager_buffer.h.s"

.include "man/state_manager.h.s"
.include "sys/sys_menu.h.s"
.include "sys/sys_interrup.h.s"







.globl _canons_pal2
.globl _song




.area _DATA
.area _CODE









 


_main::
	
ld sp, #0x8000
   
    ;; Disable firmware to prevent it from interfering with string drawing
    call cpct_disableFirmware_asm
  
    ld c, #0
    call cpct_setVideoMode_asm
  
    ld hl, #_canons_pal2
    ld de, #16
    call cpct_setPalette_asm

   
  

    ld de, #_song
    call cpct_akp_SFXInit_asm

    ld hl,#isr
    call cpct_setInterruptHandler_asm

    call zerostate_init   ;; inicialmente, cargamos el menu del juego
 
loop: ;; loop infinito 


   call manage_game
 
  ;;cambiamos los buffer (manager_buffer)

   call cpct_waitVSYNC_asm
   
 

jr loop



 































