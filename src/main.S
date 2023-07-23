.syntax unified
.thumb

.include "includes/main.inc"
.include "includes/stepper.inc"
.include "includes/systick.inc"
.include "includes/utils.inc"

.section .data
.align 4
    steps: .word 400
    delay_counter: .word 0

.section .text
.globl  main
.thumb_func
main:

    ldr REG, =RCC_AHB1ENR
    mov VAL, GPIOA_EN
    bl  bit_set

    ldr REG, =RCC_APB1ENR
    mov VAL, TIM2_EN
    bl  bit_set

    ldr REG, =GPIOA_MODER
    mov VAL, STEP_PIN_AF_MODE
    bl  bit_set

    ldr REG, =GPIOA_MODER
    mov VAL, DIR_PIN_OUTPUT_MODE
    bl  bit_set

    ldr REG, =GPIOA_AFRL
    mov VAL, STEP_PIN_AF1
    bl  bit_set

    bl  systick_init
    bl  stepper_timer_init
    bl  stepper_interrupt_init

loop:

    ldr r0, =steps
    ldr r1, [r0]
    cmp r1, #0
    beq switch_direction

    b   loop

switch_direction:
    push {lr}
    //Set steps back to 400
    ldr r0, =steps
    mov r1, #400
    str r1, [r0]

    //Switch motor direction
    ldr r0, =GPIOA_ODR
    ldr r1, [r0]
    eor r1, r1, DIR_PIN
    str r1, [r0]

    //Give some time to stabilize the shaft
    ldr r0, =delay_counter
    mov r1, #50
    str r1, [r0]
    bl  delay_ms

    //Enable the timer
    ldr REG, =TIM2_CR1
    mov VAL, TIM_CR1_CEN
    bl  bit_set

    pop {lr}

.align
.end
