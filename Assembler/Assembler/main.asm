;
; Assembler.asm
;
; Created: 15/03/2018 09:50:41
; Author : Daniela ,Hristo Getov, Nikolay Nikolov


; Version 1 : LDI working
;To complete version one the requirements were to make the STK600 board to turn on LEDs based on our input from a register
/*
		ldi r16,0xFF		; R16 has value of 1111 1111
		out ddra,r16		; Write the bit pattern to port a data direction register

		ldi r16,0b10101010  ; Invert the bit patern to 1010 1010 and write it to r16
							; After ivertin the bit we have a led working as 0101 0101 
		out porta, r16      ; Write the pattern to port a output control register

*/

; Version 2 :LDI is off
; To complete version two the rquirements were to make the STK600 board to turn off LEDs based on our input from register
; This will be used to clear the sequence of the game after 10 sec


	LDI R16,0xFF		; R16 set value to binary 1111 1111
	out ddra,r16		; Write the bit pattern to port a data direction register
	out porta,r16