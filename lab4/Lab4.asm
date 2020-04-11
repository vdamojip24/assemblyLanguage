#Vishal Damojipurapu
#vdamojip@ucsc.edu
#LAB 4: DEADBEEF in MIPS
#2/16/18
#1D, Carlos Ramirez

.text
main:
	#prompts user to enter integer
	li $v0, 4 #load immediate value integer into register $v0 for print string
	la $a0, prompt #loads the address of the prompt into register $a0 
	syscall
	
	# Read the integer and save it in $s0
	li $v0, 5 #loads integer (prompted N) into register #v0 
	syscall
	move $s0, $v0 #moves the integer into a save register $s0
 
 	li $t0, 1 #loads temporary register $t0 with 1  
 	
 	LOOP: 	
 		bgt $t0, $s0, EXIT #exits when N is reached 
 		
		#checking if the number is DEADBEEF (n % 36 == 0)
		rem $t1, $t0, 36 #temporary register $t1 contains whatever is in $t0 mod 36
		beqz $t1, IF1
		
		#checking if the number is BEEF (n % 9 == 0)
		rem $t2, $t0, 9 #temporary register $t2 contains whatever is in $t0 mod 9
		beqz $t2, IF2
		
		#checking if the number is DEAD (n % 4 == 0)
		rem $t3, $t0, 4 #temporary register $t3 contains whatever is in $t0 mod 4
		beqz $t3, IF3
 		
 		bnez $t1, IF4 #if the number isn't DEAD, BEEF, or DEADBEEF, the number itself is printed 
 	
 	EXIT:
 		#exits program
 		li $v0, 10 #loads a 10 into register $v0, which causes the program to halt (ends program)
		syscall 
 			
 	IF1:	
 		li $v0, 4 #loads 4 into register $v0 for print string
 		la $a0, DEADBEEF #loads address into $a0 to print out DEADBEEF
 		syscall 
 		
 		beq $t0,$s0, EXIT #exits if N is reached
 		
 		li $v0, 4 #loads 4 into register $v0 for print string
		la $a0, newLine #loads address of newLine into $a0, which allows us to go to a newline for each number/word
		syscall
 		
 		addi $t0, $t0, 1 #increments the temporary register $t0 
		b LOOP #calls the loop
	
	IF2:
		li $v0, 4 #loads 4 into register $v0 for print string
 		la $a0, BEEF #loads address into $a0 to print out BEEF
 		syscall 
 		
 		beq $t0,$s0, EXIT  #exits if N is reached
 		
 		li $v0, 4 #loads 4 into register $v0 for print string
		la $a0, newLine #loads address of newLine into $a0, which allows us to go to a newline for each number/word
		syscall
 		
 		addi $t0, $t0, 1		
		b LOOP
		
	IF3:
		li $v0, 4 #loads 4 into register $v0 for print string
		la $a0, DEAD #loads address into $a0 to print out DEAD
		syscall 
		
		beq $t0,$s0, EXIT  #exits if N is reached
		
		li $v0, 4 #loads 4 into register $v0 for print string
		la $a0, newLine #loads address of newLine into $a0, which allows us to go to a newline for each number/word
		syscall
		
		addi $t0, $t0, 1
		b LOOP
		
	IF4:
		#printing out the numbers from 1 till the inputted number
 		li $v0, 1 #loads 1 into register $v0 to print out integer
 		la $a0, ($t0) #loads address of integer that is in $t0 to $a0 and prints the integer to output
 		syscall
 		
 		beq $t0,$s0, EXIT 
 		
 		li $v0, 4 #loads 4 into register $v0 for print string
		la $a0, newLine #loads address of newLine into $a0, which allows us to go to a newline for each number/word
		syscall
 		
 		#incrememnts the counter 
 		addi $t0, $t0, 1
 		b LOOP
		
.data 
prompt: .asciiz "Please enter a number N: "
newLine: .asciiz "\n"
DEADBEEF: .asciiz "DEADBEEF"
BEEF: .asciiz "BEEF"
DEAD: .asciiz "DEAD"


	
