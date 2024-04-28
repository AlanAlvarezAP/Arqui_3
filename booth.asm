.data
endl: .asciiz "\n"
info: .asciiz "Dame el numero "

.text
.globl start
start:
la $a0, info
li $v0, 4
syscall
li $v0, 5
syscall
addi $t3, $v0, 0
add $t1, $zero, $zero
la $a0, info
li $v0, 4
syscall
li $v0, 5
syscall
addi $t2, $v0, 0
addi $t4, $zero, 32
addi $s4, $zero, 1 

loop:
beq $t4, $zero, fin
andi $t6, $t3, 1
subi $t4, $t4, 1
bne $s4, $t6, caso_uno
j caso_cero

caso_uno:
bne $t1, $s4, caso_shift
sub $t0, $t0, $t2
j caso_shift 

caso_cero:
bne $t1, $zero, caso_shift
add $t0, $t0, $t2
j caso_shift

caso_shift:
andi $t7, $t0, 1 
sra $t0, $t0, 1
sll $t7, $t7, 31
andi $t8, $t3, 1
srl $t3, $t3, 1
or $t3, $t3, $t7
j loop

fin:
move $a0, $t0 
li $v0, 1 
syscall 

move $a0, $t3 
li $v0, 1  
syscall 

li $v0, 10 
syscall 
