# Initialize the timer
stepper_timer_init:

    push {r0-r2, lr}

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

    ldr REG, =TIM2_DIER
    mov VAL, TIM_CH1_CC_INT_EN
    bl  bit_set

    ldr REG, =TIM2_CR1
    mov VAL, TIM_CR1_CEN
    bl  bit_set

    ldr REG, =TIM2_CCER
    mov VAL, TIM_CH1_CC_EN
    bl  bit_set

    ldr r1, =TIM2_SR
    mov r2, #0
    str r2, [r1]

    pop {r0-r2, lr}
    bx  lr

# Enable the interrupt.
stepper_interrupt_init:

    push {r0-r2, lr}

    ldr REG, =NVIC_BASE
    mov VAL, TIM2_IRQN_NUMBER
    bl  bit_set

    pop {r0-r2, lr} 
    bx  lr


.globl TIM2_IRQHandler
.type TIM2_IRQHandler, %function
TIM2_IRQHandler:

    push {r0-r2, lr}

    ldr r0, =TIM2_SR
    ldr r1, [r0]
    tst r1, TIM_SR_CC1IF
    beq clear_TIM2_IRQHandler

    # Decrement the step value with each pulse.
    ldr r1, =steps
    ldr r2, [r1]

    subs r2, r2, #1
    str r2, [r1]
    beq steps_done

    # Clear the flag and leave the handler.
    clear_TIM2_IRQHandler:

        ldr r0, =TIM2_SR
        ldr r1, [r0]
        bic r1, r1, TIM_SR_CC1IF
        str r1, [r0]
        pop {r0-r2, lr}
        bx lr

    # If there are no steps remaining, start over the counter and switch direction.
    steps_done:

        ldr REG, =TIM2_CR1
        mov VAL, TIM_CR1_CEN
        bl  bit_clear
        b clear_TIM2_IRQHandler
