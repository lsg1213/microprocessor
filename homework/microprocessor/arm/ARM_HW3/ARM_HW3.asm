GPIO_BASE			.equ	0x40000000
NVIC_BASE			.equ	0xe0000000
RCGCGPIO			.equ	0x608
GPIOHBCTL			.equ	0x06C
GPIODIR				.equ	0x400
GPIOAFSEL			.equ	0x420
GPIOPUR				.equ	0x510
GPIODEN				.equ	0x51C
GPIOAMSEL			.equ	0x528
GPIOPCTL			.equ	0x52C
GPIOLOCK			.equ	0x520
GPIOCR				.equ	0x524
GPIODR8R			.equ	0x508

GPIODATA			.equ	0x000
EN3					.equ	0x10C
GPIOIM				.equ	0x410
GPIOICR				.equ	0x41C
RCGC2				.equ	0x108
RCGCUART			.equ	0x618
RCGCGPIO			.equ	0x608
UARTCTL				.equ	0x030
UARTIBRD			.equ	0x024
UARTFBRD			.equ	0x028
UARTLCRH			.equ	0x02C
UARTDR				.equ	0x000

SW_UP				.equ	0x1E
SW_DOWN				.equ	0x1D
SW_LEFT				.equ	0x1B
SW_RIGHT			.equ	0x17


	.global __stack
	.text



__stack:
		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x40
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;HBCTL : High-Performance Bus Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #GPIOHBCTL
		add r1, r1, r0

		mov r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;RCGC2
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGC2
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x40
		str r0, [r1]

		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		mov r0, #0
		str r0, [r1]

		mov r0, #GPIO_BASE	;DR8R
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODR8R
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f;#0x000f000f
		str r0, [r1]

		mov r0, #GPIO_BASE	;LOCK
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOLOCK
		add r1, r1, r0

		mov r0, #GPIO_BASE
		mov r2, #0xc400000
		add r2, r2, r0
		mov r0, #0xf4000
		add r2, r2, r0
		mov r0, #0x34b
		add r2, r2, r0

		ldr r0, [r1]
		orr r0, r0, r2
		str r0, [r1]

		mov r0, #GPIO_BASE	;CR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOCR
		add r1, r1, r0

		ldr r0, [r1]
		mov r2, #0x00000000
		bic r0, r0, r2
		str r0, [r1]

		mov r0, #GPIO_BASE	;RCGCUART
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCUART
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x01
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;RCGCGPIO
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x01
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;UARTCTL
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTCTL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x01
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;UARTIBRD
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTIBRD
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0xFF00
		bic r0, r0, #0xFF
		orr r0, r0, #0x08
		bic r0, r0, #0x07
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;UARTFBRD
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTFBRD
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0xFF
		orr r0, r0, #0x2C
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;UARTLCRH
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTLCRH
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x60
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;UARTCTL
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x01
		orr r0, r0, #0x0300
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x03
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x01
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x03
		str r0, [r1]
		
		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		bic r0, r0, #03
		str r0, [r1]
		
		mov r5, #GPIO_BASE	;LED MODE
		mov r1, #0xC000
		add r1, r1, r5
		mov r5, #UARTDR
		add r1, r1, r5
		
		mov r5, #'L'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'E'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'D'
		str r5, [r1]
		bl DELAY
		
		mov r5, #0x20
		str r5, [r1]
		bl DELAY
		
		mov r5, #'M'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'O'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'D'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'E'
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xA
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xD
		str r5, [r1]
		bl DELAY

Switch_Input:

		mov r5, #GPIO_BASE 		;Port M
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]


_DELAY_EXIT:

		cmp r5, #SW_UP
		BEQ _up

		cmp r5, #SW_DOWN
		BEQ _down

		cmp r5, #SW_LEFT
		BEQ _left

		cmp r5, #SW_RIGHT
		BEQ _right

		mov r11, #0x0

		b Switch_Input
