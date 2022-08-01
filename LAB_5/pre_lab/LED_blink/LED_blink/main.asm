;
; LED_blink.asm
;
; Created: 2022-07-07 6:22:49 PM
; Author : cal
;


; Replace with your application code
ldi r16, 0xFF ; Load register 16 with 0xFF (all bits 1)
out DDRB, r16 ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.
ldi r16, 0x0 ; Load register 16 with 0x00 (all bits 0)
out PORTB, r16 ; Write 0x00 to port B. This sets all pins to 0.
sbi PORTB, 0 ; Sets bit 0 on port B to 1
