bit_set:
    ldr r2, [REG]
    orr r2, r2, VAL
    str r2, [REG]
    bx  lr

bit_clear:
    ldr r2, [REG]
    bic r2, r2, VAL
    str r2, [REG]
    bx  lr
