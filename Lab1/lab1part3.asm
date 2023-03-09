
.data

  
 prompta:.asciiz "Enter number a: "
 promptb:.asciiz "Enter number b: "
 promptc:.asciiz "Enter number c: "
 newLine: .asciiz "\n"
 message: .asciiz "Division by zero"

 
.text 

aska:

	li $v0,4
	la $a0, prompta
	syscall

	li $v0, 5
	syscall 

	move $t0, $v0 #t0 = a

askb:

	li $v0,4
	la $a0, promptb
	syscall

	li $v0, 5
	syscall 

	move $t1, $v0 #t1 = b


calc:
	
	div $t1, $t0
	mfhi $t2
	
	bne $t2,$zero, notZero
	j messageZ
	
notZero:	
	sll $t3, $t1, 2 #4b
	
	div $t3, $t2
	mflo $t4 


	mult $t0, $t0
	mflo $t5
	
	mult $t5, $t0
	mflo $t5
	
	sub $t6, $t5, $t4
	
	li $v0, 1
   	move $a0, $t6
    	syscall
    	
messageZ:
	
	li $v0,4
	la $a0, message
	syscall
	

done:

	li $v0,10
    	syscall
 


