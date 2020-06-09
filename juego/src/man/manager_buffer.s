;;
;; Manager_buffer 
;;

.include "cpct_functions.h.s"
videoPrt:: .dw #0x8000

map_switchBuffers::
	modifier=.+1
 ld l, #0x20
 call cpct_setVideoMemoryPage_asm
 ld hl, #modifier
 ld a, #0x10
 xor (hl)    ;; hace un xor con a
 ld (modifier), a


 ld 	hl, #videoPrt+1  ;;valor del videoPrt
 ld 	a, #0x40
 xor (hl)
 ld (videoPrt+1), a

ret
map_firstBuffer::
 
 ld hl, (videoPrt)
 ld a, h
 cp #0x80
 call z, map_switchBuffers


ret



map_getVideoPrt::
	ld hl, (videoPrt)
	ret 
