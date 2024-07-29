#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <xc.h>
#include "system.h"
#include  "HardwareProfile.h"

void SystemInitial(void);
void TimerRefresh (void);
void Debounce(void);

typedef union 
{
  struct
  {
    unsigned int t244_122Hz : 2;
    unsigned int t61Hz : 1;
    unsigned int t30Hz : 1;
    unsigned int t15Hz : 1;
    unsigned int t7Hz : 1;
    unsigned int t3Hz : 1;
    unsigned int t2Hz : 1;
    };
    unsigned char tmr0Counter;
}mycounter;
mycounter myCounter;

// 1s: count 488 times
unsigned short timecounter;

char DebounceTimer;

void main(){
    SystemInitial();
    while(1){
        TimerRefresh();
	    Debounce();
    }
}

void SystemInitial(void){
    OPTION_REGbits.PS = 0b010;
    OPTION_REGbits.T0CS = 0;
    OPTION_REGbits.PSA = 0;
    TRISA = 0b00010000;
    TRISB = 0b00000000;
}

void TimerRefresh (void){
    if (INTCONbits.T0IF){
        INTCONbits.T0IF = 0;
        myCounter.tmr0Counter ++;
	    if (DebounceTimer != 0)
		    DebounceTimer++;
        if (mode)
            timecounter++;
	}
} // stopwatch timer: new mycounter, when the watch is running, than refresh the counter

bool keyin, prekey, keyValue;

void Debounce(void){
    keyin = button; // button: button signal; keyin: button input signal
    if (keyin != prekey){
        DebounceTimer = 1;
    }else{
        if(DebounceTimer > DEBOUNCE_TIME){
            keyValue = keyin;
            DebounceTimer = 0;
        }
    }
    prekey = keyin;
}

bool mode; // 0: pause; 1: run

void Stopwatch(void){
    if (keyValue == 0){
        mode = !mode;
        keyValue = 1;
    }
    if(timecounter > 488){
        timecounter = 0;
        if (digit[0] == 9) {
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
// 讀t244_122Hz判斷state，每次呼叫此函式時判斷state是否改變，有改變的話先關掉所有顯示，再輸出新的值

    const unsigned char pattern[] = {
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

    if(t244_122Hz != prev_state){
        column = 0;
        row = 0;
	    switch (t244_122Hz) {
            case 0:
                column = pattern[digit[0]];
                row = 0b0001;
                break;
            case 1:
                column = pattern[digit[1]];
                row = 0b0010;
                break;
            case 2:
                column = pattern[digit[2]];
                row = 0b0100;
                break;
            case 3:
                column = pattern[digit[3]];
                row = 0b1000;
                break;
            default:
                break;
        }
        prev_state = t244_122Hz;
    }
}