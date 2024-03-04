.text
main:
    addi a0, x0, 110 # first input -> a =110
    addi a1, x0, 50 # second input -> b =50

    jal mult 

    #print int
    mv a1, a0
    addi a0, x0, 1
    ecall
    
    addi a0, x0, 10 # set terminate
    ecall


mult:
    # base case
    addi x5, x0, 1 # x5 = 1
    beq a1, x5, exit_base_case # if b == 1 -> exit base case

    #recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on stack

    # mult(a, b - 1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1
    jal mult

    # a + mult(a, b - 1)
    mv x6, a0
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, x6

    # restore original value before call to mult
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra


exit_base_case:
    jr ra
