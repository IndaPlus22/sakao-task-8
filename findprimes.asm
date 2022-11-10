.data

primes:		.space  1000               						# reserves a block of 2 (sizeof(short)) * 168(number of primes up to 1000) bytes in application memory
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

    #li		$v0, 1                  # print if number was ok
    #add     $a0, $t0, $zero         
    #syscall
    
    #make prime number array
    la      $t0, primes				# $s1 is now pointer to primes[0]
    li		$t1, 0					# counter
    li		$t2, 1					# first number in primes array

# initialize loop
init_loop:
	
	sb		$t2, ($t0)				# primes[$t1] = $t2
	
	#incrementing shit
	addi	$t1, $t1, 1					# $t1++ counter
	addi	$t0, $t0, 1					# go to next element in primes
	
	#checking if end
	bne		$t1, $v0, init_loop	# if counter < input, loop again
# loop end 

		
	la      $t0, primes				# $s1 is now pointer to primes[0]
	li		$t1, 1					# counter in for main_loop
	li		$t2, 0
	li		$s1, 32					# max sqrt of n
	li		$s0, 2					# false
#main loop of determining
main_loop:
	add		$t7, $t0, $zero			 # saves t0
	
	#incrementing shit
	addi	$t1, $t1, 1					# $t1++ counter of main_loop
	addi	$t0, $t0, 1					# go to next element
	
	lb		$t6, ($t7)
	beq		$t6, $s0, main_loop		 # if primes[i] == false, loop again from main_loop
	

	mul		$t4, $t1, $t1			# first number to check
	la		$t5, primes
	add		$t5, $t5, $t4			# 
	subi	$t5, $t5, 1
	
sec_loop:
	sb		$s0, ($t5)
	
	add		$t5, $t5, $t1			# incrementing pointer by t1(counter of main_loop)
	add		$t4, $t4, $t1			# incrementing counter by t1
	ble		$t4, $v0, sec_loop		# if i <= n		
# sec_loop end

	bne		$t1, $s1, main_loop		# if i != max, loop again !!!!!!!!!
#main_loop end

	
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
    
dumb_people:
    li       $v0, 4
    la       $a0, dumb_msg
    syscall

    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
