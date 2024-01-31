#(x + 5) / y + 10 / (y - 1)
li a7, 5
ecall 
mv t0, a0

li a7, 5
ecall 
mv t1, a0

addi t0, t0, 5
div t0, t0, t1

li t2, 10

addi t1, t1, -1
sub t1, t2, t1

add t0, t0, t1

mv a0, t0
li a7, 1
ecall