#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <xc.h>
#include "system.h"
#include  "HardwareProfile.h"

#define DEBOUNCE_TIME 8
#define ONESECOND     488 
// 4MHz/4/8/256 = 488.28125Hz
// 0.999424sec for every 488 oscillation 

void SystemInitial(void);
void TimerRefresh (void);
void Debounce(void);
void Stopwatch(void);
void Display(void);

typedef union {
    struct{
        unsigned int t244_122Hz : 2;
        unsigned int t61Hz : 1;
        unsigned int t30Hz : 1;
        unsigned int t15Hz : 1;
        unsigned int t7Hz : 1;
        unsigned int t3Hz : 1;
        unsigned int t2Hz : 1;
    };
    unsigned char tmr0Counter;
} mycounter;

typedef struct {
    unsigned int var : 2;
} TwoBitField;

const unsigned char pattern[] = { // 7-segment displayer pattern
    0b00111111,  // 0
    0b00000110,  // 1
    0b01011011,  // 2
    0b01001111,  // 3
    0b01100110,  // 4
    0b01101101,  // 5
    0b01111101,  // 6
    0b00000111,  // 7
    0b01111111,  // 8
    0b01101111   // 9
};

// 1s: count 488 times
unsigned short timecounter;
unsigned char DebounceTimer;
unsigned char digit[4] = {0};
bool mode = 0; // 0: pause; 1: run
bool keyin, prekey, keyValue = 1;
mycounter myCounter;
TwoBitField prev_state;

void main(){
    SystemInitial();
    while(1){
        TimerRefresh();
	Debounce();
        Stopwatch();
        Display();
    }
}

void SystemInitial(void){
    OPTION_REGbits.PS = 0b010;
    OPTION_REGbits.T0CS = 0;
    OPTION_REGbits.PSA = 0;
    TRISA = 0b00010000;
    TRISB = 0b00000000;
}

void TimerRefresh (void){ //Refreshing tmr0, debounce timer, time counter
    if (INTCONbits.T0IF){
        INTCONbits.T0IF = 0;
        myCounter.tmr0Counter ++;
	if (DebounceTimer != 0)    DebounceTimer++;
        if (mode)   timecounter++; // refresh counter if stopwatch is active
	}
}

void Debounce(void){
    keyin = button; // button: button signal (0: press); keyin: button input signal
    if (keyin != prekey)    DebounceTimer = 1; // when button state change, start debounce timer
    else
        if(DebounceTimer > DEBOUNCE_TIME){
            keyValue = keyin; // output key state to keyValue
            DebounceTimer = 0; //reset debounce timer
        }
    prekey = keyin;
}

void Stopwatch(void){
    if (keyValue == 0){ // if the button is pressed
        mode = !mode; // run-> pause, pause->run
        keyValue = 1; // reset keyValue
    }
    if(timecounter > ONESECOND){
        timecounter = 0;
        if (digit[0] == 9) { // add timer number and handle the carry
            digit[0] = 0;
            if (digit[1] == 5) {
                digit[1] = 0;
                if (digit[2] == 9) {
                    digit[2] = 0;
                    if (digit[3] == 5)
                        digit[3] = 0;
                    else  digit[3] = digit[3] + 1;
                } else  digit[2] = digit[2] + 1;
            } else  digit[1] = digit[1] + 1;
        } else  digit[0] = digit[0] + 1;
    }
}

void Display(void){
    if(myCounter.t244_122Hz != prev_state.var){
        column = 0;
        row0 = 0; row1 = 0; row2 = 0; row3 = 0;
	    switch (myCounter.t244_122Hz) {
            case 0:
                column = pattern[digit[0]];
                row0 = 1;
                break;
            case 1:
                column = pattern[digit[1]];
                row1 = 1;
                break;
            case 2:
                column = pattern[digit[2]];
                row2 = 1;
                break;
            case 3:
                column = pattern[digit[3]];
                row3 = 1;
                break;
            default:
                break;
        }
        prev_state.var = myCounter.t244_122Hz;
    }
}