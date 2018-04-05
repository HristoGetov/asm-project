;
; Assembler.asm
;
; Created: 15/03/2018 09:50:41
; Author : Daniela Crucerescu ,Hristo Getov, Nikolay Nikolov

; Version 1 : Not working as expected 
; Idea was to create level by level the same code just to make sure we get the basic idea of assembler
; However we found numers bugs or feautures ?? Therefore we change our strategy

; Version 2 : Modified to use stack and limit the amount of code

; Improved the code overall design by deleting around 800 lines of code

; Version 3.1 : After final round added ... Flashesh LED's on / off

; Version 3.2 : Added to level 30 and restart round

; Version 3.3 : Added delay changed based on levels

; TODO for Version 4.1 : Add VIA convention

; TODO for Version 4.2 : Make randomizer for the game not using the predefine values

																			;Binary patterns for levels
																			;Randomly genereted using Java  { As random as possible }
																			;Beggins from level 1
.EQU bitPattern_level_1  = 0b01010011
.EQU bitPattern_level_2  = 0b00100111
.EQU bitPattern_level_3  = 0b01001101
.EQU bitPattern_level_4  = 0b00011101
.EQU bitPattern_level_5  = 0b11010011
.EQU bitPattern_level_6  = 0b01010001
.EQU bitPattern_level_7  = 0b11101101
.EQU bitPattern_level_8  = 0b10110100
.EQU bitPattern_level_9  = 0b00101111
.EQU bitPattern_level_10 = 0b01001011
.EQU bitPattern_level_11 = 0b11100111
.EQU bitPattern_level_12 = 0b00100000
.EQU bitPattern_level_13 = 0b01001010
.EQU bitPattern_level_14 = 0b11110001
.EQU bitPattern_level_15 = 0b01111110
.EQU bitPattern_level_16 = 0b00101011
.EQU bitPattern_level_17 = 0b00001000
.EQU bitPattern_level_18 = 0b00100110
.EQU bitPattern_level_19 = 0b10111011
.EQU bitPattern_level_20 = 0b11101011
.EQU bitPattern_level_21 = 0b10011001
.EQU bitPattern_level_22 = 0b10010110
.EQU bitPattern_level_23 = 0b01101011
.EQU bitPattern_level_24 = 0b00101001
.EQU bitPattern_level_25 = 0b11001100
.EQU bitPattern_level_26 = 0b00101100
.EQU bitPattern_level_27 = 0b00010101
.EQU bitPattern_level_28 = 0b00001010
.EQU bitPattern_level_29 = 0b10010001
.EQU bitPattern_level_30 = 0b11100010											;End at level 30 is assumed as the last level of the game

																				
InitialSetUp:																	;Game will enter initial setup once at the beggining of it. However every time the input from the player is wrong it will go again to initial setup
																				;Create stack

				LDI R16,high(RAMEND)											;
				OUT sph, R16													;
				LDI R16,low(RAMEND)												;
				OUT spl, R16													;
																				;Adding patterns to the stack
				
				LDI R16, bitPattern_level_30									;
				PUSH R16
				LDI R16, bitPattern_level_29									;
				PUSH R16
				LDI R16, bitPattern_level_28									;
				PUSH R16
				LDI R16, bitPattern_level_27									;
				PUSH R16
				LDI R16, bitPattern_level_26									;
				PUSH R16
				LDI R16, bitPattern_level_25									;
				PUSH R16
				LDI R16, bitPattern_level_24									;
				PUSH R16
				LDI R16, bitPattern_level_23									;
				PUSH R16
				LDI R16, bitPattern_level_22									;
				PUSH R16
				LDI R16, bitPattern_level_21									;
				PUSH R16
				LDI R16, bitPattern_level_20									;
				PUSH R16
				LDI R16, bitPattern_level_19									;
				PUSH R16
				LDI R16, bitPattern_level_18									;
				PUSH R16
				LDI R16, bitPattern_level_17									;
				PUSH R16
				LDI R16, bitPattern_level_16									;
				PUSH R16
				LDI R16, bitPattern_level_15									;
				PUSH R16
				LDI R16, bitPattern_level_14									;
				PUSH R16
				LDI R16, bitPattern_level_13									;
				PUSH R16
				LDI R16, bitPattern_level_12									;
				PUSH R16
				LDI R16, bitPattern_level_11									;
				PUSH R16
				LDI R16, bitPattern_level_10									;
				PUSH R16														
				LDI R16, bitPattern_level_9										;
				PUSH R16														
				LDI R16, bitPattern_level_8										;
				PUSH R16														
				LDI R16, bitPattern_level_7										;
				PUSH R16														
				LDI R16, bitPattern_level_6										;
				PUSH R16														
				LDI R16, bitPattern_level_5										;
				PUSH R16														
				LDI R16, bitPattern_level_4										;
				PUSH R16														
				LDI R16, bitPattern_level_3										;
				PUSH R16														
				LDI R16, bitPattern_level_2										;
				PUSH R16														
				LDI R16, bitPattern_level_1										;
				PUSH R16														





				LDI R16, 0b11111111								;Initial value for LEDs off
				OUT ddra , R16									;Writes the binary pattern to port a data direction registrer
				OUT porta, R16									;Turn of LEDs
				LDI R18 ,0										;Defines register R18 used to store the level pattern
				LDI R19, 31										;Max level
				LDI R20 ,1										;Start at level 1
				LDI R21 ,1										;Value to add 1 to the level
