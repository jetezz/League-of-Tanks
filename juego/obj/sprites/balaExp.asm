;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module balaExp
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _balaExpl_sp_3
	.globl _balaExpl_sp_2
	.globl _balaExpl_sp_1
	.globl _balaExpl_sp_0
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
_balaExpl_sp_0:
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
_balaExpl_sp_1:
	.db #0x41	; 65	'A'
	.db #0x82	; 130
	.db #0x41	; 65	'A'
	.db #0x82	; 130
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x96	; 150
	.db #0x69	; 105	'i'
	.db #0x41	; 65	'A'
	.db #0x82	; 130
	.db #0x41	; 65	'A'
	.db #0x82	; 130
_balaExpl_sp_2:
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x6b	; 107	'k'
	.db #0x97	; 151
	.db #0x6b	; 107	'k'
	.db #0x97	; 151
	.db #0x6b	; 107	'k'
	.db #0x97	; 151
	.db #0x6b	; 107	'k'
	.db #0x97	; 151
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x15	; 21
	.db #0x2a	; 42
_balaExpl_sp_3:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)