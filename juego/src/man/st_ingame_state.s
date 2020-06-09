;;
;;Draw map
;;

.include "cpct_functions.h.s"
.include "assets.h.s"
.include "sys/check_key.h.s"
.include "state_manager.h.s"
.include "sys/physical_system.h.s"
.include "sys/sys_comp_disp.h.s"
.include "sys/ia_control_sys.h.s"
.include "sys/clean_entities.h.s"
.include "sys/render_system.h.s"
.include "sys/plant_physics.h.s"
.include "sys/sys_a.h.s"
  

ingame_update::

  ;; call a mover entidades (jugador/es y enemigos) (phisical_system) 
  call move_entities
  ;; call comprobar si hay teclas pulsadas y modificar velocidad (check_key) // jesus 
  call plant_update
  call check_key
  ;; call sys_comp_disp_update para comprobar si las balas chocan o no con los canon
  call sys_comp_disp_update
  ;; call borrar posicion entidades en pantalla  (clean_entities) // Jesus
  ;; call Pintar trozos de mapa borrados por el movimiento  (actualizar) (draw_map) // Emilio
  ;; call calcular velocidades enemigos ¡¡¡¡IA¡¡¡¡ (ia_control_sys)
  call sys_ai_control_update
  call animar
 
  ;; call sys_comp_disp_update para comprobar si las balas chocan o no con los canon
  call check_gameover
    
  call check_Pause
  call check_Esc

ret

ingame_render::

  ;; call limpiar entidades
  call clean_entities
  ;; call render (personaje enemigos (objeros?))(render_system)
  call rendersys_update

ret