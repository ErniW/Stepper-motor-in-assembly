stepper_timer_init:

    push {lr}

    ldr r1, =TIM2_PSC
    mov r2, #PRESCALER_VALUE
    str r2, [r1]

     ldr r1, =TIM2_ARR
    mov r2, #ARR_VALUE
    str r2, [r1]

    ldr r1, =TIM2_CCR1
    mov r2, #PULSE_LENGTH
    str r2, [r1]

    ldr REG, =TIM2_CCMR1
    mov VAL, TIM_CH1_PWM_MODE
    bl  bit_set

    // ldr REG, =TIM2_DIER
    // mov VAL, TIM_CH1_CC_INT_EN
    // bl  bit_set

    ldr REG, =TIM2_CCER
    mov VAL, TIM_CH1_CC_EN
    bl  bit_set

    ldr REG, =TIM2_CR1
    mov VAL, TIM_CR1_CEN
    bl  bit_set

    pop {lr}
    bx  lr

stepper_interrupt_init:

    push {lr}

    pop {lr} 
