#
# Inputs:
# 1) line thickness (0-31)
# 2) RED (0-255)
# 3) GREEN (0-255)
# 4) BLUE (0-255)
#

    .eqv   ALLSIZE 0x20000      # videomemory size (in words)
    .eqv   BASE    0x10010000   # MMIO base
    .text
    li s0, BASE
j main

draw_pixel:
	# a0 - x
	# a1 - y
	# a2 - color
	li s4, 4
	li s5, 128
	mul a1, a1, s5 # a1 *= 128
	add a1, a1, a0 # a1 += x
	mul a1, a1, s4 # a1 *= 4
	add a1, a1, s0 # add base
	sw a2, (a1)
	jr ra
	
	

main:   # inputs
	li a7, 5
	ecall
	mv t3, a0
	ecall
	mv s1, a0 # red
	slli s1, s1, 16
	ecall
	mv s2, a0 # green
	slli s2, s2, 8
	ecall
	mv s3, a0 # blue
	add a2, s1, s2
	add a2, a2, s3
	

	# draw north line
	li t0, 32 # x
	li t1, 32 # y
	li t4, 96 
	li t6, 0
	l2:
		li t0, 32
		l1:
			mv a0, t0
			mv a1, t1
			jal draw_pixel
			addi t0, t0, 1
			blt t0, t4, l1
			
		addi t6, t6, 1
		addi t1, t1, 1
		blt t6, t3, l2
	
	# draw south line
	li t0, 32 # x
	li t1, 96 # y
	sub t1, t1, t3
	li t4, 96 
	li t6, 0
	l3:
		li t0, 32
		l4:
			mv a0, t0
			mv a1, t1
			jal draw_pixel
			addi t0, t0, 1
			blt t0, t4, l4
			
		addi t6, t6, 1
		addi t1, t1, 1
		blt t6, t3, l3
	
	# draw east line
	li t0, 96 # x
	li t1, 32 # y
	sub t0, t0, t3
	li t4, 96 
	li t6, 0
	l5:
		li t1, 32
		l6:
			mv a0, t0
			mv a1, t1
			jal draw_pixel
			addi t1, t1, 1
			blt t1, t4, l6
			
		addi t6, t6, 1
		addi t0, t0, 1
		blt t6, t3, l5
	
	# draw west line
	li t0, 32 # x
	li t1, 32 # y
	#sub t0, t0, t3
	li t4, 96 
	li t6, 0
	l7:
		li t1, 32
		l8:
			mv a0, t0
			mv a1, t1
			jal draw_pixel
			addi t1, t1, 1
			blt t1, t4, l8
			
		addi t6, t6, 1
		addi t0, t0, 1
		blt t6, t3, l7

