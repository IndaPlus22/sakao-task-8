##################################################################
#
#   MIPS assembly code example
#   - Hello World as application 
#
#   Author: Tobias Hansson <tohans@kth.se>
#
#   Created: 2020-10-23
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Documentation (https://ecs-network.serv.pacific.edu/ecpe-170/tutorials/mips-instruction-set)
#
##################################################################

### Data Declaration Section ###

.data

dumb_msg: .asciiz "number must be between 1 <n < 1001\n"

### Executable Code Section ###

.text

main:
    # get input
    li      $v0, 5                  # reads integer from input
    syscall
    
    #check that number is in range
    li	    $t1, 1001
    slt     $t0, $v0,$t1	         # t0 = v0 < 1001, t0 is 0 or 1
    beq     $v0, $zero, dumb_people    # if input was 0 goto dumb
    beq     $t0, $zero, dumb_people  # if input was bigger than 1000 goto dumb
    
    
    
    li      $v0, 1                  # magic to print a number
    add     $a0, $t0, $zero         # print number
    syscall

    # # print HW
    # li      $v0, 4                  # magic code to print string
    # la      $a0, HW                 # load address of string HW into $a0
    # syscall                         # HW now printed

    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program
    
dumb_people:
    # li       $t0, .asciiz "number must be between 1 <n < 1001\n"
    li       $v0, 4
    la       $a0, dumb_msg
    syscall

    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program


##################################################################
#
#   NOTE:
#       Applications assembled and executed by MARS, or applications which terminate at EOF,
#       don't need the termination call. This termination call is therefore unnessecary.
#
##################################################################
