.data
    input: .asciiz "Enter Temperature in Fahrenheit: "   # Prompt for input
    output: .asciiz "Temperature in Celsius: "           # Message for output
    delta: .float 32.0                                   # Constant for Fahrenheit to Celsius conversion
    scalar: .float 5.0                                   # Constant for Fahrenheit to Celsius conversion
    another_scalar: .float 9.0                           # Constant for Fahrenheit to Celsius conversion

.text
li $v0, 4          # System call code for printing a string
la $a0, input      # Load address of the input prompt into $a0
syscall            # Print the input prompt

li $v0, 6          # System call code for reading a float (Fahrenheit temperature)
syscall            # Read the Fahrenheit temperature into $f0

l.s $f1, delta             # Load the constant 32.0 into $f1
l.s $f2, scalar            # Load the constant 5.0 into $f2
l.s $f3, another_scalar    # Load the constant 9.0 into $f3

sub.s $f0, $f0, $f1   # Subtract 32.0 (delta) from the Fahrenheit temperature
mul.s $f0, $f0, $f2   # Multiply the result by 5.0 (scalar)
div.s $f0, $f0, $f3   # Divide the result by 9.0 (another_scalar) to get Celsius temperature

li $v0, 4             # System call code for printing a string
la $a0, output        # Load address of the output message into $a0
syscall               # Print the output message

li $v0, 2          # System call code for printing a float
mov.s $f12, $f0    # Load the Celsius temperature into $f12
syscall            # Print the Celsius temperature

li $v0, 10         # System call code for program termination
syscall            # Terminate the program
