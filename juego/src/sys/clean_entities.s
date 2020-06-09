;;
;;Clean entities h
;;

;; IX: puntero de la entidad que queremos limpiar
;; A: NUMBER OF ENTITIES TO RENDER 
.include "cpct_functions.h.s"
.include "man/entity_manager.h.s"
.include "man/shot_manager.h.s"
.include "man/manager_buffer.h.s"


clean_entities_init::
 call entityman_getEntityVector_IX
 call entityman_num_entities


ld (_contador_entidades),a
ld (_puntero_entidades), ix


 call entityman_getArray_Bales  ;; cogemos en ix el puntero a las balas
 call entityman_num_Bales
 ld (_contador_balas), hl
 ld (_puntero_balas), ix
ret


clean_entities::
  

 call _clean_canon
 call _clean_balas	
ret





_clean_canon:

_contador_entidades=.+1
	ld a, #00
_puntero_entidades=.+2
ld ix, #0000
_cleanloop:

push af  
	
	
   ld a ,e_dead(ix)
  dec a
  jr z, _canon_muerto 

 call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
  ex de, hl
 
  ld   c, e_xll(ix)  
  ld   b, e_yll(ix)  
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   ex  de,hl
 

  
ld  a, #0x00  ;;color
ld  c, #4 	;;width
ld  b, #16	;;height
call cpct_drawSolidBox_asm

_canon_muerto:

pop af 


dec a
ret z

ld bc, #siceof_e ;;byte de cada entidad
add ix, bc
jr nz, _cleanloop


ret





_clean_balas::

 _puntero_balas=.+2
 ld ix, #0000
 _contador_balas=.+1
 ld hl, #0000
 ld a ,(hl)
 or a 
 	jr z, _no_hay_balas

	
	_cleanloop_balas:
	push af
	   
	 call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
	  ex de, hl
	 
	  ld   c, b_xll(ix)  
	  ld   b, b_yll(ix)  
	  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	   ex  de,hl
	 

	  
	ld  a, #0x00   ;; color
	ld  c, b_w(ix)	;; width
	ld  b, b_h(ix)	;; height ;;**
	call cpct_drawSolidBox_asm


	pop af 

	dec a
	ret z

	ld bc, #siceof_b ;;byte de cada BALA
	add ix, bc
	jr nz, _cleanloop_balas
_no_hay_balas:

ret  




limpiar_ultimo::


 ;;call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
  ;;ex de, hl
  ld de ,#0xc000
  ld   c, e_x(iy)  
  ld   b, e_y(iy)  
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
  ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm



 ld de ,#0x8000
 ld   c, e_x(iy)  
 ld   b, e_y(iy)  
 call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
 ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm

   ld de ,#0xc000
  ld   c, e_xl(iy)  
  ld   b, e_yl(iy)  
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
  ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm



 ld de ,#0x8000
 ld   c, e_xl(iy)  
 ld   b, e_yl(iy)  
 call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
 ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm

   ld de ,#0xc000
  ld   c, e_xll(iy)  
  ld   b, e_yll(iy)  
  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
  ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm



 ld de ,#0x8000
 ld   c, e_xll(iy)  
 ld   b, e_yll(iy)  
 call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
 ex  de,hl  
 ld  a, #0x00  ;;color
 ld  c, #4 	;;width
 ld  b, #16	;;height
 call cpct_drawSolidBox_asm

ret


limpiar_ultima::


 ;;call map_getVideoPrt  ;; esta funcion te da el puntero de el primer byte de la posicion de memoria del buffer que estamos en ese momento en hl
  ;;ex de, hl
 

	 ld de ,#0xc000

 	ld   c, b_xl(ix)  
	ld   b, b_yl(ix)  

	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	ld  c, b_w(ix)	;; width
	ld  b, b_h(ix)	;; height ;;**
	call cpct_drawSolidBox_asm

  ld de ,#0x8000
	ld   c, b_xl(ix)  
	ld   b, b_yl(ix)  
	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	ld  c, b_w(ix)	;; width
	ld  b, b_h(ix)	;; height ;;**
	call cpct_drawSolidBox_asm

	 

	  ld de ,#0xc000

 	ld   c, b_xll(ix)  
	ld   b, b_yll(ix)  
	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	ld  c, b_w(ix)	;; width
	ld  b, b_h(ix)	;; height ;;**
	call cpct_drawSolidBox_asm

  ld de ,#0x8000
	ld   c, b_xll(ix)  
	ld   b, b_yll(ix)  
	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
	 ex  de,hl	
	ld  a, #0x00   ;; color
	ld  c, b_w(ix)	;; width
	ld  b, b_h(ix)	;; height ;;**
	call cpct_drawSolidBox_asm

	 ld de ,#0xc000

 	

ret


