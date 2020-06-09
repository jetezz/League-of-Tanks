;;
;;sys_map_creator
;;

.include "mapas/mapa1.h.s"
.include "cpct_functions.h.s"
.include "assets.h.s"
.include "man/state_manager.h.s"
.include "man/st_game_over.h.s"
    

_puntero_mapa: .dw #00


draw_map::


;;Pintamos el mapa de manera inicial

   
    
    ;;Establecemos el tileset
   

    ld    c,  #_mapa1_W
    ld    b,  #_mapa1_H
    ld    de, #_mapa1_W
    ld    hl, #_tileset_00
    call cpct_etm_setDrawTilemap4x8_ag_asm
 
 


    ;;Pintamos el mapa inicialmente
  
     ld    hl, #0xC000
     ld    de, (_puntero_mapa)
     call cpct_etm_drawTilemap4x8_ag_asm

     ld    hl, #0x8000
     ld    de, (_puntero_mapa)
     call cpct_etm_drawTilemap4x8_ag_asm


   

ret




draw_map_sinhud::


;;Pintamos el mapa de manera inicial

   
    
    ;;Establecemos el tileset

    ;;Aqui se piinta con 3 tiles menos, los del hud
    ld    c,  #_mapa1_W
    ld    b,  #_mapa1_H
    dec b
    dec b
    dec b
    ld    de, #_mapa1_W
    ld    hl, #_tileset_00
    call cpct_etm_setDrawTilemap4x8_ag_asm
 
 


    ;;Pintamos el mapa inicialmente
  
     ld    hl, #0xC000
     ld    de, (_puntero_mapa)
     call cpct_etm_drawTilemap4x8_ag_asm

     ld    hl, #0x8000
     ld    de, (_puntero_mapa)
     call cpct_etm_drawTilemap4x8_ag_asm


   

ret


nivelActual: .db #00

reset_lvl::

  ld a, #00
  ld (nivelActual), a

ret
next_map::



call estado_game_over
dec a
jr z, draw_map


    ;;Sumar un nivel
    ld a, (nivelActual)
    inc a
    ld (nivelActual), a


    ld a, (_gamemode) 
    cp #5
    call z, next_map_singlep
    ld a, (_gamemode) 
    cp #5
    call z, draw_map
    ld a, (_gamemode) 
    cp #5
    ret z


    call next_map_multi
    call draw_map


ret


next_map_multi:

    ld a, (nivelActual)
    dec a
    call z, set_map1
        ret z
    dec a
    call z, set_map2
        ret z
    dec a
    call z, set_map3
        ret z
    dec a
    call z, set_map4
        ret z
    dec a
    call z, set_map5
        ret z
    dec a
    call z, set_map6
        ret z

ret

set_map1:
    ld hl, #_mapa1
    ld (_puntero_mapa), hl
ret
set_map2:
    ld hl, #_mapa2
    ld (_puntero_mapa), hl
ret
set_map3:
    ld hl, #_mapa3
    ld (_puntero_mapa), hl
ret
set_map4:
    ld hl, #_mapa4
    ld (_puntero_mapa), hl
ret
set_map5:
    ld hl, #_mapa5
    ld (_puntero_mapa), hl
ret
set_map6:
    ld hl, #_mapa6
    ld (_puntero_mapa), hl
ret
next_map_singlep:
    
    ld a, (nivelActual)
    dec a
    call z, set_single_map1
        ret z
    dec a
    call z, set_single_map2
        ret z
    dec a
    call z, set_single_map3
        ret z
    dec a
    call z, set_single_map4
        ret z
    dec a
    call z, set_single_map5
        ret z
    dec a
    call z, set_single_map6
        ret z

ret
set_single_map1:
    ld hl, #_single_mapa1
    ld (_puntero_mapa), hl
ret
set_single_map2:
    ld hl, #_single_mapa2
    ld (_puntero_mapa), hl
ret
set_single_map3:
    ld hl, #_single_mapa3
    ld (_puntero_mapa), hl
ret
set_single_map4:
    ld hl, #_single_mapa4
    ld (_puntero_mapa), hl
ret
set_single_map5:
    ld hl, #_single_mapa5
    ld (_puntero_mapa), hl
ret
set_single_map6:
    ld hl, #_single_mapa6
    ld (_puntero_mapa), hl
ret



