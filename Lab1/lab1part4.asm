.data

myArray: .space 400
promptNumber: .asciiz "Enter the number of elements ( less than 100 ): "
promptElement: .asciiz "Enter the element: "
arraySize: .space 4
promptMenu: .asciiz  "a. Find summation of numbers stored in the array which is less than an input number.\nb. Find the numbers of even and odd numbers and display them. Note you will display two numbers.\nc. Display the number of occurrences of the array elements NOT divisible by a certain input number.\nd. Quit."
promptChoice: .asciiz "Choose from the menu: "
newLine: .asciiz "\n"
enterInput: .asciiz "Enter an input number: "
even: .asciiz "Number of even:  "
odd: .asciiz "Number of odd: "


.text 
li $v0, 4
la $a0, promptNumber
syscall

li $v0, 5
syscall

move $s0, $v0

addi $t0, $t0, 1000000

while:
	beq $t0, $s0, menu
	li $v0, 4
	la $a0, promptElement
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, myArray($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	j while
	
menu:

	li $v0, 4
	la $a0, promptMenu
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, promptChoice
	syscall
	
	li $v0, 12
	syscall
	
	move $t0, $v0

	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	
	beq $t0, 97, choiceA
	beq $t0, 98, choiceB 
	beq $t0, 99, choiceC 
	beq $t0, 100, choiceD
	j menu 
	
choiceA:

	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t0, 0 # holds the sum
	li $v0, 4
	la $a0, enterInput
	syscall
	
	li $v0, 5
	syscall
	
	move $t3, $v0
	la $t4, myArray
	
	cont1:
	
	lw $t5, 0($t4)
	
	blt $t5,$t3,stageAdd
	j next
	
	stageAdd:
	
		add $t0, $t0, $t5
		j next
	
	next:
		addi $t4, $t4, 4
		addi $t6, $t6,1
		beq $t6, $s0, printA
		j cont1
		
	printA:
		
		li $v0, 1
    		move $a0, $t0
    		syscall
    		
    		li $v0, 4
		la $a0, newLine
		syscall
    		j menu
	
	
choiceB:

	li $v0, 4
	la $a0, newLine
	syscall
	
	
	la $t0, myArray
	li $t3, 0 #odd
	li $t4, 0 #even
		
	check:
		
		lw $t5, 0($t0)
		andi $t6, $t5, 1
		
		beq $t6, 1, addOdd
		beq $t6, 0, addEven
		
		j nextB
		
		addOdd: 
		
			addi $t3, $t3, 1
			j nextB
			
		addEven:
		
			addi $t4, $t4, 1
			j nextB 
		nextB:
		
			addi $t0, $t0, 4
			addi $t2, $t2, 1
			beq $t2, $s0, printB
			j check
			
		printB:
		
			li $v0, 4
			la $a0, odd
			syscall
			
			li $v0, 1
    			move $a0, $t3
    			syscall
    		
    			li $v0, 4
			la $a0, newLine
			syscall
			
			li $v0, 4
			la $a0, even
			syscall
			
			li $v0, 1
    			move $a0, $t4
    			syscall
    		
    			li $v0, 4
			la $a0, newLine
			syscall
			
			j menu
			
choiceC:

	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t0, 0 # holds the number
	li $v0, 4
	la $a0, enterInput
	syscall
	
	li $v0, 5
	syscall
	
	move $t3, $v0
	la $t4, myArray
	
	checkC:
		
		lw $t2, 0($t4)
		div $t2, $t3
		mfhi $t5
		bne $t5, $zero, inc
		j nextC
		
		inc:
		
			addi $t0, $t0, 1
			j nextC
		
		nextC:
		
			addi $t4, $t4, 4
			addi $t6,$t6, 1
			beq $t6, $s0, printC
			j checkC
	printC:
	
		li $v0, 1
    		move $a0, $t0
    		syscall
    		
    		li $v0, 4
		la $a0, newLine
		syscall
    		j menu
		
		
	
	
choiceD:
	li $v0, 10
	syscall
	
	
	
	
	
