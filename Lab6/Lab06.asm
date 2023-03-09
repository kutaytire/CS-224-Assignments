.data

welcome: .asciiz "Welcome to the program!"
prompt: .asciiz "Please select an option: "
newLine: .asciiz "\n"
displayMenu: .asciiz " 1.)Select the dimension and specific elements \n 2.)Select only the dimension \n 3.)Display an element with row and column numbers \n 4.)Display entire matrix \n 5.)Copy matrix \n 6.)Quit "
askMatrixSize: .asciiz "Enter the size of the matrix (N) (At most 8): "
promptElements: .asciiz "Please enter the elements: "
promptRowIndex: .asciiz "Please enter the row number: "
promptColumnIndex: .asciiz "Please enter the column number: "
errorMsg: .asciiz "Entered number is out of bounds."
space: .asciiz " "
askPreferance: .asciiz "1. Row by Row \n2. Column by Column: "
parS: .asciiz "("
comma: .asciiz ","
parE: .asciiz ")"
printAt: .asciiz "The value at "

.text

la $a0, welcome
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall

cycle:

la $a0, displayMenu
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall

la $a0, prompt
li $v0, 4
syscall

li $v0, 5
syscall

move $s0, $v0

beq $s0, 1, prompt1
beq $s0, 2, prompt2
beq $s0, 3, prompt3
beq $s0, 4, prompt4
beq $s0, 5, prompt5
beq $s0, 6, prompt6

j cycle

prompt6:

li $v0, 10
syscall

prompt1:

la $a0, askMatrixSize
li $v0, 4
syscall

li $v0, 5
syscall


move $s1, $v0 #s1 holds the size

mul $t1, $s1, $s1
sll $t2, $t1, 2

move $a0, $t2
li $v0, 9
syscall

move $s2, $v0 #s2 holds the starting adress
move $s7, $v0

li $t0, 0

ask:

beq $t0, $t1, done1

la $a0, promptElements
li $v0, 4
syscall

li $v0, 5
syscall

sw $v0, 0($s2)
addi $s2, $s2, 4
addi $t0, $t0, 1

j ask

done1:

j cycle

prompt2:


la $a0, askMatrixSize
li $v0, 4
syscall

li $v0, 5
syscall


move $s1, $v0 #s1 holds the size

mul $t1, $s1, $s1
sll $t2, $t1, 2

move $a0, $t2
li $v0, 9
syscall

move $s2, $v0 #s2 holds the starting adress
move $s7, $v0

li $t0, 0
li $t3, 1

while2:
beq $t0, $t1, done2

sw $t3, 0($s2)
addi $s2, $s2, 4
addi $t0, $t0, 1
addi $t3, $t3, 1

j while2

done2:

j cycle

prompt3:

la $a0, promptRowIndex
li $v0, 4
syscall

li $v0, 5
syscall

move $a2, $v0

bgt $v0, $s1 error
move $t0, $v0

la $a0, promptColumnIndex
li $v0, 4
syscall

li $v0, 5
syscall

move $a3, $v0

bgt $v0, $s1 error
move $t1, $v0

addi $t0, $t0, -1
addi $t1, $t1, -1

sll $t0, $t0, 2
sll $t1, $t1, 2

mul $t0, $t0, $s1
add $t2, $t0, $t1

add $t2, $s7, $t2
lw $t0, 0($t2)

la $a0, printAt
li $v0, 4
syscall

la $a0, parS
li $v0, 4
syscall

li $v0, 1
move $a0, $a2
syscall

la $a0, comma
li $v0, 4
syscall

li $v0, 1
move $a0, $a3
syscall

la $a0, parE
li $v0, 4
syscall

la $a0, space
li $v0, 4
syscall


li $v0, 1
move $a0, $t0
syscall

la $a0, newLine
li $v0, 4
syscall

j cycle

prompt4:

move $t2, $s7
li $t3, 0

mul $t4, $s1, $s1
li $t0, 0

iter2:

beq $t3, $t4, done4
beq $t0, $s1, enterLine

lw $t1, 0($t2)
add $t2, $t2, 4
addi $t3, $t3, 1
addi $t0, $t0, 1

li $v0, 1
move $a0, $t1
syscall

la $a0, space
li $v0, 4
syscall


j iter2

enterLine:

la $a0, newLine
li $v0, 4
syscall

li $t0, 0

j iter2

done4:

la $a0, newLine
li $v0, 4
syscall

j cycle

prompt5:

la $a0, askPreferance
li $v0, 4
syscall

li $v0, 5
syscall

beq $v0, 1, rowBy
beq $v0, 2, columnBy

j cycle


error: 

la $a0, errorMsg
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall


j cycle

rowBy: #using the indexes of the elements in each row

mul $t1, $s1, $s1
sll $t2, $t1, 2

move $a0, $t2
li $v0, 9
syscall

move $s6, $v0 #adress of the new matrix
move $t4, $v0
move $t1, $s7

mul $t2, $s1, $s1

li $t0, 0

copyR:

beq $t0, $t2, doneRCopy
lw $t3, 0($t1)
sw $t3, 0($t4)

addi $t1, $t1, 4
addi $t4, $t4, 4
addi $t0, $t0, 1

j copyR

doneRCopy:

j cycle

columnBy: #using the indexes of elements in each column

mul $t1, $s1, $s1
sll $t2, $t1, 2

move $a0, $t2
li $v0, 9
syscall

move $s6, $v0 #adress of the new matrix
move $t4, $v0
move $t1, $s7

mul $t2, $s1, $s1

li $t0, 0
li $t5, 0

mul $t8, $s1, 4

move $t6, $t4
move $t7, $t1


firstP:

beq $t0, $t2, doneC
beq $t5, $s1, secondP

lw $t3, 0($t1)
sw $t3, 0($t4)

add $t1, $t1, $t8
add $t4, $t4, $t8
addi $t5, $t5, 1
addi $t0, $t0, 1

j firstP

secondP:

addi $t6, $t6, 4
move $t4, $t6

addi $t7, $t7, 4
move $t1, $t7

li $t5, 0

j firstP

doneC:

j cycle
