DATA SEGMENT			;Defining port adresses
	PPI_A		EQU	80H
	PPI_B		EQU	82H
	PPI_C		EQU	84H
	PPI_CTRL	EQU	86H
	
	PIC_CNT0	EQU	60H
	PIC_CNT1	EQU	62H
	PIC_CNT2	EQU	64H
	PIC_CTRL	EQU	66H
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS: DATA
	MOV AX, DATA
	MOV DS, AX
	
START:
	MOV AL, 10001011B		;PPI control: PortA-Out; PortB-In; PortC_Upper-In; PortC_Lower-Out
	OUT PPI_CTRL, AL
	
	MOV AL, 00110100B		;Counter 0, in mode 2, Rate_Gen; LSB+MSB
	OUT PIC_CTRL, AL

	MOV AL, 01h				;LSB 01
	OUT PIC_CNT0, AL		;MSB 01; count = 0101 = 101, in hex mode, (FF+1)
	MOV AL, 01h
	OUT PIC_CNT0, AL
	
	MOV AL, 01010010B		;Counter 1, in mode 1, Monostable, only LSB
	OUT PIC_CTRL, AL

CHNG:
	MOV AL, 00000010B		;Reset ADC
	OUT PPI_A, AL
	MOV AL, 00000111B		;Start conversion
	OUT PPI_A, AL
	
	INTR_CHK:				;Wait till EOC
		IN AL, PPI_C		;Check INTR of ADC to see if EOC
		AND AL, 01H
		CMP AL, 00H
		JNE INTR_CHK
	
	MOV AL, 00000100B		;Read value from ADC
	OUT PPI_A, AL	
	
	IN AL, PPI_B			;Change counter 1's count
	OUT PIC_CNT1, AL
	
BACK:
	IN AL, PPI_C		;Input ADC Value, percentage of PWM
	CALL CHECK			;If push button pressed, change speed value
	JMP BACK			;Else continue
	
CHECK PROC				;Change counter 1's count
	IN AL, PPI_C
	AND AL, 80H
	CMP AL, 00H
	JZ CHNG
	JNZ BACK
CHECK ENDP	
	
CODE ENDS
END START