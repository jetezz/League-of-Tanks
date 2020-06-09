;;
;;entity manager
;;
.include "plant_manager.h.s" 
.include "man/state_manager.h.s"
.include "assets.h.s"


create_plant::

  Plant planta     00,00, _plant_sp, 4, 16, 250, 0

ret

plantman_getPlanta::

 ld ix, #planta

ret



