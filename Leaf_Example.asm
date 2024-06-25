.data
    prompt_g: .asciiz "Enter the value of g: "
    prompt_h: .asciiz "Enter the value of h: "
    prompt_i: .asciiz "Enter the value of i: "
    prompt_j: .asciiz "Enter the value of j: "
    result_msg: .asciiz "The result f is: "
    g:  .word 0
    h:  .word 0
    i:  .word 0
    j:  .word 0
    f:  .word 0

.text
main:
    # Prompt the user to enter the value of g
    li  $v0, 4
    la  $a0, prompt_g
    syscall

    # Read the value of g
    li  $v0, 5
    syscall
    move $t0, $v0   # Store the value of g in $t0
    sw   $t0, g     # Store the value of g in memory

    # Prompt the user to enter the value of h
    li  $v0, 4
    la  $a0, prompt_h
    syscall

    # Read the value of h
    li  $v0, 5
    syscall
    move $t1, $v0   # Store the value of h in $t1
    sw   $t1, h     # Store the value of h in memory

    # Prompt the user to enter the value of i
    li  $v0, 4
    la  $a0, prompt_i
    syscall

    # Read the value of i
    li  $v0, 5
    syscall
    move $t2, $v0   # Store the value of i in $t2
    sw   $t2, i     # Store the value of i in memory

    # Prompt the user to enter the value of j
    li  $v0, 4
    la  $a0, prompt_j
    syscall

    # Read the value of j
    li  $v0, 5
    syscall
    move $t3, $v0   # Store the value of j in $t3
    sw   $t3, j     # Store the value of j in memory

    # Compute f = (g + h) - (i + j)
    lw   $t0, g       # Load g from memory into $t0
    lw   $t1, h       # Load h from memory into $t1
    lw   $t2, i       # Load i from memory into $t2
    lw   $t3, j       # Load j from memory into $t3

    add  $t4, $t0, $t1   # $t4 = g + h
    add  $t5, $t2, $t3   # $t5 = i + j
    sub  $t6, $t4, $t5   # $t6 = (g + h) - (i + j)

    # Store the result f in memory
    sw   $t6, f

    # Display the result f
    li   $v0, 4
    la   $a0, result_msg
    syscall

    li   $v0, 1
    lw   $a0, f
    syscall

    # End program
    li   $v0, 10
    syscall
