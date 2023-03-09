
.data

promptNumber: .asciiz "Enter the number: "
promptShiftAmount: .asciiz "Enter the shift amount: "
newLine: .asciiz "\n"
printShiftAmount: .asciiz "The shift amount is: "
printShiftedNumber: .asciiz "Shifted number is: "
printNumberToShift: .asciiz "Number to be shifted is: "
directionL: .asciiz "The direction is left"
directionR: .asciiz "The direction is right"


.text

li $v0,4
la $a0, promptNumber
syscall


li $v0, 5
syscall 

done:

move $a2, $v0 #number in $a0

li $v0,4
la $a0, promptShiftAmount
syscall

li $v0, 5
syscall 

move $a0, $a2
move $a1, $v0 #shift in $a

jal operate

li $v0, 10
syscall


operate:

addi $sp, $sp, -12 # allocate room for 2 items
sw $ra, 0($sp)	
sw $s0, 4($sp)
sw $s1, 8($sp)

jal shiftLeftCircular

move $s0, $v0

jal shiftRightCircular

move $s1, $v0

li $v0,4
la $a0, printNumberToShift
syscall

li $v0, 1
move $a0,$a2
syscall

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printShiftAmount
syscall

li $v0, 1
move $a0,$a1
syscall

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, directionL
syscall

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printShiftedNumber
syscall

li $v0, 34
move $a0,$s0
syscall

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, directionR
syscall

li $v0,4
la $a0, newLine
syscall

li $v0,4
la $a0, printShiftedNumber
syscall

li $v0, 34
move $a0, $s1
syscall

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)

addi $sp, $sp, 12

jr $ra

shiftLeftCircular:

rol $v0, $a0, $a1
jr $ra


shiftRightCircular:

ror $v0, $a0, $a1
jr $ra










