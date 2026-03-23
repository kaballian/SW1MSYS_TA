#include "LED.h"



void initLEDport()
{
	DDRB = 0xFF; // all outputs
	PORTB = 0; // turn all off;
}
void writeAllLEDs(unsigned char pattern)
{
	PORTB = pattern;	
}
void turnOnLED(unsigned char led_nr)
{
	if(led_nr <= MAX_LED_NR){
		PORTB = PINB | (1<<led_nr);
	}
}
void turnOffLED(unsigned char led_nr) //ex 0b00110011
{
	if(led_nr <= MAX_LED_NR){
	unsigned char mask =   //ex 0b00110011 -> 11001100
	/*
	turn of LED1
	
	0b00000010
	mask = 0b11111101
	
	PINB = 0b00110011
	PINB & mask = 
					0b11111101
				&	0b00110011
					0b00110001
	*/
		mask = PINB & (~(1<<led_nr));						
	}
}
void toggleLED(unsigned char led_nr)
{
	if(led_nr <= MAX_LED_NR){
	/*
	toggling requires us to simple flip the bit
	
	led_nr = 0b00000010
	PINB   = 0b00110011
	
	flip bit 1
	
	XOR (^)
	X	Y	Z
	0	0	0
	0	1	1
	1	0	1
	1	1	0
	
	led_nr ^ PINB
			0b00000010
			0b00110011
		^   0b00110001
		
	same pattern, flip again
	
			0b00000010
			0b00110001
			0b00110011	
	
	*/
	
	PORTB = PINB ^ (1<<led_nr);
	}
}
