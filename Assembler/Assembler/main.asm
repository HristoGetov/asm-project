;
; Assembler.asm
;
; Created: 15/03/2018 09:50:41
; Author : Daniela ,Hristo Getov, Nikolay Nikolov
; Version 1

.equ Levels = 30													;Levels in the game 
.equ Levels_Substract = 1											;Levels are -1 every time players successfully inputs the correct binnary pattern

																	;Binary patterns for levels
																	;Randomly genereted using Java
																	;Beggins from level 1

.equ bitPattern_level_1 = 0b01010011
.equ bitPattern_level_2 = 0b00100111
.equ bitPattern_level_3 = 0b01001101
.equ bitPattern_level_4 = 0b00011101
.equ bitPattern_level_5 = 0b11010011
.equ bitPattern_level_6 = 0b01010001
.equ bitPattern_level_7 = 0b11101101
.equ bitPattern_level_8 = 0b10110100
.equ bitPattern_level_9 = 0b00101111
.equ bitPattern_level_10 = 0b01001011
.equ bitPattern_level_11 = 0b11100111
.equ bitPattern_level_12 = 0b00100000
.equ bitPattern_level_13 = 0b01001010
.equ bitPattern_level_14 = 0b11110001
.equ bitPattern_level_15 = 0b01111110
.equ bitPattern_level_16 = 0b00101011
.equ bitPattern_level_17 = 0b00001000
.equ bitPattern_level_18 = 0b00100110
.equ bitPattern_level_19 = 0b10111011
.equ bitPattern_level_20 = 0b11101011
.equ bitPattern_level_21 = 0b10011001
.equ bitPattern_level_22 = 0b10010110
.equ bitPattern_level_23 = 0b01101011
.equ bitPattern_level_24 = 0b00101001
.equ bitPattern_level_25 = 0b11001100
.equ bitPattern_level_26 = 0b00101100
.equ bitPattern_level_27 = 0b00010101
.equ bitPattern_level_28 = 0b00001010
.equ bitPattern_level_29 = 0b10010001
.equ bitPattern_level_30 = 0b11100010

																	;End at level 30
																	;
																	;
																	;Level count to display ldi on which level of the game is the player
																	;Level starts at 1
.equ level_Pattern_1 =  0b00000001
.equ level_Pattern_2 =  0b00000010
.equ level_Pattern_3 =  0b00000011
.equ level_Pattern_4 =  0b00000100
.equ level_Pattern_5 =  0b00000101
.equ level_Pattern_6 =  0b00000110
.equ level_Pattern_7 =  0b00000111
.equ level_Pattern_8 =  0b00001000
.equ level_Pattern_9 =  0b00001001
.equ level_Pattern_10 = 0b00001010
.equ level_Pattern_11 = 0b00001011
.equ level_Pattern_12 = 0b00001100
.equ level_Pattern_13 = 0b00001101
.equ level_Pattern_14 = 0b00001110
.equ level_Pattern_15 = 0b00001111
.equ level_Pattern_16 = 0b00010000
.equ level_Pattern_17 = 0b00010001
.equ level_Pattern_18 = 0b00010010
.equ level_Pattern_19 = 0b00010011
.equ level_Pattern_20 = 0b00010100
.equ level_Pattern_21 = 0b00010101
.equ level_Pattern_22 = 0b00010110
.equ level_Pattern_23 = 0b00010111
.equ level_Pattern_24 = 0b00011000
.equ level_Pattern_25 = 0b00011001
.equ level_Pattern_26 = 0b00011010
.equ level_Pattern_27 = 0b00011011
.equ level_Pattern_28 = 0b00011100
.equ level_Pattern_29 = 0b00011101
.equ level_Pattern_30 = 0b00011110
																;Levels of the game finishes at 30
																
																;Initial values
.equ initial_Value_For_LED_Off = 0b11111111                     ;Initial value for set up LED to be off
.equ initial_Value_For_LED_On  = 0b00000000						;Initial value for set up LED to be on

.set counterLED	=250											;Counter for LED
.set counterPlayer=250											;Counter for Player
;
	;
		;
			;
				;
					;
						;
							;
								;
									;
										;
											;
												;
													;
														;
															;
																;Main program starts
																;
																;
																;
																;
																;
																;
																;Initial setup of the game


InitialSetUp:
				LDI r16, initial_Value_For_LED_Off				;Sets binary pattern in register r16 = 1111 1111
				OUT ddra , R16									;Writes the binary pattern to port a data direction registrer
				OUT porta, R16									;Turn of LEDs
																;
																;
																;
																;
																;Create stack
				LDI R17,high(RAMEND)
				out sph, R17
				LDI R17,low(RAMEND)
				out spl, R17
				LDI R18, 5										;Register defined for startSequence
				LDI R19, 0										;Register defined for startSequence ends		

startSequence:
				LDI R16, initial_Value_For_LED_On               ; Inverts binary pattern so pattern looks as 0000 0000
				OUT porta, R16									; Turn on LEDs
																;
																;
																; Startin Delay
																;
																;
.set counterLED =50												; Counter timer for LED's

call delayLED
				LDI r16, initial_Value_For_LED_Off				; Inverts binary pattern in register r16 = 1111 1111
				OUT porta, R16									; Turn off LEDs
call delayLED
				SUB R18, R19									; While not equal
				BRNE startSequence								; Substract







                                                                ; Setup for level = 1
                                                                ; If wrong input go back to InitialSetUp
                                                                ; Game will restart
Level1:
						
						
																; Input level number on the leds in binary sequence
				LDI R16 , level_Pattern_1
				out porta, R16
.set counterLED = 200											; Set counter timer for led

