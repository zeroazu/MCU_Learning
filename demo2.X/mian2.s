    PROCESSOR   16F84A
    PAGEWIDTH   132
    RADIX       DEC

    #include <xc.inc>

    CONFIG FOSC = HS
    CONFIG WDTE = OFF
    CONFIG PWRTE = OFF
    CONFIG CP = OFF

;org 0x00
;    goto main
;org 0x04
;    goto interrupt
    
PSECT   Por_Vec,global,class=CODE,delta=2
    global  resetVec
resetVec:
    PAGESEL main
    goto    main
    
PSECT   Isr_Vec,global,class=CODE,delta=2
interrupt:
    retfie
    
PSECT   MainCode,global,class=CODE,delta=2
main:
    call initial
    
loop:
    btfsc PORTA, 4
    goto nolight
    goto light
    goto loop
    
nolight:
    bcf PORTB, 0
    goto loop

light:
    bsf PORTB, 0
    goto loop
    
initial:
    bsf STATUS, 5
    movlw 0b11010010
    movwf OPTION_REG
    movlw 0b00010000
    movwf TRISA
    movlw 0b00000000
    movwf TRISB
    bcf STATUS, 5
    return
    end
