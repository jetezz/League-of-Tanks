;;
;;Patrol manager 
;; 

.include "man/patrol_manager.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Patrones para el single;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;;Mapa 1 single;;
;;;;;;;;;;;;;;;;;
patrol_single_11:
	

	.db patrol_invalid_move_x
	.dw patrol_single_11

patrol_single_12:
	

	.db patrol_invalid_move_x
	.dw patrol_single_12

patrol_single_13:
	.db 64, 48
	.db 64, 112
	.db 72, 80
	.db 68, 80
	.db 72, 80
	.db patrol_invalid_move_x
	.dw patrol_single_13
;;;;;;;;;;;;;;;;;
;;Mapa 2 single;;
;;;;;;;;;;;;;;;;;



patrol_single_21:
	
	
	.db 56, 64	
	.db 40, 64	
	.db 28, 88
	.db 20, 64
	.db 4, 88
	.db 32, 64
	.db 44, 88
	



	.db patrol_invalid_move_x
	.dw patrol_single_21

patrol_single_22:
	

	.db patrol_invalid_move_x
	.dw patrol_single_22

patrol_single_23:
	.db 8,144
	.db 24,144
	.db 36,120
	.db 48,144
	.db 60,120
	.db 44,120
	.db 32,144
	.db 20,120








	.db patrol_invalid_move_x
	.dw patrol_single_23
;;;;;;;;;;;;;;;;;
;;Mapa 3 single;;
;;;;;;;;;;;;;;;;;

patrol_single_31:
	
	.db 12,32
	.db 64,32
	.db 64,128	
	.db 12,128



	.db patrol_invalid_move_x
	.dw patrol_single_31

patrol_single_32:
	.db 68,144	
	.db 8,16
	.db 68,16
	.db 36,16
	.db 36,72
	.db 44,72
	.db 36,72
	.db 36,144
	.db 68,144	
	.db 8,144

	.db patrol_invalid_move_x
	.dw patrol_single_32

patrol_single_33:

	.db 38,16
	.db 38,144


	.db patrol_invalid_move_x
	.dw patrol_single_33
;;;;;;;;;;;;;;;;;
;;Mapa 4 single;;
;;;;;;;;;;;;;;;;;

patrol_single_41:
	.db 52,32
	.db 52,128
	.db 60,128
	.db 72,80





	.db patrol_invalid_move_x
	.dw patrol_single_41

patrol_single_42:
	

	.db 20,64
	.db 20,96
	

	.db patrol_invalid_move_x
	.dw patrol_single_42

patrol_single_43:

	.db 48,80	
	.db 48,24
	.db 28,24
	.db 28,80
	.db 48,80
	.db 48,136
	.db 28,136
	.db 28,80






	.db patrol_invalid_move_x
	.dw patrol_single_43
;;;;;;;;;;;;;;;;;
;;Mapa 5 single;;
;;;;;;;;;;;;;;;;;

patrol_single_51:
	
	.db 22,80
	.db 22,112	
	.db 4,80
	.db 4,64
	.db 22,64
	.db 22,112
	.db 22,64
	.db 72,64
	.db 72,80
	.db 22,80
	.db 22,112









	.db patrol_invalid_move_x
	.dw patrol_single_51

patrol_single_52:
	
	.db 38,48
	.db 38,112
	.db 38,48
	.db 4,48
	.db 38,48
	.db 38,112
	.db 38,48	
	.db 72,48







	.db patrol_invalid_move_x
	.dw patrol_single_52

patrol_single_53:
	
	.db 54,16
	.db 54,112
	.db 54,16
	.db 4,16
	.db 4,32
	.db 54,32
	.db 54,112
	.db 54,32
	.db 72,32
	.db 72,16











	.db patrol_invalid_move_x
	.dw patrol_single_53
;;;;;;;;;;;;;;;;;
;;Mapa 6 single;;
;;;;;;;;;;;;;;;;;

patrol_single_61:
	

	.db 36,24
	.db 8,24
	.db 8,136
	.db 36,136






	.db patrol_invalid_move_x
	.dw patrol_single_61

patrol_single_62:
		

	.db 68,24
	.db 40,24
	.db 40,80
	.db 68,80
	.db 68,136
	.db 40,136
	.db 40,80
	.db 68,80










	.db patrol_invalid_move_x
	.dw patrol_single_62

patrol_single_63:
	

	.db 4,16
	.db 4,144
	.db 72,144
	.db 72,16





	.db patrol_invalid_move_x
	.dw patrol_single_63


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Patrones para el multi;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;
;;Mapa 1 multi;;
;;;;;;;;;;;;;;;;
patrol_multi_11:
	.db 16, 80
	.db 20, 64
	.db 32, 80
	.db 40, 112	

	.db patrol_invalid_move_x
	.dw patrol_multi_11

patrol_multi_12:
	
	.db 56, 56	
	.db 44, 104
	.db 4, 104	
	.db 16, 16
	.db 28, 16	
	.db 44, 48
	.db patrol_invalid_move_x
	.dw patrol_multi_12

patrol_multi_13:
	
	.db 72,136	
	.db 48,48
	.db 44,48
	.db 48,48
	.db 48,136
	.db patrol_invalid_move_x
	.dw patrol_multi_13



;;;;;;;;;;;;;;;;
;;Mapa 1 multi;;
;;;;;;;;;;;;;;;;
patrol_multi_21:
	.db 12,40
	.db 68,120
	

	.db patrol_invalid_move_x
	.dw patrol_multi_21

patrol_multi_22:
	
	.db 36, 84
	.db 10, 32

	
	.db patrol_invalid_move_x
	.dw patrol_multi_22

