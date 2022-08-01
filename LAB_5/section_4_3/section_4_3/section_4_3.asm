;
; section_4_3.asm
;
; Created: 2022-07-13 5:42:07 PM
; Author : cal
;

ldi r16, 0xFF ; Load register 16 with 0xFF (all bits 1)
out DDRD, r16 ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.
ldi r16, 0b11111110
out DDRB, r16 ; set as output
ldi r16, 0x0 ; Load register 16 with 0x00 (all bits 0), to d
out PORTB, r16
out PORTD, r16

ldi r17, 0x0
ldi r18, 0x0
ldi r21, 0x0
ldi r22, 0x0
ldi r23, 0x0

isButton:
	in r16, PINB
	andi r16, 0b00000001
	cpi r16, 0b00000000
	breq master_loop
	jmp isButton

master_loop:
	andi r17, 0x0F

	; wait 1
	ldi r20, 0xE0
	outer_outer_loop:
		ldi r19, 0x0
		outer_loop:
			ldi r18, 0x0
			inner_loop:
				mul r21, r21
				inc r18
				brne inner_loop
		inc r19
		brne outer_loop
	inc r20
	brne outer_outer_loop

	ldi r16, 0x00
	out PORTD, r16
	out PORTB, r16
	
	; if statements
	cpi r17, 0x00
	breq zero
	brne C0
	zero:
		inc r17
		sbi PORTD, 7
		sbi PORTB, 1
		sbi PORTD, 4
		sbi PORTD, 3
		sbi PORTD, 2
		sbi PORTD, 6
		jmp master_loop
	C0:
	cpi r17, 0x01
	breq one
	brne C1
	one:
		inc r17
		sbi PORTB, 1
		sbi PORTD, 4
		jmp master_loop
	C1:
	cpi r17, 0x02
	breq two
	brne C2
	two:
		inc r17
		sbi PORTD, 7
		sbi PORTB, 1
		sbi PORTD, 5
		sbi PORTD, 2
		sbi PORTD, 3
		jmp master_loop
	C2:
	cpi r17, 0x03
	breq three
	brne C3
	three:
		inc r17
		sbi PORTD, 7
		sbi PORTB, 1
		sbi PORTD, 5
		sbi PORTD, 4
		sbi PORTD, 3
		jmp master_loop
	C3:
	cpi r17, 0x04
	breq four
	brne C4
	four:
		inc r17
		sbi PORTD, 6
		sbi PORTD, 5
		sbi PORTB, 1
		sbi PORTD, 4
		jmp master_loop
	C4:
	cpi r17, 0x05
	breq five
	brne C5
	five:
		inc r17
		sbi PORTD, 7
		sbi PORTD, 6
		sbi PORTD, 5
		sbi PORTD, 4
		sbi PORTD, 3
		jmp master_loop
	C5:
	cpi r17, 0x06
	breq six
	brne C6
	six:
		inc r17
		sbi PORTD, 7
		sbi PORTD, 6
		sbi PORTD, 5
		sbi PORTD, 2
		sbi PORTD, 4
		sbi PORTD, 3
		jmp master_loop
	C6:
	cpi r17, 0x07
	breq seven
	brne C7
	seven:
		inc r17
		sbi PORTD, 7
		sbi PORTB, 1
		sbi PORTD, 4
		jmp master_loop
	C7:
	cpi r17, 0x08
	breq eight
	brne C8
	eight:
		inc r17
		sbi PORTD, 7
		sbi PORTB, 1
		sbi PORTD, 4
		sbi PORTD, 3
		sbi PORTD, 2
		sbi PORTD, 6
		sbi PORTD, 5
		jmp master_loop
	C8:
	cpi r17, 0x09
	breq nine
	brne C9
	nine:
		inc r17
		sbi PORTD, 3
		sbi PORTD, 4
		sbi PORTD, 5
		sbi PORTD, 6
		sbi PORTD, 7
		sbi PORTB, 1
		jmp master_loop
	C9:
	cpi r17, 0x0A
	breq ten
	brne C10
	ten:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 4
		sbi PORTD, 5
		sbi PORTD, 6
		sbi PORTD, 7
		sbi PORTB, 1
		jmp master_loop
	C10:
	cpi r17, 0x0B
	breq eleven
	brne C11
	eleven:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 3
		sbi PORTD, 4
		sbi PORTD, 5
		sbi PORTD, 6
		jmp master_loop
	C11:
	cpi r17, 0x0C
	breq twelve
	brne C12
	twelve:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 3
		sbi PORTD, 6
		sbi PORTD, 7
		jmp master_loop
	C12:
	cpi r17, 0x0D
	breq thirteen
	brne C13
	thirteen:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 3
		sbi PORTD, 4
		sbi PORTD, 5
		sbi PORTB, 1
		jmp master_loop
	C13:
	cpi r17, 0x0E
	breq fourteen
	brne C14
	fourteen:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 3
		sbi PORTD, 5
		sbi PORTD, 6
		sbi PORTD, 7
		jmp master_loop
	C14:
	cpi r17, 0x0F
	breq fifteen
	brne CERROR
	fifteen:
		inc r17
		sbi PORTD, 2
		sbi PORTD, 5
		sbi PORTD, 6
		sbi PORTD, 7
		jmp isButton
	CERROR:
		sbi PORTD, 5
		jmp master_loop
jmp master_loop