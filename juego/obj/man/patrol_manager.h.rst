ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
