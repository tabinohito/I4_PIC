	LIST	P=PIC16F84A
	INCLUDE	"P16F84A.INC"
		
	__CONFIG    _HS_OSC&_WDT_OFF
		
CNT1	EQU	    0CH
CNT2	EQU	    0DH
CNT3	EQU	    0EH
CNT4	EQU	    0FH
TMP	EQU	    11H	;shiftL_portB
TMP1	EQU	    12H	;shiftR_portB
TMP2	EQU	    13H	;shiftL_portA
TMP3	EQU	    14H	;shiftL_portA
	
	ORG	    0H

MAIN	
	BSF	    STATUS , RP0
	CLRF	    TRISA
	CLRF	    TRISB
	BCF	    STATUS , RP0
	MOVLW	    B'00000001'	;shiftL_portB
	MOVWF	    TMP
	MOVLW	    B'00000000'	;shiftR_portB
	MOVWF	    TMP1
	MOVLW	    B'00000'	;shiftL_portA
	MOVWF	    TMP2
	MOVLW	    B'000010'	;shiftR_portA
	MOVWF	    TMP3
	MOVF	    TMP,W
	IORWF	    TMP1,W
	MOVWF	    PORTB
	MOVF	    TMP2,W
	IORWF	    TMP3,W
	MOVWF	    PORTA
	GOTO	    MAINLP
	
MAINLP	
	CALL	    TIME100M
	
	BCF	    STATUS,C
	BTFSC	    TMP2,1
	CALL	    ResetShiftL
	
	BTFSC	    TMP2,0
	CALL	    PortB10
	
	BTFSC	    TMP,7
	CALL	    PortB9
	
	RLF	    TMP,F
	
	BCF	    STATUS,C
	
	MOVF	    TMP,W
	IORWF	    TMP1,W
	MOVWF	    PORTB

	MOVF	    TMP2,W
	IORWF	    TMP3,W
	MOVWF	    PORTA
	
	CALL	    TIME100M
	
	BCF	    STATUS,C
	BTFSC	    TMP3,0
	CALL	    ResetShiftR
	
	BTFSC	    TMP3,1
	CALL	    PortA9
	
	BTFSC	    TMP1,0
	CALL	    PortA10
	
	RRF	    TMP1,F
	BCF	    STATUS,C
	
	BTFSC	    TMP2,1
	CALL	    ResetShiftL
	
	BTFSC	    TMP2,0
	CALL	    PortB10
	
	BTFSC	    TMP,7
	CALL	    PortB9
	
	RLF	    TMP,F
	
	BCF	    STATUS,C
	MOVF	    TMP,W
	IORWF	    TMP1,W
	MOVWF	    PORTB
	
	MOVF	    TMP2,W
	IORWF	    TMP3,W
	MOVWF	    PORTA
	
	GOTO	    MAINLP

PortB9
	BCF	    STATUS ,C
	MOVLW	    B'00001'	;shiftL_portA
	MOVWF	    TMP2
	MOVLW	    B'00000000'	;shiftL_portB
	MOVWF	    TMP
	RETURN
	
PortB10
	BCF	    STATUS ,C
	MOVLW	    B'00010'	;shiftL_portA
	MOVWF	    TMP2
	MOVLW	    B'00000000'	;shiftL_portB
	MOVWF	    TMP
	RETURN

PortA9
	BCF	    STATUS ,C
	MOVLW	    B'00001'	;shiftL_portA
	MOVWF	    TMP3
	MOVLW	    B'00000000'	;shiftL_portB
	MOVWF	    TMP1
	RETURN
	
PortA10
	BCF	    STATUS ,C
	MOVLW	    B'00010'	;shiftL_portA
	MOVWF	    TMP3
	MOVLW	    B'00000000'	;shiftL_portB
	MOVWF	    TMP1
	RETURN
	
ResetShiftL
	MOVLW	    B'00000'	;shiftL_portA
	MOVWF	    TMP2
	BSF	    STATUS,C
	RETURN
	
ResetShiftR
	MOVLW	    B'00000'	;shiftL_portA
	MOVWF	    TMP3
	BSF	    STATUS,C
	RETURN
	
TIME100U						
	MOVLW	    0A5H			
	MOVWF	    CNT1			
	NOP						
	NOP						
LOOP1
	DECFSZ	    CNT1,F			
	GOTO	    LOOP1			
	RETURN					
		
TIME10M
	MOVLW	    063H			
	MOVWF	    CNT2			
	NOP						
	NOP		
LOOP2
	CALL	    TIME100U
	DECFSZ	    CNT2,F	
	GOTO	    LOOP2			
	RETURN					
	
TIME100M
	MOVLW	    0AH			
	MOVWF	    CNT3
LOOP3
	CALL	    TIME10M
	DECFSZ	    CNT3,F
	GOTO	    LOOP3
	RETURN
	
	END