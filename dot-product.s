.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
# register that we can use are x5 to x9 and x18 to x31
    addi x5, x0, 5 # x5 = 5 -> size = 5
    addi x6, x0, 0 # x6 = 0 -> i = 0
    addi x18, x0, 0 # sop = 0

loop:
    bge x6, x5, exit1 # if i >= size -> exit1

    la x7, a # loading the address of a to x7
    la x8, b # loading the address of b to x8
    slli x9, x6, 2 # set x9 to i * 4

    
    add x19, x9, x7 # x19 = x9 + x7 -> x19 = &a[i]
    add x20, x9, x8 # x19 = x9 + x8 -> x20 = &b[i]
    lw x19, 0(x19) # value of &a[i]
    lw x20, 0(x20) # value of &b[i]

    addi x21, x0, 0 # x21 = 0 -> to store multiply value

    mul x21, x19, x20 # x21 = a[i] * b[i]
    add x18, x18, x21 # sop += a[i] * b[i]
    addi x6, x6, 1 # i++
    j loop

exit1:
    addi a0, x0, 4 # set print string
    la a1, text
    ecall

    addi a0, x0, 1 # set print int
    add a1, x0, x18
    ecall

    addi a0, x0, 4 # set print string
    la a1, newline
    ecall

    addi a0, x0, 10 # terminate
    ecall



