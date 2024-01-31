#(x >> 2) + ((y - 1) << 3) (>> - logical shift)
li a7, 5
ecall 
mv t0, a0

li a7, 5
ecall 
mv t1, a0

srli  t0, t0, 2

addi t1, t1, -1
slli t1, t1, 3

add t0, t0, t1

mv a0, t0
li a7,1
ecall