#ifndef LED_H
#define LED_H
#include <avr/io.h>


#define MAX_LED_NR	7
void initLEDport(void);
void writeAllLEDs(unsigned char pattern);
void turnOnLED(unsigned char led_nr);
void turnOffLED(unsigned char led_nr);
void toggleLED(unsigned char led_nr);


#endif


