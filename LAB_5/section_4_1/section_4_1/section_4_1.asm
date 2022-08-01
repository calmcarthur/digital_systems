;
; section_4_1.asm
;
; Created: 2022-07-11 9:33:14 AM
; Author : cal and dylan
;

; overall loop
overall_loop:

	; on
	ldi r16, 0xFF ; Load register 16 with 0xFF (all bits 1)
	out DDRB, r16 ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.
	ldi r16, 0x0 ; Load register 16 with 0x00 (all bits 0)
	out PORTB, r16 ; Write 0x00 to port B. This sets all pins to 0.
	sbi PORTB, 0 ; Sets bi	t 0 on port B to 1.

	; wait 1
	ldi r20, 0xE8
	outer_outer_loop:
		ldi r19, 0x0
		outer_loop:
			ldi r18, 0x0
			inner_loop:
				mul r17, r17
				inc r18
				brne inner_loop
		inc r19
		brne outer_loop
	inc r20
	brne outer_outer_loop

	; off
	ldi r16, 0xFF ; Load register 16 with 0xFF (all bits 1)
	out DDRB, r16 ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.
	ldi r16, 0x0 ; Load register 16 with 0x00 (all bits 0)
	cbi PORTB, 0 ; Clears bit 0 on port B to 0.

	; wait 2
	ldi r20, 0xE8
	outer_outer_loop2:
		ldi r19, 0x0
		outer_loop2:
			ldi r18, 0x0
			inner_loop2:
				mul r17, r17
				inc r18
				brne inner_loop2
		inc r19
		brne outer_loop2
	inc r20
	brne outer_outer_loop2

jmp overall_loop