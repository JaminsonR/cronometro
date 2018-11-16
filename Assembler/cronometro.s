.data
	format: .asciiz " : "
	nextLine: .asciiz "\n"
.text
.globl main
main:
	li $t0, 25 #number of iterations
	li $t1, 0
	li $t2, 0

	li $t3, 61 #number of iterations
	li $t4, 0
	li $t5, 0

	li $t6, 61 #number of iterations
	li $t7, 0
	li $t8, 0

loop_horas:
	beq $t1, $t0 end
	j loop_minutos 
	addi $t1,$t1,1
	j loop_horas

loop_minutos:
	beq $t4, $t3 loop_horas
	j loop_segundos 
	addi $t4,$t4,1
	j loop_minutos

loop_segundos:

	beq $t7, $t6 loop_minutos
	
	# Printing out the hours
	li $v0,1
	add $a0,$t1,$0
	syscall

	# Printing out :
	li $v0,4
	la $a0,format
	syscall


	# Printing out the minutes
	li $v0,1
	add $a0,$t4,$0
	syscall

	# Printing out :
	li $v0,4
	la $a0,format
	syscall

	# Printing out the seconds
	li $v0,1
	add $a0,$t7,$0
	syscall

	# Printing out :
	li $v0,4
	la $a0,nextLine
	syscall

	# Wait for 1 second
	li $v0, 32
	li $a0, 1000
	syscall


	addi $t7,$t7,1
	j loop_segundos

end:
	# Printing out the number
	li $v0,1
	add $a0,$t2,$0
	syscall

	# End Program
	li $v0,10
	syscall