JMP Level														;Start the game


restart:														;Restart the game
CALL restartGame												;Calls restart level if wrong input
JMP InitialSetUp												;Restarts game

                    
		
					                                            ;Game start up
                                                                ;If wrong input go back to InitialSetUp based on that game will restart
																;If correct input go to next level
Level:
				LDI R16 ,0b00000000								;Correct input for player input
				OUT porta ,R16									;Turn on LEDs
CALL delayTimeForGame											;Delay
CALL delay														;Delay
				
				ADD R20,R21										;Level minus 1
				CP R19,R20										;Checks if level is the last
BREQ win		
				CLR R16											;Clears register R16 used to display values on LED's
				LDI R16,0b11111111
				CLR R17											;Clears register R17 used to store the value of the buttons
				CLR R18											;Clears register R18 used to store the value for the current level
				OUT porta,R16									;Turns off the leds
				
CALL delayTimeForGame											;Delay
CALL delay														;Delay
				
				POP R16											;Pops a value of the stack
				ADD R18,R16										;Writes R16  value to R18
				OUT porta,R16									;Displays the value that was poped from the stack
					
CALL delayTimeForGame											;Delay
CALL delay														;Delay
				CLR R16											;Clears register R16 used to display values on LED's
				LDI R16,0b11111111								;Turn off LED's after showing the pattern for the current level
				OUT porta,R16									;Turn off LED's 
CALL delayTimeForPlayer											;Delay
CALL delay														;Delay
				IN R17,pinb										;Record player input in register R17
				CP R17,R18										;Compare bit pattern for current level with player input

BRNE restart													;If the input from the player is wrong it will restart the game
BREQ Level														;If the input from the player is correct it will continue to next level





win :															;Win method 
				LDI R16, 0b11111111
				OUT porta, R16
CALL delayTimeForPlayer
CALL delay
				LDI R16,0b00000000
				OUT porta,R16
CALL delayTimeForPlayer
CALL delay

JMP win															;Endless loop




;Delay methos showed by the teacher way to keep cpu busy so player is able to see result or give input

delay:
loop:							
innerLoop:			
innerLoop2:
						DEC r24
BRNE innerLoop2
						DEC r23
BRNE innerLoop
						DEC r22
BRNE loop
RET


delayTimeForPlayer:													;Delay time for player input
		LDI R25 ,2													;Value used to multiply
		MUL R25,R20													;Lowering the delay with the level number multiplyed by 2
		MOV R25,R0
		LDI R22,200													;Setting time for delay
		SUB R22,R25													;Substract value with the lowered amount
		LDI R23,200													;Setting time for delay
		SUB R23,R25													;Substract value with the lowered amount
		LDI R24,200													;Setting time for delay
		SUB R24,R25													;Substract value with the lowered amount
