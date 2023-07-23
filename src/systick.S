systick_init:
    push {lr}

    ldr r0, =SYSTICK_CTRL
    mov r1, #0
    str r1, [r0]

    ldr r0, =SYSTICK_VAL
    mov r1, #0
    str r1, [r0]

    ldr r0, =SYSTICK_LOAD
    mov r1, #(16000000 / 1000) - 1
    str r1, [r0]

    ldr r0, =SYSTICK_CTRL
    mov r1, SYSTICK_CLKSOURCE | SYSTICK_CTRL_EN | SYSTICK_TICKINT
    str r1, [r0]

    pop {lr}
    bx  lr


.globl SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
    push {r0-r1, lr}
    ldr r0, =delay_counter
    ldr r1, [r0]
    cmp r1, #0
    beq stop

    sub r1, r1, #1
    str r1, [r0]

    stop:
        pop {r0-r1, lr}
        bx  lr


delay_ms:

    push {r0-r1, lr}

    ldr r0, =delay_counter

    wait:
        ldr r1, [r0]
        cmp r1, #0
        bne wait

    pop {r0-r1, lr}
    bx  lr
