/*************************************
* MSYS, LAB8, Part 1                 *
* Timer 0 in Normal Mode             *
* Led port increments 125 times/sec. *
**************************************/
#include <avr/io.h>
#include "LED.h"
#include "switch.h"

#define LAB_OPG 1

// Prototype
void T0Delay();
void T1Delay();


int main()
{
#if LAB_OPG == 1
	unsigned char x = 0;
	// Klargør LED port
	initLEDport();
	while(1)
	{
		// Vent 1/125 sekund
		T0Delay();
		// Inkrementer og vis variablen x
		x++;
		writeAllLEDs(x);
	}
#elif LAB_OPG == 2
	unsigned char tiere = 0;
	unsigned char enere = 0;

	// Klargør LED port
	initLEDport();
	while(1)
	{
		// Vent 1 sekund
		T1Delay();
		// Juster enere og tiere (BCD format)
		enere++;
		if (enere > 9)
		{
			enere = 0;
			tiere++;
			if (tiere > 5)
			{
				tiere = 0;
			}
		}
		// Vis 10'ere og enere på LEDs
		writeAllLEDs(enere | (tiere<<4));
	}

#elif LAB_OPG == 3
	// Initialize the LED port
	initLEDport();
	// PD = Inputs (T0 pin is PD7)
	DDRD = 0;
	// Timer 0 in normal mode
	// Timer 0 clock = T0 (rising edge)
	TCCR0A = 0b00000000;
	TCCR0B = 0b00000111;
	while(1)
	{
		// Display TCNT0 at the LEDs
		writeAllLEDs(TCNT0);
	}

#endif
}

void T0Delay()
{
	// <----- Skriv den manglende kode her
	//use prescaler of 1024 (2^10)
	
	
	//16MHz / 2^10 = 15625 Hz (det betyder at i et sekundt tæller den ~15KHz)
	/*
	vi vil have 125Hz = 8ms
	1/15KHz = 64us
	
	hvor mange ticks til 8ms?
	15625 / 125 = 125
	
	8 bit tælleren tæller til i skidt af ~15KHz
	preload TCNT0 med 256-125 = 131
	
	
	*/
	TCCR0A = 0b00000000; // normal mode
	TCCR0B = 0b00000101;   
	
	// vi venter på timer 0 overflow flag
	
	while((TIFR0 & (1<<0)) ==0){}
	
	//stop timer 0
	TCCR0B = 0b00000000;
	//nulstil flaget 
	TIFR0 = 0b00000001;
	
}
void T1Delay()
{
	// 16000000 Hz /256 = 62500 Hz
	// Vi har altså 62500 "trin" per sekund
	// - og ønsker 1 sekund til overflow
	TCNT1 = 65536-62500;
	// Timer 1 i Normal Mode og PS = 256
	TCCR1A = 0b00000000;
	TCCR1B = 0b00000100;
	// Afvent Timer 1 overflow flag
	while ((TIFR1 & (1<<0)) == 0)
	{}
	// Stop Timer 1 (ingen clock)
	TCCR1B = 0b00000000;
	// Nulstil Timer 1 overflow flag
	TIFR1 = 1<<0;
}