RET

delayTimeForGame:													;Delay time for player input
		LDI R25 ,5													;Value used to multiply
		MUL R25,R20													;Lowering the delay with the level number multiplyed by 5
		MOV R25,R0
		LDI R22,170													;Setting time for delay
		SUB R22,R25													;Substract value with the lowered amount
		LDI R23,170													;Setting time for delay
		SUB R23,R25													;Substract value with the lowered amount
		LDI R24,170													;Setting time for delay
		SUB R24,R25													;Substract value with the lowered amount
RET
delayRestart:
		LDI R22,10													;Setting time for delay
		LDI R23,10													;Setting time for delay
		LDI R24,10													;Setting time for delay
RET






; Used to restart the game
	
restartGame:
				LDI R28,128											;Defines R18 with the decimal value of 128
				LDI R16,0b00000001									;Defines R16 with the value of 1
label:
CALL delayRestart													;Delay
CALL delay															;Delay
				OUT pina,R16										;Display R16 value
				ADD R16 , R16										;Add R16 to R16
				CP R16 , R28										;Comparisment
				BRNE label											;If not equal repeat
CALL delayRestart													;Delay
CALL delay															;Delay
				LDI R16,0b00000000									;Display the 256 decimal value
				OUT pina, R16										;Display
					
JMP InitialSetUp



;
;
;
;
;Game ends  here 
;
;
;
;





													;Testing

/*


;Testing for subrutin of lithing led's on request with specific value
				LDI R16,0b11111111											;Initial value for register 16
																			;With that value all LED's should be off
				OUT ddra,R16												;Placing register 16 in ddra
				OUT porta,R16												;Display the value
call delaytest															
				LDI R16,0b00001111											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest
				LDI R16,0b11110000											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest
				LDI R16,0b10101010											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest
				LDI R16,0b01010101											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest
				LDI R26,0b11001100											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest
				LDI R16,0b00110011											;Placing new value in a register 16
				OUT porta ,R16												;Display the value






;Delay loop showed by the teacher
;Keeping CPU busy
delaytest:
						LDI R22,150	
loop:			
						LDI R23,150		
innerLoop:			
						LDI R24,150
innerLoop2:				
						DEC r24
BRNE innerLoop2
						DEC r23
BRNE innerLoop
						DEC r22
BRNE loop
RET





;The idea was to test if the on LED's will be changed based on the new value
;After completing the test the result was as expected and LED's were turn on as requested
				


	*/	





/*

;Testing input from buttons
;The idea is if Wrong input go back go begging
;Test used to see if it will be posible to read the input from the buttons
;And compare it to the output of the LED's

Test:
				LDI R16,0b11111111											;Initial value for register 16
				OUT ddra,R16												;Placing register 16 in ddra
				OUT porta,R16												;Display the value
call delaytest															
				LDI R16,0b00001111											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest	
				CLR R17														;Clear value in register 17
				IN R17,pinb													;Read the value from the buttons and remember it in register 17
				CP R17,R16													;Compare the value between them
				BRNE Test													;If values are wrong start again
call delaytest
				LDI R16,0b11110000											;Placing new value in a register 16
				OUT porta ,R16												;Display the value
call delaytest	
				CLR R17														;Clear value in register 17
				IN R17,pinb													;Read the value from the buttons and remember it in register 17
				CP R17,R16													;Compare the value between them
				BRNE Test													;If values are wrong start again







;Delay loop showed by the teacher
;Keeping CPU busy
delaytest:
						LDI R22,200	
loop:			
						LDI R23,200		
innerLoop:			
						LDI R24,200
innerLoop2:				
						DEC r24
BRNE innerLoop2
						DEC r23
BRNE innerLoop
						DEC r22
BRNE loop
RET


;Testing is succesfull if the buttons are pressed and then the leds go to the second sequence 

*/