;;
;;sys_dir
;;

.include "man/entity_manager.h.s"
.include "sys_dir.h.s"

modificar_sprite::


ld a, e_ia_st(ix)

  cp #e_ia_st_noIA

  jr z, sin_ia

  con_ia:
  ld b, e_clock(ix)
  dec b
  jr z, _actualizo_dir
  ld e_clock(ix),b
  ret
  sin_ia:

ld b, e_clock(ix)

 ld a, e_vx(ix)
 or a
 jr nz, _salir
  ld a, e_vy(ix)
  or a
  jr nz, _salir
 dec b
  jr z, _actualizo_dir
  _actualizo_clock:
  ld e_clock(ix),b
  ret

_actualizo_dir:
  ld e_clock(ix), #_contador_ciclos
  ld a, e_dir(ix)
  dec a
  jr z, _reinicio_dir
  _decremento_dir:
ld e_dir(ix), a
  ret


 _reinicio_dir:
ld e_dir(ix), #4
  ret


_salir:
	ld e_clock(ix),#1
ret