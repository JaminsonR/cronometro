.data
	format: .asciiz " : "
	timerMessage: .asciiz "\nTimer has been completed!\n\n\n"
	nextLine: .asciiz "\n\n"
	menu: .asciiz "\nSelect an option: \n1.-Clock\n2.-Timer\n\n"
	timerInput: .asciiz "\nInput the amount of minutes to count: \n\n"
	

	beep: .byte 72
	duration: .byte 100
	volume: .byte 127
.text
.globl main
main: 

	# Printing out menu
	li $v0,4
	la $a0,menu
	syscall

	# Get option from user
	li $v0,5
	syscall
	add $s1,$v0, $0

	# execute option
	addi $t1, $0, 1
	addi $t2, $0, 2
	beq $s1, $t1, exe_clock
	beq $s1, $t2, exe_timer

# Execute timer
exe_timer:
	
	# Printing out timerInput
	li $v0,4
	la $a0,timerInput
	syscall

	# Get minutes from user
	li $v0,5
	syscall
	add $s0,$v0, $0
	
	jal timer
	j end

# Execute clock
exe_clock:
	jal clock
	j end


timer:

#reserving memory for $s0
	addi $sp, $sp, -4
	sw $s0,0($sp)

	add $t1, $0, $0 # Seconds
	add $t2, $0, $0 # Minutes
	add $t3, $0, $0 # Hours

while: 
	beq $t2, $s0, print_message
	addi $t4, $0, 60
if_seconds:

	beq $t1, $t4, add_minute
if_minutes:
	beq $t2, $t4, add_hour
	
print_time:
	

	# Printing out the hours
	li $v0,1
	add $a0,$t3,$0
	syscall

	# Printing out :
	li $v0,4
	la $a0,format
	syscall

	# Printing out the minutes
	li $v0,1
	add $a0,$t2,$0
	syscall
	
	# Printing out :
	li $v0,4
	la $a0,format
	syscall

	# Printing out the seconds
	li $v0,1
	add $a0,$t1,$0
	syscall

	# Printing out \n
	li $v0,4
	la $a0,nextLine
	syscall

	# Wait for 1 second
	li $v0, 32
	li $a0, 1000
	syscall

	addi $t1, $t1, 1
	j while



add_minute:
	
	addi $t2, $t2, 1
	addi $t1, $0, 0
	
	j if_minutes

add_hour:

	addi $t3, $t3, 1
	addi $t2, $0, 0

	j print_time


print_message:
	# Printing out message
	li $v0,4
	la $a0,timerMessage
	syscall

	# Makes beep sound
	li $v0,31
	la $a0,beep # Beep sound
	lbu $a0 0($a0) 
	addi $t2,$a0,12
	la $a1,duration # Beep duration
	lbu $a1, 0($a1)

	move $t2,$a0
	move $t3,$a1
	la $a3,volume # Beep volume
	lbu $a3, 0 ($a3)
	syscall

	# Restoring $s0 from stack pointer
	lw $s0,0($sp)
	addi $sp, $sp, 4

	j end_function



clock:
	li $t0, 24 #number of iterations
	li $t1, -1
	li $t2, 0
loop_horas:
	beq $t1, $t0, end_function

	li $t3, 60 #number of iterations
	li $t4, -1
	li $t5, 0

	addi $t1,$t1,1 # Adds 1 to counter

	j loop_minutos 
	

loop_minutos:

	beq $t4, $t3, loop_horas

	li $t6, 60 #number of iterations
	li $t7, 0
	li $t8, 0

	addi $t4,$t4,1 # Adds 1 to counter

	j loop_segundos 

	

loop_segundos:

	beq $t7, $t6, loop_minutos
	
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

	# Printing out \n
	li $v0,4
	la $a0,nextLine
	syscall

	# Wait for 1 second
	li $v0, 32
	li $a0, 1000
	syscall


	addi $t7,$t7,1
	j loop_segundos

end_function:
	jr $ra
end:
	# End Program
	li $v0,10
	syscall
