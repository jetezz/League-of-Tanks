;;
;;sys_menu
;;

.include "cpct_functions.h.s"
.include "sys/render_system.h.s"
.include "../man/manager_buffer.h.s"
.include "sys_menu.h.s"
.include "assets.h.s"
.include "../man/state_manager.h.s"
.include "../sys/sys_map_creator.h.s"
.include "sys/sys_interrup_music.h.s"
.include "sys/sys_a.h.s"
   

first_time: .db #01

zerostate_init::

   ld a, (first_time)
   dec a
   call nz, map_firstBuffer
   ld a, #00
   ld (first_time), a

   
    ld hl, #0x8000  ;; limpiar fireware
    ld de, #0x8001
    ld (hl), #0x00
    ld bc, #0x8000
    ldir


   call stopmusic
   call cancion4
   call limpiar_animaciones

   

   ld de, #0XC000
   ld    b, #5                 ;; B = y coordinate (24 = 0x18)
   ld    c, #10           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_plant_sp
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm






   call pintar_tituloenter

   textoNegro

   call print_tanks
   call print_selected_green

   textoNegro
  

ret

pintar_tituloenter:


;; call rendersys_init

    ;; Set up draw char colours before calling draw string
   ld    h, #0         ;; D = Background PEN (0)
   ld    l, #14         ;; E = Foreground PEN (3)

   call cpct_setDrawCharM0_asm   ;; Set draw char colours


   ;; Calculate a video-memory location for printing a string
   ld de, #0XC000
   ld    b, #15                  ;; B = y coordinate (24 = 0x18)
   ld    c, #10                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

   ;; Print the string in video memory
   ;; HL already points to video memory, as it is the return
   ;; value from cpct_getScreenPtr_asm
   
   ld iy, #title    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

    ;; Set up draw char colours before calling draw string
   ld    h, #0         ;; D = Background PEN (0)
   ld    l, #6         ;; E = Foreground PEN (3)

   call cpct_setDrawCharM0_asm   ;; Set draw char colours


   ;; Calculate a video-memory location for printing a string
   ld de, #0XC000
   ld    b, #40                  ;; B = y coordinate (24 = 0x18)
   ld    c, #03                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

   ;; Print the string in video memory
   ;; HL already points to video memory, as it is the return
   ;; value from cpct_getScreenPtr_asm
   
   ld iy, #enter    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string


ret






print_tanks:


   call print_singlePlayertank
   call print1playertanks
   call print2playertanks
   call print3playertanks
   call print4playertanks


ret

print_singlePlayer:

   ld de, #0XC000
   ld    b, #65                  ;; B = y coordinate (24 = 0x18)
   ld    c, #15                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 


   ld iy, #Single_player    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret

print_singlePlayertank:

;;Pintar TANKE SINGLE PLAYER;;
   ld de, #0XC000
   ld    b, #80                 ;; B = y coordinate (24 = 0x18)
   ld    c, #38           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_cannons_sp_02
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm

ret

printbattleroyale:
 ;; Calculate a video-memory location for printing a string
   ld de, #0XC000
   ld    b, #105                  ;; B = y coordinate (24 = 0x18)
   ld    c, #15                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

   ;; Print the string in video memory
   ;; HL already points to video memory, as it is the return
   ;; value from cpct_getScreenPtr_asm
   
   ld iy, #battle_royale    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret

print1player:

   ;;Pintar "1 Player"
   ld de, #0XC000
   ld    b, #123                 ;; B = y coordinate (24 = 0x18)
   ld    c, #2                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld iy, #one_player    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret

print1playertanks:

      ;;Pintar JUGADOR 1;;
   ld de, #0XC000
   ld    b, #135                 ;; B = y coordinate (24 = 0x18)
   ld    c, #18           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_cannons_sp_02
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm


ret


print2player:

   ;;Pintar "2 Players"
   ld de, #0XC000
   ld    b, #123                 ;; B = y coordinate (24 = 0x18)
   ld    c, #42                 ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld iy, #two_players    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret

print2playertanks:


      ;;Pintar tankes jugador 2;;
      ld de, #0XC000
      ld    b, #135                 ;; B = y coordinate (24 = 0x18)
      ld    c, #55           
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_02
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm

      ld de, #0XC000
      ld    b, #135                 ;; B = y coordinate (24 = 0x18)
      ld    c, #60           
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_07
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm


ret





print3player:

  ;;Pintar "3 Player"
   ld de, #0XC000
   ld    b, #160                 ;; B = y coordinate (24 = 0x18)
   ld    c, #2                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld iy, #tres_players    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret

print3playertanks:

   ;;Pintar 1 tankes
   ld de, #0XC000
   ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   ld    c, #13           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_cannons_sp_02
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm

   ;;Pintar segundo tanke
   ld de, #0XC000
   ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   ld    c, #18           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_cannons_sp_07
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm

   ;;Pintar tercer tanke
   ld de, #0XC000
   ld    b, #170                 ;; B = y coordinate (24 = 0x18)
   ld    c, #23           
   call cpct_getScreenPtr_asm

   ex   de, hl
   ld hl,#_cannons_sp_12
   ld c, #04  ;;ancho
   ld b, #16  ;;alto
   call cpct_drawSprite_asm

ret


print4player:

   ;;Pintar "2 Players"
   ld de, #0XC000
   ld    b, #160                 ;; B = y coordinate (24 = 0x18)
   ld    c, #42                 ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld iy, #cuatro_players    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

ret


print4playertanks:


      ;;Pintar tankes jugador 4;;
      ld de, #0XC000
      ld    b, #170                 ;; B = y coordinate (24 = 0x18)
      ld    c, #50           
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_02
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm
      ;;Segundo tanke
      ld de, #0XC000
      ld    b, #170                 ;; B = y coordinate (24 = 0x18)
      ld    c, #55           
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_07
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm
        ;;Tercer tanke
      ld de, #0XC000
      ld    b, #170                 ;; B = y coordinate (24 = 0x18)
      ld    c, #60           
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_12
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm
        ;;Cuarto tanke
      ld de, #0XC000
      ld    b, #170                 ;; B = y coordinate (24 = 0x18)
      ld    c, #65          
      call cpct_getScreenPtr_asm

      ex   de, hl
      ld hl,#_cannons_sp_17
      ld c, #04  ;;ancho
      ld b, #16  ;;alto
      call cpct_drawSprite_asm

ret



print_selected_green::

   call pintarSelecciones

   textoVerde
   
   ;;Cambiamos el color de lo que pintaremos
   ld a, (_gamemode)
   dec a ;;Gamemode es 1, es decir 1 jugador contra ia battle royale
   call z, print1player
   call z, printbattleroyale
   ret z

   dec a ;;Gamemode es 2, es decir 2 jugador contra ia battle royale
   call z, print2player
   call z, printbattleroyale
   ret z

   dec a ;;Gamemode es 3, es decir 3 jugador contra ia battle royale
   call z, print3player
   call z, printbattleroyale
   ret z


   dec a ;;Gamemode es 4, es decir 4 jugador contra ia battle royale
   call z, print4player
   call z, printbattleroyale
   ret z

   dec a ;;Gamemode es 5, es decir singleplayer
   call z, print_singlePlayer
   ret z


ret




pintarSelecciones:

   ld    h, #00         ;; D = Background PEN (0)
   ld    l, #01        ;; E = Foreground PEN (3)

   call cpct_setDrawCharM0_asm   ;; Set draw char colours

call print_singlePlayer
call printbattleroyale
call print1player
call print2player
call print3player
call print4player



ret











