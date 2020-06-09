;;
;; shot manager
;;

.include "shot_manager.h.s"
.include "entity_manager.h.s"


_num_bales:: .db #0  ;; ESTABLECEMOS UN CONTADOR PARA LAS BALAS QUE SE VAYAN CREANDO EN EL JUEGO (INICIALIZADO A 0, AL INICIO DEL MISMO)

;; FUNCION INIT, UTILIZADA PARA INICIALIZAR LAS BALAS QUE SE PRODUCIRAN EN EL JUEGO. ACTUALMENTE, SOLO RESERVARA EL ESPACIO PARA EL ARRAY DE BALAS DE LA ESCENA

create_bullets_array::

  ;; RESERVAMOS MEMORIA PARA EL TOTAL DE BALAS
   
  DefineBalesArray bales_array, (max_bales)

  ret


entityman_getArray_Bales::   ;; madar el puntero al primer byte del array de balas
ld ix, #bales_array
  ret

entityman_num_Bales::        ;; mandar el puntero al numero de balas que hay 
 ld hl, #_num_bales
 ret  