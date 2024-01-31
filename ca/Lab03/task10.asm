# x & (-1 << 5)
li a7, 5
ecall 
mv t0, a0

li t1, -1

slli t1, t1, 5
and t0, t0, t1

mv a0, t0
li a7, 1
ecall