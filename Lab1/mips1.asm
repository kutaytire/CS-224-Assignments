
.data

 myarray:.space 80    
 prompt:.asciiz "Enter a number: "
 numberN:.asciiz "Enter the n less than 20: "
 newLine: .asciiz "\n"
 
.text 

li $v0,4
la $a0, numberN
syscall

li $v0, 5
syscall 

move $s1, $v0 # holds the size
la $t1, myarray
la $t3, myarray

srl $s2, $s1,1 #$s2 is for the number of iterations in twisting the array

while:

	beq $t0,$s1 , while2
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4

	j while

while2:

	beq $t2, $s1, reverseBefore
	lw $t4, 0($t3)
	
 	li $v0, 1
    	move $a0, $t4
    	syscall
    	
	addi $t2, $t2, 1
	addi $t3, $t3, 4    

	j while2

reverseBefore: #finds the number of iterations

	sub $t3, $s1, $s2
	sll $t3,$t3,2
	li $t0,0
	li $t1,0

reverse:

	beq $t0, $s2, printReverseBefore
	lw $t6, myarray($t3)
	lw $t7, myarray($t1)

	sw $t6, myarray($t1)
	sw $t7, myarray($t3)

	addi $t3, $t3, 4
	addi $t1, $t1, 4 
	addi $t0, $t0, 1   

	j reverse

	printReverseBefore:

	addi $t0, $zero, 0 # t0 = 0
	addi $t4, $zero, 0 # t1 = 0  
	addi $t2, $zero, 0 # t2 = 0  
	addi $t5, $zero, 0 # t2 = 0  
	li $v0,4
	la $a0, newLine
	syscall

	printReverse:


	beq $t2, $s1, done
	lw $t4, myarray($t5)
 	li $v0, 1
    	move $a0, $t4
    	syscall
	addi $t2, $t2, 1
	addi $t5, $t5, 4    

	j printReverse
 
  
done:

	li $v0,10
    	syscall
 


