#(x == (y + 3)) ? 0 : 1
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

addi t1, t1, 3

beq t0, t1, con1
li t0, 1
j print

con1:
li t0, 0

print:
mv a0, t0
li a7, 1
ecall
