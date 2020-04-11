#Vishal Damojipurapu
#vdamojip@ucsc.edu
#LAB 6: VIGENERE CIPHER
#3/9/18
#1D, Carlos Ramirez



#PSEUDOCODE
#check if character is lower case
#perform arithmetic to encrypt char
#begin encryptString going character by character (loop) and calling encryptChar
#make sure to have conditions for each edge case: input > key, input isn't an alphabet (check ascii values)
#also check if the input is max 30 characters
#branch out into separate brances for each case and make sure you print out inputted non-alphabet characters
#update stack pointers as you go and call jal to jump and jr to go back
#move to decryptChar and perform algorithm on character
#check the same edge cases and branch accordingly
#make sure to check if you get a negative number when performing algorithm and add 26 to make it positive


.text

#encrypts a given input char using an inputted key and outputs an encrypted char
EncryptChar:

	bgt $a0, 90, __EncryptCharLower#checks if the char is lower case
	sub $t0, $a0, 65 #subtracts by ascii value of A for offset 
	sub $t1, $a1, 65
	add $t2, $t0, $t1
	rem $t2, $t2, 26 
	add $t2, $t2, 65
	move $v0, $t2 #t0 is the encrypted char thats moved to v0
	jr $ra 
	
#same as previous function except this one is for lowercase
__EncryptCharLower:
	
	sub $t0, $a0, 97 #97 is the ascii value for lowercase a
	sub $t1, $a1, 65 
	add $t2, $t0, $t1
	rem $t2, $t2, 26
	add $t2, $t2, 97
	move $v0, $t2 	
	jr $ra 

#encrypts inputted string using inputted key into an encrypted output string	
EncryptString:
	
	la $t3, ($a0) #t3 has the address of inputted character
	la $t4, ($a1) #t4 has the address of the inputted key
	la $t5, ($a1)# saving the address in a separate register for later use
	
	
	#loads address and begins encrypting string character by character
	__LoadingAddress:	
	
		lb $a0, ($t3)#loads first byte and begins 
		lb $a1, ($t4)
	
		beq $t9, 30, __EXIT #ensures max output is going to be 30 characters
		beq $a0, 0, __EXIT 
		beq $a1, 0, __InputLongerThanKey#checks if the input is longer than the key
		blt $a0, 65, __ifLessThanA #checks if the input is in the range
		bgt $a0, 65, __ifGreaterThanA
		
		#code given by the TA for stack and also begins encrypting each character 
		sw $ra, ($sp)
		subi $sp, $sp, 4				
		jal EncryptChar
		#sb $v0, ($a2)
		addi $sp, $sp, 4
		lw $ra, ($sp)
		sb $v0, ($a2)
		
		#addi $t9, $t9, 1
		#move $a0, $a2
		#li $v0, 4
		#syscall 
		addi $t9, $t9, 1 #incrementer for the max 30 characters
		addi $t3, $t3, 1 #increments loop byte by byte
		addi $t4, $t4, 1
		addi $a2, $a2, 1
		
		b __LoadingAddress

#if input is longer than the key, then restart the key from the beginning
__InputLongerThanKey:
		
	la $t4, ($t5)#resets address to beginning
	b __LoadingAddress
	
#if the character's ascii value is less than 65
__ifLessThanA:
			
	beq $a0, 0, __EXIT 	
		
	sb $a0, ($a2)#stores the byte from a2 into a0 
	move $a0, $a2
	
	addi $t3, $t3, 1 #increments loop
	addi $a2, $a2, 1
	addi $t9, $t9, 1
	
	b __LoadingAddress

#if the character's ascii value is greater than 65
__ifGreaterThanA:
		
	beq $a0, 0, __EXIT 	
	bgt $a0,90, __ifGreaterThanZ#if the ascii value of the inputted character is greater than 90
		
	#updates stack pointer and encrypts character by character
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal EncryptChar
	#sb $v0, ($a2)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	sb $v0, ($a2)
		#move $a0, $a2
		#li $v0, 4
		#syscall 
	addi $t3, $t3, 1 #increments loop
	addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t9, $t9, 1
		
	b __LoadingAddress
 
 #if the ascii value of the inputted character is greater than 90
 __ifGreaterThanZ:
		
	beq $a0, 0, __EXIT 	
	blt $a0, 97, __ifLessThana #if inputted ascii character's value is less than 97
	bgt $a0, 122, __ifGreaterThanz #if inputted ascii character's value is greater than 122
		
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal EncryptChar
	#sb $v0, ($a2)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	sb $v0, ($a2)
		#move $a0, $a2
		#li $v0, 4
		#syscall 

	addi $t3, $t3, 1 #increments loop
	addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t9, $t9, 1
	
	b __LoadingAddress

#if inputted ascii character's value is less than 97
__ifLessThana:
		
	beq $a0, 0, __EXIT 
	#sb $a0, ($a2)
	move $a0, $a2
	sb $v0, ($a2)
		#move $a0, $a2
		#li $v0, 4
		#syscall  
 	addi $t3, $t3, 1 #increments loop
	#addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t9, $t9, 1
	
	b __LoadingAddress

#if inputted ascii character's value is greater than 122
__ifGreaterThanz:
		
	beq $a0, 0, __EXIT 	
	#sb $a0, ($a2)
	move $a0, $a2
	sb $v0, ($a2)
		
	#move $a0, $a2
	#li $v0, 4
	#syscall 
	addi $t3, $t3, 1 #increments loop
	#addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t9, $t9, 1
	b __LoadingAddress

