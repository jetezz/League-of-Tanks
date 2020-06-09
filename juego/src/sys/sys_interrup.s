;;
;;sys_interrup
;;

.include "../sys/sys_interrup_music.h.s"





isr::

	ex af,af'
	exx
	push af
	push bc
	push de
	push hl
	push iy

	call generate_music


 	pop iy
 	pop hl
 	pop de
 	pop bc
 	pop af
 	exx
 	ex af, af'
ret


