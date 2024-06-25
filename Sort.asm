.data
    array: .space 100              # Reserve space for 25 integers (each integer is 4 bytes)
    size: .asciiz "Enter size: "   # Prompt for entering the size of the array
    int: .asciiz "Enter int: "     # Prompt for entering an integer
    final: .asciiz "\nSorted: "    # Message to indicate the sorted array

.text
main:
    # Print "Enter size: " message and read the size of the array from the user
    li $v0, 4           # System call code for printing a string
    la $a0, size        # Load the address of the size prompt into $a0
    syscall             # Print the size prompt
    li $v0, 5           # System call code for reading an integer
    syscall             # Read the size of the array from the user
    move $s1, $v0       # Store the size of the array in $s1
    sub $s1, $s1, 1     # Decrement the size by 1 (since arrays start from index 0)

addint:
    # Loop to input integers into the array
    la $a0, int         # Load the address of the int prompt into $a0
    li $v0, 4           # System call code for printing a string
    syscall             # Print the int prompt
    li $v0, 5           # System call code for reading an integer
    syscall             # Read an integer from the user
    move $t3, $v0       # Store the integer in $t3
    add $t1, $zero, $zero   # Initialize loop counter to 0
    sll $t1, $t0, 2     # Calculate the offset of the next element in the array
    sw $t3, array($t1)  # Store the integer in the array at the calculated offset
    addi $t0, $t0, 1    # Increment the loop counter (index)
    slt $t1, $s1, $t0   # Check if all integers have been inputted
    beq $t1, $zero, addint  # If not, repeat the loop

    # Sort the array using sort
    la $a0, array       # Load the address of the array into $a0
    addi $a1, $s1, 1    # Add 1 to the size of the array (for comparison)
    jal sort            # Call sort to sort the array

    # Print "Sorted: " message
    la $a0, final       # Load the address of the final message into $a0
    li $v0, 4           # System call code for printing a string
    syscall             # Print the final message

    # Print the sorted array
    la $t0, array       # Load the base address of the array into $t0
    li $t1, 0           # Initialize loop counter to 0
print:
    lw $a0, 0($t0)      # Load the integer from the array
    li $v0, 1           # System call code for printing an integer
    syscall             # Print the integer
    addi $t0, $t0, 4    # Move to the next element in the array
    addi $t1, $t1, 1    # Increment loop counter
    slt $t2, $s1, $t1   # Check if all integers have been printed
    beq $t2, $zero, print  # If not, repeat the loop

    # End program
    li $v0, 10          # System call code for program termination
    syscall             # Terminate the program

sort:
    # Save registers $s0, $s1, $s2, $s3, $ra on the stack
    addi $sp, $sp, -20   # Allocate space on the stack for 5 registers
    sw $ra, 16($sp)      # Save $ra on the stack
    sw $s3, 12($sp)      # Save $s3 on the stack
    sw $s2, 8($sp)       # Save $s2 on the stack
    sw $s1, 4($sp)       # Save $s1 on the stack
    sw $s0, 0($sp)       # Save $s0 on the stack

    move $s2, $a0        # Save the base address of the array into $s2
    move $s3, $a1        # Save the size of the array into $s3
    li $s0, 0            # Initialize outer loop counter (i = 0)

for1tst:
    slt $t0, $s0, $s3     # Check if outer loop counter exceeds array size (i < n)
    beq $t0, $zero, exit1 # If i >= n, exit the outer loop
    addi $s1, $s0, -1     # Initialize inner loop counter (j = i - 1)

for2tst:
    slti $t0, $s1, 0      # Check if inner loop counter is negative (j < 0)
    bne $t0, $zero, exit2 # If j < 0, exit the inner loop
    sll $t1, $s1, 2       # Calculate offset of current element (j * 4)
    add $t2, $s2, $t1     # Calculate address of current element (base address + offset)
    lw $t3, 0($t2)        # Load word from current element (v[j])
    lw $t4, 4($t2)        # Load word from next element (v[j + 1])
    slt $t0, $t4, $t3     # Compare adjacent elements (v[j] < v[j + 1])
    beq $t0, $zero, exit2 # If v[j] >= v[j + 1], exit the inner loop

    # Swap v[j] and v[j + 1]
    sw $t4, 0($t2)      # Store v[j + 1] at v[j]
    sw $t3, 4($t2)      # Store v[j] at v[j + 1]
    addi $s1, $s1, -1   # Decrement inner loop counter (j -= 1)
    j for2tst           # Jump to the test condition of the inner loop

exit2:
    addi $s0, $s0, 1   # Increment outer loop counter (i += 1)
    j for1tst          # Jump to the test condition of the outer loop

exit1:
    # Restore saved registers from the stack
    lw $s0, 0($sp)      # Restore $s0 from the stack
    lw $s1, 4($sp)      # Restore $s1 from the stack
    lw $s2, 8($sp)      # Restore $s2 from the stack
    lw $s3, 12($sp)     # Restore $s3 from the stack
    lw $ra, 16($sp)     # Restore $ra from the stack
    addi $sp, $sp, 20   # Restore stack pointer
    jr $ra              # Return to the calling routine
