;;
;;kill bullet 2
;;
.include "man/entity_manager.h.s"
.include "man/shot_manager.h.s"	
.include "sys/sys_a.h.s"
.include "sys/clean_entities.h.s"
	


kill_bullet_init_2::

 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix

  ret



kill_bullet_2::
push af
 call iniciar_animacion_bala
 call limpiar_ultima
pop af
ld c, a

call devolver_tiro

_puntero_balas=.+2
ld ix, #0000


dec a
or a
jr z,_eliminamos_primera_bala

ld de, #siceof_b
loop_posicionar:


add ix, de
dec a

jr nz, loop_posicionar

_eliminamos_primera_bala:
;; aqui tengo el puntero a la bala que hay que eliminar
ld (puntero_entidad_a_eliminar), ix
call devolver_tiro


ld a, #max_bales
sub c
;; aqui tengo el numero de entidades que tengo que mover


puntero_entidad_a_eliminar=.+1
ld de, #0000
ld hl ,(puntero_entidad_a_eliminar)
ld bc ,#siceof_b
add hl,bc


_seguimos_limpiando:
ld bc ,#siceof_b
ldir
dec a
jr nz, _seguimos_limpiando





_contador_balas=.+1
ld hl ,#0000
ld a,(hl)
dec a
ld (hl), a


 	






 ret


devolver_tiro:

ld h, b_canon_h(ix)
ld l, b_canon_l(ix)
ld de, #e_sh
add hl, de
ld (hl), #0

 ret