;;
;;sys_posicionar_entities
;;

.include "sys_posicionar_entities.h.s"
.include "man/state_manager.h.s"
.include "man/entity_manager.h.s"
.include "man/st_game_over.h.s"

estado_posiciones: .db #00



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONAR LOS CANONS EN SINGLE PLAYER;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

posicion_entities::
ld a, (estado_posiciones)
cp #sin_posicion
jr nz,_NO_inicializar_posicion ;; Comprobamos si el nivel actual es 0 o otro para inicializar o ir al siguiente
_inicializar_posicion:	;; inicializo el nivel y lo pongo en el nivel_1

call get_gamemode
cp #5
jr z,_posiciones_single			;;inicializo para ir al single o al multi
_posiciones_multi:

ld hl, #pos_entities_multi_1
ld(_puntero_posicion),hl
jr salir

_posiciones_single:

ld hl, #pos_entities_single_1
ld(_puntero_posicion),hl

salir:

ld a, #siguiente_posicion ;;pongo el estado a siguiente nivel para que salte a los siguientes y no inicialice
ld (estado_posiciones),a

_NO_inicializar_posicion: ;; salto al nivel que toca

call estado_game_over
dec a
jr z,_reiniciar_posiciones


 _puntero_posicion=.+1
 jp 0000


_reiniciar_posiciones:
  _puntero_posicion_reinicio=.+1
 jp 0000
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 1  single;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_1::
call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y

;;posicion entidad 1
ld a, #hay_entidad
ld h,#8
ld l,#16
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #no_hay_entidad
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #no_hay_entidad
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#72
ld l,#112
call colocamos_entidad
NextEntity






ld hl, #pos_entities_single_2		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl

ld hl ,#pos_entities_single_1
ld (_puntero_posicion_reinicio),hl
ret
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 2;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_2::
call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y

;;posicion entidad 1
ld a, #hay_entidad
ld h,#72
ld l,#24
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#56
ld l,#64
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #no_hay_entidad

call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#8
ld l,#144
call colocamos_entidad


ld hl, #pos_entities_single_3		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl

ld hl ,#pos_entities_single_2
ld (_puntero_posicion_reinicio),hl
ret
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 3;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_3::
call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y


;;posicion entidad 1
ld a, #hay_entidad
ld h,#20
ld l,#80
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#8
ld l,#48
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#38
ld l,#128
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#68
ld l,#48
call colocamos_entidad


ld hl, #pos_entities_single_4		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl

ld hl ,#pos_entities_single_3
ld (_puntero_posicion_reinicio),hl
ret
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 4;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_4::
call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y


;;posicion entidad 1
ld a, #hay_entidad
ld h,#6
ld l,#112
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#72
ld l,#80
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#26
ld l,#80
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#48
ld l,#80
call colocamos_entidad




ld hl, #pos_entities_single_5		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl

ld hl ,#pos_entities_single_4
ld (_puntero_posicion_reinicio),hl
ret
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 5;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_5::
call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y


;;posicion entidad 1
ld a, #hay_entidad
ld h,#72
ld l,#136
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#22
ld l,#80
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#38
ld l,#48
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#54
ld l,#16
call colocamos_entidad

ld hl, #pos_entities_single_6		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl

ld hl ,#pos_entities_single_5
ld (_puntero_posicion_reinicio),hl
ret
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 6;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_single_6::

call entityman_getEntityVector_IX

;;en ix posicion de la entidad
;;cargamos en a si hay(0) o si no(1)
;;cargamos en h posicion x 
;;cargamos en l posicion y


;;posicion entidad 1
ld a, #hay_entidad
ld h,#4
ld l,#144
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#22
ld l,#80
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#54
ld l,#80
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#72
ld l,#16
call colocamos_entidad

ld hl ,#pos_entities_single_6
ld (_puntero_posicion_reinicio),hl

ret











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONAR LOS CANONS EN MULTIPLAYER;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 1;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_1::

call entityman_getEntityVector_IX

ld a, #hay_entidad
ld h,#4
ld l,#16
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#4
ld l,#144
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#72
ld l,#16
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#72
ld l,#144
call colocamos_entidad
NextEntity


ld hl, #pos_entities_multi_2		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 2;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_2::

call #pos_entities_multi_1


ld hl, #pos_entities_multi_3		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 3;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_3::

call entityman_getEntityVector_IX

ld a, #hay_entidad
ld h,#4
ld l,#32
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#24
ld l,#144
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#52
ld l,#16
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#72
ld l,#128
call colocamos_entidad
NextEntity

ld hl, #pos_entities_multi_4		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 4;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_4::

call #pos_entities_multi_1


ld hl, #pos_entities_multi_5		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 5;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_5::

call entityman_getEntityVector_IX

ld a, #hay_entidad
ld h,#36
ld l,#16
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#4
ld l,#144
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#72
ld l,#16
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#40
ld l,#144
call colocamos_entidad
NextEntity

ld hl, #pos_entities_multi_6		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;POSICIONES PARA EL MAPA 6;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pos_entities_multi_6::
call entityman_getEntityVector_IX

ld a, #hay_entidad
ld h,#4
ld l,#16
call colocamos_entidad
NextEntity


;;posicion entidad 2
ld a, #hay_entidad
ld h,#4
ld l,#144
call colocamos_entidad
NextEntity


;;posicion entidad 3
ld a, #hay_entidad
ld h,#72
ld l,#16
call colocamos_entidad
NextEntity

;;posicion entidad 4
ld a, #hay_entidad
ld h,#72
ld l,#144
call colocamos_entidad
NextEntity

ld hl, #pos_entities_multi_1		;;preparo para ir al siguiente nivel
ld(_puntero_posicion),hl
ret 


colocamos_entidad:
ld e_x(ix),h
ld e_xl(ix),h 
ld e_xll(ix),h 
ld e_y(ix),l
ld e_yl(ix),l
ld e_yll(ix),l
ld e_dead(ix), a



ret



reiniciar_posiciones::
	ld a ,#00
	ld(estado_posiciones),a
ret