# x < -5 & y > 10
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

li t3, -5
li t4, 10

blt t0, t3, conX
li t0, 0
j y

conX:
	li t0, 1
y:
	bgt t1, t4, conY
	li t1, 0
	j print
conY:
	li t1, 1

print:
	and t0, t0, t1

	mv a0, t0
	li a7, 1
	ecall