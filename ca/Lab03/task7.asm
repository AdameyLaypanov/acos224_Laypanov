#2 * x * x - 3 * y + 4
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

li t2, 2
li t3, 3

mul t0, t0, t0
mul t0, t0, t2

mul t1, t1, t3

sub t0, t0, t1

addi t0, t0, 4

mv a0, t0
li a7, 1
ecall