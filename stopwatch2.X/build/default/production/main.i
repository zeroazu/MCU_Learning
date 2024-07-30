# 1 "main.s"
# 1 "<built-in>" 1
# 1 "main.s" 2
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
; A simple time counter with 4-digit 7-segment displyer
;
; Add this line in the project properties box, pic-as Global Options -> Additional options: 
; -Wa,-a -Wl,-pPor_Vec=0h,-pIsr_Vec=4h
; ==================
    PROCESSOR 16F84A
    PAGEWIDTH 132
    RADIX DEC
; ==================

# 1 "C:\\Program Files\\Microchip\\xc8\\v2.46\\pic\\include\\xc.inc" 1 3






# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\pic.inc" 1 3



# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\pic_as_chip_select.inc" 1 3
# 543 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\pic_as_chip_select.inc" 3
# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\proc\\pic16f84a.inc" 1 3
# 47 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\proc\\pic16f84a.inc" 3
INDF equ 0000h



TMR0 equ 0001h



PCL equ 0002h



STATUS equ 0003h

STATUS_C_POSN equ 0000h
STATUS_C_POSITION equ 0000h
STATUS_C_SIZE equ 0001h
STATUS_C_LENGTH equ 0001h
STATUS_C_MASK equ 0001h
STATUS_DC_POSN equ 0001h
STATUS_DC_POSITION equ 0001h
STATUS_DC_SIZE equ 0001h
STATUS_DC_LENGTH equ 0001h
STATUS_DC_MASK equ 0002h
STATUS_Z_POSN equ 0002h
STATUS_Z_POSITION equ 0002h
STATUS_Z_SIZE equ 0001h
STATUS_Z_LENGTH equ 0001h
STATUS_Z_MASK equ 0004h
STATUS_nPD_POSN equ 0003h
STATUS_nPD_POSITION equ 0003h
STATUS_nPD_SIZE equ 0001h
STATUS_nPD_LENGTH equ 0001h
STATUS_nPD_MASK equ 0008h
STATUS_nTO_POSN equ 0004h
STATUS_nTO_POSITION equ 0004h
STATUS_nTO_SIZE equ 0001h
STATUS_nTO_LENGTH equ 0001h
STATUS_nTO_MASK equ 0010h
STATUS_RP_POSN equ 0005h
STATUS_RP_POSITION equ 0005h
STATUS_RP_SIZE equ 0002h
STATUS_RP_LENGTH equ 0002h
STATUS_RP_MASK equ 0060h
STATUS_IRP_POSN equ 0007h
STATUS_IRP_POSITION equ 0007h
STATUS_IRP_SIZE equ 0001h
STATUS_IRP_LENGTH equ 0001h
STATUS_IRP_MASK equ 0080h
STATUS_RP0_POSN equ 0005h
STATUS_RP0_POSITION equ 0005h
STATUS_RP0_SIZE equ 0001h
STATUS_RP0_LENGTH equ 0001h
STATUS_RP0_MASK equ 0020h
STATUS_RP1_POSN equ 0006h
STATUS_RP1_POSITION equ 0006h
STATUS_RP1_SIZE equ 0001h
STATUS_RP1_LENGTH equ 0001h
STATUS_RP1_MASK equ 0040h
STATUS_CARRY_POSN equ 0000h
STATUS_CARRY_POSITION equ 0000h
STATUS_CARRY_SIZE equ 0001h
STATUS_CARRY_LENGTH equ 0001h
STATUS_CARRY_MASK equ 0001h
STATUS_ZERO_POSN equ 0002h
STATUS_ZERO_POSITION equ 0002h
STATUS_ZERO_SIZE equ 0001h
STATUS_ZERO_LENGTH equ 0001h
STATUS_ZERO_MASK equ 0004h



FSR equ 0004h



PORTA equ 0005h

