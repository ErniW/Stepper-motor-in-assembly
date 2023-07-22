/*
    Configure timer
    configure interrupt for PWM mode to count steps
    move to
    ... in direction
    change speed.

    ldr REG, =RCC_AHB1ENR
    mov BIT, GPIOA_EN
    bl  bit_set

*/


.syntax unified
.thumb



.include "includes/main.inc"
.include "includes/stepper.inc"

.include "src/utils.S"

.section .data
.align 4
    steps: .word 0

.section .text
.globl  main
.word   main
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

    ldr REG, =GPIOA_AFRL
    mov VAL, STEP_PIN_AF1
    bl  bit_set

    bl  stepper_timer_init
    # bl  stepper_interrupt_init

loop:


    b   loop



.align
.end
