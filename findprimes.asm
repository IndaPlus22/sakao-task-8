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
    li		$t2, 2					# first number in primes array

# main loop
while_loop:
	
	sb		$t2, ($t0)				# primes[$t1] = $t2
	srl		$t3, $t2, 8				# shift number by 1 byte
	sb		$t3, 1($t0)
	
	#incrementing shit
	addi	$t2, $t2, 1				    # $t2++ next number to check
	addi	$t1, $t1, 1					# $t1++ counter
	addi	$t0, $t0, 2					# go to next element in primes (short)
	
	#checking if end
	bne		$t1, $v0, while_loop	# if counter < input, loop again

# loop end 

    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
    
dumb_people:
    li       $v0, 4
    la       $a0, dumb_msg
    syscall

    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