call delayLED													; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
call delayLED													; Call delay so player prepares to start game
				LDI R16, bitPattern_level_1						; Show first bit pattern to player
call delayLED													; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
.set counterPlayer = 200										; Set counter timer for player input
call delayPlayer												; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input




BRNE InitialSetUp




                                                                ;Setup for level = 2
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level2:


			LDI R16 , initial_Value_For_LED_Off					; Input level number on the leds in binary sequence
			LDI R16 , level_Pattern_2
			out porta, R16
	.set counterLED = 190										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_2						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 190									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input





BRNE InitialSetUp




                                                                ;Setup for level = 3
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level3:


																; Input level number on the leds in binary sequence
			LDI R16 , initial_Value_For_LED_Off
			LDI R16 , level_Pattern_3
			out porta, R16
	.set counterLED = 180										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_3						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 180									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input



BRNE InitialSetUp




                                                                ;Setup for level = 4
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level4:

																; Input level number on the leds in binary sequence
			LDI R16 , initial_Value_For_LED_Off
			LDI R16 , level_Pattern_4
			out porta, R16
	.set counterLED = 170										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_4						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 170									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input




BRNE InitialSetUp




                                                                ;Setup for level = 5
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level5:

											; Input level number on the leds in binary sequence
			LDI R16 , initial_Value_For_LED_Off
			LDI R16 , level_Pattern_5
			out porta, R16
	.set counterLED = 160										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_5						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 160									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input




BRNE InitialSetUp




                                                                ;Setup for level = 6
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level6:

											; Input level number on the leds in binary sequence
			LDI R16 , initial_Value_For_LED_Off
			LDI R16 , level_Pattern_6
			out porta, R16
	.set counterLED = 150										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_6						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 150									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input




BRNE InitialSetUp




                                                                ;Setup for level = 7
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level7:

																; Input level number on the leds in binary sequence
			LDI R16 , initial_Value_For_LED_Off
			LDI R16 , level_Pattern_7
			out porta, R16
	.set counterLED = 140										; Set counter timer for led

	call delayPlayer											; Call delay on the led
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after announcing the level
	call delayLED												; Call delay so player prepares to start game
				LDI R16, bitPattern_level_7						; Show first bit pattern to player
	call delayLED												; Call delay so player has time to see pattern
				LDI R16, initial_Value_For_LED_Off				; Turn off leds after showing the pattern for the current level
	.set counterPlayer = 140									; Set counter timer for player input
	call delayPlayer											; Call delay for player input
				IN R17,pinb										; Record player input in
				CP R17,R16										; Compare bit pattern for current level with player input




BRNE InitialSetUp




                                                                ;Setup for level = 8
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level8:






BRNE InitialSetUp




                                                                ;Setup for level = 9
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level9:






BRNE InitialSetUp




                                                                ;Setup for level = 10
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level10:






BRNE InitialSetUp




                                                                ;Setup for level = 11
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level11:






BRNE InitialSetUp




                                                                ;Setup for level = 12
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level12:






BRNE InitialSetUp




                                                                ;Setup for level = 13
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level13:






BRNE InitialSetUp




                                                                ;Setup for level = 14
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level14:






BRNE InitialSetUp




                                                                ;Setup for level = 15
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level15:






BRNE InitialSetUp




                                                                ;Setup for level = 16
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level16:






BRNE InitialSetUp




                                                                ;Setup for level = 17
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level17:






BRNE InitialSetUp




                                                                ;Setup for level = 18
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level18:






BRNE InitialSetUp




                                                                ;Setup for level = 19
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level19:






BRNE InitialSetUp




                                                                ;Setup for level = 20
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level20:






BRNE InitialSetUp




                                                                ;Setup for level = 21
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level21:






BRNE InitialSetUp




                                                                ;Setup for level = 22
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level22:






BRNE InitialSetUp




                                                                ;Setup for level = 23
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level23:






BRNE InitialSetUp




                                                                ;Setup for level = 24
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level24:






BRNE InitialSetUp




                                                                ;Setup for level = 25
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level25:






BRNE InitialSetUp




                                                                ;Setup for level = 26
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level26:






BRNE InitialSetUp




                                                                ;Setup for level = 27
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level27:






BRNE InitialSetUp




                                                                ;Setup for level = 28
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level28:






BRNE InitialSetUp




                                                                ;Setup for level = 29
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level29:






BRNE InitialSetUp




                                                                ;Setup for level = 30
                                                                ;If wrong input go back to InitialSetUp
                                                                ;Game will restart
Level30:






BRNE InitialSetUp









                                                                ;Final round win ...
                                                                ;Flash leds until buttons SW0,SW2,SW4,SW6 pressed togheter
                                                                ;After pressing specified buttons game is restarted





																;
																;
																;
																;DELAY
															;DELAY
														;DELAY
													;DELAY
												;DELAY
											;DELAY
										;DELAY
									;DELAY
								;DELAY
							;DELAY
						;DELAY
					;DELAY
				;DELAY
			;DELAY
		;DELAY
	;DELAY
;DELAY




;Delay methos showed by the teacher way to keep cpu busy so player is able to see result
delayLED:
						ldi r22,counterLED
loop:
						ldi r23,counterLED				
innerLoop:
						ldi r24,counterLED	
innerLoop2:
						dec r22
brne innerLoop2
						dec r23
brne innerLoop
						dec r24
brne loop
ret



delayPlayer:
						ldi r22,counterPlayer
loops:
						ldi r23,counterPlayer				
innerLoops:
						ldi r24,counterPlayer	
innerLoops2:
						ldi r25,counterPlayer	
innerLoops3:
						dec r25					
brne innerLoops3
						dec r24
brne innerLoops2
						dec r23
brne innerLoops
						dec r22
brne loops
ret