patrol_multi_23:
	
	.db 72,120
	.db 36,120	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_23

;;;;;;;;;;;;;;;;
;;Mapa 3 multi;;
;;;;;;;;;;;;;;;;


patrol_multi_31:
	.db 36,80
	.db 8,120
	.db 32,80

	.db patrol_invalid_move_x
	.dw patrol_multi_31

patrol_multi_32:
	.db 40,80
	.db 72,72
	.db 72,128
	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_32

patrol_multi_33:
	.db 64,80
	.db 40,144
	.db 38,80
	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_33


;;;;;;;;;;;;;;;;
;;Mapa 4 multi;;
;;;;;;;;;;;;;;;;

patrol_multi_41:
	.db 24,96
	.db 40,144
	.db 56,112
	.db 40,144
	.db 24,144

	.db patrol_invalid_move_x
	.dw patrol_multi_41

patrol_multi_42:
	
	.db 62,80
	.db 56,16
	.db 20,48
	.db 4,16
	.db 20,16
	.db 44,48
	.db 48,16
	


	
	.db patrol_invalid_move_x
	.dw patrol_multi_42

patrol_multi_43:
	.db 54,144
	.db 34,112
	.db 28,144
	.db 48,112

	
	
	.db patrol_invalid_move_x
	.dw patrol_multi_43

;;;;;;;;;;;;;;;;
;;Mapa 5 multi;;
;;;;;;;;;;;;;;;;

patrol_multi_51:
	.db 20,16
	.db 32,144
	.db 40,72
	.db 32,72
	.db 20,144
	

	.db patrol_invalid_move_x
	.dw patrol_multi_51

patrol_multi_52:
	.db 56,144
	.db 44,16
	.db 40,72
	.db 44,72
	.db 56,16
	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_52

patrol_multi_53:
	
	.db 48,88
	.db 36,88
	.db 36,16
	.db 28,88

		

	
	.db patrol_invalid_move_x
	.dw patrol_multi_53

;;;;;;;;;;;;;;;;
;;Mapa 6 multi;;
;;;;;;;;;;;;;;;;


patrol_multi_61:
	.db 28,104
	.db 16,16
	.db 56,128
	.db 16,32
	.db 20,144

	

	.db patrol_invalid_move_x
	.dw patrol_multi_61

patrol_multi_62:
	.db 52,40
	.db 52,120
	.db 24,40
	.db 24,120
	
	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_62

patrol_multi_63:
	.db 48,104
	.db 72,144
	.db 44,144
	

	
	.db patrol_invalid_move_x
	.dw patrol_multi_63






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LLAMADAS PARA EL SINGLE;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

man_patrol_single_11_get::
	ld hl, #patrol_single_11
	ret
man_patrol_single_12_get::
	ld hl, #patrol_single_12
	ret
man_patrol_single_13_get::
	ld hl, #patrol_single_13
	ret
man_patrol_single_21_get::
	ld hl, #patrol_single_21
	ret
man_patrol_single_22_get::
	ld hl, #patrol_single_22
	ret
man_patrol_single_23_get::
	ld hl, #patrol_single_23
	ret
man_patrol_single_31_get::
	ld hl, #patrol_single_31
	ret
man_patrol_single_32_get::
	ld hl, #patrol_single_32
	ret
man_patrol_single_33_get::
	ld hl, #patrol_single_33
	ret
man_patrol_single_41_get::
	ld hl, #patrol_single_41
	ret
man_patrol_single_42_get::
	ld hl, #patrol_single_42
	ret
man_patrol_single_43_get::
	ld hl, #patrol_single_43
	ret
man_patrol_single_51_get::
	ld hl, #patrol_single_51
	ret
man_patrol_single_52_get::
	ld hl, #patrol_single_52
	ret
man_patrol_single_53_get::
	ld hl, #patrol_single_53
	ret
man_patrol_single_61_get::
	ld hl, #patrol_single_61
	ret
man_patrol_single_62_get::
	ld hl, #patrol_single_62
	ret
man_patrol_single_63_get::
	ld hl, #patrol_single_63
	ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LLAMADAS PARA EL MULTI;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_patrol_multi_11_get::
	ld hl, #patrol_multi_11
	ret

man_patrol_multi_12_get::
	ld hl, #patrol_multi_12
	ret

man_patrol_multi_13_get::
	ld hl, #patrol_multi_13
	ret


man_patrol_multi_21_get::
	ld hl, #patrol_multi_21
	ret

man_patrol_multi_22_get::
	ld hl, #patrol_multi_22
	ret

man_patrol_multi_23_get::
	ld hl, #patrol_multi_23
	ret


man_patrol_multi_31_get::
	ld hl, #patrol_multi_31
	ret

man_patrol_multi_32_get::
	ld hl, #patrol_multi_32
	ret

man_patrol_multi_33_get::
	ld hl, #patrol_multi_33
	ret


man_patrol_multi_41_get::
	ld hl, #patrol_multi_41
	ret

man_patrol_multi_42_get::
	ld hl, #patrol_multi_42
	ret

man_patrol_multi_43_get::
	ld hl, #patrol_multi_43
	ret

man_patrol_multi_51_get::
	ld hl, #patrol_multi_51
	ret

man_patrol_multi_52_get::
	ld hl, #patrol_multi_52
	ret

man_patrol_multi_53_get::
	ld hl, #patrol_multi_53
	ret

man_patrol_multi_61_get::
	ld hl, #patrol_multi_61
	ret

man_patrol_multi_62_get::
	ld hl, #patrol_multi_62
	ret

man_patrol_multi_63_get::
	ld hl, #patrol_multi_63
	ret