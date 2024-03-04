.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "Hello World\n"

.text
main:
# register not to be use x0 to x4 and x10 to x17
# register that we can use are x5 to x9 and x18 to x31

    addi x5, x0, 10 # x5 = 0 + 10 -> size = 10
    addi x6, x0, 0 # x6 = 0 + 0 -> sum1 = 0
    addi x7, x0, 0 # x7 = 0 + 0 -> sum2 = 0
    
    #for(i = 0; i < size; i++)
    #    arr1[i] = i + 1;
    addi, x8, x0, 0 # x8 = 0 + 0 -> i = 0
    la x9, arr1 # loading the address of arr1 to x9
loop1:
    bge x8, x5, exit1 # if(i >= size) -> exit1
    # we need to calcualte &arr1[i]
    # we need to base address of arr1
    # then, we add an offset of i * 4 to the base address
    slli x18, x8, 2 # set x18 to i * 4
    add x19, x18, x9 # x19 = x18 + x9 -> x19 = arr1[i]
    addi x20, x8, 1 # x20 = x19 + 1
    sw x20, 0(x19) # arr1[i] = i + 1
    addi x8, x8, 1 # i++
    j loop1
    
exit1:
    addi x8, x0, 0 # set i initial = 0
    la x21, arr2 # loading the address of arr2 to x21
    
loop2:
    bge x8, x5, exit2 # if(i >= size) -> exit1
    # we need to calcualte &arr1[i]
    # we need to base address of arr1
    # then, we add an offset of i * 4 to the base address
    slli x18, x8, 2 # set x18 to i * 4
    add x19, x18, x21 # x19 = x18 + x21 -> x19 = arr2[i]
    add x20, x8, x8 # x20 = i + i(2 * 1)
    sw x20, 0(x19) # arr1[i] = 2 * 1
    addi x8, x8, 1 # i++
    j loop2

exit2:
    addi x8, x0, 0 # set i initial = 0
    
loop3:
    bge x8, x5, exit3 #if i >= size -> exit3
    # sum1 = sum1 + arr1[i]
    slli x18, x8, 2 # set x18 to i * 4
    add x19, x18, x9 # x19 = x18 + x9 -> x19 = arr1[i]
    lw x20, 0(x19) # x20 = arr1[i]
    add x6, x6, x20 # sum1 = sum1 + arr1[i]
    
    # sum2 = sum2 + arr2[i]
    add x19, x18, x21 # x19 = x18 + x21 -> x19 = arr2[i] reuse x18
    lw x20, 0(x19) # x20 = arr2[i]
    add x7, x7, x20 # sum2 = sum2 + arr2[i]
    addi x8, x8, 1 # i++
    j loop3
    
exit3:
    # print_int; sum1
    addi a0, x0, 1
    add a1, x0, x6
    ecall
    
    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # print_int; sum2
    addi a0, x0, 1
    add a1, x0, x7
    ecall
    
    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall
