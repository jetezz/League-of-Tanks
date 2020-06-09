;;
;;State manager
;;

.include "cpctelera.h.s"
.include "cpct_functions.h.s"
.include "../sys/sys_create_bullet.h.s"
.include "../sys/sys_create_bullet_2.h.s"
.include "../sys/render_system.h.s"
.include "../sys/check_key.h.s"
.include "../sys/physical_system.h.s"
.include "../sys/clean_entities.h.s"
.include "../sys/ia_control_sys.h.s"
.include "../sys/sys_comp_disp.h.s"
.include "../sys/sys_kill_bullet.h.s"
.include "../sys/sys_kill_bullet_2.h.s"  
.include "../sys/sys_menu.h.s"
.include "../sys/sys_map_creator.h.s"
.include "man/patrol_manager.h.s"
.include "man/entity_manager.h.s"
.include "man/manager_buffer.h.s"
.include "man/state_manager.h.s"
.include "man/st_zerostate_manager.h.s"
.include "man/st_game_over.h.s"
.include "man/st_ingame_state.h.s"
.include "man_create_nivel.h.s"
.include "man/plant_manager.h.s"
  
_gamemode:: .db #05

;; 1 -- 1 vs 3 ia
;; 2 -- 2 vs 2 ia
;; 3 -- 3 vs 1 ia
;; 4 -- 4 contra todos
;; 5 -- Single player



_pausa:: .db #00
;; 0 --> No pausa
;; 1 --> Pausa

_state:: .db #00
;;ESTADOS;;
;;0-pulsa enter para jugar, PRESS TO PLAY;;
;;1-jugando;;                
;;2-Game over;;


manage_game::

	;;Comprobamos en que estado nos hallamos

     ld a, (_state) 
     or a
     jp z ,_zerostate    ;;Estado de pulsar enter para jugar
     dec a
     jp z ,_jugando	;;Estado jugando
     dec a
     jp z ,_gameover	;;Estado Game over



ret


;;Funciones para poner el estado en uno en concreto
set_Inicio::
      
    ld hl, #_state
    ld (hl), #00
    ld hl, #_gamemode
    ld (hl), #05
    call zerostate_init 
   

ret


set_Ingame::
    
    ld hl, #_state
    ld (hl), #01


    call init_entities


    call entityman_getEntityVector_IX
    call sys_ai_control_init

    call entityman_getEntityVector_IX
    call sys_comp_disp_init


    
   
ld a, (_gamemode)
cp #5
  jr z, _single
_multi:
  call crear_nivel_multi
  jr _salir_multi
_single:

   call crear_nivel_single

_salir_multi:

    call pintar_letras
    call pintar_hud

  

ret

set_Gameover::

    ld hl, #_state
    ld (hl), #02
    
    call updategameover_init

ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;INICIALIZACIONES;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

jugandostate_init::
    ld hl, #_state
    ld (hl), #01
    ;; Inicializamos sistemas
    call rendersys_init

    ;; Creamos las entidades que emplearemos en nuestro juego
    call create_entities       ;; Creamos las entidades que se utilizaran en el juego
    call create_plant          ;;Creamos la entidad planta
    call init_entities
    call create_bullets_array  ;; Creamos el array de balas, reservando memoria para el numero tope de balas que habra en el juego
  
    call entityman_getEntityVector_IX
    call sys_ai_control_init

    call entityman_getEntityVector_IX
    call sys_comp_disp_init


    
    call clean_entities_init
    call move_entities_init
    call sys_create_bullet_init
    call sys_create_bullet_init2
    call kill_bullet_init
    call kill_bullet_init_2    
    call check_key_init


ld a, (_gamemode)
    cp #5
    jr z, _single_2
  _multi_2:
    call crear_nivel_multi
  jr _salir_multi
  _single_2:

   call crear_nivel_single

  _salir_multi_2:
    
    call pintar_letras
    call pintar_hud

ret



   
  
    




;;;;;;;;;;;;;;;;;;;;;;
;;Estado PressToPlay;;
;;;;;;;;;;;;;;;;;;;;;;



_zerostate:  ;;Estado de pulsar space para jugar
    

  call update_zerostate;;UPDATE ZeroState
  call render_zerostate;;Render ZeroState

  ;;
ret


update_zerostate:
  
  call zerostate_update

ret

render_zerostate:


ret





;;;;;;;;;;;;Siguiente estado;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;
;;Estado JUGANDO;;
;;;;;;;;;;;;;;;;;;


_jugando:	;;Estado en el que se mueven los tanques

  ld a, (_pausa)
  dec a
  call z, check_unPause

  ld a, (_pausa)
  dec a
  jr z, _saltarupdate
  call update_jugandostate;;UPDATE GamingState  
  _saltarupdate:
  call render_jugandostate;;Render GamingState

ret



update_jugandostate:

  call ingame_update

ret

render_jugandostate:


   ld a, (_state) 
   or a
   jp z ,_noRenderingame    ;;Estado de pulsar enter para jugar
   dec a
    ;;Estado jugando
   dec a
   jp z ,_noRenderingame  ;;Estado Game over
  
  call ingame_render
  
  _noRenderingame:
  call map_switchBuffers

ret





;;;;;;;;;;;;Siguiente estado;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;
;;Estado GAME OVER;;
;;;;;;;;;;;;;;;;;;;;



_gameover:  ;;Estado de has perdido dale de nuevo para comenzar

	call update_overstate;;UPDATE GamingState	
	call render_overstate;;Render GamingState
ret


update_overstate:

    ld a, (estado_nivel_single)
    cp #2
    jr nz, _normalgameover_update
    
      call single_end_update
      ret
    _normalgameover_update:
    call updategameover

ret

render_overstate::

    ld a, (estado_nivel_single)
    cp #2
    jr z, _dorender ;;Si se ha ganado el final del single hace el render

    call estado_game_over
    dec a
    jr z, _restar_single

    _dorender:
    call rendersys_update
    

     _restar_single:
      call map_switchBuffers
ret




get_gamemode::

ld a, (_gamemode)

  ret