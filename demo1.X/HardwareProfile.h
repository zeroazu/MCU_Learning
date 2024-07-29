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
    
#define LED     PORTBbits.RB0
#define button  PORTAbits.RA4



#ifdef	__cplusplus
}
#endif

#endif	/* HARDWAREPROFILE_H */

