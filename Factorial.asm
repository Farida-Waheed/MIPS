.data
    prompt: .asciiz "Enter a number to find its factorial:"
    result: .asciiz "\nThe factorial of the number is :"
    theNumber: .word 0
    theAnswer: .word 0
    
.text
main:
   # Read the number from the user
   li $v0, 4               # Load immediate: syscall code for printing a string
   la $a0, prompt          # Load address: address of the prompt message
   syscall                 # System call to print the prompt message
   li $v0, 5               # Load immediate: syscall code for reading an integer
   syscall                 # System call to read the integer entered by the user
   sw $v0, theNumber       # Store the entered number in the memory location theNumber

   # Call the factorial function
   lw $a0, theNumber       # Load the number from memory into $a0
   jal findFactorial       # Jump and link to the findFactorial function
   sw $v0, theAnswer       # Store the result (factorial) in the memory location theAnswer

   # Display the results
   li $v0, 4               # Load immediate: syscall code for printing a string
   la $a0, result          # Load address: address of the result message
   syscall                 # System call to print the result message
   li $v0, 1               # Load immediate: syscall code for printing an integer
   lw $a0, theAnswer       # Load the factorial from memory into $a0
   syscall                 # System call to print the factorial

   # Tell the OS that this is the end of the program
   li $v0, 10              # Load immediate: syscall code for program termination
   syscall                 # System call to terminate the program

# findFactorial function
findFactorial:
   subu $sp, $sp, 8        # Adjust stack pointer to make space for local variables
   sw $ra, ($sp)           # Save the return address on the stack
   sw $s0, 4($sp)          # Save $s0 register on the stack

   # Base case: if the number is 0, return 1
   li $v0, 1                      # Load immediate: result set to 1
   beq $a0, $zero, factorialDone  # Branch to factorialDone if the number is 0

   # Recursive case: calculate factorial(n-1)
   move $s0, $a0           # Save the original number in $s0
   sub $a0, $a0, 1         # Decrement the number by 1
   jal findFactorial       # Recursive call to findFactorial with n-1

   # Multiply the result of factorial(n-1) by the original number
   mul $v0, $s0, $v0       # Multiply the original number by the result of factorial(n-1)

factorialDone:
   lw $ra, ($sp)           # Restore the return address from the stack
   lw $s0, 4($sp)          # Restore $s0 register from the stack
   addu $sp, $sp, 8        # Restore the stack pointer
   jr $ra                  # Jump back to the return address to return from the function