PORTA_RA0_POSN equ 0000h
PORTA_RA0_POSITION equ 0000h
PORTA_RA0_SIZE equ 0001h
PORTA_RA0_LENGTH equ 0001h
PORTA_RA0_MASK equ 0001h
PORTA_RA1_POSN equ 0001h
PORTA_RA1_POSITION equ 0001h
PORTA_RA1_SIZE equ 0001h
PORTA_RA1_LENGTH equ 0001h
PORTA_RA1_MASK equ 0002h
PORTA_RA2_POSN equ 0002h
PORTA_RA2_POSITION equ 0002h
PORTA_RA2_SIZE equ 0001h
PORTA_RA2_LENGTH equ 0001h
PORTA_RA2_MASK equ 0004h
PORTA_RA3_POSN equ 0003h
PORTA_RA3_POSITION equ 0003h
PORTA_RA3_SIZE equ 0001h
PORTA_RA3_LENGTH equ 0001h
PORTA_RA3_MASK equ 0008h
PORTA_RA4_POSN equ 0004h
PORTA_RA4_POSITION equ 0004h
PORTA_RA4_SIZE equ 0001h
PORTA_RA4_LENGTH equ 0001h
PORTA_RA4_MASK equ 0010h



PORTB equ 0006h

PORTB_RB0_POSN equ 0000h
PORTB_RB0_POSITION equ 0000h
PORTB_RB0_SIZE equ 0001h
PORTB_RB0_LENGTH equ 0001h
PORTB_RB0_MASK equ 0001h
PORTB_RB1_POSN equ 0001h
PORTB_RB1_POSITION equ 0001h
PORTB_RB1_SIZE equ 0001h
PORTB_RB1_LENGTH equ 0001h
PORTB_RB1_MASK equ 0002h
PORTB_RB2_POSN equ 0002h
PORTB_RB2_POSITION equ 0002h
PORTB_RB2_SIZE equ 0001h
PORTB_RB2_LENGTH equ 0001h
PORTB_RB2_MASK equ 0004h
PORTB_RB3_POSN equ 0003h
PORTB_RB3_POSITION equ 0003h
PORTB_RB3_SIZE equ 0001h
PORTB_RB3_LENGTH equ 0001h
PORTB_RB3_MASK equ 0008h
PORTB_RB4_POSN equ 0004h
PORTB_RB4_POSITION equ 0004h
PORTB_RB4_SIZE equ 0001h
PORTB_RB4_LENGTH equ 0001h
PORTB_RB4_MASK equ 0010h
PORTB_RB5_POSN equ 0005h
PORTB_RB5_POSITION equ 0005h
PORTB_RB5_SIZE equ 0001h
PORTB_RB5_LENGTH equ 0001h
PORTB_RB5_MASK equ 0020h
PORTB_RB6_POSN equ 0006h
PORTB_RB6_POSITION equ 0006h
PORTB_RB6_SIZE equ 0001h
PORTB_RB6_LENGTH equ 0001h
PORTB_RB6_MASK equ 0040h
PORTB_RB7_POSN equ 0007h
PORTB_RB7_POSITION equ 0007h
PORTB_RB7_SIZE equ 0001h
PORTB_RB7_LENGTH equ 0001h
PORTB_RB7_MASK equ 0080h



EEDATA equ 0008h



EEADR equ 0009h



PCLATH equ 000Ah

PCLATH_PCLATH_POSN equ 0000h
PCLATH_PCLATH_POSITION equ 0000h
PCLATH_PCLATH_SIZE equ 0005h
PCLATH_PCLATH_LENGTH equ 0005h
PCLATH_PCLATH_MASK equ 001Fh



INTCON equ 000Bh

