;;
;;CHECK KEY
;;

;; IX: POINTER TO ENTITY MOVE (KEY)
 
.include "cpctelera.h.s"
.include "cpct_functions.h.s"
.include "man/entity_manager.h.s"
.include "sys/clean_entities.h.s"
.include "man/shot_manager.h.s"
.include "man/state_manager.h.s"
.include "../sys/sys_create_bullet.h.s"
.include "../sys/sys_create_bullet_2.h.s"
.include "../man/pause.h.s"
.include "../man/st_zerostate_manager.h.s"
.include "man/man_create_nivel.h.s"
.include "man/st_game_over.h.s"


check_key_init::

 call entityman_getEntityVector_IX 
 ld (_puntero_entidades), ix

	ret
check_key::

 _puntero_entidades=.+2
 ld ix, #0000

	call cpct_scanKeyboard_asm
   ;;Comprobamos en que modo de juego estamos para hacer el checkkey de un jugador u otro
   ld a, (_gamemode)
   dec a ;;Gamemode es 1, es decir 1 jugador contra ia battle royale
   jr nz, _gamemo2
   	call  limpiar_1players
   	call  play1_move_q
   	call  play1_shot_w
   ret 
_gamemo2:
   dec a ;;Gamemode es 2, es decir 2 jugador contra ia battle royale
   jr nz, _gamemo3
   	call  limpiar_2players
   	call  play1_move_q
   	call  play1_shot_w
   	call  play2_move_z
   	call  play2_shot_x
   ret 
_gamemo3:
   dec a ;;Gamemode es 3, es decir 3 jugador contra ia battle royale
   jr nz, _gamemo4
  	call  limpiar_3players
  	call  play1_move_q
   	call  play1_shot_w
   	call  play2_move_z
   	call  play2_shot_x
   	call  play3_move_i
   	call  play3_shot_u
   ret 
_gamemo4:

   dec a ;;Gamemode es 4, es decir 4 jugador battle royale
   jr nz, _gamemo5
  	call   limpiar_4players
  	call  play1_move_q
   	call  play1_shot_w
   	call  play2_move_z
   	call  play2_shot_x
   	call  play3_move_i
   	call  play3_shot_u
   	call  play4_move_m
   	call  play4_shot_n
   ret 
	_gamemo5:
   dec a ;;Gamemode es 5, es decir singleplayer
   jr nz, _gamemo6
   	call  limpiar_1players
   	call  play1_move_q
   	call  play1_shot_w
   ret 
_gamemo6:



ret


 ;;Las funciones limpiar ponen la velocidad de los jugadores a 0 cada turno

limpiar_1players:
ld ix, (_puntero_entidades)
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
ret


limpiar_2players:
ld ix, (_puntero_entidades)

	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
	nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
ret


limpiar_3players:
 ld ix, (_puntero_entidades)

	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
		nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
		nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0

ret

limpiar_4players:
 ld ix, (_puntero_entidades)

	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
		nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
		nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
		nextEntity
	ld e_vx(ix) ,#0
	ld e_vy(ix) ,#0
ret


;; MOVIMIENTO PERSONAJE 1
play1_move_q:
ld	hl, #Key_Q

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_q
;;Pusada
	 
	

 	ld ix, (_puntero_entidades)

	;; si ha muerto, no puede moverse
	ld a, e_dead(ix)
	dec a
	jr z, _pers1_dead_not_move

	ld a, e_dir(ix)
	dec a
	jr z, #_izquierda
	dec a
	jr z, #_arriba
	dec a
	jr z, #_derecha
	dec a
	jr z, #_abajo

	_izquierda:
	ld e_vx(ix) ,#-1
	jr _salir

	_arriba:
	ld e_vy(ix) ,#-4
	jr _salir

	_derecha:
	ld e_vx(ix) ,#1
	jr _salir

	_abajo:
	ld e_vy(ix) ,#4
	


	_salir:

	
		

_pers1_dead_not_move:

o_no_pulsada_q:

ret


