;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module bala
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bala_sp
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_bala_sp:
	.db #0x14	; 20
	.db #0x28	; 40
	.db #0x14	; 20
	.db #0x28	; 40
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x14	; 20
	.db #0x28	; 40
	.db #0x14	; 20
	.db #0x28	; 40
	.area _INITIALIZER
	.area _CABS (ABS)
