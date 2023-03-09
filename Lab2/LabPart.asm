

.data

promptArraySize: .asciiz "Enter the array size: "
prompt: .asciiz "Enter a number: "
newLine: .asciiz "\n"
information: .asciiz "index / element / sum of digits: "
space: .asciiz "  "

.text

main:

jal createArray

move $a0, $v0 # $a0 has the adress
move $a2, $v0 # $a2 has the adress
move $a1, $v1 # $a1 has the size

jal bubbleSort

move $a0, $v0

jal processSortedArray

li $v0, 10
syscall

createArray:

addi $sp, $sp, -12
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)

li $v0,4
la $a0, promptArraySize
syscall

li $v0, 5
syscall 

move $a0, $v0 # holds the size of the array

move $v1, $v0 #for returning the size

sll $a0, $a0, 2

li $v0, 9 #return adress
syscall

move $s0, $v0 #saves the return adress
move $s1, $v0 # for returning the beginning adress when elements are taken.

while:
	
	beq $s2, $v1, done
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($s0)
	addi $s2, $s2, 1
	addi $s0, $s0, 4

	j while
	
done:
move $v0, $s1

addi $sp, $sp, 12
lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)

jr $ra

bubbleSort:

addi $sp, $sp, -32
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp) # index
sw $s3, 12($sp)
sw $s4, 16($sp) #nextIndex
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)

li $s0, 1 #pass
li $s1, 0 # isSorted = false
li $s2, 0 
move $s7, $a0 

whileSort:
	
	beq $s0, $a1, doneSort
	beq $s1, 1, doneSort
	li $s1, 1
	
	whileIndex:
	
		sub $s3, $a1, $s0
		bge $s2, $s3, exitInner
		addi $s4, $a0, 4
		lw $s5, 0($a0) 
		lw $s6, 0($s4)
		bgt $s5, $s6, insideIf
		addi $s2, $s2, 1
		addi $a0, $a0 ,4
		j whileIndex
		
	insideIf:
	
		sw $s5, 0($s4)
		sw $s6, 0($a0)
		li $s1, 0
		addi $s2, $s2, 1
		addi $a0, $a0 ,4
		j whileIndex
	
	
	exitInner:
		
		addi $s0, $s0, 1
		li $s2, 0
		move $a0, $s7
		
		j whileSort
		
	
doneSort:

	move $v0, $s7
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
	lw $s4, 16($sp) 
	lw $s5, 20($sp)	
	lw $s6, 24($sp)
	
	addi $sp, $sp, 28
	
	jr $ra
	
#############################################################	

processSortedArray:

	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	
	move $s2, $a0
	
	whilePrint:
	
		beq $s0, $a1, donePrint
		lw $s1, 0($s2)
		
		li $v0,4
		la $a0, information
		syscall
		
		li $v0, 1
		move $a0,$s0
		syscall
		
		li $v0,4
		la $a0, space
		syscall
		
		li $v0, 1
		move $a0,$s1
		syscall
		
		li $v0,4
		la $a0, space
		syscall
		
		move $a0,$s1 
		
		jal sumDigits
		
		move $s3, $v0
		
		li $v0, 1
		move $a0,$s3
		syscall
		
		li $v0,4
		la $a0, newLine
		syscall
		
		addi $s0, $s0, 1
		addi $s2,$s2, 4
		j whilePrint
		
	donePrint:
	
		lw $ra, 16($sp)
		lw $s3, 12($sp)
		lw $s2, 8($sp)
		lw $s1, 4($sp)
		lw $s0, 0($sp) 
		
		addi $sp, $sp, 20
		
		jr $ra
	
#############################################################	

sumDigits:

	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp) #sum
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
	
	li $s1, 0
	li $s0,10

	whileSum:
		
		beq $a0, $zero, doneSum
		blt $a0, $zero, makePositive
		continue:
		
			div $a0,$s0
			mfhi $s2
			add $s1, $s1, $s2
			mflo $a0
			j whileSum
		
		makePositive:
			
			
			mul $a0, $a0,-1
			j continue
	
	doneSum:
	
		move $v0, $s1
		
		lw $s3, 12($sp)
		lw $s2, 8($sp) 
		lw $s1, 4($sp) #sum
		lw $s0, 0($sp)
		
		addi $sp, $sp, 16
		
		jr $ra
	
	
	
	

		






