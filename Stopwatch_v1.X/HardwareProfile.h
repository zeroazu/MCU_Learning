/* 
 * File:   HardwareProfile.h
 * Author: kuovi
 *
 * Created on 2024?7?12?, ?? 8:51
 */

#ifndef HARDWAREPROFILE_H
#define	HARDWAREPROFILE_H

#ifdef	__cplusplus
extern "C" {
#endif
    
#define _XTAL_FREQ 4000000
    
#define row0    PORTAbits.RA0
#define row1    PORTAbits.RA1
#define row2    PORTAbits.RA2
#define row3    PORTAbits.RA3
#define button  PORTAbits.RA4
#define column  PORTB



#ifdef	__cplusplus
}
#endif

#endif	/* HARDWAREPROFILE_H */

