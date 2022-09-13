# I pledge on my honor that I have not given or received any unauthorized
#   assistance on this assignment/examination.

# Nicolas Bofill : nbofill : 117243086 : Section 0108


# This function takes in an integer greater than zero and prints out the
# integer in reverse order. 		
	
	.data
n:	.word 0
ans:	.word -1

	.text
main:	li 	$v0, 5			# scan int 
	syscall

	move 	$t0, $v0
	sw 	$t0, n			# store int in n

	beqz 	$t0, if_t		# if (n == 0)		
	rem 	$t1, $t0, 10		# n % 10
	bgtz 	$t0, andif		# if (n > 0)
	j 	else			# if arguement is false
	

andif:	bnez 	$t1, if_t		# if (n % 10 != 0)
	j 	else			# if this line is reached, argument is false

if_t:	li 	$t1, 0
	sw 	$t1, ans		# set ans to 0

while:	bgtz 	$t0, loop		# if (n > 0)
	j 	else			# when this line is reached, n <= 0

loop:	rem 	$t1, $t0, 10		# n % 10
	lw 	$t2, ans
	mul 	$t2, $t2, 10		# ans * 10
	add 	$t2, $t2, $t1		# ans * 10 + (n % 10)
	sw 	$t2, ans		# store result in ans

	lw 	$t0, n
	div 	$t0, $t0, 10		# n / 10
	sw 	$t0, n			# n = n / 10
	j 	while

else:	li 	$v0, 1
	lw 	$a0, ans		# print ans
	syscall

	li 	$v0, 11
	li 	$a0, 10			# print 'n'
	syscall
	
	li 	$v0 10			# return 0
	syscall
