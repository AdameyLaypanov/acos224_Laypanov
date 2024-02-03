#((x << 2) - y + 5) >> 1 (>> - arithmetical shift)

li a7, 5
ecall
mv t0, a0

li a7, 5
ecall 
mv t1, a0

slli t0, t0, 2
sub t0, t0, t1
addi t0, t0, 5
srai t0, t0, 1

mv a0, t0
li a7, 1
ecall