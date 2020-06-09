;;
;;RENDER SYSTEM
;;

.include "cpct_functions.h.s"
.include "man/plant_manager.h.s"
.include "man/manager_buffer.h.s"
.include "sys/sys_map_colision.h.s"
.include "assets.h.s"




plant_update::


  call plantman_getPlanta ;;Devuelve en ix la planta
  ld a, p_cont(ix)
  dec a
  ld p_cont(ix), a
  jr nz, nocambio
  ld a, #250
  ld p_cont(ix), a
  ld a, #0
  ld p_activa(ix), a
  nocambio:

  
  ld a, p_activa(ix)
  dec a
  jr nz, _novalido
  ret 





  _novalido:

  _incorrecto_lmayorquea:
  call cpct_getRandom_mxor_u8_asm
  ld a, #74
  sub l
  jr c, _incorrecto_lmayorquea
  ld b, l


    _incorrecto_lmayorquea2:
  call cpct_getRandom_mxor_u8_asm
  ld a, #144
  sub l
  jr c, _incorrecto_lmayorquea2
  ld c, l
  ld d, #4
  ld e, #16

  ld h, #3


  push de
  push bc
  dec b
  call comp_colisiones ;devuelve en a 1 si no hay colision
  pop bc
  pop de

  dec a
  jr nz, _novalido
  ld h, #1
  push bc
  inc b 
  call comp_colisiones ;devuelve en a 1 si no hay colision
  pop bc
  dec a
  jr nz, _novalido



  call plantman_getPlanta ;;Devuelve en ix la planta


  ld   p_x(ix), b ;;x
  ld   p_y(ix), c;;y
  ld   a, #1
  ld   p_activa(ix), a


 
ret
