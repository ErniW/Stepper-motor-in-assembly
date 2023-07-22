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

    pop {lr}
    bx  lr


stepper_interrupt_init:

    push {lr}

    ldr r1, =NVIC_BASE
    ldr r2, [r1]
    mov r3, TIM2_IRQN_OFFSET
    str r3, [r1]

    pop {lr} 
    bx  lr


.globl TIM2_IRQHandler
.type TIM2_IRQHandler, %function
# Decrement the step value with each pulse.
TIM2_IRQHandler:

    push {lr, r0-r2}

    ldr r0, =TIM2_SR
    tst r0, TIM_SR_CC1IF
    bne clear_TIM2_IRQHandler

    ldr r1, =steps
    ldr r2, [r1]
    subs r2, r2, #1
    str r2, [r1]
    beq steps_done

# Clear the flag and leave the handler.
clear_TIM2_IRQHandler:

    ldr r1, [r0]
    bic r1, r1, TIM_SR_CC1IF
    str r1, [r0]
    pop {lr, r0-r2}
    bx lr

# If there are no steps remaining, start over the counter and switch direction.
steps_done:
    ldr r1, =steps
    mov r2, #400
    str r2, [r1]
    ldr r1, =GPIOA_ODR
    ldr r2, [r1]
    eor r2, r2, DIR_PIN
    str r2, [r1]
    b clear_TIM2_IRQHandler
    