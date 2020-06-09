;;
;;sys_interrup_music
;;

.include "sys_music.h.s"
.include "../cpct_functions.h.s"
.include "sys_interrup_music.h.s"
.include "man/st_game_over.h.s"



cancionactual: .db #0
contador: .db #1
tiempo  : .db #1

contadordis: .db #1
estadodis: .db #00

contadormuer: .db #1
estadomuer: .db #00

contadorwin: .db #1
estadowin: .db #00

contadorintera: .db #1
estadointera: .db #0





generate_music::


	ld a, (contador)
	dec a
	ld (contador),a
	jr nz,return
 		call cpct_akp_musicPlay_asm
 		ld a ,(tiempo)
 		ld(contador), a

 	return:


 	ld a ,(estadodis)
 	or a
 	jr z, return2

 		ld a, (contadordis)
		dec a
		ld (contadordis),a
		jr nz,return2
			ld a,(estadodis)
 			call sfxdisp
			;;debuelvo el estado nuevo
 			ld (estadodis), a
 			ld a ,#6
 			ld (contadordis), a

 	return2:


 	ld a ,(estadomuer)
 	or a
 	jr z, return3

 		ld a, (contadormuer)
		dec a
		ld (contadormuer),a
		jr nz,return3
			ld a,(estadomuer)
 			call sfxdead
			;;debuelvo el estado nuevo
 			ld (estadomuer), a
 			ld a ,#30
 			ld (contadormuer), a

 	return3:


 		ld a ,(estadowin)
 	or a
 	jr z, return4

 		ld a, (contadorwin)
		dec a
		ld (contadorwin),a
		jr nz,return4
			ld a,(estadowin)
 			call sfxwin
			;;debuelvo el estado nuevo
 			ld (estadowin), a
 			ld a ,#40
 			ld (contadorwin), a

 	return4:

	


_sfx_interacion::
ld a ,(estadointera)
 	or a
 	jr z, return5

 		ld a, (contadorintera)
		dec a
		ld (contadorintera),a
		jr nz,return2
			ld a,(estadointera)
 			call sfxinteraccion
			;;debuelvo el estado nuevo
 			ld (estadointera), a
 			ld a ,#0xFF
 			ld (contadorintera), a

 	return5:

ret

sonido_disparo::
	ld a, (estadodis)
	or a
	jr z, _realizamos_sonido
	ret

	_realizamos_sonido:
	ld a, #1
	ld (estadodis), a

ret

sonido_muerte::
	ld a, (estadomuer)
	or a
	jr z, _realizamos_sonido2
	ret

	_realizamos_sonido2:
	ld a, #1
	ld (estadomuer), a

ret



sonido_win::
	ld a, (estadowin)
	or a
	jr z, _realizamos_sonido3
	ret

	_realizamos_sonido3:
	ld a, #1
	ld (estadowin), a

ret


sonido_interaccion::
	ld a, (estadointera)
	or a
	jr z, _realizamos_sonido4
	ret

	_realizamos_sonido4:
	ld a, #1
	ld (estadointera), a

ret


off_muerte::
 ld a, #0
 ld (estadomuer), a
 ret



cancion1::
	ld a,#6
	ld (tiempo), a
	ld (contador),a
	
	ld de, #_song
    call cpct_akp_musicInit_asm
 
    ld a,#1
    ld (cancionactual),a

 ret

cancion2::

	ld a,#8
	ld (tiempo), a	
	ld (contador),a

	ld de, #_song2
    call cpct_akp_musicInit_asm

     ld a,#2
    ld (cancionactual),a

 ret
cancion3::

	ld a,#10
	ld (tiempo), a	
	ld (contador),a

	ld de, #_song3
    call cpct_akp_musicInit_asm

         ld a,#3
    ld (cancionactual),a

 ret

cancion4::

	ld a,#8
	ld (tiempo), a	
	ld (contador),a

	ld de, #_song4
    call cpct_akp_musicInit_asm

       ld a,#4
    ld (cancionactual),a

 ret

stopmusic::
call cpct_akp_stop_asm
 ret


next_song::
call stopmusic
	
call estado_game_over
dec a
jr z,_reiniciar_posiciones

	

	ld a,(cancionactual)

	cp #1
	jr z,_song_2
	cp #2
	jr z,_song_3
	cp #3
	jr z,_song_1
	cp #4
	jr z,_song_1

	_song_2:
	call cancion2
	ret
	_song_3:
	call cancion3
	ret
	_song_1:
	call cancion1
	ret

_reiniciar_posiciones:
	ret
	



