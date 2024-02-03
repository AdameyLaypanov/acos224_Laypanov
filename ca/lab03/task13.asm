#reset the y-th bit of x to 0 (bit numbers start from 0)
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0

li t2, 1          
sll t2, t2, t1    
not t2, t2        
and t2, t0, t2    

mv a0, t2
li a7, 1
ecall
