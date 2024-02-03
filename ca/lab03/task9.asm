#(x / y) * y + x % y

li a7, 5
ecall 
mv t0, a0

li a7, 5
ecall
mv t1, a0

div t2, t0, t1
mul t2, t2, t1

rem t0, t0, t1

add t0, t2, t0

mv a0, t0
li a7, 1
ecall