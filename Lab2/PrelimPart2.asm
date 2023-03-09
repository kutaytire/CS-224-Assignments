
.data

promptArraySize: .asciiz "Enter the array size: "
prompt: .asciiz "Enter a number: "
printMin: .asciiz "Minimum number is: "
printMax: .asciiz "Maximum number is: "
printSum: .asciiz "Sum is: "
printPalindrome: .asciiz "Print 1 if palindrome 0 if not: "
newLine: .asciiz "\n"

.text

main:

jal createArray

move $a0, $v0 # $a0 has the adress
move $a2, $v0 # $a2 has the adress
move $a1, $v1 # $a1 has the size

jal arrayOperations

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


arrayOperations:

addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)


jal min

move $s0, $v0

li $v0,4
la $a0, printMin
syscall

li $v0, 1
move $a0,$s0
syscall

move $a0, $a2
jal max
move $s1, $v0

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printMax
syscall

li $v0, 1
move $a0,$s1
syscall

move $a0, $a2
jal sum 

move $s2, $v0

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printSum
syscall

li $v0, 1
move $a0,$s2
syscall

move $a0, $a2
jal isPalindrome

move $s3, $v0

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printPalindrome
syscall

li $v0, 1
move $a0,$s3
syscall

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20

jr $ra

######################################

min:

addi $sp, $sp, -16
sw $s0, 0($sp) #counter
sw $s1, 4($sp) #holding min
sw $s2, 8($sp) #adress
sw $s3, 12($sp) #holding element

move $s2, $a0
lw $s1, 0($s2) #$t1 holds the min

whileMin:

beq $s0, $a1, returnOne
lw $s3, 0($s2)
slt $at, $s3, $s1
bne $at, $zero, newMin
j minNext

newMin:

move $s1, $s3

minNext:

addi $s0, $s0, 1
addi $s2, $s2, 4
j whileMin

returnOne:

move $v0, $s1

addi $sp, $sp, 16
lw $s0, 0($sp) #counter
lw $s1, 4($sp) #holding min
lw $s2, 8($sp) #adress
lw $s3, 12($sp) #holding element

jr $ra

######################################


max:

addi $sp, $sp, -16
sw $s0, 0($sp) #counter
sw $s1, 4($sp) #holding max
sw $s2, 8($sp) #adress
sw $s3, 12($sp) #holding element

move $s2, $a0
lw $s1, 0($s2) #$t1 holds the max
li $s0, 0

whileMax:

beq $s0, $a1, returnTwo
lw $s3, 0($s2)
slt $at, $s3, $s1
beq $at, $zero, newMax
j maxNext

newMax:

move $s1, $s3

maxNext:

addi $s0, $s0, 1
addi $s2, $s2, 4
j whileMax

returnTwo:

move $v0, $s1

addi $sp, $sp, 16
lw $s0, 0($sp) #counter
lw $s1, 4($sp) #holding max
lw $s2, 8($sp) #adress
lw $s3, 12($sp) #holding element

jr $ra

######################################

sum:

addi $sp, $sp, -16
sw $s0, 0($sp) #counter
sw $s1, 4($sp) #holding max
sw $s2, 8($sp) #adress
sw $s3, 12($sp) #holding element

li $s0, 0
li $s1, 0
move $s2, $a0 #address

whileSum:

beq $s0, $a1, returnThree
lw $s1, 0($s2) 
add $s3, $s3, $s1
addi $s0, $s0, 1
addi $s2, $s2, 4

j whileSum

returnThree:

move $v0, $s3

addi $sp, $sp, 16
lw $s0, 0($sp) #counter
lw $s1, 4($sp) #holding max
lw $s2, 8($sp) #adress
lw $s3, 12($sp) #holding element

jr $ra

######################################

isPalindrome:

addi $sp, $sp, -24
sw $s0, 0($sp) #counter
sw $s1, 4($sp) #holding max
sw $s2, 8($sp) #adress
sw $s3, 12($sp) #holding element
sw $s4, 16($sp) #adress
sw $s5, 20($sp) #holding element

move $s0, $a0 #address
move $s1, $a0 #address

sll $s2, $a1, 2
addi $s2, $s2, -4 #holds the last index
add $s2, $s2, $s0

li $s3, 0 #counter


whilePalindrome:

beq $s3, $a1, returnFour
lw $s4, 0($s1)
lw $s5, 0($s2)

bne $s4, $s5, notPal
addi $s1, $s1, 4
addi $s2, $s2, -4
addi $s3, $s3, 1

j whilePalindrome

notPal:

li $v0, 0
j returnFour

Pal:

li $v0, 1

returnFour:

addi $sp, $sp, 24
lw $s0, 0($sp) #counter
lw $s1, 4($sp) #holding max
lw $s2, 8($sp) #adress
lw $s3, 12($sp) #holding element
lw $s4, 16($sp) #adress
lw $s5, 20($sp) #holding element

jr $ra





