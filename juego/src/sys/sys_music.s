;;
;;sys_music
;;
.include "cpct_functions.h.s"
.include "sys_music.h.s"


;;(1B L ) sfx_num	Number of the instrument in the SFX Song (>0), same as the number given to the instrument in Arkos Tracker.
;;(1B H ) volume	Volume [0-15], 0 = off, 15 = maximum volume.
;;(1B E ) note	Note to be played with the given instrument [0-143]
;;(1B D ) speed	Speed (0 = As original, [1-255] = new Speed (1 is fastest))
;;(2B BC) inverted_pitch	Inverted Pitch (-0xFFFF -> 0xFFFF).  0 is no pitch.  The higher the pitch, the lower the sound.
;;(1B A ) channel_bitmask	Bitmask representing channels to use for reproducing the sound (Ch.A = 001 (1), Ch.B = 010 (2), Ch.C = 100 (4))



sfxinteraccion::

cp #1
jr nz, _Noinicializar_intera

_inicializar_intera:

ld de, #_estado4_1
ld(_siguiente_puntero_intera),de

_Noinicializar_intera:

_siguiente_puntero_intera=.+1
jp 0000



	_estado4_1:
		ld l ,#2
		ld h, #15
		ld e, #70
		ld d, #10
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado4_2
		ld(_siguiente_puntero_intera),de
		ld a, #_continuar
		ret
		

	_estado4_2:
		ld l ,#2
		ld h, #15
		ld e, #75
		ld d, #1
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		
		ld a, #_parar
		

ret



sfxdisp::


	cp #1
jr nz, _Noinicializar_dis

_inicializar_disp:

ld de, #_estado_1
ld(_siguiente_puntero_disp),de

_Noinicializar_dis:

_siguiente_puntero_disp=.+1
jp 0000



	
	_estado_1:
		ld l ,#2
		ld h, #15
		ld e, #60
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado_2
		ld(_siguiente_puntero_disp),de
		ld a, #_continuar
		ret
		

	_estado_2:
		ld l ,#2
		ld h, #15
		ld e, #63
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado_3
		ld(_siguiente_puntero_disp),de
		ld a, #_continuar
		ret

	_estado_3:
		ld l ,#2
		ld h, #15
		ld e, #64
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado_4
		ld(_siguiente_puntero_disp),de
		ld a, #_continuar
		ret

	_estado_4:

		ld l ,#2
		ld h, #15
		ld e, #65
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		
		ld(_siguiente_puntero_disp),de
		ld a, #_parar





	ret


sfxdead::



	cp #1
jr nz, _no_inicializar_muerte
_inicializar_muerte:

 ld de, #_estado2_1
 ld(_siguiente_puntero_muerte),de

_no_inicializar_muerte:


_siguiente_puntero_muerte=.+1
	jp 0000

	
	_estado2_1:
		ld l ,#2
		ld h, #15
		ld e, #70
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado2_2
		ld(_siguiente_puntero_muerte),de
		ld a, #_continuar

		ret

	_estado2_2:
		ld l ,#2
		ld h, #15
		ld e, #60
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado2_3
		ld(_siguiente_puntero_muerte),de
		ld a, #_continuar
		
		ret
	_estado2_3:
		ld l ,#2
		ld h, #15
		ld e, #50
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado2_4
		ld(_siguiente_puntero_muerte),de
		ld a, #_continuar
		
		ret
	_estado2_4:

		ld l ,#2
		ld h, #15
		ld e, #40
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm		
		
		ld a, #_parar

		ret






	ret



sfxwin::


	cp #1
jr nz, _no_inicializar_win
_inicializar_win:

 ld de, #_estado3_1
 ld(_siguiente_puntero_win),de

_no_inicializar_win:


_siguiente_puntero_win=.+1
	jp 0000



	
	_estado3_1:
		ld l ,#1
		ld h, #15
		ld e, #60
		ld d, #0
		ld bc, #0000
		ld a, #0
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado3_2
		ld(_siguiente_puntero_win),de
		ld a, #_continuar
		

		ret

	_estado3_2:
		ld l ,#1
		ld h, #15
		ld e, #63
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado3_3
		ld(_siguiente_puntero_win),de
		ld a, #_continuar

		ret

	_estado3_3:
		ld l ,#1
		ld h, #15
		ld e, #65
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado3_4
		ld(_siguiente_puntero_win),de
		ld a, #_continuar

		ret

	_estado3_4:
		ld l ,#1
		ld h, #15
		ld e, #63
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado3_5
		ld(_siguiente_puntero_win),de
		ld a, #_continuar

		ret

	_estado3_5:
		ld l ,#1
		ld h, #15
		ld e, #60
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado3_6
		ld(_siguiente_puntero_win),de
		ld a, #_continuar
		
		ret

	_estado3_6:

		ld l ,#1
		ld h, #15
		ld e, #63
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
			
		ld de, #_estado3_7
		ld(_siguiente_puntero_win),de
		ld a, #_continuar

		ret

	_estado3_7:

		ld l ,#1
		ld h, #15
		ld e, #67
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		
		ld de, #_estado3_8
		ld(_siguiente_puntero_win),de
		ld a, #_continuar

		ret

	_estado3_8:

		ld l ,#1
		ld h, #15
		ld e, #0
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado3_9
		ld(_siguiente_puntero_win),de
		ld a, #_continuar
		
		ret
	_estado3_9:

		ld l ,#1
		ld h, #15
		ld e, #65
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm

		ld de, #_estado3_10
		ld(_siguiente_puntero_win),de
		ld a, #_continuar
		
		ret

	_estado3_10:

		ld l ,#1
		ld h, #15
		ld e, #68
		ld d, #0
		ld bc, #0000
		ld a, #2
		call cpct_akp_SFXPlay_asm
		

		ld a, #_parar
		







	ret
