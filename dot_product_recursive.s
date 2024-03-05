.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"


.text
main:
    la a0, a # load the address of array a
    la a1, b # load the address of array b
    li a2, 5 # size array = 5

    jal dot_prod # go to dot prod

    mv t1, a0 # store r0 in t1

    li a0, 4 # print text
    la a1, text
    ecall

    li a0, 1 # print the result
    mv a1, t1
    ecall

    li a0, 4 # print newline
    la a1, newline
    ecall

    li a0, 10 # terminate
    ecall

dot_prod:
    # base case
    addi t0, x0, 1 # set t0 to 1
    beq a2, t0, exit_base_case # if second argument is 1, exit

    # recursive case
    addi sp, sp, -4 
    sw ra, 0(sp) # store ra values in stack

    # dot_product_recursive(a+1, b+1, size-1);
    addi sp, sp, -4 
    sw a0, 0(sp)
    addi sp, sp, -4
    sw a1, 0(sp)
    addi a2, a2, -1 # size-1
    addi a0, a0, 4 # *a+1
    addi a1, a1, 4 # *b+1

    jal dot_prod # go to dot prod
    
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
    lw t1, 0(sp) 
    lw t1, 0(t1)
    addi sp, sp, 4
    lw t0, 0(sp)
    lw t0, 0(t0)
    addi sp, sp, 4

    # multiply the first element of the arrays
    mul t0, t0, t1
    add a0, a0 , t0

    # restore the stack and exit the recursive call
    lw ra, 0(sp) # restore ra values from stack
    addi sp, sp, 4 # restore sp
    jr ra


exit_base_case:
    lw t0, 0(a0) # load the first element of a
    lw t1, 0(a1) # load the first element of b
    mul a0, t0, t1 # mult the first element of the arrays
    jr ra # return to function