#(x << y) - 10
li a7, 5
ecall 
mv t0, a0

li a7, 5
ecall 
mv t1, a0

sll t0, t0, t1
addi t0, t0, -10

mv a0, t0
li a7, 1
ecall