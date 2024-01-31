#reset the y-th bit of x to 0 (bit numbers start from 0)
li a7, 5
ecall

li a7, 5
ecall

li t0, 1          
sll t0, t0, a1    
not t0, t0        
and a0, a0, t0    

li a7, 1
ecall
