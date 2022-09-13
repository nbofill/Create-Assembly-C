# I pledge on my honor that I have not given or received any unauthorized
# assistance on this assignment/examination.

# Nicolas Bofill : nbofill : 117243086 : Section 0108

# The catalan function takes in an integer and returns its corresponding
# catalan number

	.data
number:		.word 0
result:		.word 0

	.text
main:	li 	$sp, 0x7ffffffc		# init $sp

	li 	$v0, 5			# scan int
	syscall
	
	move 	$t0, $v0
	sw 	$t0, number		# store int in number
	sw 	$t0, ($sp)
	sub 	$sp, $sp, 4		# push arg

	jal 	catal			# call catalan

	add 	$sp, $sp, 4		# pop arg
	
	move 	$t0, $v0
	sw 	$t0, result		# store return of function
	
	li 	$v0 1		
	lw 	$a0, result		# print result
	syscall

	li 	$v0, 11
	li 	$a0, 10			# print '\n'
	syscall

	li 	$v0 10			# return 0
	syscall

					# prologue
catal:	sub 	$sp, $sp, 16		# set $sp
	sw 	$ra, 16($sp)		# save $ra
	sw 	$fp, 12($sp)		# save $fp
	add 	$fp, $sp, 16		# set new $fp

	li 	$t0, -1
	sw 	$t0, 8($sp)		# ans = -1

	lw 	$t0, 4($fp) 		# get arg

	beqz 	$t0, if_t		# if (n == 0)

	bgtz 	$t0, call		# if (n > 0) make call for n - 1
	j 	ret			# if (n <= 0) end if statement

call:	sub 	$t1, $t0, 1		# n - 1
	sw 	$t1, ($sp)		# store new n
	sub 	$sp, $sp, 4

	jal 	catal

	add 	$sp, $sp, 4

	move 	$t0, $v0		# get temp
	lw 	$t1, 4($fp) 		# load n
	mul 	$t1, $t1, 2		# 2 * n
	sub 	$t1, $t1, 1		# 2 * n - 1
	mul 	$t1, $t1, 2		# 2 * (2 * n - 1)
	mul 	$t1, $t1, $t0		# 2 * (2 * n - 1) * ans
	lw 	$t0, 4($fp)
	add 	$t0, $t0, 1		# n + 1
	div 	$t1, $t1, $t0 		# 2 * (2 * n - 1) * ans / (n + 1)

	sw 	$t1, 8($sp)		# store ans
	move 	$t0, $t1
	
	j 	ret

	
if_t:	li 	$t0, 1
	sw 	$t0, 8($sp)		# ans = 1

ret:	lw  	$v0, 8($sp)		# return ans
					# epilogue
	lw 	$ra, 16($sp)		# restore $ra
	lw 	$fp, 12($sp)		# restore $fp
	add 	$sp, $sp, 16		# restore $sp
	jr 	$ra			# return to caller
