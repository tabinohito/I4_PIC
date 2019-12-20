		LIST	P=PIC16F84A
		#INCLUDE<P16F84A.INC>
		
		__CONFIG	_HS_OSC&_CP_OFF&_WDT_OFF&_PWRTE_ON
		
W_TEMP	        EQU		0CH
STATUS_TEMP	EQU		0DH
TMP		EQU		0EH
CNT		EQU		0FH

		ORG		0H
		GOTO		MAIN
		
		ORG		04H
		
;PUSH
		MOVWF		W_TEMP
		MOVF		STATUS,W
		MOVWF		STATUS_TEMP
		
		;if TMP0 int
		BTFSS		INTCON,T0IF
		GOTO		OTHER
		INCF		CNT,F
		MOVLW		D'61'
		MOVWF		TMR0
		BCF		INTCON,T0IF
		GOTO		POP
		
		;else if other int

OTHER
		
POP
		MOVF		STATUS_TEMP,W
		MOVWF		STATUS
		SWAPF		W_TEMP,F
		SWAPF		W_TEMP,W
		
		RETFIE
		
;REMAINING CODE GOES HERE
		
MAIN
		BCF		INTCON,GIE
		BSF		STATUS,RP0
		CLRF		TRISB
		MOVLW		086H
		MOVWF		OPTION_REG
		BCF		STATUS,RP0
		CLRF		PORTB
		CLRF		TMP
		MOVLW		D'61'
		MOVWF		TMR0
		BSF		INTCON,T0IE
		BSF		INTCON,GIE
		
MAINLP
		MOVF		TMP,  	W
		CALL		BCD
		MOVWF		PORTB
		CLRF		CNT
		CALL		TIME01
		INCF		TMP,	F
		MOVF		TMP,	W
		SUBLW		D'100'
		BTFSC		STATUS,	Z
		CLRF		TMP
		GOTO		MAINLP
;100us
TIME01
		MOVF		CNT,W
		SUBLW		D'20'
		BTFSS		STATUS,Z
		GOTO		TIME01
		RETURN
		
;BCD
BCD
		ANDLW	0FFH
		ADDWF	PCL,	F
		RETLW	00H			;code0
		RETLW	01H			;code1
		RETLW	02H			;code2
		RETLW	03H			;code3	
		RETLW	04H			;code4
		RETLW	05H			;code5
		RETLW	06H			;code6
		RETLW	07H			;code7
		RETLW	08H			;code8	
		RETLW	09H			;code9
		RETLW	10H			;code0
		RETLW	11H			;code1
		RETLW	12H			;code2
		RETLW	13H			;code3	
		RETLW	14H			;code4
		RETLW	15H			;code5
		RETLW	16H			;code6
		RETLW	17H			;code7
		RETLW	18H			;code8	
		RETLW	19H			;code9
		RETLW	20H			;code0
		RETLW	21H			;code1
		RETLW	22H			;code2
		RETLW	23H			;code3	
		RETLW	24H			;code4
		RETLW	25H			;code5
		RETLW	26H			;code6
		RETLW	27H			;code7
		RETLW	28H			;code8	
		RETLW	29H			;code9
		RETLW	30H			;code0
		RETLW	31H			;code1
		RETLW	32H			;code2
		RETLW	33H			;code3	
		RETLW	34H			;code4
		RETLW	35H			;code5
		RETLW	36H			;code6
		RETLW	37H			;code7
		RETLW	38H			;code8	
		RETLW	39H			;code9
		RETLW	40H			;code0
		RETLW	41H			;code1
		RETLW	42H			;code2
		RETLW	43H			;code3	
		RETLW	44H			;code4
		RETLW	45H			;code5
		RETLW	46H			;code6
		RETLW	47H			;code7
		RETLW	48H			;code8	
		RETLW	49H			;code9
		RETLW	50H			;code0
		RETLW	51H			;code1
		RETLW	52H			;code2
		RETLW	53H			;code3	
		RETLW	54H			;code4
		RETLW	55H			;code5
		RETLW	56H			;code6
		RETLW	57H			;code7
		RETLW	58H			;code8	
		RETLW	59H			;code9
		RETLW	60H			;code0
		RETLW	61H			;code1
		RETLW	62H			;code2
		RETLW	63H			;code3	
		RETLW	64H			;code4
		RETLW	65H			;code5
		RETLW	66H			;code6
		RETLW	67H			;code7
		RETLW	68H			;code8	
		RETLW	69H			;code9
		RETLW	70H			;code0
		RETLW	71H			;code1
		RETLW	72H			;code2
		RETLW	73H			;code3	
		RETLW	74H			;code4
		RETLW	75H			;code5
		RETLW	76H			;code6
		RETLW	77H			;code7
		RETLW	78H			;code8	
		RETLW	79H			;code9
		RETLW	80H			;code0
		RETLW	81H			;code1
		RETLW	82H			;code2
		RETLW	83H			;code3	
		RETLW	84H			;code4
		RETLW	85H			;code5
		RETLW	86H			;code6
		RETLW	87H			;code7
		RETLW	88H			;code8	
		RETLW	89H			;code9
		RETLW	90H			;code0
		RETLW	91H			;code1
		RETLW	92H			;code2
		RETLW	93H			;code3	
		RETLW	94H			;code4
		RETLW	95H			;code5
		RETLW	96H			;code6
		RETLW	97H			;code61
		RETLW	98H			;code62	
		RETLW	99H			;code63
		
		END


