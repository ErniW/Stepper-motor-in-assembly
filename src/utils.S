REG .req r0
VAL .req r1

bit_set:
    ldr r2, [REG]
    orr r2, r2, VAL
    str r2, [REG]
    bx  lr