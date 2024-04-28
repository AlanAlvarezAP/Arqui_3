.data
Bas: .asciiz "Ingresar base:"
Exp: .asciiz "Ingresar expo:"
fin: .asciiz "El exponente da"
endl: .asciiz "\n"
errr: .asciiz "Error caso no permitido"
errr_over: .asciiz "OVERFLOW DETECTADO"
.text
.globl start
start:
la $a0,Bas
li $v0,4
syscall
li $v0,5
syscall
addi $t1,$v0,0
la $a0,Exp
li $v0,4
syscall 
li $v0,5
syscall
addi $t0,$v0,0
la $a0,($t1)
la $a1,($t0)


jal pot

la $t1,($a0)
la $a0,($v0)
li $v0,1
syscall
li $v0,4
la $a0,endl
syscall
li $v0,1
la $a0,($t1)
syscall
li $v0,4
la $a0,endl
syscall
li $v0,1
la $t2,($a1)
la $a0,($t2)
syscall


li $v0, 10
syscall
pot:
#a0 = base
#a1 = exponente
#v0 = resultado
sw $fp,-4($sp)
addi $fp,$sp,0
addi $sp,$sp,-20
sw $ra,-8($fp)
sw $a0,-12($fp)
sw $a1,-16($fp)
sw $t3,-20($fp)

bltz $a1, error
bltz $a0,error
beq $a1,$zero,compro_ba

conti:
addi $s0,$zero,0
addi $v0,$zero,1
loop:
  beq $s0,$a1,termin
  mul $v0, $a0,$v0
  addi $s0,$s0,1
  div $t3,$v0,$a0
  blt $v0,$t3,error_over
  j loop
  
error_over:
la $a0,errr_over
li $v0,4
syscall
la $a0,endl
syscall
li $v0, 0
j termin
error:
la $a0,errr
li $v0,4
syscall
la $a0,endl
syscall
li $v0, 0
j termin
compro_ba:
seq $t2, $a0, $zero  
beq $t2, $zero,conti
j error
termin:
lw $t3,-20($fp)
lw $a1,-16($fp)
lw $a0,-12($fp)
lw $ra,-8($fp)
addi $sp,$fp, 0
lw $fp,-4($sp)
jr $ra