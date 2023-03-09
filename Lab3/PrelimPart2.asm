

.data

promptDividend: .asciiz "Please enter the divident: "
promptDivisor: .asciiz "Please enter the divisor: "
newLine: .asciiz "\n"
continue: .asciiz "Do you want to continue (y/n): "
result: .asciiz "The result of the division is: "

.text

loop:

	li $v0,4
	la $a0, promptDividend
	syscall
	ror $t1, $t2, $t3

	li $v0, 5
	syscall 

	move $s1, $v0 #dividend in $s1

	li $v0,4
	la $a0, promptDivisor
	syscall

	li $v0, 5
	syscall 

	move $a1, $v0 #divisor in $a1
	move $a0, $s1
	jal divison

	move $s0, $v0

	li $v0,4
	la $a0, result
	syscall

	li $v0, 1
	move $a0,$s0
	syscall
	
	li $v0,4
	la $a0, newLine 
	syscall

	li $v0,4
	la $a0, continue 
	syscall
	
	li $v0, 12
	syscall
	
	move $s2, $v0
	
	li $v0,4
	la $a0, newLine 
	syscall
	
	bne $s2,121, done
	j loop

done:
	li $v0, 10
	syscall

###################################################

divison:

	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	bge $a0, $a1, else
	li $v0, 0 #base case
	
	addi $sp, $sp, 12
	jr $ra
	
	else:
		sub $a0, $a0, $a1
		jal divison
	
		addi $v0, $v0, 1
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		
		jr $ra
	
	
	
	
