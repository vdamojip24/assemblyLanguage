#Vishal Damojipurapu
#vdamojip@ucsc.edu
#LAB 5: DECIMAL TO BINARY CONVERTER
#2/28/18
#1D, Carlos Ramirez

#PSUEDOCODE:

#lw $s2 $a1
#(loop)
#lb $t1, $s2 
#check to see if input is a negative number 
#if the inputted number has a "-", then set the s1 register to 1 to indicate its a negative
#also increment by one because you want to skip over the "-" character from the input, but still make sure you know if its a negative or not 
#subi t1 t1 48 (converts ascii to regular number) 
#multi s0 s0 10 
#add s0 s0 t1 
#addi s2 s2 1 (increment inside the loop)

#print out integer in base 10

#check to see if the number is negative by checking the $s1 register, and if it is 1, then branch to the 2SC branch
#else loop through the integer and AND it with 2^31 to print out one specific bit
#then shift the bit from 2^31 to 2^30 and continue till you print out every bit, thus printing out the binary representation
#print 0 if the AND'D value is a 0 ,else print 1

#to perform 2SC, flips the bits using the NOT operator and then add 1 

#move the number back into $s0 at the end because that is how the script checks it for grading purposes
#EXIT

#END OF PSUEDOCODE


.text
main: 

	li $v0, 4 #load immediate value integer into register $v0 for printing string
	la $a0, input #loads the address of the input into register $a0 
	syscall

	lw $s0, ($a1) #loads the ascii address into the $s0 register


	la $t0, ($s0) #loads address into temp register for manipulation
	lb $t1, ($t0) #loads the first byte into temp register
	
	li $t4, 2147483648 #2^31 in base 10
			
	#converts input into integer 
	CONVERTDECIMAL:
			lb $t1, ($t0)
			beq $t1, 0, PRINTINT #loop ternminating condition
			beq $t1, 45, CHECKNEGATIVE #when a negative is inputed, then branch to that loop
			subi $t2, $t1, 48 #subtracts '0' to convert input into a integer in base 10
			mulu  $t3, $t3, 10 #shifts over one place 
			addu $t3, $t3, $t2 # integer in base 10 that is outputted eventually to user 
			addi $t0, $t0, 1 #increments loop
			b CONVERTDECIMAL 
	
	#prints out integer after converting the program argument
	PRINTINT:
			li $v0, 1
			add $a0, $t3, 0 
			syscall 
		
			b PRINTBINARY
	
	#prints out "This number in binary is:"
	PRINTBINARY:
			li $v0, 4 
			la $a0, newLine #adds a newline for spacing the output 
			syscall
			
			li $v0, 4 #load immediate value integer into register $v0 for print string
			la $a0, printBinary #prints out "This number in binary is:"
			syscall
			
			beq $s1, 1, TWOSC #indicates we have a negative number, so do twos complement if $s1 contains a 1
			
			b CONVERTBINARY

	#converts the base 10 value into its binary representation
	CONVERTBINARY:	
			beq $t4, 0, EXIT  #terminating condition where if we reach a null value, then we exit
			
			and $t5, $t3, $t4 #ANDS two values together for the purpose of printing out one specific bit later
			
			srl $t4, $t4, 1 #shifts over the 1 for the purpose of continuing to print out one specific bit later
			
			beqz $t5, PRINTZERO #prints 0 if there is a 0 bit
			
			li $t7, 1 #else prints 1 if there is a positive number(1)
			
			li $v0, 1
			add $a0, $t7, 0 
			syscall 
					
			b CONVERTBINARY
	
	#performs twos complement on our value if its a negative number	
	TWOSC:		
			beq $t4, 0, EXIT  
			not $t3, $t3 #flips bits
			addi $t3, $t3, 1 #adds 1
			
			b CONVERTBINARY  
	
	#indicates the number is negative and prints out the negative sign
	CHECKNEGATIVE: 
			li $s1, 1 #1 in $s1 indicates that the number is negative 
			li $v0, 4 
			la $a0, negativeSign #prints out the negative sign
			syscall
			
			addi $t0, $t0, 1 #increments by one because we want to ignore the "-" that is inputted 
			b CONVERTDECIMAL
	
	#prints out 0 when printing out the binary representaion
	PRINTZERO:
			li $v0, 1 
			add $a0, $t6, $t6 
			syscall	
			
			b CONVERTBINARY		
	
	#terminates program		
	EXIT:
 
 			move $s0, $t3 #move the value back into $s0 for grading purposes
 			li $v0, 10 #loads a 10 into register $v0, which causes the program to halt (ends program)
			syscall 

.data
	input: .asciiz "User input number:\n"
	printBinary: .asciiz "This number in binary is:\n" 
	newLine: .asciiz "\n"
	negativeSign: .asciiz "-" 
