#x > y ? 0 : 1

li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

bgt t0, t1, greater
li t0, 1
j print

greater:
li t0, 0

print:
mv a0, t0
li a7, 1
ecall
