# x | (-1 >> 27)

li a7, 5
ecall 
mv t0, a0

li t1, -1

srli t1, t1, 27
xor t0, t0, t1
 
mv a0, t0
li a7, 1
ecall
