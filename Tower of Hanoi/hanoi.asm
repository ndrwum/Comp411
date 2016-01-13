# Andrew 

# Tower of Hanoi
# Function of this program is to move disks from peg1 to peg3,
# which are placed in order by size
 
	.data
prompt:  .asciiz "Enter number of disks: "
transfer: .asciiz "Move disk "
from:	.asciiz "from peg"
to:	.asciiz " to peg"
nl: .asciiz "\n"
done: .asciiz "\nDone. "
too_low: .asciiz "Incalculable number."
 
        .text
        .globl main
main:
	add 	$fp, $0, $sp	
        li 	$v0,4			# System call to print string
        la 	$a0,prompt		# Address of string to print
        syscall				# Print 
 
        li 	$v0,5			# System call to read int input
        syscall				# Read
	add 	$a0, $0, $v0		# and move number into arg0
	
	addi 	$a1, $0, 1		# assign peg one to arg1
	addi 	$a2, $0, 2		# assign peg two to arg2
	addi 	$a3, $0, 3		# assign peg three to arg3
	jal 	hanoi			# jal to hanoi
 
exit:
	li 	$v0, 4       		
	la 	$a0, done    			
	syscall
        li 	$v0,10			# System call to exit
        syscall                         # exit
 

hanoi:
	addi	$sp,$sp,-4		# allocate space
	sw	$ra,($sp)		# save ra on stack
	addi	$sp,$sp,-4		
	sw	$fp,($sp)		# save fp on stack
	addi	$sp,$sp,-4		
	sw	$s0,($sp)		# save s0 on stack
	addi	$sp,$sp,-4		
	sw	$s1,($sp)		# save s1 on stack
	addi	$sp,$sp,-4		
	sw	$s2,($sp)		# save s2 on stack
	addi	$sp,$sp,-4		
	sw	$s3,($sp)		# save s3 on stack
	addi	$sp,$sp,-4		
	addi	$fp, $sp, 32		# set $fp
	
	beq	$a0, $0, zero		# check if n is zero
	blt 	$a0, 0, invalid		# check if n < 0
	sw	$a0,($sp)		# store arg value n on stack
	addi	$sp,$sp,-4		
	sw	$a1,($sp)		# store "from" peg on stack
	addi	$sp,$sp,-4		
	sw	$a2,($sp)		# store "aux" peg on stack
	addi	$sp,$sp,-4		
	sw	$a3,($sp)		# store "to" on stack
	addi	$sp,$sp,-4
				
	addi	$a0,$a0,-1		# store n-1 in arg0
	add	$t2, $0,$a3		# put "to" peg in temp register
	add	$a3, $0, $a2		# swap "to" peg and "aux" peg on 1st run
	add	$a2, $0, $t2		
	jal	hanoi			# jal hanoi
	
	addi	$sp,$sp,4		# deallocate space	
	lw	$s0,($sp)		# get "to" 
	addi	$sp,$sp,4			
	lw	$s1,($sp)		# get "aux" 
	addi	$sp,$sp,4			
	lw	$s2,($sp)		# get "from" 
	addi	$sp,$sp,4			
	lw	$s3,($sp)		# get n 
 

	li 	$v0, 4       			
	la 	$a0, transfer	
	syscall				

	li 	$v0, 4       		
	la 	$a0, from    		
	syscall
	li 	$v0, 1       			
	add 	$a0,$0, $s2    			
	syscall
	li 	$v0, 4       			
	la 	$a0, to    			
	syscall
	li 	$v0, 1       			
	add 	$a0, $0, $s0    			
	syscall
	li 	$v0, 4       			
	la 	$a0, nl    			
	syscall


	addi 	$a0,$s3,-1		# store n-1 in arg0
	add 	$a1, $0, $s1		# to is 1st arg
	add 	$a2, $0, $s2		# aux is 2nd arg
	add 	$a3, $0, $s0		# from is last arg
	jal 	hanoi			
	
zero:
	addi	$sp,$sp,4		# deallocate space
	lw	$s3,($sp)		# pop s3 from stack
	addi	$sp,$sp,4		 
	lw	$s2,($sp)		# pop s2 from stack
	addi	$sp,$sp,4		 
	lw	$s1,($sp)		# pop s1 from stack
	addi	$sp,$sp,4		 
	lw	$s0,($sp)		# pop s0 from stack
	addi	$sp,$sp,4		 
	lw	$fp,($sp)		# pop $fp from stack
	addi	$sp,$sp,4		 
	lw	$ra,($sp)		# restore $ra
	addi	$sp,$sp,4		# restore to pointer start
	jr 	$ra			# return 
	
invalid: 
	li $v0, 4
    	la $a0, too_low
    	syscall
    	j exit