INTCON_RBIF_POSN equ 0000h
INTCON_RBIF_POSITION equ 0000h
INTCON_RBIF_SIZE equ 0001h
INTCON_RBIF_LENGTH equ 0001h
INTCON_RBIF_MASK equ 0001h
INTCON_INTF_POSN equ 0001h
INTCON_INTF_POSITION equ 0001h
INTCON_INTF_SIZE equ 0001h
INTCON_INTF_LENGTH equ 0001h
INTCON_INTF_MASK equ 0002h
INTCON_T0IF_POSN equ 0002h
INTCON_T0IF_POSITION equ 0002h
INTCON_T0IF_SIZE equ 0001h
INTCON_T0IF_LENGTH equ 0001h
INTCON_T0IF_MASK equ 0004h
INTCON_RBIE_POSN equ 0003h
INTCON_RBIE_POSITION equ 0003h
INTCON_RBIE_SIZE equ 0001h
INTCON_RBIE_LENGTH equ 0001h
INTCON_RBIE_MASK equ 0008h
INTCON_INTE_POSN equ 0004h
INTCON_INTE_POSITION equ 0004h
INTCON_INTE_SIZE equ 0001h
INTCON_INTE_LENGTH equ 0001h
INTCON_INTE_MASK equ 0010h
INTCON_T0IE_POSN equ 0005h
INTCON_T0IE_POSITION equ 0005h
INTCON_T0IE_SIZE equ 0001h
INTCON_T0IE_LENGTH equ 0001h
INTCON_T0IE_MASK equ 0020h
INTCON_EEIE_POSN equ 0006h
INTCON_EEIE_POSITION equ 0006h
INTCON_EEIE_SIZE equ 0001h
INTCON_EEIE_LENGTH equ 0001h
INTCON_EEIE_MASK equ 0040h
INTCON_GIE_POSN equ 0007h
INTCON_GIE_POSITION equ 0007h
INTCON_GIE_SIZE equ 0001h
INTCON_GIE_LENGTH equ 0001h
INTCON_GIE_MASK equ 0080h
INTCON_TMR0IF_POSN equ 0002h
INTCON_TMR0IF_POSITION equ 0002h
INTCON_TMR0IF_SIZE equ 0001h
INTCON_TMR0IF_LENGTH equ 0001h
INTCON_TMR0IF_MASK equ 0004h
INTCON_TMR0IE_POSN equ 0005h
INTCON_TMR0IE_POSITION equ 0005h
INTCON_TMR0IE_SIZE equ 0001h
INTCON_TMR0IE_LENGTH equ 0001h
INTCON_TMR0IE_MASK equ 0020h



OPTION_REG equ 0081h

OPTION_REG_PS_POSN equ 0000h
OPTION_REG_PS_POSITION equ 0000h
OPTION_REG_PS_SIZE equ 0003h
OPTION_REG_PS_LENGTH equ 0003h
OPTION_REG_PS_MASK equ 0007h
OPTION_REG_PSA_POSN equ 0003h
OPTION_REG_PSA_POSITION equ 0003h
OPTION_REG_PSA_SIZE equ 0001h
OPTION_REG_PSA_LENGTH equ 0001h
OPTION_REG_PSA_MASK equ 0008h
OPTION_REG_T0SE_POSN equ 0004h
OPTION_REG_T0SE_POSITION equ 0004h
OPTION_REG_T0SE_SIZE equ 0001h
OPTION_REG_T0SE_LENGTH equ 0001h
OPTION_REG_T0SE_MASK equ 0010h
OPTION_REG_T0CS_POSN equ 0005h
OPTION_REG_T0CS_POSITION equ 0005h
OPTION_REG_T0CS_SIZE equ 0001h
OPTION_REG_T0CS_LENGTH equ 0001h
OPTION_REG_T0CS_MASK equ 0020h
OPTION_REG_INTEDG_POSN equ 0006h
OPTION_REG_INTEDG_POSITION equ 0006h
OPTION_REG_INTEDG_SIZE equ 0001h
OPTION_REG_INTEDG_LENGTH equ 0001h
OPTION_REG_INTEDG_MASK equ 0040h
OPTION_REG_nRBPU_POSN equ 0007h
OPTION_REG_nRBPU_POSITION equ 0007h
OPTION_REG_nRBPU_SIZE equ 0001h
OPTION_REG_nRBPU_LENGTH equ 0001h
OPTION_REG_nRBPU_MASK equ 0080h
OPTION_REG_PS0_POSN equ 0000h
OPTION_REG_PS0_POSITION equ 0000h
OPTION_REG_PS0_SIZE equ 0001h
OPTION_REG_PS0_LENGTH equ 0001h
OPTION_REG_PS0_MASK equ 0001h
OPTION_REG_PS1_POSN equ 0001h
OPTION_REG_PS1_POSITION equ 0001h
OPTION_REG_PS1_SIZE equ 0001h
OPTION_REG_PS1_LENGTH equ 0001h
OPTION_REG_PS1_MASK equ 0002h
OPTION_REG_PS2_POSN equ 0002h
OPTION_REG_PS2_POSITION equ 0002h
OPTION_REG_PS2_SIZE equ 0001h
OPTION_REG_PS2_LENGTH equ 0001h
OPTION_REG_PS2_MASK equ 0004h