#decrypts the encrypted character using the key back into what was inputted	
DecryptChar:

	bgt $a0, 90, __DecryptCharLower#branches out if encrypted character is lower case
	sub $t0, $a0, 0 #t0 is the encrypted character
	sub $t1, $a1, 0 #t1 is the key 
	sub $t2, $t0, $t1
	bltz $t2, __DecryptCharNegative #branches out when you get a negative value 
	rem $t2, $t2, 26 
	add $t2, $t2, 65
	move $v0, $t2 #t0 is the encrypted char thats moved to v0
	jr $ra 

#decrypts the encrypted character if it is lower case
__DecryptCharLower:
	
	sub $t0, $a0, 32
	sub $t1, $a1, 0
	sub $t2, $t0, $t1
	bltz $t2, __DecryptCharNegative #if lower case character becomes negative after performing arithmetic, branch out
	rem $t2, $t2, 26
	add $t2, $t2, 97
	move $v0, $t2 
	
	jr $ra 

#when subtracting ascii values, make sure to fix negative number issue by adding 26 to make it positive again
__DecryptCharNegative:

	add $t2, $t2, 26
	rem $t2, $t2, 26 
	add $t2, $t2, 65 
	move $v0, $t2 #t0 is the encrypted char thats moved to v0
	jr $ra 

#decrypts a given encrypted string using key back into the original inputted string
DecryptString:
	
	
	la $t3, ($a0)#t3 has the address of inputted encrypted character
	la $t4, ($a1)#t4 has the address of the inputted key 
	la $t5, ($a1)# saving the address in a separate register for later use
	
	#loads address and begins decrypting string character by character
	__LoadingAddressForDecrypt:	
	
		lb $a0, ($t3)#loads byte to begin loop
		lb $a1, ($t4)
	
		beq $t8, 30, __EXIT
		beq $a0, 0, __EXIT 
		beq $a1, 0, __InputLongerThanKeyForDecrypt#checks if input is longer than key 
		blt $a0, 65, __ifLessThanAForDecrypt #branches out if ascii value of character is less than 65
		bgt $a0, 65, __ifGreaterThanAForDecrypt #branches out if ascii value of character is greater than 65
		
		
		#code given by the TA for updating stack pointer 
		sw $ra, ($sp)
		subi $sp, $sp, 4
		jal DecryptChar #begins decrypting character by character 
		#sb $v0, ($a2)
		addi $sp, $sp, 4
		lw $ra, ($sp)
	
		sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall 

	
		addi $t3, $t3, 1 #increments loop
		addi $t4, $t4, 1
		
		addi $a2, $a2, 1
		addi $t8, $t8, 1
		b __LoadingAddressForDecrypt

#if input is longer than the key, then restart the key from the beginning		
__InputLongerThanKeyForDecrypt:
		
	la $t4, ($t5)#resets address to beginning
	b __LoadingAddressForDecrypt

#if the character's ascii value is less than 65
__ifLessThanAForDecrypt:
			
		
	beq $a0, 0, __EXIT 	
			
	sb $a0, ($a2)
	move $a0, $a2
		#sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall 
	addi $t3, $t3, 1 #increments loop
		#addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	
	b __LoadingAddressForDecrypt

#if inputted character's ascii value is greater than 65
__ifGreaterThanAForDecrypt:
		
	beq $a0, 0, __EXIT 	
	bgt $a0,90, __ifGreaterThanZForDecrypt #branch out if character's ascii value is greater than that of Z's
		
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal DecryptChar
	#sb $v0, ($a2)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall 
	addi $t3, $t3, 1 #increments loop
	addi $t4, $t4, 1
		
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	b __LoadingAddressForDecrypt

#if the ascii value of the inputted character is greater than 90(Z)
__ifGreaterThanZForDecrypt:
		
	beq $a0, 0, __EXIT 	
	blt $a0, 97, __ifLessThanaForDecrypt #branches out if inputted character's ascii value is lesser than that of a's
	bgt $a0, 122, __ifGreaterThanzForDecrypt #branches out if inputted character's ascii value is greater than that of z's
		
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal DecryptChar	
		#sb $v0, ($a2)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall 
	addi $t3, $t3, 1 #increments loop
	addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t8, $t8, 1
		
	b __LoadingAddressForDecrypt

#if inputted character's ascii value is greater than that of a's (97)
__ifLessThanaForDecrypt:
		
	beq $a0, 0, __EXIT 	
	#sb $a0, ($a2)
	move $a0, $a2
	sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall  
 	addi $t3, $t3, 1 #increments loop
		#addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	
	b __LoadingAddressForDecrypt
		
#if inputted character's ascii value is greater than that of z's (122)		
__ifGreaterThanzForDecrypt:
		
	beq $a0, 0, __EXIT 	
	#sb $a0, ($a2)
	move $a0, $a2
	sb $v0, ($a2)
		
		#move $a0, $a2
		#li $v0, 4
		#syscall 
	addi $t3, $t3, 1 #increments loop
		#addi $t4, $t4, 1
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	
	b __LoadingAddressForDecrypt

#exit call
__EXIT:
	#move $a2, $v0
	
	#li $v0, 11 
	#add $a0, $a2, 0
	#syscall
	
	#li $v0, 10
 	#syscall
 	
 	jr $ra
