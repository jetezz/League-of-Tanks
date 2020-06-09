;;
;;Game over
;;


.include "cpct_functions.h.s"
.include "assets.h.s"

.include "sys/check_key.h.s"
.include "sys/sys_dir.h.s"
.include "sys/sys_kill_bullet.h.s"
.include "sys/sys_interrup_music.h.s"
.include "sys/render_system.h.s"
.include "man/entity_manager.h.s"
.include "man/state_manager.h.s"
.include "man/man_create_nivel.h.s"
.include "man/st_game_over.h.s"
.include "sys/sys_a.h.s"




jugwin: .asciz "Well played"
julose: .asciz "Try again"
youwon: .asciz "You won single game"

restart: .asciz "Restart with enter"
continue: .asciz "Continue with enter"
esc: .asciz "Main menu with Esc"

_stado_game_over: .db #0    ;;1 single_muere    0 multi



updategameover_init::

    ld hl, #0x8000  ;; limpiar fireware
    ld de, #0x8001
    ld (hl), #0x00
    ld bc, #0x8000
    ldir

    call limpiar_animaciones
    call kill_bullet_all

    call get_gamemode
    cp #5
    jr z,_single_player


_no_muere_1:

    call get_gamemode
    cp #5
    jr z,_single_player_gana

    call set_winner_pos
    call draw_winText

    call off_muerte
    call sonido_win

     ld a, #mueren_todos
    ld (_stado_game_over), a
    ret
_single_player_gana:

    ld a, (estado_nivel_single)
    cp #2
    jr z, _single_end_text ;;Comprobar si es el ultimo nivel de single

    call set_winner_pos   
    call draw_continueText
    call off_muerte
    call sonido_win
    
    ld a, #mueren_todos
    ld (_stado_game_over), a
    ret

    _single_end_text: ;;pintar ultimo nivel single

    call set_winner_pos   
    call draw_single_end_text
    call off_muerte
    call sonido_win

    ret

    _single_player:
    call entityman_getEntityVector_IX
    ld a, e_dead(ix)
    dec a
    jr nz,_no_muere_1
    _muere_single:  ;;muere el jugador 1 en single

    call draw_lostText
    call dibujar_sprite_muerto
    call kill_all


    ld a, #single_muere
    ld (_stado_game_over), a

    ret

updategameover::


ld a, (_stado_game_over)

cp #single_muere
jr nz,_update_multi
_update_single:


 call check_restart
    call check_Esc

ret






_update_multi:


 _puntero_ganador=.+2
 ld ix, #0000
 call modificar_sprite
 call check_restart
 call check_Esc
ret



set_winner_pos::



    call entityman_getEntityVector_IX
    call entityman_num_entities
  
      _loopcheckdead:

    
    ld b, e_dead(ix)
      dec b
      jr nz, _ganador
    
 NextEntity
      dec a
      jr nz, _loopcheckdead

    _ganador:

    ld   c, #38  ;;x
    ld   b, #133  ;;y

    ld e_vx(ix), #00
    ld e_vy(ix), #00

    ld e_x(ix), c
    ld e_xl(ix), c
    ld e_xll(ix), c

    ld e_y(ix), b
    ld e_yl(ix), b
    ld e_yll(ix), b
    

   ld (_puntero_ganador),ix

    


ret


draw_winText::
    
    ld de, #0xC000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #restart
    call cpct_drawStringM0_asm

    ld de, #0x8000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #restart 
    call cpct_drawStringM0_asm


    ld de, #0xC000
    ld   c, #20  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #jugwin
    call cpct_drawStringM0_asm
   
    ld de, #0x8000
    ld   c, #20  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #jugwin
    call cpct_drawStringM0_asm


ret

draw_lostText::
    
    ld de, #0xC000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #restart
    call cpct_drawStringM0_asm

    ld de, #0x8000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #restart 
    call cpct_drawStringM0_asm


    ld de, #0xC000
    ld   c, #22  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #julose
    call cpct_drawStringM0_asm
   
    ld de, #0x8000
    ld   c, #22  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #julose
    call cpct_drawStringM0_asm


ret

draw_continueText::
    
    ld de, #0xC000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #continue
    call cpct_drawStringM0_asm

    ld de, #0x8000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #continue 
    call cpct_drawStringM0_asm


    ld de, #0xC000
    ld   c, #22  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #jugwin
    call cpct_drawStringM0_asm
   
    ld de, #0x8000
    ld   c, #22  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #jugwin
    call cpct_drawStringM0_asm


ret

draw_single_end_text::
    
    ld de, #0xC000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #esc
    call cpct_drawStringM0_asm

    ld de, #0x8000
    ld   c, #3  ;;x
    ld   b, #30  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #esc 
    call cpct_drawStringM0_asm


    ld de, #0xC000
    ld   c, #2  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #youwon
    call cpct_drawStringM0_asm
   
    ld de, #0x8000
    ld   c, #2  ;;x
    ld   b, #100  ;;y
    call cpct_getScreenPtr_asm
    ld iy, #youwon
    call cpct_drawStringM0_asm


ret


estado_game_over::
   ld a,(_stado_game_over)
ret


kill_all::


 call entityman_getEntityVector_IX
 call entityman_num_entities
  
      _loop_matar:

    
    ld b, e_dead(ix)
      dec b
      jr nz, _matar
    
 NextEntity
      dec a
      ret z
      jr  _loop_matar

    _matar:
    ld  e_dead(ix), #1
   
     jr  _loop_matar
  


dibujar_sprite_muerto:
ld  de, #0xC000
 ld   c, #37    ;;x
 ld   b, #130  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_04
 call cpct_drawSprite_asm

 ld  de, #0x8000
 ld   c, #37  ;;x
 ld   b, #130  ;;y
 call cpct_getScreenPtr_asm
 
 ex de, hl
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 ld hl,#_cannons_sp_04
 call cpct_drawSprite_asm

 ret


 reiniciar_gameover::
ld a, #0
    ld (_stado_game_over), a
 ret




single_end_init::


    ld hl, #0x8000  ;; limpiar fireware
    ld de, #0x8001
    ld (hl), #0x00
    ld bc, #0x8000
    ldir


    call kill_bullet_all

ret


single_end_update::

     ld ix, (_puntero_ganador)
     call modificar_sprite
    call check_Esc

ret