TRISA equ 0085h

TRISA_TRISA0_POSN equ 0000h
TRISA_TRISA0_POSITION equ 0000h
TRISA_TRISA0_SIZE equ 0001h
TRISA_TRISA0_LENGTH equ 0001h
TRISA_TRISA0_MASK equ 0001h
TRISA_TRISA1_POSN equ 0001h
TRISA_TRISA1_POSITION equ 0001h
TRISA_TRISA1_SIZE equ 0001h
TRISA_TRISA1_LENGTH equ 0001h
TRISA_TRISA1_MASK equ 0002h
TRISA_TRISA2_POSN equ 0002h
TRISA_TRISA2_POSITION equ 0002h
TRISA_TRISA2_SIZE equ 0001h
TRISA_TRISA2_LENGTH equ 0001h
TRISA_TRISA2_MASK equ 0004h
TRISA_TRISA3_POSN equ 0003h
TRISA_TRISA3_POSITION equ 0003h
TRISA_TRISA3_SIZE equ 0001h
TRISA_TRISA3_LENGTH equ 0001h
TRISA_TRISA3_MASK equ 0008h
TRISA_TRISA4_POSN equ 0004h
TRISA_TRISA4_POSITION equ 0004h
TRISA_TRISA4_SIZE equ 0001h
TRISA_TRISA4_LENGTH equ 0001h
TRISA_TRISA4_MASK equ 0010h



TRISB equ 0086h

TRISB_TRISB0_POSN equ 0000h
TRISB_TRISB0_POSITION equ 0000h
TRISB_TRISB0_SIZE equ 0001h
TRISB_TRISB0_LENGTH equ 0001h
TRISB_TRISB0_MASK equ 0001h
TRISB_TRISB1_POSN equ 0001h
TRISB_TRISB1_POSITION equ 0001h
TRISB_TRISB1_SIZE equ 0001h
TRISB_TRISB1_LENGTH equ 0001h
TRISB_TRISB1_MASK equ 0002h
TRISB_TRISB2_POSN equ 0002h
TRISB_TRISB2_POSITION equ 0002h
TRISB_TRISB2_SIZE equ 0001h
TRISB_TRISB2_LENGTH equ 0001h
TRISB_TRISB2_MASK equ 0004h
TRISB_TRISB3_POSN equ 0003h
TRISB_TRISB3_POSITION equ 0003h
TRISB_TRISB3_SIZE equ 0001h
TRISB_TRISB3_LENGTH equ 0001h
TRISB_TRISB3_MASK equ 0008h
TRISB_TRISB4_POSN equ 0004h
TRISB_TRISB4_POSITION equ 0004h
TRISB_TRISB4_SIZE equ 0001h
TRISB_TRISB4_LENGTH equ 0001h
TRISB_TRISB4_MASK equ 0010h
TRISB_TRISB5_POSN equ 0005h
TRISB_TRISB5_POSITION equ 0005h
TRISB_TRISB5_SIZE equ 0001h
TRISB_TRISB5_LENGTH equ 0001h
TRISB_TRISB5_MASK equ 0020h
TRISB_TRISB6_POSN equ 0006h
TRISB_TRISB6_POSITION equ 0006h
TRISB_TRISB6_SIZE equ 0001h
TRISB_TRISB6_LENGTH equ 0001h
TRISB_TRISB6_MASK equ 0040h
TRISB_TRISB7_POSN equ 0007h
TRISB_TRISB7_POSITION equ 0007h
TRISB_TRISB7_SIZE equ 0001h
TRISB_TRISB7_LENGTH equ 0001h
TRISB_TRISB7_MASK equ 0080h



EECON1 equ 0088h

