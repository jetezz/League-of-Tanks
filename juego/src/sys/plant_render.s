;;
;;RENDER SYSTEM
;;

.include "cpct_functions.h.s"
.include "man/plant_manager.h.s"
.include "man/manager_buffer.h.s"
.include "assets.h.s"





plant_render::

  
  call plantman_getPlanta ;;Devuelve en ix la planta

  call map_getVideoPrt

  ex de, hl
  ld   c, p_x(ix)  ;;x
  ld   b, p_y(ix)  ;;y
  call cpct_getScreenPtr_asm
  ex de, hl

 ld l, p_sprite(ix)
 ld h, p_sprite2(ix)
 ld c, #04  ;;ancho
 ld b, #16  ;;alto
 
 call cpct_drawSprite_asm
 
ret
