#ifndef LED_H
#define LED_H


#define MAX_LED_NR	7
void initLEDport(void);
void writeAllLEDs(unsigned char pattern);
void turnOnLED(unsigned char led_nr);
void turnOffLED(unsigned char led_nr);
void toggleLED(unsigned char led_nr);


