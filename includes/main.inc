.equ RCC_BASE,              0x40023800
.equ GPIOA_BASE,            0x40020000

.equ GPIO_MODER_OFFSET,     0x00
.equ GPIO_AFRL_OFFSET,      0x20
.equ AHB1ENR_OFFSET,        0x30
.equ APB1ENR_OFFSET,        0x40
.equ APB2ENR_OFFSET,        0x44

.equ RCC_AHB1ENR,           (RCC_BASE   + AHB1ENR_OFFSET)
.equ RCC_APB1ENR,           (RCC_BASE   + APB1ENR_OFFSET)
.equ RCC_APB2ENR,           (RCC_BASE   + APB2ENR_OFFSET)
.equ GPIOA_MODER,           (GPIOA_BASE + GPIO_MODER_OFFSET)
.equ GPIOA_AFRL,            (GPIOA_BASE + GPIO_AFRL_OFFSET)

.equ GPIOA_EN,              (1 << 0)
.equ TIM2_EN,               (1 << 0)

.equ STEP_PIN,          (1 << 5)
.equ STEP_PIN_AF_MODE,  (1 << 11)
.equ STEP_PIN_AF1,      (1 << 20)