.data

primes:		.space  1001               						# reserves a block of 1001 bytes in application memory for 1000 bools and 1 end char
dumb_msg:	.asciiz "number must be between 1 <n < 1001\n"

### Executable Code Section ###

.text

main:
    # get input n
    li      $v0, 5                  # reads integer from input
    syscall
    
    #check that number is in range
    li	    $t1, 1001
    slt     $t0, $v0,$t1	           # t0 = v0 < 1001, t0 is bool
    beq     $t0, $zero, dumb_people    # if input was 0 goto dumb
    beq     $t1, $zero, dumb_people   # if input was bigger than 1000 goto dumb
    
    #make prime number array
    la      $t0, primes				# $s1 is now pointer to primes[0]
    li		$t1, 0					# counter
    li		$t2, 1					# first number in primes array

# initialize loop, for changing all elements in primes to 1
init_loop:
	sb		$t2, ($t0)				# primes[$t1] = 1
	
	#incrementing shit
	addi	$t1, $t1, 1					# $t1++ counter
	addi	$t0, $t0, 1					# increment counter
	
	#checking if end
	bne		$t1, $v0, init_loop	# if counter < input, loop again, else all primes = 1
# loop end 

		
	la      $t0, primes				# $s1 is now pointer to primes[0]
	li		$t1, 1					# counter in for-loop (main_loop)s
	li		$t2, 0
	li		$s1, 1				# true
	li		$s0, 2					# false
	addi		$s2, $v0, 1
#main loop of determining
main_loop:
	add		$t7, $t0, $zero			 # saves t7 = t0
	
	#incrementing shit
	addi		$t1, $t1, 1					# $t1++ counter of main_loop
	addi		$t0, $t0, 1					# increment counter for t0
	
	lb		$t6, ($t0)				# t6 = primes[i]
	beq		$t6, $s0, main_loop		 # if primes[i] == false(2), loop again from main_loop (false means number is not a prime number)	
	

	mul		$t2, $t1, $t1			# t4 = (t1^2)
	ble		$v0, $t2, last_steps		# if i^2 >= n, stop loop
	
	la		$t5, primes				# t5 = adress to primes[0]
	add		$t5, $t5, $t2			# t5 = first adress to check
	subi		$t5, $t5, 1				# t5 -= 1 (because arrays start at 0)
	add		$t4, $t2, $zero
	
sec_loop:
	sb		$s0, ($t5)				# primes[t4-1] = false (2)
	
	add		$t5, $t5, $t1			# incrementing pointer by t1(counter of main_loop)
	add		$t4, $t4, $t1			# incrementing counter by t1
	ble		$t4, $s2, sec_loop		# if i <= n+1, goto sec_loop
# sec_loop end
	
	ble		$t2, $s2, main_loop		# if i^2 <= n+1, stop loop
#main_loop end

last_steps:
	li		$t1, 0					# counter
	la		$t0, primes				# pointer
	add		$t7, $v0, $zero			# saving n to t7
	li		$t6, 2					# t6 is false (2)
	addi		$t5, $t0, 1001			
	sb		$zero, ($t5)				# set last value in primes to 0 as ending value
last_loop:
	lb		$t2, ($t0)
	
	
	# increment shit
	addi		$t0, $t0, 1				# pointer++
	addi		$t1, $t1, 1				# counter++
	
	beq		$t2, $t6, last_loop		# if t2 is false(2), dont print
	beq		$t2, $zero, ending_time	# if t2 is 0 end 
	
	subi		$t0, $t0, 1				# counter back to normal
	
	# printing ------------
	li		$v0, 1
	add		$a0, $t1, 0				# print prime number
	syscall
	
	li		$v0, 11
	li		$a0, 44					# print ","
	syscall
	# printing -----------
	
	# increment shit
	addi		$t0, $t0, 1				# pointer++ again
	
	bne		$t7, $t1, last_loop		# if counter (t1) has not yet reached n (t7) loop again

ending_time:
	
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
    
dumb_people:
    li       $v0, 4
    la       $a0, dumb_msg
    syscall

    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
