;;
;;entity manager
;;
.include "entity_manager.h.s" 
.include "man/state_manager.h.s"
_num_entities:: .db #4  ;; ESTABLECEMOS EL NUMERO DE ENTIDADES QUE HABRA EN NUESTRO JUEGO

_jugx: .db #4
_jugy: .db #16

_jug2x: .db #4
_jug2y: .db #144

_jug3x: .db #72
_jug3y: .db #16


_jug4x: .db #72
_jug4y: .db #144


_jugv: .db #00
_jugshot: .db #00
_jugdir:  .db #03
_jugdead: .db #00

_jugia:  .db e_ia_st_noIA
_jug2ia: .db e_ia_st_noIA
_jug3ia: .db e_ia_st_noIA
_jug4ia: .db e_ia_st_noIA
set_gamemode_ia::

   ;;Cambiamos el color de lo que pintaremos
   ld a, (_gamemode)
   dec a ;;Gamemode es 1, es decir 1 jugador contra ia battle royale
   call z, set_1player_ia
   ret z

   dec a ;;Gamemode es 2, es decir 2 jugador contra ia battle royale
   call z, set_2player_ia
   ret z

   dec a ;;Gamemode es 3, es decir 3 jugador contra ia battle royale
   call z, set_3player_ia
   ret z


   dec a ;;Gamemode es 4, es decir 4 jugador battle royale
   call z, set_4player_ia
   ret z

   dec a ;;Gamemode es 5, es decir singleplayer
   call z, set_single_player_ia
   ret z

ret
set_1player_ia:
 ld a, #e_ia_st_stand_by
 ld (_jug2ia), a
 ld (_jug3ia), a
 ld (_jug4ia), a
ret
set_2player_ia:
 ld a, #e_ia_st_noIA
 ld (_jug2ia), a
 ld a, #e_ia_st_stand_by
 ld (_jug3ia), a
 ld (_jug4ia), a
ret
set_3player_ia:
 ld a, #e_ia_st_noIA
 ld (_jug2ia), a
 ld (_jug3ia), a
 ld a, #e_ia_st_stand_by
 ld (_jug4ia), a
ret
set_4player_ia:
 ld a, #e_ia_st_noIA
 ld (_jug2ia), a
 ld (_jug3ia), a
 ld (_jug4ia), a
ret
set_single_player_ia:
 ld a, #e_ia_st_stand_by
 ld (_jug2ia), a
 ld (_jug3ia), a
 ld (_jug4ia), a
ret

init_entities::
	call set_gamemode_ia
	call entityman_getEntityVector_IX


	;;Jugador 1
	ld a, (_jugx)
	ld e_x(ix), a
	ld e_xl(ix), a
	ld e_xll(ix), a
	ld a, (_jugy)
	ld e_y(ix), a
	ld e_yl(ix), a
	ld e_yll(ix), a
	ld a, (_jugv)
	ld e_vx(ix), a
	ld e_vy(ix), a
	ld a, (_jugshot)
	ld e_sh(ix), a
	ld a, (_jugia)
	ld e_ia_st(ix), a
	ld a, (_jugdead)
	ld e_dead(ix), a


	nextEntity

	;;Jugador 2
	ld a, (_jug2x)
	ld e_x(ix), a
	ld e_xl(ix), a
	ld e_xll(ix), a
	ld a, (_jug2y)
	ld e_y(ix), a
	ld e_yl(ix), a
	ld e_yll(ix), a
	ld a, (_jugv)
	ld e_vx(ix), a
	ld e_vy(ix), a
	ld a, (_jugshot)
	ld e_sh(ix), a
	ld a, (_jug2ia)
	ld e_ia_st(ix), a
	ld a, (_jugdead)
	ld e_dead(ix), a

	NextEntity

	;;Jugador 3
	ld a, (_jug3x)
	ld e_x(ix), a
	ld e_xl(ix), a
	ld e_xll(ix), a
	ld a, (_jug3y)
	ld e_y(ix), a
	ld e_yl(ix), a
	ld e_yll(ix), a
	ld a, (_jugv)
	ld e_vx(ix), a
	ld e_vy(ix), a
	ld a, (_jugshot)
	ld e_sh(ix), a
	ld a, (_jug3ia)
	ld e_ia_st(ix), a
	ld a, (_jugdead)
	ld e_dead(ix), a

	NextEntity

	;;Jugador 4
	ld a, (_jug4x)
	ld e_x(ix), a
	ld e_xl(ix), a
	ld e_xll(ix), a
	ld a, (_jug4y)
	ld e_y(ix), a
	ld e_yl(ix), a
	ld e_yll(ix), a
	ld a, (_jugv)
	ld e_vx(ix), a
	ld e_vy(ix), a
	ld a, (_jugshot)
	ld e_sh(ix), a
	ld a, (_jug4ia)
	ld e_ia_st(ix), a
	ld a, (_jugdead)
	ld e_dead(ix), a




ret

create_entities::

  Entity jugador   00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_noIA    , 3, 0,4,16		;; explicados en la macro
  Entity jugador2  00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_noIA	   , 3, 0,4,16	   
  Entity enemigo   00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_stand_by, 3, 0,4,16	               
  Entity enemigo2  00,00  ,00,00  ,00,00  ,00,00 ,0 ,e_ia_st_stand_by, 3, 0,4,16	

  ret               



entityman_getEntityVector_IX:: ;;mandar el puntero al primer byte del array de tanques en xy
 ld ix, #jugador
	ret
	

entityman_num_entities::      ;; mandar el numero de tanques que hay en a(no necesario siempre es 4)
 ld a, (_num_entities)
 ret


