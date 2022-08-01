flash:
	ldi r16, 0b11111010
	out DDRB, r16
	ldi r16, 0xFF
	out DDRD, r16
	ldi r16, 0b00000101
	out PORTB, r16
	ldi r16, 0x00
	ldi r22, 0b00000101
	ldi r23, 0b00000000
	ldi r18, 0x00

call showQuestion
master_loop: 
	in r18, PINB
	andi r18, 0x05
	cpi r18, 0x01
	breq enter_pressed
	cpi r18, 0x04
	brne master_loop 
	inc r16
	call delay_02
	mov r18, r16
	call display_r18
	jmp master_loop

enter_pressed:
	mov r18, r16
	call display_r18
	call delay_02
	call display_blank
	call delay_02
	call display_r18
	call delay_02
	call display_blank
	call delay_02
	call display_r18
	call delay_02
	call display_blank
	call delay_02
	call display_r18

ldi r19, 0x00
call showQuestion
master_loop2: 
	in r18, PINB
	andi r18, 0x05
	cpi r18, 0x01
	breq enter_pressed_2
	cpi r18, 0x04
	brne master_loop2
	inc r19
	call delay_02
	mov r18, r19
	call display_r18
	jmp master_loop2

enter_pressed_2:
	mov r18, r19
	call delay_02
	call display_blank
	call delay_02
	call display_r18
	call delay_02
	call display_blank
	call delay_02
	call display_r18
	call delay_02
	call display_blank
	call delay_02
	call display_r18

mul r16, r19 
mov r20, r0
mov r21, r0
lsr r21
lsr r21
lsr r21
lsr r21

answer_loop:
	mov r18, r20
	call display_r18
	call delay_05
	call display_blank
	call delay_05
	mov r18, r21
	call display_r18
	call delay_05
	call display_blank
	call delay_05
	call showDash
	call delay_05
	call display_blank
	call delay_05
	jmp answer_loop


delay_05:
ldi r31, 0xE1
d05loop3:
  mul r28, r28
  ldi r30, 0x0
  d05loop2:
    mul r28, r28
    ldi r29, 0x0
    d05loop1:
      mul r28, r28
      inc r29
    brne d05loop1
   inc r30
  brne d05loop2
  inc r31
brne d05loop3


delay_02:
	ldi r31, 0xF3
	d02loop3:
		mul r28, r28
		ldi r30, 0x0
		d02loop2:
			mul r28, r28
			ldi r29, 0x0
				d02loop1:
				mul r28, r28
				inc r29
				brne d02loop1
		inc r30
		brne d02loop2
	inc r31
	brne d02loop3

showQuestion:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 2
	sbi PORTD, 5
	ret

showDash:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 5

ret

display_blank:
	out PORTD, r23
	out PORTB, r22
	ret

display_r18:
	andi r18, 0b00001111
	cpi r18, 0x0
	breq zero
	cpi r18, 0x1
	breq one
	cpi r18, 0x2
	breq two
	cpi r18, 0x3
	breq three
	rjmp landing1

zero:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 4
	sbi PORTD, 3
	sbi PORTD, 2
	sbi PORTD, 6
	ret

one:
	out PORTD, r23
	out PORTB, r22
	sbi PORTB, 1
	sbi PORTD, 4
	ret

two:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 5
	sbi PORTD, 2
	sbi PORTD, 3
	ret

three:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 5
	sbi PORTD, 4
	sbi PORTD, 3
	ret

landing1:
	cpi r18, 0x4
	breq four
	cpi r18, 0x5
	breq five
	cpi r18, 0x6
	breq six
	cpi r18, 0x7
	breq seven
	cpi r18, 0x8
	breq eight
	rjmp landing2

four:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 6
	sbi PORTD, 5
	sbi PORTB, 1
	sbi PORTD, 4
	ret

five:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTD, 6
	sbi PORTD, 5
	sbi PORTD, 4
	sbi PORTD, 3
	ret

six:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTD, 6
	sbi PORTD, 5
	sbi PORTD, 2
	sbi PORTD, 4
	sbi PORTD, 3
	ret

seven:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 4
	ret

eight:
	sbi PORTD, 7
	sbi PORTB, 1
	sbi PORTD, 4
	sbi PORTD, 3
	sbi PORTD, 2
	sbi PORTD, 6
	sbi PORTD, 5
	ret

landing2:
	cpi r18, 0x9
	breq nine
	cpi r18, 0xA
	breq ten
	cpi r18, 0xB
	breq eleven
	cpi r18, 0xC
	breq twelve
	cpi r18, 0xD
	breq thirteen
	cpi r18, 0xE
	breq fourteen
	cpi r18, 0xF
	breq fifteen


nine:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 3
	sbi PORTD, 4
	sbi PORTD, 5
	sbi PORTD, 6
	sbi PORTD, 7
	sbi PORTB, 1
	ret

ten:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 4
	sbi PORTD, 5
	sbi PORTD, 6
	sbi PORTD, 7
	sbi PORTB, 1
	ret

eleven:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 3
	sbi PORTD, 4
	sbi PORTD, 5
	sbi PORTD, 6
	ret

twelve:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 3
	sbi PORTD, 6
	sbi PORTD, 7
	ret

thirteen:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 3
	sbi PORTD, 4
	sbi PORTD, 5
	sbi PORTB, 1
	ret

fourteen:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 3
	sbi PORTD, 5
	sbi PORTD, 6
	sbi PORTD, 7
	ret

fifteen:
	out PORTD, r23
	out PORTB, r22
	sbi PORTD, 2
	sbi PORTD, 5
	sbi PORTD, 6
	sbi PORTD, 7
	ldi r18, 0x01
	ret
