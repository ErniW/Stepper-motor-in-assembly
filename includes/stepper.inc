.equ TIM2_BASE,     0x40000000 

.equ CR1_OFFSET,    0x00
.equ DIER_OFFSET,   0x0C
.equ SR_OFFSET,     0x10
.equ CCMR1_OFFSET,  0x18
.equ CCMR2_OFFSET,  0x1C
.equ CCER_OFFSET,   0x20
.equ PSC_OFFSET,    0x28
.equ ARR_OFFSET,    0x2C
.equ CCR1_OFFSET,   0x34

.equ TIM2_CR1,      (TIM2_BASE + CR1_OFFSET)
.equ TIM2_DIER,     (TIM2_BASE + DIER_OFFSET)
.equ TIM2_SR,       (TIM2_BASE + SR_OFFSET)
.equ TIM2_CCMR1,    (TIM2_BASE + CCMR1_OFFSET)
.equ TIM2_CCMR2,    (TIM2_BASE + CCMR2_OFFSET)
.equ TIM2_CCER,     (TIM2_BASE + CCER_OFFSET)
.equ TIM2_PSC,      (TIM2_BASE + PSC_OFFSET)
.equ TIM2_ARR,      (TIM2_BASE + ARR_OFFSET)
.equ TIM2_CCR1,     (TIM2_BASE + CCR1_OFFSET)

.equ TIM_CCMR1_OC1M,    (3 << 5)
.equ TIM_CCER_CC1E,     (1 << 0)
.equ TIM_CR1_CEN,       (1 << 0)
.equ TIM_CH1_PWM_MODE,  ((1 << 6) | (1 << 5))
.equ TIM_CH1_CC_EN,     (1 << 0)
.equ TIM_CH1_CC_INT_EN, (1 << 1)
.equ TIM_SR_CC1IF,      (1 << 1)

.equ PRESCALER_VALUE,   16-1
.equ ARR_VALUE,         4000
.equ PULSE_LENGTH,      10