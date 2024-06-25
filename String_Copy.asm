.data
    x: .space 128                       # Memory space reserved for string X
    y: .space 128                       # Memory space reserved for string Y
    prompt: .asciiz "Enter a string: "  # Prompt for entering the string

.text
main:
    # Print prompt to enter the string
    li $v0, 4                 # System call code for printing a string
    la $a0, prompt            # Load the address of the prompt
    syscall                   # Print the prompt
    
    # Read the string from the user
    li $v0, 8                 # System call code for reading a string
    la $a0, y                 # Load the address of the buffer for the string
    li $a1, 128               # Maximum number of characters to read
    syscall                   # Read the string from the user

    la $a0, x                 # Load the address of the destination string (X[])
    la $a1, y                 # Load the address of the source string (Y[])
    jal strcpy                # Call the strcpy function to copy Y[] to X[]

    # Print the copied string in X[]
    li $v0, 4                 # System call code for printing a string
    la $a0, x                 # Load the address of the copied string (X[])
    syscall                   # Print the copied string to the console

    # End the program
    li $v0, 10                # System call code for program termination
    syscall                   # Terminate the program

strcpy:
    addi $sp, $sp, -4         # Adjust stack for 1 item
    sw $s0, 0($sp)            # Save $s0

    add $s0, $zero, $zero     # Initialize loop counter (i = 0)

L1:
    add $t1, $s0, $a1         # Calculate address of y[i] in $t1
    lbu $t2, 0($t1)           # Load character y[i] into $t2

    add $t3, $s0, $a0         # Calculate address of x[i] in $t3
    sb $t2, 0($t3)            # Store character y[i] into x[i]

    beq $t2, $zero, L2        # Exit loop if y[i] == 0 (reached end of string)
    addi $s0, $s0, 1          # Increment loop counter (i = i + 1)
    j L1                       # Jump back to L1 for next iteration

L2:
    lw $s0, 0($sp)            # Restore saved $s0
    addi $sp, $sp, 4          # Pop 1 item from stack
    jr $ra                    # Return from function
