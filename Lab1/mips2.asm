
.data

 myarray:.space 80    
 prompt:.asciiz "Enter a number: "
 numberN:.asciiz "Enter the n less than 20: "
 eqMessage:.asciiz "They are equal"
 noteqMessage:.asciiz "They are not equal"
 newLine: .asciiz "\n"
 
.text 

li $v0,4
la $a0, numberN
syscall

li $v0, 5
syscall 

move $s1, $v0
srl $s2, $s1,1

la $t1, myarray
la $t3, myarray

while:

	beq $t0,$s1 , while2
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0,0($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4

	j while

while2:

	beq $t2, $s1, beforeReverse
	
	lw $t4, 0($t3)
 	li $v0, 1
    	move $a0, $t4
    	syscall
    	
	addi $t2, $t2, 1
	addi $t3, $t3, 4    

	j while2

beforeReverse:

	sub $t3, $s1, $s2
	sll $t3,$t3,2
	li $t0,0
	li $t1,0

reverse:

	beq $t1, $s2, Eq
	lw $t6, myarray($t3)
	lw $t7, myarray($t0)

	bne $t6, $t7, notEq

	addi $t3, $t3, 4
	addi $t0, $t0, 4 
	addi $t1, $t1, 1   

	j reverse

Eq:

	li $v0,4
	la $a0, newLine
	syscall

	li $v0,4
	la $a0, eqMessage
	syscall

	j done

notEq:

	li $v0,4
	la $a0, newLine
	syscall

	li $v0,4
	la $a0, noteqMessage
	syscall
  
done:

li $v0,10
    syscall
 


