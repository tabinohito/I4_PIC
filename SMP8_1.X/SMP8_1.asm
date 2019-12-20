	LIST	P=PIC16F819
	#INCLUDE<P16F819.INC>
		
	__CONFIG    _HS_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON & _MCLR_ON & _LVP_OFF
		
CNT	EQU	020H
	ORG	0H
	
MAIN
	BSF	STATUS,RP0
	MOVLW	01H
	MOVWF	TRISA
	CLRF	TRISB
	MOVLW	08EH
	MOVWF	ADCON1
	BCF	STATUS,RP0
	MOVLW	081H
	MOVWF	ADCON0
	CLRF	PORTA
	CLRF	PORTB
	
ADSTART
	CALL	TIME20U
	BSF	ADCON0,GO
	
ADLOOP
	BTFSC	ADCON0,GO
	GOTO	ADLOOP
	RLF	ADRESH,W
	MOVWF	PORTA
	BSF	STATUS,RP0
	MOVF	ADRESL,W
	BCF	STATUS,RP0
	MOVWF	PORTB
	GOTO	ADSTART
	
TIME20U
	MOVLW	020H
	MOVWF	CNT
	NOP

LOOP
	DECFSZ	CNT,F
	GOTO	LOOP
	RETURN
	
	END