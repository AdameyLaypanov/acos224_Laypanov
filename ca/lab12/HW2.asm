.data
.macro exit
    li      a7, 10
    ecall
.end_macro

.macro print_hex(%x)
    mv      a0, %x
    li      a7, 34
    ecall
.end_macro

.macro newline
    li      a0, '\n'
    li      a7, 11
    ecall
.end_macro

.macro ReadInt(%x)
    li a7, 5
    ecall
    mv %x, a0
.end_macro 

found:
  .string "FOUND"
 
stop:
  .string  "STOPPED"

    .text
main:
    lui     s0, 0xffff0   # MMIO base
    mv      s1, zero      # counter
    mv      s2, zero      # previous value
    li      s3, 20        # counter limit
   ReadInt t2
    mv t3, zero
    li t4, 17
    check_if_0:
    bne t2, t3, check_if_1
    li t2, 17
    check_if_1:
    addi t3, t3, 1
    bne t2, t3, check_if_2
    li t2, 33
    check_if_2:
    addi t3, t3, 1
    bne t2, t3, check_if_3
    li t2, 65
    check_if_3:
    addi t3, t3, 1
    bne t2, t3, check_if_4
    li t2, -127
    check_if_4:
    addi t3, t3, 1
    bne t2, t3, check_if_5
    li t2, 18
    check_if_5:
    addi t3, t3, 1
    bne t2, t3, check_if_6
    li t2, 34
    check_if_6:
    addi t3, t3, 1
    bne t2, t3, check_if_7
    li t2, 66
    check_if_7:
    addi t3, t3, 1
    bne t2, t3, check_if_8
    li t2, -126
    check_if_8:
    addi t3, t3, 1
    bne t2, t3, check_if_9
    li t2, 20
    check_if_9:
    addi t3, t3, 1
    bne t2, t3, check_if_10
    li t2, 36
    check_if_10:
    addi t3, t3, 1
    bne t2, t3, check_if_11
    li t2, 68
    check_if_11:
    addi t3, t3, 1
    bne t2, t3, check_if_12
    li t2, -124
    check_if_12:
    addi t3, t3, 1
    bne t2, t3, check_if_13
    li t2, 24
    check_if_13:
    addi t3, t3, 1
    bne t2, t3, check_if_14
    li t2, 40
    check_if_14:
    addi t3, t3, 1
    bne t2, t3, check_if_15
    li t2, 72
    check_if_15:
    addi t3, t3, 1
    bne t2, t3, loop
    li t2, -120
loop:
    li      t0, 1         # check first row
    sb      t0, 0x12(s0)  # scan
    lb      t1, 0x14(s0)  # get result
    bnez    t1, pressed   # process key pressed

    li      t0, 2         # check second row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 4         # check third row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 8         # check fourth row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    mv      s2, zero  # reset previous value
    j       loop  # nothing is pressed (t1 == 0) - repeat
pressed:
    bne t1, t2, not_found
    beq t1, t4, stop1
    la a0, found
    li a7, 4 
    ecall
    newline
    exit
    stop1:
    la a0, stop
    li a7, 4
    ecall
    newline
    exit
    not_found:
    beq t1, t4, stop1
    j loop
