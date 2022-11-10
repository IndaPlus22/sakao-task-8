
.data

msg:		.asciiz	"Hello!\n, enter 0 to mulply, press 1 to get factorial\n" # welcome msg
multmsg:		.asciiz "you chose to multiply!\nenter 1st number and then 2nd number\n"		# command for mult
factmsg:		.asciiz	"you chose to get factorial!\nenter 1 number\n"			# command for get factorial

.text

main: 
	li		$v0, 4
	la		$a0, msg
	syscall
	
	li		$v0, 5
	syscall
	add		$s1, $v0, $zero
	
	bne 		$s1, $zero, factorial		# if player chose fact go to factorial 
	
	li		$v0, 4
	la		$a0, multmsg
	syscall
	
	# start reading vals
	li		$v0, 5
	syscall
	
	add		$t0, $v0, $zero			# t0 is a
	
	li		$v0, 5
	syscall
	
	add		$t1, $v0, $zero			# t1 is b
	
# start multiplying
multiply:
	# begin doing things
	li		$t2, 0				# counter
	li		$t3, 0				# sum
	
# start loop
mult_loop:
	add		$t3, $t3, $t1		# sum += b
	
	addi		$t2, $t2, 1			# counter++
	slt		$t4, $t2, $t0
	bne		$t4, $zero, mult_loop	 # go back while i <= a
# end multloop
	bne		$s1, $zero, fac_in_loop   # if you are facing then go back
	
	li		$v0, 1
	add		$a0, $t3, $zero			# prints res
	syscall
	
# exit program

    li 		$v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
    
# end of mult

# start of factorial
factorial:
	li		$v0, 4
	la		$a0, factmsg
	syscall
	
	# start factorial
	li		$v0, 5
	syscall
	
	add		$t4, $v0, $zero			# t4 is n
	add		$t6, $t4, $zero			# counter $t6 is i
	li		$t5, 1					# factorial number the result t5 is fac
	li		$s0, 2					# 2 min number

# start of fact loop
fac_loop: 
	add		$t0, $t6, $zero			# set a for mult (i)
	add		$t1, $t5, $zero			# set b for mult (fac)
	ble		$s0, $t6, multiply		# if 2 <= counter, do (i*fac) res goes to t3

# point to return from multiply function
fac_in_loop:
	add		$t5, $t3, $zero			# fac = fac*i  (fac is t5)
		
	subi		$t6, $t6, 1				# i--
	ble		$s0, $t6, fac_loop
# end of fact loop

	li		$v0, 1					# print answer
	add		$a0, $t5, $zero
	syscall

# exit program
    li 		$v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
	
	
	
	