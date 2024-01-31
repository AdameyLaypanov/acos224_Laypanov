#x * 6 - y * 3 (do multiplication using shifts, adds, and subs)
#x * 6 = x * 3 + x * 3 => (x << 1) + x) << 1
#y * 3 = (y<<2) - y
li a7, 5
ecall
mv t0, a0

li a7, 5
ecall
mv t1, a0


# x * 3
slli t2, t0, 1
add t0, t0, t2
slli t0, t0, 1

# y * 3
slli t2, t1, 2
sub t1, t2, t1

sub t0, t0, t1

mv a0, t0
li a7, 1
ecall 
