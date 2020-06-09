ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Patrol manager 
                              3 ;; 
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "man/patrol_manager.h.s"
                              1 ;;
                              2 ;;Patrol manager h
                              3 ;;
                              4 
                              5 ;;
                     FFFFFFFF     6 patrol_invalid_move_x =-1
                              7 
                              8 .globl man_patrol_single_11_get
                              9 .globl man_patrol_single_12_get
                             10 .globl man_patrol_single_13_get
                             11 .globl man_patrol_single_21_get
                             12 .globl man_patrol_single_22_get
                             13 .globl man_patrol_single_23_get
                             14 .globl man_patrol_single_31_get
                             15 .globl man_patrol_single_32_get
                             16 .globl man_patrol_single_33_get
                             17 .globl man_patrol_single_41_get
                             18 .globl man_patrol_single_42_get
                             19 .globl man_patrol_single_43_get
                             20 .globl man_patrol_single_51_get
                             21 .globl man_patrol_single_52_get
                             22 .globl man_patrol_single_53_get
                             23 .globl man_patrol_single_61_get
                             24 .globl man_patrol_single_62_get
                             25 .globl man_patrol_single_63_get
                             26 
                             27 .globl man_patrol_multi_11_get
                             28 .globl man_patrol_multi_12_get
                             29 .globl man_patrol_multi_13_get
                             30 .globl man_patrol_multi_21_get
                             31 .globl man_patrol_multi_22_get
                             32 .globl man_patrol_multi_23_get
                             33 .globl man_patrol_multi_31_get
                             34 .globl man_patrol_multi_32_get
                             35 .globl man_patrol_multi_33_get
                             36 .globl man_patrol_multi_41_get
                             37 .globl man_patrol_multi_42_get
                             38 .globl man_patrol_multi_43_get
                             39 .globl man_patrol_multi_51_get
                             40 .globl man_patrol_multi_52_get
                             41 .globl man_patrol_multi_53_get
                             42 .globl man_patrol_multi_61_get
                             43 .globl man_patrol_multi_62_get
                             44 .globl man_patrol_multi_63_get
                             45 
                             46 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 
                              7 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              8 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              9 ;;;Patrones para el single;;;
                             10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             11 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             12 
                             13 ;;;;;;;;;;;;;;;;;
                             14 ;;Mapa 1 single;;
                             15 ;;;;;;;;;;;;;;;;;
   3FB0                      16 patrol_single_11:
                             17 	
                             18 
   3FB0 FF                   19 	.db patrol_invalid_move_x
   3FB1 B0 3F                20 	.dw patrol_single_11
                             21 
   3FB3                      22 patrol_single_12:
                             23 	
                             24 
   3FB3 FF                   25 	.db patrol_invalid_move_x
   3FB4 B3 3F                26 	.dw patrol_single_12
                             27 
   3FB6                      28 patrol_single_13:
   3FB6 40 30                29 	.db 64, 48
   3FB8 40 70                30 	.db 64, 112
   3FBA 48 50                31 	.db 72, 80
   3FBC 44 50                32 	.db 68, 80
   3FBE 48 50                33 	.db 72, 80
   3FC0 FF                   34 	.db patrol_invalid_move_x
   3FC1 B6 3F                35 	.dw patrol_single_13
                             36 ;;;;;;;;;;;;;;;;;
                             37 ;;Mapa 2 single;;
                             38 ;;;;;;;;;;;;;;;;;
                             39 
                             40 
                             41 
   3FC3                      42 patrol_single_21:
                             43 	
                             44 	
   3FC3 38 40                45 	.db 56, 64	
   3FC5 28 40                46 	.db 40, 64	
   3FC7 1C 58                47 	.db 28, 88
   3FC9 14 40                48 	.db 20, 64
   3FCB 04 58                49 	.db 4, 88
   3FCD 20 40                50 	.db 32, 64
   3FCF 2C 58                51 	.db 44, 88
                             52 	
                             53 
                             54 
                             55 
   3FD1 FF                   56 	.db patrol_invalid_move_x
   3FD2 C3 3F                57 	.dw patrol_single_21
                             58 
   3FD4                      59 patrol_single_22:
                             60 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             61 
   3FD4 FF                   62 	.db patrol_invalid_move_x
   3FD5 D4 3F                63 	.dw patrol_single_22
                             64 
   3FD7                      65 patrol_single_23:
   3FD7 08 90                66 	.db 8,144
   3FD9 18 90                67 	.db 24,144
   3FDB 24 78                68 	.db 36,120
   3FDD 30 90                69 	.db 48,144
   3FDF 3C 78                70 	.db 60,120
   3FE1 2C 78                71 	.db 44,120
   3FE3 20 90                72 	.db 32,144
   3FE5 14 78                73 	.db 20,120
                             74 
                             75 
                             76 
                             77 
                             78 
                             79 
                             80 
                             81 
   3FE7 FF                   82 	.db patrol_invalid_move_x
   3FE8 D7 3F                83 	.dw patrol_single_23
                             84 ;;;;;;;;;;;;;;;;;
                             85 ;;Mapa 3 single;;
                             86 ;;;;;;;;;;;;;;;;;
                             87 
   3FEA                      88 patrol_single_31:
                             89 	
   3FEA 0C 20                90 	.db 12,32
   3FEC 40 20                91 	.db 64,32
   3FEE 40 80                92 	.db 64,128	
   3FF0 0C 80                93 	.db 12,128
                             94 
                             95 
                             96 
   3FF2 FF                   97 	.db patrol_invalid_move_x
   3FF3 EA 3F                98 	.dw patrol_single_31
                             99 
   3FF5                     100 patrol_single_32:
   3FF5 44 90               101 	.db 68,144	
   3FF7 08 10               102 	.db 8,16
   3FF9 44 10               103 	.db 68,16
   3FFB 24 10               104 	.db 36,16
   3FFD 24 48               105 	.db 36,72
   3FFF 2C 48               106 	.db 44,72
   4001 24 48               107 	.db 36,72
   4003 24 90               108 	.db 36,144
   4005 44 90               109 	.db 68,144	
   4007 08 90               110 	.db 8,144
                            111 
   4009 FF                  112 	.db patrol_invalid_move_x
   400A F5 3F               113 	.dw patrol_single_32
                            114 
   400C                     115 patrol_single_33:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            116 
   400C 26 10               117 	.db 38,16
   400E 26 90               118 	.db 38,144
                            119 
                            120 
   4010 FF                  121 	.db patrol_invalid_move_x
   4011 0C 40               122 	.dw patrol_single_33
                            123 ;;;;;;;;;;;;;;;;;
                            124 ;;Mapa 4 single;;
                            125 ;;;;;;;;;;;;;;;;;
                            126 
   4013                     127 patrol_single_41:
   4013 34 20               128 	.db 52,32
   4015 34 80               129 	.db 52,128
   4017 3C 80               130 	.db 60,128
   4019 48 50               131 	.db 72,80
                            132 
                            133 
                            134 
                            135 
                            136 
   401B FF                  137 	.db patrol_invalid_move_x
   401C 13 40               138 	.dw patrol_single_41
                            139 
   401E                     140 patrol_single_42:
                            141 	
                            142 
   401E 14 40               143 	.db 20,64
   4020 14 60               144 	.db 20,96
                            145 	
                            146 
   4022 FF                  147 	.db patrol_invalid_move_x
   4023 1E 40               148 	.dw patrol_single_42
                            149 
   4025                     150 patrol_single_43:
                            151 
   4025 30 50               152 	.db 48,80	
   4027 30 18               153 	.db 48,24
   4029 1C 18               154 	.db 28,24
   402B 1C 50               155 	.db 28,80
   402D 30 50               156 	.db 48,80
   402F 30 88               157 	.db 48,136
   4031 1C 88               158 	.db 28,136
   4033 1C 50               159 	.db 28,80
                            160 
                            161 
                            162 
                            163 
                            164 
                            165 
   4035 FF                  166 	.db patrol_invalid_move_x
   4036 25 40               167 	.dw patrol_single_43
                            168 ;;;;;;;;;;;;;;;;;
                            169 ;;Mapa 5 single;;
                            170 ;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            171 
   4038                     172 patrol_single_51:
                            173 	
   4038 16 50               174 	.db 22,80
   403A 16 70               175 	.db 22,112	
   403C 04 50               176 	.db 4,80
   403E 04 40               177 	.db 4,64
   4040 16 40               178 	.db 22,64
   4042 16 70               179 	.db 22,112
   4044 16 40               180 	.db 22,64
   4046 48 40               181 	.db 72,64
   4048 48 50               182 	.db 72,80
   404A 16 50               183 	.db 22,80
   404C 16 70               184 	.db 22,112
                            185 
                            186 
                            187 
                            188 
                            189 
                            190 
                            191 
                            192 
                            193 
   404E FF                  194 	.db patrol_invalid_move_x
   404F 38 40               195 	.dw patrol_single_51
                            196 
   4051                     197 patrol_single_52:
                            198 	
   4051 26 30               199 	.db 38,48
   4053 26 70               200 	.db 38,112
   4055 26 30               201 	.db 38,48
   4057 04 30               202 	.db 4,48
   4059 26 30               203 	.db 38,48
   405B 26 70               204 	.db 38,112
   405D 26 30               205 	.db 38,48	
   405F 48 30               206 	.db 72,48
                            207 
                            208 
                            209 
                            210 
                            211 
                            212 
                            213 
   4061 FF                  214 	.db patrol_invalid_move_x
   4062 51 40               215 	.dw patrol_single_52
                            216 
   4064                     217 patrol_single_53:
                            218 	
   4064 36 10               219 	.db 54,16
   4066 36 70               220 	.db 54,112
   4068 36 10               221 	.db 54,16
   406A 04 10               222 	.db 4,16
   406C 04 20               223 	.db 4,32
   406E 36 20               224 	.db 54,32
   4070 36 70               225 	.db 54,112
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4072 36 20               226 	.db 54,32
   4074 48 20               227 	.db 72,32
   4076 48 10               228 	.db 72,16
                            229 
                            230 
                            231 
                            232 
                            233 
                            234 
                            235 
                            236 
                            237 
                            238 
                            239 
   4078 FF                  240 	.db patrol_invalid_move_x
   4079 64 40               241 	.dw patrol_single_53
                            242 ;;;;;;;;;;;;;;;;;
                            243 ;;Mapa 6 single;;
                            244 ;;;;;;;;;;;;;;;;;
                            245 
   407B                     246 patrol_single_61:
                            247 	
                            248 
   407B 24 18               249 	.db 36,24
   407D 08 18               250 	.db 8,24
   407F 08 88               251 	.db 8,136
   4081 24 88               252 	.db 36,136
                            253 
                            254 
                            255 
                            256 
                            257 
                            258 
   4083 FF                  259 	.db patrol_invalid_move_x
   4084 7B 40               260 	.dw patrol_single_61
                            261 
   4086                     262 patrol_single_62:
                            263 		
                            264 
   4086 44 18               265 	.db 68,24
   4088 28 18               266 	.db 40,24
   408A 28 50               267 	.db 40,80
   408C 44 50               268 	.db 68,80
   408E 44 88               269 	.db 68,136
   4090 28 88               270 	.db 40,136
   4092 28 50               271 	.db 40,80
   4094 44 50               272 	.db 68,80
                            273 
                            274 
                            275 
                            276 
                            277 
                            278 
                            279 
                            280 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            281 
                            282 
   4096 FF                  283 	.db patrol_invalid_move_x
   4097 86 40               284 	.dw patrol_single_62
                            285 
   4099                     286 patrol_single_63:
                            287 	
                            288 
   4099 04 10               289 	.db 4,16
   409B 04 90               290 	.db 4,144
   409D 48 90               291 	.db 72,144
   409F 48 10               292 	.db 72,16
                            293 
                            294 
                            295 
                            296 
                            297 
   40A1 FF                  298 	.db patrol_invalid_move_x
   40A2 99 40               299 	.dw patrol_single_63
                            300 
                            301 
                            302 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            303 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            304 ;;;Patrones para el multi;;;;
                            305 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            306 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            307 
                            308 
                            309 ;;;;;;;;;;;;;;;;
                            310 ;;Mapa 1 multi;;
                            311 ;;;;;;;;;;;;;;;;
   40A4                     312 patrol_multi_11:
   40A4 10 50               313 	.db 16, 80
   40A6 14 40               314 	.db 20, 64
   40A8 20 50               315 	.db 32, 80
   40AA 28 70               316 	.db 40, 112	
                            317 
   40AC FF                  318 	.db patrol_invalid_move_x
   40AD A4 40               319 	.dw patrol_multi_11
                            320 
   40AF                     321 patrol_multi_12:
                            322 	
   40AF 38 38               323 	.db 56, 56	
   40B1 2C 68               324 	.db 44, 104
   40B3 04 68               325 	.db 4, 104	
   40B5 10 10               326 	.db 16, 16
   40B7 1C 10               327 	.db 28, 16	
   40B9 2C 30               328 	.db 44, 48
   40BB FF                  329 	.db patrol_invalid_move_x
   40BC AF 40               330 	.dw patrol_multi_12
                            331 
   40BE                     332 patrol_multi_13:
                            333 	
   40BE 48 88               334 	.db 72,136	
   40C0 30 30               335 	.db 48,48
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   40C2 2C 30               336 	.db 44,48
   40C4 30 30               337 	.db 48,48
   40C6 30 88               338 	.db 48,136
   40C8 FF                  339 	.db patrol_invalid_move_x
   40C9 BE 40               340 	.dw patrol_multi_13
                            341 
                            342 
                            343 
                            344 ;;;;;;;;;;;;;;;;
                            345 ;;Mapa 1 multi;;
                            346 ;;;;;;;;;;;;;;;;
   40CB                     347 patrol_multi_21:
   40CB 0C 28               348 	.db 12,40
   40CD 44 78               349 	.db 68,120
                            350 	
                            351 
   40CF FF                  352 	.db patrol_invalid_move_x
   40D0 CB 40               353 	.dw patrol_multi_21
                            354 
   40D2                     355 patrol_multi_22:
                            356 	
   40D2 24 54               357 	.db 36, 84
   40D4 0A 20               358 	.db 10, 32
                            359 
                            360 	
   40D6 FF                  361 	.db patrol_invalid_move_x
   40D7 D2 40               362 	.dw patrol_multi_22
                            363 
   40D9                     364 patrol_multi_23:
                            365 	
   40D9 48 78               366 	.db 72,120
   40DB 24 78               367 	.db 36,120	
                            368 
                            369 	
   40DD FF                  370 	.db patrol_invalid_move_x
   40DE D9 40               371 	.dw patrol_multi_23
                            372 
                            373 ;;;;;;;;;;;;;;;;
                            374 ;;Mapa 3 multi;;
                            375 ;;;;;;;;;;;;;;;;
                            376 
                            377 
   40E0                     378 patrol_multi_31:
   40E0 24 50               379 	.db 36,80
   40E2 08 78               380 	.db 8,120
   40E4 20 50               381 	.db 32,80
                            382 
   40E6 FF                  383 	.db patrol_invalid_move_x
   40E7 E0 40               384 	.dw patrol_multi_31
                            385 
   40E9                     386 patrol_multi_32:
   40E9 28 50               387 	.db 40,80
   40EB 48 48               388 	.db 72,72
   40ED 48 80               389 	.db 72,128
                            390 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            391 
                            392 	
   40EF FF                  393 	.db patrol_invalid_move_x
   40F0 E9 40               394 	.dw patrol_multi_32
                            395 
   40F2                     396 patrol_multi_33:
   40F2 40 50               397 	.db 64,80
   40F4 28 90               398 	.db 40,144
   40F6 26 50               399 	.db 38,80
                            400 	
                            401 
                            402 	
   40F8 FF                  403 	.db patrol_invalid_move_x
   40F9 F2 40               404 	.dw patrol_multi_33
                            405 
                            406 
                            407 ;;;;;;;;;;;;;;;;
                            408 ;;Mapa 4 multi;;
                            409 ;;;;;;;;;;;;;;;;
                            410 
   40FB                     411 patrol_multi_41:
   40FB 18 60               412 	.db 24,96
   40FD 28 90               413 	.db 40,144
   40FF 38 70               414 	.db 56,112
   4101 28 90               415 	.db 40,144
   4103 18 90               416 	.db 24,144
                            417 
   4105 FF                  418 	.db patrol_invalid_move_x
   4106 FB 40               419 	.dw patrol_multi_41
                            420 
   4108                     421 patrol_multi_42:
                            422 	
   4108 3E 50               423 	.db 62,80
   410A 38 10               424 	.db 56,16
   410C 14 30               425 	.db 20,48
   410E 04 10               426 	.db 4,16
   4110 14 10               427 	.db 20,16
   4112 2C 30               428 	.db 44,48
   4114 30 10               429 	.db 48,16
                            430 	
                            431 
                            432 
                            433 	
   4116 FF                  434 	.db patrol_invalid_move_x
   4117 08 41               435 	.dw patrol_multi_42
                            436 
   4119                     437 patrol_multi_43:
   4119 36 90               438 	.db 54,144
   411B 22 70               439 	.db 34,112
   411D 1C 90               440 	.db 28,144
   411F 30 70               441 	.db 48,112
                            442 
                            443 	
                            444 	
   4121 FF                  445 	.db patrol_invalid_move_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4122 19 41               446 	.dw patrol_multi_43
                            447 
                            448 ;;;;;;;;;;;;;;;;
                            449 ;;Mapa 5 multi;;
                            450 ;;;;;;;;;;;;;;;;
                            451 
   4124                     452 patrol_multi_51:
   4124 14 10               453 	.db 20,16
   4126 20 90               454 	.db 32,144
   4128 28 48               455 	.db 40,72
   412A 20 48               456 	.db 32,72
   412C 14 90               457 	.db 20,144
                            458 	
                            459 
   412E FF                  460 	.db patrol_invalid_move_x
   412F 24 41               461 	.dw patrol_multi_51
                            462 
   4131                     463 patrol_multi_52:
   4131 38 90               464 	.db 56,144
   4133 2C 10               465 	.db 44,16
   4135 28 48               466 	.db 40,72
   4137 2C 48               467 	.db 44,72
   4139 38 10               468 	.db 56,16
                            469 	
                            470 
                            471 	
   413B FF                  472 	.db patrol_invalid_move_x
   413C 31 41               473 	.dw patrol_multi_52
                            474 
   413E                     475 patrol_multi_53:
                            476 	
   413E 30 58               477 	.db 48,88
   4140 24 58               478 	.db 36,88
   4142 24 10               479 	.db 36,16
   4144 1C 58               480 	.db 28,88
                            481 
                            482 		
                            483 
                            484 	
   4146 FF                  485 	.db patrol_invalid_move_x
   4147 3E 41               486 	.dw patrol_multi_53
                            487 
                            488 ;;;;;;;;;;;;;;;;
                            489 ;;Mapa 6 multi;;
                            490 ;;;;;;;;;;;;;;;;
                            491 
                            492 
   4149                     493 patrol_multi_61:
   4149 1C 68               494 	.db 28,104
   414B 10 10               495 	.db 16,16
   414D 38 80               496 	.db 56,128
   414F 10 20               497 	.db 16,32
   4151 14 90               498 	.db 20,144
                            499 
                            500 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            501 
   4153 FF                  502 	.db patrol_invalid_move_x
   4154 49 41               503 	.dw patrol_multi_61
                            504 
   4156                     505 patrol_multi_62:
   4156 34 28               506 	.db 52,40
   4158 34 78               507 	.db 52,120
   415A 18 28               508 	.db 24,40
   415C 18 78               509 	.db 24,120
                            510 	
                            511 	
                            512 
                            513 	
   415E FF                  514 	.db patrol_invalid_move_x
   415F 56 41               515 	.dw patrol_multi_62
                            516 
   4161                     517 patrol_multi_63:
   4161 30 68               518 	.db 48,104
   4163 48 90               519 	.db 72,144
   4165 2C 90               520 	.db 44,144
                            521 	
                            522 
                            523 	
   4167 FF                  524 	.db patrol_invalid_move_x
   4168 61 41               525 	.dw patrol_multi_63
                            526 
                            527 
                            528 
                            529 
                            530 
                            531 
                            532 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            533 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            534 ;; LLAMADAS PARA EL SINGLE;;;
                            535 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            536 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            537 
   416A                     538 man_patrol_single_11_get::
   416A 21 B0 3F      [10]  539 	ld hl, #patrol_single_11
   416D C9            [10]  540 	ret
   416E                     541 man_patrol_single_12_get::
   416E 21 B3 3F      [10]  542 	ld hl, #patrol_single_12
   4171 C9            [10]  543 	ret
   4172                     544 man_patrol_single_13_get::
   4172 21 B6 3F      [10]  545 	ld hl, #patrol_single_13
   4175 C9            [10]  546 	ret
   4176                     547 man_patrol_single_21_get::
   4176 21 C3 3F      [10]  548 	ld hl, #patrol_single_21
   4179 C9            [10]  549 	ret
   417A                     550 man_patrol_single_22_get::
   417A 21 D4 3F      [10]  551 	ld hl, #patrol_single_22
   417D C9            [10]  552 	ret
   417E                     553 man_patrol_single_23_get::
   417E 21 D7 3F      [10]  554 	ld hl, #patrol_single_23
   4181 C9            [10]  555 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   4182                     556 man_patrol_single_31_get::
   4182 21 EA 3F      [10]  557 	ld hl, #patrol_single_31
   4185 C9            [10]  558 	ret
   4186                     559 man_patrol_single_32_get::
   4186 21 F5 3F      [10]  560 	ld hl, #patrol_single_32
   4189 C9            [10]  561 	ret
   418A                     562 man_patrol_single_33_get::
   418A 21 0C 40      [10]  563 	ld hl, #patrol_single_33
   418D C9            [10]  564 	ret
   418E                     565 man_patrol_single_41_get::
   418E 21 13 40      [10]  566 	ld hl, #patrol_single_41
   4191 C9            [10]  567 	ret
   4192                     568 man_patrol_single_42_get::
   4192 21 1E 40      [10]  569 	ld hl, #patrol_single_42
   4195 C9            [10]  570 	ret
   4196                     571 man_patrol_single_43_get::
   4196 21 25 40      [10]  572 	ld hl, #patrol_single_43
   4199 C9            [10]  573 	ret
   419A                     574 man_patrol_single_51_get::
   419A 21 38 40      [10]  575 	ld hl, #patrol_single_51
   419D C9            [10]  576 	ret
   419E                     577 man_patrol_single_52_get::
   419E 21 51 40      [10]  578 	ld hl, #patrol_single_52
   41A1 C9            [10]  579 	ret
   41A2                     580 man_patrol_single_53_get::
   41A2 21 64 40      [10]  581 	ld hl, #patrol_single_53
   41A5 C9            [10]  582 	ret
   41A6                     583 man_patrol_single_61_get::
   41A6 21 7B 40      [10]  584 	ld hl, #patrol_single_61
   41A9 C9            [10]  585 	ret
   41AA                     586 man_patrol_single_62_get::
   41AA 21 86 40      [10]  587 	ld hl, #patrol_single_62
   41AD C9            [10]  588 	ret
   41AE                     589 man_patrol_single_63_get::
   41AE 21 99 40      [10]  590 	ld hl, #patrol_single_63
   41B1 C9            [10]  591 	ret
                            592 
                            593 
                            594 
                            595 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            596 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            597 ;; LLAMADAS PARA EL MULTI;;;;
                            598 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            599 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   41B2                     600 man_patrol_multi_11_get::
   41B2 21 A4 40      [10]  601 	ld hl, #patrol_multi_11
   41B5 C9            [10]  602 	ret
                            603 
   41B6                     604 man_patrol_multi_12_get::
   41B6 21 AF 40      [10]  605 	ld hl, #patrol_multi_12
   41B9 C9            [10]  606 	ret
                            607 
   41BA                     608 man_patrol_multi_13_get::
   41BA 21 BE 40      [10]  609 	ld hl, #patrol_multi_13
   41BD C9            [10]  610 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            611 
                            612 
   41BE                     613 man_patrol_multi_21_get::
   41BE 21 CB 40      [10]  614 	ld hl, #patrol_multi_21
   41C1 C9            [10]  615 	ret
                            616 
   41C2                     617 man_patrol_multi_22_get::
   41C2 21 D2 40      [10]  618 	ld hl, #patrol_multi_22
   41C5 C9            [10]  619 	ret
                            620 
   41C6                     621 man_patrol_multi_23_get::
   41C6 21 D9 40      [10]  622 	ld hl, #patrol_multi_23
   41C9 C9            [10]  623 	ret
                            624 
                            625 
   41CA                     626 man_patrol_multi_31_get::
   41CA 21 E0 40      [10]  627 	ld hl, #patrol_multi_31
   41CD C9            [10]  628 	ret
                            629 
   41CE                     630 man_patrol_multi_32_get::
   41CE 21 E9 40      [10]  631 	ld hl, #patrol_multi_32
   41D1 C9            [10]  632 	ret
                            633 
   41D2                     634 man_patrol_multi_33_get::
   41D2 21 F2 40      [10]  635 	ld hl, #patrol_multi_33
   41D5 C9            [10]  636 	ret
                            637 
                            638 
   41D6                     639 man_patrol_multi_41_get::
   41D6 21 FB 40      [10]  640 	ld hl, #patrol_multi_41
   41D9 C9            [10]  641 	ret
                            642 
   41DA                     643 man_patrol_multi_42_get::
   41DA 21 08 41      [10]  644 	ld hl, #patrol_multi_42
   41DD C9            [10]  645 	ret
                            646 
   41DE                     647 man_patrol_multi_43_get::
   41DE 21 19 41      [10]  648 	ld hl, #patrol_multi_43
   41E1 C9            [10]  649 	ret
                            650 
   41E2                     651 man_patrol_multi_51_get::
   41E2 21 24 41      [10]  652 	ld hl, #patrol_multi_51
   41E5 C9            [10]  653 	ret
                            654 
   41E6                     655 man_patrol_multi_52_get::
   41E6 21 31 41      [10]  656 	ld hl, #patrol_multi_52
   41E9 C9            [10]  657 	ret
                            658 
   41EA                     659 man_patrol_multi_53_get::
   41EA 21 3E 41      [10]  660 	ld hl, #patrol_multi_53
   41ED C9            [10]  661 	ret
                            662 
   41EE                     663 man_patrol_multi_61_get::
   41EE 21 49 41      [10]  664 	ld hl, #patrol_multi_61
   41F1 C9            [10]  665 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            666 
   41F2                     667 man_patrol_multi_62_get::
   41F2 21 56 41      [10]  668 	ld hl, #patrol_multi_62
   41F5 C9            [10]  669 	ret
                            670 
   41F6                     671 man_patrol_multi_63_get::
   41F6 21 61 41      [10]  672 	ld hl, #patrol_multi_63
   41F9 C9            [10]  673 	ret