;; DISPARO PERSONAJE 1

play1_shot_w:

ld	hl, #Key_W

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_w
;;Pusada
ld ix, (_puntero_entidades)

;; si ha muerto, no puede disparar
ld a, e_dead(ix)
dec a
jr z, _pers1_dead

ld a, e_sh(ix)
dec a
jr z, _pers1_ya_ha_disparado

 ;;call hacer_disparo
 call hacer_disparo2


_pers1_ya_ha_disparado:
_pers1_dead:
o_no_pulsada_w:
ret

;; MOVIMIENTO PERSONAJE 2

play2_move_z::
ld	hl, #Key_Z

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_z
;;Pusada
	ld ix, (_puntero_entidades)

	nextEntity
      
      ;; si ha muerto, no puede moverse
      ld a, e_dead(ix)
	dec a
	jr z, _pers2_dead_not_move

	ld a, e_dir(ix)
	dec a
	jr z, #_izquierda2
	dec a
	jr z, #_arriba2
	dec a
	jr z, #_derecha2
	dec a
	jr z, #_abajo2
	
	_izquierda2:
	ld e_vx(ix) ,#-1
	jr _salir2

	_arriba2:
	ld e_vy(ix) ,#-4
	jr _salir2

	_derecha2:
	ld e_vx(ix) ,#1
	jr _salir2

	_abajo2:
	ld e_vy(ix) ,#4
	


	_salir2:

	

_pers2_dead_not_move:

o_no_pulsada_z:


ret



;; DISPARO PERSONAJE 2

play2_shot_x:

	

ld	hl, #Key_X

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_x
;;Pusada
ld ix, (_puntero_entidades)
	nextEntity
;; si ha muerto, no puede disparar
ld a, e_dead(ix)
dec a
jr z, _pers2_dead

ld a,e_sh(ix)
dec a
jr z, _pers2_ya_ha_disparado


 call hacer_disparo2


_pers2_ya_ha_disparado:
	
_pers2_dead:

o_no_pulsada_x:


ret



;; MOVIMIENTO PERSONAJE 3

play3_move_i:
ld	hl, #Key_I

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_i
;;Pusada
	ld ix, (_puntero_entidades)

	nextEntity
      nextEntity
      ;; si ha muerto, no puede moverse
      ld a, e_dead(ix)
	dec a
	jr z, _pers3_dead_not_move

	ld a, e_dir(ix)
	dec a
	jp z, #_izquierda3
	dec a
	jp z, #_arriba3
	dec a
	jp z, #_derecha3
	dec a
	jp z, #_abajo3
	
	_izquierda3:
	ld e_vx(ix) ,#-1
	jr _salir3

	_arriba3:
	ld e_vy(ix) ,#-4
	jr _salir3

	_derecha3:
	ld e_vx(ix) ,#1
	jr _salir3

	_abajo3:
	ld e_vy(ix) ,#4
	


	_salir3:

	
_pers3_dead_not_move:

o_no_pulsada_i:


ret



;; DISPARO PERSONAJE 3

play3_shot_u:
ld	hl, #Key_U

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_u
;;Pusada
	ld ix, (_puntero_entidades)

	nextEntity
      nextEntity

;; si ha muerto, no puede disparar
ld a, e_dead(ix)
dec a
jr z, _pers3_dead

ld a,e_sh(ix)
dec a
jr z, _pers3_ya_ha_disparado

 call hacer_disparo2


_pers3_ya_ha_disparado:
	
_pers3_dead:

o_no_pulsada_u:


ret




;; MOVIMIENTO PERSONAJE 4

play4_move_m:
ld	hl, #Key_M

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_m
;;Pusada
	ld ix, (_puntero_entidades)

	nextEntity
      nextEntity
      nextEntity
      ;; si ha muerto, no puede moverse
      ld a, e_dead(ix)
	dec a
	jr z, _pers4_dead_not_move

	ld a, e_dir(ix)
	dec a
	jp z, #_izquierda4
	dec a
	jp z, #_arriba4
	dec a
	jp z, #_derecha4
	dec a
	jp z, #_abajo4


	_izquierda4:
	ld e_vx(ix) ,#-1
	jr _salir4

	_arriba4:
	ld e_vy(ix) ,#-4
	jr _salir4

	_derecha4:
	ld e_vx(ix) ,#1
	jr _salir4

	_abajo4:
	ld e_vy(ix) ,#4
	


	_salir4:

	

