;;
;;sys_patrol
;;
.include "../man/entity_manager.h.s"
.include "../man/patrol_manager.h.s"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;PATRONES PARA EL SINGLE PLAYER;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;
;;MAPA 1 single;;;
;;;;;;;;;;;;;;;;;;


patrol_nivel_single1::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_11_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_12_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_13_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret
;;;;;;;;;;;;;;;;;;
;;MAPA 2 single;;;
;;;;;;;;;;;;;;;;;;


patrol_nivel_single2::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_21_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_22_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_23_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret
;;;;;;;;;;;;;;;;;;
;;MAPA 3 single;;;
;;;;;;;;;;;;;;;;;;


patrol_nivel_single3::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_31_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_32_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_33_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret

;;;;;;;;;;;;;;;;;;
;;MAPA 4 single;;;
;;;;;;;;;;;;;;;;;;


patrol_nivel_single4::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_41_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_42_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_43_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret
;;;;;;;;;;;;;;;;;;
;;MAPA 5 single;;;
;;;;;;;;;;;;;;;;;;


patrol_nivel_single5::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_51_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_52_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_53_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret
;;;;;;;;;;;;;;;;;;
;;MAPA 6 single;;;
;;;;;;;;;;;;;;;;;;



patrol_nivel_single6::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_single_61_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_62_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_single_63_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret



















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;PATRONES PARA EL SINGLE PLAYER;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;;MAPA 1 MULTI;;;
;;;;;;;;;;;;;;;;;
patrol_nivel_multi1::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_11_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_12_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_13_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret

;;;;;;;;;;;;;;;;;
;;MAPA 2 MULTI;;;
;;;;;;;;;;;;;;;;;
patrol_nivel_multi2::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_21_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_22_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_23_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret

;;;;;;;;;;;;;;;;;
;;MAPA 3 MULTI;;;
;;;;;;;;;;;;;;;;;

patrol_nivel_multi3::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_31_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_32_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_33_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret





;;;;;;;;;;;;;;;;;
;;MAPA 4 MULTI;;;
;;;;;;;;;;;;;;;;;

patrol_nivel_multi4::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_41_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_42_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_43_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret






;;;;;;;;;;;;;;;;;
;;MAPA 5 MULTI;;;
;;;;;;;;;;;;;;;;;




patrol_nivel_multi5::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_51_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_52_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_53_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret




;;;;;;;;;;;;;;;;;
;;MAPA 6 MULTI;;;
;;;;;;;;;;;;;;;;;


patrol_nivel_multi6::
call entityman_getEntityVector_IX

ld de, #siceof_e
add ix, de

call man_patrol_multi_61_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_62_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l
add ix, de

call man_patrol_multi_63_get
ld e_ia_puntero_patrol_h(ix), h
ld e_ia_puntero_patrol_l(ix), l

ret