_up:	
		cmp r11, #0x01
		beq Switch_Input
		mov r11, #0x01
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r5, #0x4
		str r5, [r1]
		
		mov r5, #GPIO_BASE	;-SW A
		mov r1, #0xC000
		add r1, r1, r5
		mov r5, #UARTDR
		add r1, r1, r5
		
		mov r5, #'-'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'S'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'W'
		str r5, [r1]
		bl DELAY

		mov r5, #0x20
		str r5, [r1]
		bl DELAY
		
		mov r5, #'A'
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xA
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xD
		str r5, [r1]
		bl DELAY
		
		b Switch_Input

_down:
		cmp r11, #0x02
		beq Switch_Input
		mov r11, #0x02
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r5, #0x0
		str r5, [r1]
		
		mov r5, #GPIO_BASE	;-SW B
		mov r1, #0xC000
		add r1, r1, r5
		mov r5, #UARTDR
		add r1, r1, r5
		
		mov r5, #'-'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'S'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'W'
		str r5, [r1]
		bl DELAY

		mov r5, #0x20
		str r5, [r1]
		bl DELAY
		
		mov r5, #'B'
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xA
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xD
		str r5, [r1]
		bl DELAY
		
		b Switch_Input

_left:
		cmp r11, #0x03
		beq Switch_Input
		mov r11, #0x03
		mov r5, #GPIO_BASE	;-SW C
		mov r1, #0xC000
		add r1, r1, r5
		mov r5, #UARTDR
		add r1, r1, r5

		mov r5, #'-'
		str r5, [r1]
		bl DELAY

		mov r5, #'S'
		str r5, [r1]
		bl DELAY

		mov r5, #'W'
		str r5, [r1]
		bl DELAY

		mov r5, #0x20
		str r5, [r1]
		bl DELAY

		mov r5, #'C'
		str r5, [r1]
		bl DELAY

		mov r5, #0xA
		str r5, [r1]
		bl DELAY

		mov r5, #0xD
		str r5, [r1]
		bl DELAY


		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5
		mov r8, #0
		
		
_left_init:
		cmp r8, #5
		beq Switch_Input

		mov r7, #0
		mov r5, #0x4
		str r5, [r1]

_slow_loop1:
		add r7, r7, #1
		cmp r7, #0x100000
		blt _slow_loop1

		mov r7, #0
		mov r5, #0x0
		str r5, [r1]
_slow_loop2:
		add r7, r7, #1
		cmp r7, #0x100000
		blt _slow_loop2

		add r8, r8, #1
		b _left_init

_left_loop2:

		mov r5, #0x0
		str r5, [r1]
		b Switch_Input
_right:
		cmp r11, #0x04
		beq Switch_Input
		mov r11, #0x04
		mov r5, #GPIO_BASE	;-SW D
		mov r1, #0xC000
		add r1, r1, r5
		mov r5, #UARTDR
		add r1, r1, r5
		
		mov r5, #'-'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'S'
		str r5, [r1]
		bl DELAY
		
		mov r5, #'W'
		str r5, [r1]
		bl DELAY

		mov r5, #0x20
		str r5, [r1]
		bl DELAY
		
		mov r5, #'D'
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xA
		str r5, [r1]
		bl DELAY
		
		mov r5, #0xD
		str r5, [r1]
		bl DELAY

		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5
		mov r8, #0



_right_init:
		cmp r8, #5
		beq Switch_Input

		mov r7, #0
		mov r5, #0x4
		str r5, [r1]

_fast_loop1:
		add r7, r7, #1
		cmp r7, #0x40000
		blt _fast_loop1

		mov r7, #0
		mov r5, #0x0
		str r5, [r1]

_fast_loop2:
		add r7, r7, #1
		cmp r7, #0x40000
		blt _fast_loop2

		add r8, r8, #1
		b _right_init

_right_loop2:

		mov r5, #0x0
		str r5, [r1]
		b Switch_Input
DELAY:
		mov r3, #0
del:
		add r3, r3, #1
		cmp r3, #500
		blt del	
		mov pc, lr
		

		B __stack

		.retain
		.retainrefs

