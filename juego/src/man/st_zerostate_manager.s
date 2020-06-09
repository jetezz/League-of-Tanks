;;
;;Draw map
;;

.include "cpct_functions.h.s"
.include "assets.h.s"
.include "sys/check_key.h.s"
.include "state_manager.h.s"
.include "sys/sys_menu.h.s"
.include "sys/sys_interrup_music.h.s"

init_zerostate::
  call zerostate_init ;;LLamar al inicializador del sistema
ret

zerostate_update::
    call check_game_begin
    call check_nextGamemode
ret

next_gamemode::

    ld a, (_gamemode)
    inc a
    ld b, #06
    cp b
    jr nz, _noover5
    ld a, #01
    _noover5:
    ld (_gamemode), a
    call print_selected_green ;;AQUI NECESITA a QUE ES EL ULTIMO SELECCIONADO

    
   ;;Ponemos el color por defecto a negro
   ld    h, #0         ;; D = Background PEN (0)
   ld    l, #1         ;; E = Foreground PEN (3)
   call cpct_setDrawCharM0_asm   ;; Set draw char colours
   call sonido_interaccion
ret