EECON1_RD_POSN equ 0000h
EECON1_RD_POSITION equ 0000h
EECON1_RD_SIZE equ 0001h
EECON1_RD_LENGTH equ 0001h
EECON1_RD_MASK equ 0001h
EECON1_WR_POSN equ 0001h
EECON1_WR_POSITION equ 0001h
EECON1_WR_SIZE equ 0001h
EECON1_WR_LENGTH equ 0001h
EECON1_WR_MASK equ 0002h
EECON1_WREN_POSN equ 0002h
EECON1_WREN_POSITION equ 0002h
EECON1_WREN_SIZE equ 0001h
EECON1_WREN_LENGTH equ 0001h
EECON1_WREN_MASK equ 0004h
EECON1_WRERR_POSN equ 0003h
EECON1_WRERR_POSITION equ 0003h
EECON1_WRERR_SIZE equ 0001h
EECON1_WRERR_LENGTH equ 0001h
EECON1_WRERR_MASK equ 0008h
EECON1_EEIF_POSN equ 0004h
EECON1_EEIF_POSITION equ 0004h
EECON1_EEIF_SIZE equ 0001h
EECON1_EEIF_LENGTH equ 0001h
EECON1_EEIF_MASK equ 0010h



EECON2 equ 0089h
# 506 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\proc\\pic16f84a.inc" 3
psect udata,class=RAM,space=1,noexec
psect udata_bank0,class=BANK0,space=1,noexec
psect code,class=CODE,space=0,delta=2
psect data,class=STRCODE,space=0,delta=2,noexec
psect edata,class=EEDATA,space=3,delta=2,noexec
# 544 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\pic_as_chip_select.inc" 2 3
# 5 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/PIC16Fxxx_DFP/1.6.156/xc8\\pic\\include\\pic.inc" 2 3



stk_offset SET 0
auto_size SET 0


; stack_auto defines a symbol /name/_offset which equates to the
; stack offset of the auto object in question

stack_auto MACRO name, size
name&_offset EQU stk_offset-size
stk_offset SET name&_offset
auto_size SET -stk_offset
ENDM


; stack_param defines a symbol /name/_offset which equates to the
; stack offset of the parameter object in question

stack_param MACRO name, size
name&_offset EQU stk_offset-size
stk_offset SET name&_offset
ENDM


; alloc_stack adjusts the SP to allocate space for auto objects
; it also links in to the btemp symbol so that can be used

alloc_stack MACRO
GLOBAL btemp
addfsr FSR1,auto_size
ENDM


; restore_stack adjusts the SP to remove all auto and parameter
; objects from the stack prior to returning from a function

restore_stack MACRO
addfsr FSR1,stk_offset
stk_offset SET 0
auto_size SET 0
ENDM
# 7 "C:\\Program Files\\Microchip\\xc8\\v2.46\\pic\\include\\xc.inc" 2 3
# 21 "main.s" 2
 CONFIG FOSC = XT
    CONFIG WDTE = OFF
    CONFIG PWRTE = OFF
    CONFIG CP = OFF
; ==================
DEBOUNCE_TIME equ 8
ONESECOND equ 488
ch_0 equ 0b00111111 ; 0
ch_1 equ 0b00000110 ; 1
ch_2 equ 0b01011011 ; 2
ch_3 equ 0b01001111 ; 3
ch_4 equ 0b01100110 ; 4
ch_5 equ 0b01101101 ; 5
ch_6 equ 0b01111101 ; 6
ch_7 equ 0b00000111 ; 7
ch_8 equ 0b01111111 ; 8
ch_9 equ 0b01101111 ; 9
; ==================
PSECT Por_Vec,global,class=CODE,delta=2
    global resetVec
resetVec:
    PAGESEL main
    goto main
; ==================
PSECT Isr_Vec,global,class=CODE,delta=2
interrupt:
    retfie
; ==================
PSECT MainData,global,class=RAM,space=1,delta=1,noexec
tmr0counter: DS 1
DebounceTimer: DS 1
mode: DS 1
timecounter: DS 2
keyin: DS 1
prekey: DS 1
keyValue: DS 1
digit0: DS 1
digit1: DS 1
digit2: DS 1
digit3: DS 1
state: DS 1
prev_state: DS 1
; ==================
PSECT MainCode,global,class=CODE,delta=2
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
