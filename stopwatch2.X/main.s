; File:     main.S
; Target:   PIC16f84A-04
; Author:   zeroazu
; Date:     2024-07-30
; Compiler: pic-as(v2.46)
; IDE:      MPLABX v6.20
;
; Description:
;
;   My study project of PIC16f84A using assembly
;   A simple time counter with 4-digit 7-segment displyer
;
; Schematic:
;   RA0,RA1,RA2,RA3: output to digit 0~3 of 7-segment display
;   RA4: button input for start/pause (with external pull high resistor)
;   RB0~RB7: output to segment a~g of 7-segment display
;   OSC1,OSC2: 4MHz crystal oscillator input
;   MCLR: master reset button
;
; Add this line in the project properties box, pic-as Global Options -> Additional options: 
;   -Wa,-a -Wl,-pPor_Vec=0h,-pIsr_Vec=4h
; ==================   
    PROCESSOR   16F84A
    PAGEWIDTH   132
    RADIX       DEC
; ==================
    #include <xc.inc>
    CONFIG FOSC = XT
    CONFIG WDTE = OFF
    CONFIG PWRTE = OFF
    CONFIG CP = OFF
; ==================
DEBOUNCE_TIME equ 8
ONESECOND equ 488
ch_0 equ 0b00111111    ; 0
ch_1 equ 0b00000110    ; 1
ch_2 equ 0b01011011    ; 2
ch_3 equ 0b01001111    ; 3
ch_4 equ 0b01100110    ; 4
ch_5 equ 0b01101101    ; 5
ch_6 equ 0b01111101    ; 6
ch_7 equ 0b00000111    ; 7
ch_8 equ 0b01111111    ; 8
ch_9 equ 0b01101111    ; 9
; ==================
PSECT   Por_Vec,global,class=CODE,delta=2
    global  resetVec
resetVec:
    PAGESEL main
    goto    main
; ==================   
PSECT   Isr_Vec,global,class=CODE,delta=2
interrupt:
    retfie
; ==================
PSECT   MainData,global,class=RAM,space=1,delta=1,noexec
tmr0counter:    DS  1
DebounceTimer:  DS  1
mode:           DS  1
timecounter:    DS  2
keyin:		DS  1
prekey:		DS  1
keyValue:	DS  1
digit0:		DS  1
digit1:		DS  1
digit2:		DS  1
digit3:		DS  1
state:		DS  1
prev_state:	DS  1
; ================== 
PSECT   MainCode,global,class=CODE,delta=2
main:
    call initial
loop:
    call TimerRefresh
    call Debounce
    call Stopwatch
    call Display
    goto loop
; ==================
TimerRefresh:
    btfss INTCON, INTCON_T0IF_POSITION
    goto End_TimerRefresh
    bcf INTCON, INTCON_T0IF_POSITION
    incf tmr0counter, F
    movf DebounceTimer, F
    btfss STATUS, STATUS_Z_POSITION ; if DT!=0 -> Z=0 -> incf DT
    incf DebounceTimer, F
    btfsc mode, 0 ; if mode=1 -> timecounter++
    incfsz timecounter, F
    goto End_TimerRefresh
    incf timecounter+1, F
End_TimerRefresh:
    return
; ==================
Debounce:
    movlw 0b00010000
    andwf PORTA, W
    movwf keyin
    subwf prekey, W
    btfss STATUS, STATUS_Z_POSITION ; if keyin!=prekey -> Z=0
    goto DebounceLoop1 ; Z=0 -> keyin!=prekey
    movf DebounceTimer, W ; Z=1
    sublw DEBOUNCE_TIME
    btfsc STATUS, STATUS_C_POSITION ; if DebounceTimer<DEBOUNCE_TIME -> C=0(borrow)
    goto DebounceLoop2 ; C=0(borrow) -> DebounceTimer<DEBOUNCE_TIME
    movf keyin, W ; C=1(no borrow) -> DebounceTimer>DEBOUNCE_TIME -> output
    movwf keyValue
    clrf DebounceTimer
    goto DebounceLoop2
DebounceLoop1:
    movlw 1
    movwf DebounceTimer
DebounceLoop2:
    movf keyin, W
    movwf prekey
End_Debounce:
    return
; ==================
Stopwatch:
    btfsc keyValue, 4
    goto StopwatchLoop1
    movlw 0b00000001
    xorwf mode, F ; mode = !mode
    bsf keyValue, 4
