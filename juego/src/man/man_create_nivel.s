;;
;;man create nivel
;;

.include "man_create_nivel.h.s"
.include "sys/sys_map_creator.h.s"
.include "sys/ia_control_sys.h.s"
.include "sys/sys_create_bullet.h.s"
.include "sys/sys_interrup_music.h.s"
.include "sys/sys_map_colision.h.s"
.include "sys/sys_patrol.h.s"
.include "sys/sys_posicionar_entities.h.s"
.include "man/st_game_over.h.s"
.include "sys/sys_kill_bullet.h.s"

estado_nivel_single:: .db #00
estado_nivel_multi: .db #00
;; funcion para inicializar los niveles LLAMAR A ESTA FUNCION LA PRIMERA VEZ




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;GENERADOR NIVELES SINGLE_PLAYER;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



crear_nivel_single::





ld a, (estado_nivel_single)
cp #sin_nivel
jr nz,_NO_inicializar_nivel1 ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
_inicializar_nivel1:	;; inicializo el nivel y lo pongo en el nivel_1
ld hl, #nivel_1
ld(_puntero_nivel),hl

ld a, #siguiente_nivel ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
ld (estado_nivel_single),a

_NO_inicializar_nivel1: ;; salto al nivel que toca

call estado_game_over
dec a
jr z,_reiniciar_posiciones


 _puntero_nivel=.+1
 jp 0000

 _reiniciar_posiciones:

  _puntero_nivel_reinicio=.+1
 jp 0000
 
;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 1 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;

nivel_1::
	
 call posicion_entities
 call patrol_nivel_single1
 call cambiar_colisiones
 
 call next_map

 
 ld a, #dificultad1
 call cambiar_velocidad_ia

 ld a, #dificultad1
 call cambiar_dificultad_ia

 ld a, #dificultad1 
 call velocidad_balas


 call next_song

ld hl, #nivel_2		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl

ld hl, #nivel_1		
ld(_puntero_nivel_reinicio),hl

ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 2 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;

nivel_2::
 
 call posicion_entities
  call patrol_nivel_single2
 call next_map
 call cambiar_colisiones

 ld a, #dificultad1
 call cambiar_velocidad_ia

 ld a, #dificultad1
 call cambiar_dificultad_ia

 ld a, #dificultad1 
 call velocidad_balas

ld hl, #nivel_3		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl

ld hl, #nivel_2		
ld(_puntero_nivel_reinicio),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 3 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_3::

  call posicion_entities                
 call patrol_nivel_single3

 call cambiar_colisiones

 call next_map


  ld a, #dificultad1
 call cambiar_velocidad_ia

 ld a, #dificultad2
 call cambiar_dificultad_ia

 ld a, #dificultad1 
 call velocidad_balas

 call next_song


ld hl, #nivel_4		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl


ld hl, #nivel_3		
ld(_puntero_nivel_reinicio),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 4 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_4::

  call posicion_entities               
  call patrol_nivel_single4

 call cambiar_colisiones

 call next_map



  ld a, #dificultad1
 call cambiar_velocidad_ia

 ld a, #dificultad3
 call cambiar_dificultad_ia

 ld a, #dificultad1 
 call velocidad_balas

ld hl, #nivel_5		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl


ld hl, #nivel_4		
ld(_puntero_nivel_reinicio),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 5 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_5::


 call posicion_entities               
 call patrol_nivel_single5

 call cambiar_colisiones

 call next_map

 ld a, #dificultad2
 call cambiar_velocidad_ia

 ld a, #dificultad3
 call cambiar_dificultad_ia

 ld a, #dificultad2 
 call velocidad_balas

 call next_song

ld hl, #nivel_6		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl


ld hl, #nivel_5		
ld(_puntero_nivel_reinicio),hl

ret



;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 6 single player;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_6::

 

 call posicion_entities               
 call patrol_nivel_single6

 call cambiar_colisiones

 call next_map

 ld a, #dificultad2
 call cambiar_velocidad_ia

 ld a, #dificultad4
 call cambiar_dificultad_ia

 ld a, #dificultad2 
 call velocidad_balas


ld hl, #nivel_6		;;preparo para ir al siguiente nivel
ld(_puntero_nivel),hl

ld a, #partida_terminada ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
ld (estado_nivel_single),a


ld hl, #nivel_6		
ld(_puntero_nivel_reinicio),hl


ret










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;GENERADOR NIVELES MULTIJUGADOR;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,


crear_nivel_multi::

ld a, (estado_nivel_multi)
cp #sin_nivel
jr nz,_NO_inicializar_nivel_multi1 ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
_inicializar_nivel_multi1:	;; inicializo el nivel y lo pongo en el nivel_1
ld hl, #nivel_multi_1
ld(_puntero_nivel_multi),hl

ld a, #siguiente_nivel ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
ld (estado_nivel_multi),a

_NO_inicializar_nivel_multi1: ;; salto al nivel que toca

 _puntero_nivel_multi=.+1
 jp 0000
 


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 1 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_1::

 
 call reset_lvl

 call patrol_nivel_multi1
 
 call posicion_entities

 call cambiar_colisiones


 call next_map


 call next_song



ld hl, #nivel_multi_2		;;preparo para ir al siguiente nivel
ld (_puntero_nivel_multi),hl

ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 2 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_2::

 call posicion_entities

 call patrol_nivel_multi2

 call cambiar_colisiones

 call next_map





ld hl, #nivel_multi_3		;;preparo para ir al siguiente nivel
ld(_puntero_nivel_multi),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 3 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_3::

 call posicion_entities

 call patrol_nivel_multi3

 call cambiar_colisiones

 call next_map
 call next_song


ld hl, #nivel_multi_4		;;preparo para ir al siguiente nivel
ld(_puntero_nivel_multi),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 4 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_4::

 call posicion_entities

 call patrol_nivel_multi4

 call cambiar_colisiones

 call next_map



ld hl, #nivel_multi_5		;;preparo para ir al siguiente nivel
ld(_puntero_nivel_multi),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 5 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_5::

 call posicion_entities

 call patrol_nivel_multi5

 call cambiar_colisiones

 call next_map
 call next_song

ld hl, #nivel_multi_6		;;preparo para ir al siguiente nivel
ld(_puntero_nivel_multi),hl
ret

ret


;;;;;;;;;;;;;;;;;;;;;;;;;
;;NIVEL 6 multiplayer  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
nivel_multi_6:

 call patrol_nivel_multi6

 call cambiar_colisiones

 call next_map


ld hl, #nivel_multi_1		;;preparo para ir al siguiente nivel
ld (_puntero_nivel_multi),hl
ret




sistema_reiniciar_niveles::

ld a,#0
ld (estado_nivel_single), a
ld (estado_nivel_multi), a

call reiniciar_gameover
call reiniciar_posiciones
call reset_lvl
call reiniciar_colisiones
call kill_bullet_all

ld a, #dificultad1
 call cambiar_velocidad_ia

 ld a, #dificultad1
 call cambiar_dificultad_ia

 ld a, #dificultad1 
 call velocidad_balas
	
	ret