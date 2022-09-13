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
	sub	$sp, $sp, 4		# push arg

	jal 	catal			# call catalan

	add 	$sp, $sp, 4		#pop arg
	
	move 	$t0, $v0
	sw 	$t0, result		# store return of function
	
	li 	$v0 1		
	lw	$a0, result		# print result
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

	lw	 $t0, number		# get arg number

	bgez 	$t0, if_t		# if (n >= 0)
	j 	end			# when n < 0
	
if_t:	li	$t1, 1		
	sw 	$t1, 8($sp)		# ans = 1

	li 	$t1, 1
	sw	$t1, 4($sp)		# i = 1

while:	ble 	$t1, $t0, loop		# while (i <= n)
	j 	end			# when (i > n)
	
loop:	mul 	$t0, $t1, 2		# 2 * i
	sub 	$t0, $t0, 1		# 2 * i - 1
	mul 	$t0, $t0, 2		# 2(2 * i - 1)
	lw 	$t2, 8($sp)
	mul 	$t0, $t0, $t2		# 2(2 * i - 1) * ans
	add 	$t1, $t1, 1 		# i + 1
	div 	$t0, $t0, $t1		# 2(2 * i - 1) * ans / (i + 1)

	sw 	$t0, 8($sp)		# store result in ans

	lw 	$t1, 4($sp)
	add 	$t1, $t1, 1
	sw 	$t1, 4($sp)  		# i++

	lw 	$t0, number		# put n in t0

	j 	while

end:	lw 	$v0, 8($sp)
					# epilogue
	lw 	$ra, 16($sp)		# restore $ra
	lw 	$fp, 12($sp)		# restore $fp
	add 	$sp, $sp, 16		# restore $sp
	jr 	$ra			# return to caller
	
	
	

	
