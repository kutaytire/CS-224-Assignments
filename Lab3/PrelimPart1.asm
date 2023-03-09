
.data

	main: .asciiz "For main program"
	subProg: .asciiz "For the subprogram"
	numberAdd: .asciiz "The number of add instructions is: "
	numberOr: .asciiz "The number of ori instructions is: "
	numberLoad: .asciiz "The number of lw instructions is: "
	newLine: .asciiz "\n"

.text 

beginning:

	la $s0, beginning
	la $s1, end
	
	lw $s6, 0($s0) # for testing
	lw $s6, 4($s0) # for testing
	lw $s6, 8($s0) # for testing
	
	li $v0,4
	la $a0, main
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	
	jal instructionCount
	
	add $s2, $a0, $zero #add
	add $s3, $v0, $zero #ori
	add $s4, $v1, $zero #lw
	
	li $v0,4
	la $a0, numberAdd
	syscall
	
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	li $v0,4
	la $a0, numberOr
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	li $v0,4
	la $a0, numberLoad
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	li $v0,4
	la $a0, subProg
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	
	la $a0, instructionCount
	la $a1, lastAdress
	
	jal instructionCount
	
	add $s2, $a0, $zero #add
	add $s3, $v0, $zero #ori
	add $s4, $v1, $zero #lw
	
	li $v0,4
	la $a0, numberAdd
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	li $v0,4
	la $a0, numberOr
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0,4
	la $a0, newLine
	syscall
	
	li $v0,4
	la $a0, numberLoad
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	
	li $v0, 10
	syscall
end:

#######################################################

instructionCount: 

	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)	
	
	#for testing
	ori $s0, $s0, 1
	ori $s0, $s0, 2
	ori $s0, $s0, 3
	
	while:
	
		bge $a0,$a1, done
		
		lw $s5, 0($a0)
		srl $s1, $s5, 26
		
		beq $s1, 13, oriOper
		beq $s1, 35, lwOper
		
		andi $at, $s1, 63
		bne $at, $zero, inc
		
		sll $s1, $s5, 26
		srl $s1, $s1, 26
		beq $s1, 32, addOper
		
		inc: addi $a0, $a0, 4
		j while
	
	addOper:
	
		addi $s2, $s2, 1
		addi $a0, $a0, 4
		j while
		
	oriOper:
	
		addi $s3, $s3, 1
		addi $a0,$a0, 4
		j while
		
	lwOper:
	
		addi $s4, $s4, 1
		addi $a0, $a0, 4
		j while
		  	  
	done: 
	
		add $a0, $s2, $zero
		add $v0, $s3, $zero
		add $v1, $s4, $zero
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		
		addi $sp, $sp, 24
lastAdress:	jr $ra
	