_pers4_dead_not_move:

o_no_pulsada_m:


ret



;; DISPARO PERSONAJE 4

play4_shot_n:
ld	hl, #Key_N

 
call cpct_isKeyPressed_asm
jr  z, o_no_pulsada_n
;;Pusada
ld ix, (_puntero_entidades)

nextEntity
nextEntity
nextEntity
;; si ha muerto, no puede disparar
ld a, e_dead(ix)
dec a
jr z, _pers4_dead

ld a,e_sh(ix)
dec a
jr z, _pers4_ya_ha_disparado


 call hacer_disparo2


_pers4_ya_ha_disparado:
	
_pers4_dead:

o_no_pulsada_n:

ret

_unavez: .db #01
check_game_begin::

;; Activamos el escaneado del teclado para poder captar si se ha pulsado la tecla enter o no
  call cpct_scanKeyboard_asm

  ld hl, #Key_Return
  call cpct_isKeyPressed_asm
  jr z, o_no_pulsada_enter
  
  ;; Si se ha pulsado la tecla enter
  ld a, (_unavez)
  dec a
  jr z, _iniciarPrimeravez
  call sistema_reiniciar_niveles
  call set_Ingame

  
  ret
  _iniciarPrimeravez:
  ld (_unavez), a
  call jugandostate_init

o_no_pulsada_enter:

ret


holdingrestart:: .db #00

check_restart::


call cpct_scanKeyboard_asm

ld	hl, #Key_Return

 call cpct_isKeyPressed_asm
	jr z, _norestart
	ld a, (holdingrestart)
	dec a
	ret z

	call set_Ingame
	ld a,#1
	ld (holdingrestart), a
	ret


_norestart:
ld a, #0
ld (holdingrestart), a



ret



holdingEsc:: .db #00

check_Esc::


 call cpct_scanKeyboard_asm

ld	hl, #Key_Esc

 call cpct_isKeyPressed_asm
	jr z, _noEsc
	ld a, (holdingEsc)
	dec a
	ret z
	call kill_all
	call set_Inicio
	ld a,#1
	ld (holdingEsc), a
	ret


_noEsc:
ld a, #0
ld (holdingEsc), a



ret




;;Delay para unpausar, al pausar se pone un contador para que no se pueda despausar al instantess


;;Check que se pulsa p para un pausar
check_unPause::


call cpct_scanKeyboard_asm

ld	hl, #Key_P
	
call cpct_isKeyPressed_asm
	jr z, nopulsandoup

	ld a, (holdingpause)
	dec a
	ret z

	call unPause

	ld a, #1
	ld (holdingpause), a
	ret
nopulsandoup:
ld a, #0
ld (holdingpause), a
ret




holdingpause:: .db #00
;;CHECK QUE  SE PULA P para pausar

check_Pause::

call cpct_scanKeyboard_asm

ld	hl, #Key_P
	
call cpct_isKeyPressed_asm
	jr z, nopulsandop

	ld a, (holdingpause)
	dec a
	ret z

	call Pause

	ld a, #1
	ld (holdingpause), a
	ret
nopulsandop:
ld a, #0
ld (holdingpause), a

ret



holdingQ:: .db #00

check_nextGamemode::

call cpct_scanKeyboard_asm

ld	hl, #Key_Q
	
call cpct_isKeyPressed_asm
	jr z, nopulsandoQ

	ld a, (holdingQ)
	dec a
	ret z

	call next_gamemode

	ld a, #1
	ld (holdingQ), a
	ret
nopulsandoQ:
ld a, #0
ld (holdingQ), a

ret