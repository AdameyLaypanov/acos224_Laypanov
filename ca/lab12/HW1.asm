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

.macro solve(%x) # uses s2 register
	mv s2, %x
try_0:
	li t6, 0x11
	bne s2, t6, try_1
	li t6, 0x3f
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_1:
	li t6, 0x21
	bne s2, t6, try_2
	li t6, 0x6
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_2:
	li t6, 0x41
	bne s2, t6, try_3
	li t6, 0x5b
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_3:
	lui t6, 0xfffff
	addi t6, t6, 0x7ff
	addi t6, t6, 0x782
	bne s2, t6, try_4
	li t6, 0x4f
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_4:
	li t6, 0x12
	bne s2, t6, try_5
	li t6, 0x66
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_5:
	li t6, 0x22
	bne s2, t6, try_6
	li t6, 0x6d
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_6:
	li t6, 0x42
	bne s2, t6, try_7
	li t6, 0x7d
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_7:
	lui t6, 0xfffff
	addi t6, t6, 0x7ff
	addi t6, t6, 0x783
	bne s2, t6, try_8
	li t6, 0x7
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_8:
	li t6, 0x14
	bne s2, t6, try_9
	li t6, 0x7f
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_9:
	li t6, 0x24
	bne s2, t6, try_10
	li t6, 0x6f
	sb t6, 0x10(s0)
	li t6, 0
	sb t6, 0x11(s0)
	j number_found
try_10:
	li t6, 0x44
	bne s2, t6, try_11
	li t6, 0x3f
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
	j number_found
try_11:
	lui t6, 0xfffff
	addi t6, t6, 0x7ff
	addi t6, t6, 0x785
	bne s2, t6, try_12
	li t6, 0x6
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
	j number_found
try_12:
	li t6, 0x18
	bne s2, t6, try_13
	li t6, 0x5b
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
	j number_found
try_13:
	li t6, 0x28
	bne s2, t6, try_14
	li t6, 0x4f
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
	j number_found
try_14:
	li t6, 0x48
	bne s2, t6, try_15
	li t6, 0x66
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
	j number_found
try_15:
	lui t6, 0xfffff
	addi t6, t6, 0x7ff
	addi t6, t6, 0x789
	bne s2, t6, try_0
	li t6, 0x6d
	sb t6, 0x10(s0)
	li t6, 0x6
	sb t6, 0x11(s0)
number_found:
.end_macro

    .text
main:
    lui     s0, 0xffff0   # MMIO base
    mv      s1, zero      # counter
    mv      s2, zero      # previous value
    li      s3, 20        # counter limit
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
    beq     t1, s2, loop # repeat if the same key value
    mv      s2, t1 # save current value

    # Prints the pressed key in format 0xXY, where X is column, Y is row.
    # Both X and Y are specified as bit flags (0x1, 0x2, 0x4, 0x8).
    # Bit position means the number of row/column (0x1 -> 1, 0x2 -> 2, 0x4 -> 3, x8 -> 4).
    
    #print_hex(t1)
    #newline
    
    solve(t1)

    addi    s1, s1, 1    # counter increment
    ble     s1, s3, loop # repeat if s1 <= s3
end:
    exit
