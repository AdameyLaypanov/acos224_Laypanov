#set the y-th bit of x to 1 (bit numbers start from 0)
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

li t2, 1

sll t1, t2, t1
or t0, t0, t1

mv a0, t0
li a7,1
ecall












    # Assuming a0 = x, a1 = y
    li t0, 1          # Load immediate value 1 into temporary register t0
    sll t0, a1, t0    # Shift left logical t0 by a1 positions, t0 = 1 << y
    or a0, a0, t0     # OR a0 with t0, setting the y-th bit of a0
