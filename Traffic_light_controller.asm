
_to_BCD:

	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _counter+0, 0
	MOVWF      R0+0
	MOVF       _counter+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__to_BCD+0
	MOVF       R0+1, 0
	MOVWF      FLOC__to_BCD+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _counter+0, 0
	MOVWF      R0+0
	MOVF       _counter+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__to_BCD30:
	BTFSC      STATUS+0, 2
	GOTO       L__to_BCD31
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__to_BCD30
L__to_BCD31:
	MOVF       R2+0, 0
	ADDWF      FLOC__to_BCD+0, 0
	MOVWF      PORTB+0
L_end_to_BCD:
	RETURN
; end of _to_BCD

_manual_mode:

L_manual_mode0:
	BTFSC      PORTA+0, 1
	GOTO       L_manual_mode1
	CLRF       PORTB+0
	BTFSC      PORTA+0, 2
	GOTO       L_manual_mode2
	MOVLW      1
	XORWF      _flags+0, 1
	BTFSS      PORTD+0, 0
	GOTO       L_manual_mode3
	BSF        PORTD+0, 0
	BCF        PORTD+0, 2
	BCF        PORTD+0, 1
	BCF        PORTD+0, 3
	BCF        PORTD+0, 5
	BSF        PORTD+0, 4
	GOTO       L_manual_mode4
L_manual_mode3:
	BCF        PORTD+0, 0
	BCF        PORTD+0, 2
	BSF        PORTD+0, 1
	BSF        PORTD+0, 3
	BCF        PORTD+0, 5
	BCF        PORTD+0, 4
L_manual_mode4:
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
L_manual_mode5:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual_mode33
	MOVF       _counter+0, 0
	SUBLW      0
L__manual_mode33:
	BTFSC      STATUS+0, 0
	GOTO       L_manual_mode6
	CALL       _to_BCD+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual_mode8:
	DECFSZ     R13+0, 1
	GOTO       L_manual_mode8
	DECFSZ     R12+0, 1
	GOTO       L_manual_mode8
	DECFSZ     R11+0, 1
	GOTO       L_manual_mode8
	NOP
	NOP
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
	GOTO       L_manual_mode5
L_manual_mode6:
L_manual_mode2:
	BTFSS      _flags+0, 0
	GOTO       L_manual_mode9
	BSF        PORTD+0, 0
	BCF        PORTD+0, 2
	BCF        PORTD+0, 1
	BCF        PORTD+0, 3
	BSF        PORTD+0, 5
	BCF        PORTD+0, 4
	GOTO       L_manual_mode10
L_manual_mode9:
	BCF        PORTD+0, 0
	BSF        PORTD+0, 2
	BCF        PORTD+0, 1
	BSF        PORTD+0, 3
	BCF        PORTD+0, 5
	BCF        PORTD+0, 4
L_manual_mode10:
	GOTO       L_manual_mode0
L_manual_mode1:
L_end_manual_mode:
	RETURN
; end of _manual_mode

_stop_west:

	BSF        PORTD+0, 0
	BCF        PORTD+0, 2
	BCF        PORTD+0, 1
	BCF        PORTD+0, 3
	BSF        PORTD+0, 5
	BCF        PORTD+0, 4
	MOVLW      15
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
L_stop_west11:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stop_west35
	MOVF       _counter+0, 0
	SUBLW      0
L__stop_west35:
	BTFSC      STATUS+0, 0
	GOTO       L_stop_west12
	BTFSC      PORTA+0, 1
	GOTO       L_stop_west14
	GOTO       L_end_stop_west
L_stop_west14:
	CALL       _to_BCD+0
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stop_west36
	MOVLW      3
	XORWF      _counter+0, 0
L__stop_west36:
	BTFSS      STATUS+0, 2
	GOTO       L_stop_west15
	BSF        PORTD+0, 4
	BCF        PORTD+0, 5
L_stop_west15:
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_stop_west16:
	DECFSZ     R13+0, 1
	GOTO       L_stop_west16
	DECFSZ     R12+0, 1
	GOTO       L_stop_west16
	DECFSZ     R11+0, 1
	GOTO       L_stop_west16
	NOP
	NOP
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
	GOTO       L_stop_west11
L_stop_west12:
L_end_stop_west:
	RETURN
; end of _stop_west

_stop_south:

	BCF        PORTD+0, 0
	BSF        PORTD+0, 2
	BCF        PORTD+0, 1
	BSF        PORTD+0, 3
	BCF        PORTD+0, 5
	BCF        PORTD+0, 4
	MOVLW      23
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
L_stop_south17:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stop_south38
	MOVF       _counter+0, 0
	SUBLW      0
L__stop_south38:
	BTFSC      STATUS+0, 0
	GOTO       L_stop_south18
	BTFSC      PORTA+0, 1
	GOTO       L_stop_south20
	GOTO       L_end_stop_south
L_stop_south20:
	CALL       _to_BCD+0
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stop_south39
	MOVLW      3
	XORWF      _counter+0, 0
L__stop_south39:
	BTFSS      STATUS+0, 2
	GOTO       L_stop_south21
	BCF        PORTD+0, 2
	BSF        PORTD+0, 1
L_stop_south21:
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_stop_south22:
	DECFSZ     R13+0, 1
	GOTO       L_stop_south22
	DECFSZ     R12+0, 1
	GOTO       L_stop_south22
	DECFSZ     R11+0, 1
	GOTO       L_stop_south22
	NOP
	NOP
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
	GOTO       L_stop_south17
L_stop_south18:
L_end_stop_south:
	RETURN
; end of _stop_south

_main:

	MOVLW      7
	MOVWF      ADCON1+0
	MOVLW      1
	MOVWF      TRISA+0
	MOVLW      63
	MOVWF      PORTA+0
	CLRF       TRISB+0
	CLRF       TRISC+0
	CLRF       TRISD+0
	CLRF       PORTB+0
	MOVLW      255
	MOVWF      PORTC+0
	CLRF       PORTD+0
	BSF        _flags+0, 0
L_main23:
	BTFSS      PORTA+0, 0
	GOTO       L_main24
	GOTO       L_main23
L_main24:
L_main25:
	CALL       _manual_mode+0
	BTFSS      _flags+0, 0
	GOTO       L_main27
	CALL       _stop_west+0
	CALL       _stop_south+0
	GOTO       L_main28
L_main27:
	CALL       _stop_south+0
	CALL       _stop_west+0
L_main28:
	GOTO       L_main25
L_end_main:
	GOTO       $+0
; end of _main
