
.data

  
 prompta:.asciiz "Enter number a: "
 promptb:.asciiz "Enter number b: "
 promptc:.asciiz "Enter number c: "
 newLine: .asciiz "\n"

 
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

askc:

	li $v0,4
	la $a0, promptc
	syscall

	li $v0, 5
	syscall 

	move $t2, $v0 #t2 = c

calc:

	sub $t3, $t1, $t2
	mult $t3, $t0
	mflo $t4

	andi $t5, $t4, 15 #takes the last 4 bits

	li $v0, 1
   	move $a0, $t5
    	syscall

done:

	li $v0,10
    	syscall
 