StopwatchLoop1:
    movf timecounter+1, W
    sublw HIGH(ONESECOND) ; 488 = 01E8
    btfss STATUS, STATUS_Z_POSITION ; H(timecounter)=H(488) -> Z=1
    goto StopwatchLoop2; check High
    ; L-L
    movf timecounter, W
    sublw LOW(ONESECOND) ; 488 = 01E8
    btfss STATUS, STATUS_C_POSITION ; if L(timecounter)>L(488) -> C=1
    goto StopwatchLoop3 ; C=0
    goto End_Stopwatch ; C=1
StopwatchLoop2:
    btfss STATUS, STATUS_C_POSITION
    goto StopwatchLoop3 ; C=0 -> H(timecounter)>H(488)
    goto End_Stopwatch ; C=1 
StopwatchLoop3:
    clrf timecounter
    clrf timecounter+1
    ; if digit0=9
    movf digit0, W
    xorlw 9
    btfss STATUS, STATUS_Z_POSITION ; if digit0=9 -> Z=1
    goto IncDigit0
    clrf digit0
    ; if digit1=5
    movf digit1, W
    xorlw 5
    btfss STATUS, STATUS_Z_POSITION
    goto IncDigit1
    clrf digit1
    ; if digit2=9
    movf digit2, W
    xorlw 9
    btfss STATUS, STATUS_Z_POSITION
    goto IncDigit2
    clrf digit2
    ; if digit3=5
    movf digit3, W
    xorlw 5
    btfss STATUS, STATUS_Z_POSITION ; if d3=5 -> Z=1
    goto IncDigit3
    clrf digit3
    goto End_Stopwatch
IncDigit0:   
    incf digit0, F
    goto End_Stopwatch
IncDigit1:   
    incf digit1, F
    goto End_Stopwatch
IncDigit2:   
    incf digit2, F
    goto End_Stopwatch
IncDigit3:   
    incf digit3, F
    goto End_Stopwatch
End_Stopwatch:
    return
; ==================
Display:
    movf tmr0counter, W
    andlw 0b00000011
    movwf state
    xorwf prev_state, W ; if state=prev_state, xor=0 -> Z=1
    btfsc STATUS, STATUS_Z_POSITION ; Z=0 -> skip
    goto End_Display ; if state=prev
    clrf PORTB ; if state!=prev
    movlw 0b00010000
    movwf PORTA
    movlw HIGH($+4)
    movwf PCLATH
    movf state, W
    addwf PCL, F
    goto case0
    goto case1
    goto case2
    goto case3
case0:
    movlw HIGH(seven_segment_code)
    movwf PCLATH
    movf digit0, W
    call seven_segment_code
    movwf PORTB
    bsf PORTA, 0
    goto DisplayLoop1
case1:
    movlw HIGH(seven_segment_code)
    movwf PCLATH
    movf digit1, W
    call seven_segment_code
    movwf PORTB
    bsf PORTA, 1
    goto DisplayLoop1
case2:
    movlw HIGH(seven_segment_code)
    movwf PCLATH
    movf digit2, W
    call seven_segment_code
    movwf PORTB
    bsf PORTA, 2
    goto DisplayLoop1
case3:
    movlw HIGH(seven_segment_code)
    movwf PCLATH
    movf digit3, W
    call seven_segment_code
    movwf PORTB
    bsf PORTA, 3
    goto DisplayLoop1
DisplayLoop1:
    movf state, W
    movwf prev_state
    goto End_Display
End_Display:
    return
; ==================
seven_segment_code:
    addwf PCL, F
    retlw ch_0
    retlw ch_1
    retlw ch_2
    retlw ch_3
    retlw ch_4
    retlw ch_5
    retlw ch_6
    retlw ch_7
    retlw ch_8
    retlw ch_9
; ==================
initial:
    bsf STATUS, STATUS_RP0_POSITION
    movlw 0b11010010
    movwf OPTION_REG
    movlw 0b00010000
    movwf TRISA
    movlw 0b00000000
    movwf TRISB
    bcf STATUS, STATUS_RP0_POSITION
    movlw 0
    movwf mode
    movwf digit0
    movwf digit1
    movwf digit2
    movwf digit3
    movwf timecounter
    movwf timecounter+1
    movwf DebounceTimer
    movlw 0b00010000
    movwf keyin
    movwf prekey
    movwf keyValue
    return
; ==================
    end
