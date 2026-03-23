/*
 * LAB9.c
 *
 * Created: 23-03-2026 21:26:23
 * Author : alext
 */ 

#include <avr/io.h>

#include "switch.h"
#include "LED.h"
#define LAB_OPG 3

//proto
void initTM1_1HZ(void);
void initTM1_PHM_PHASE(void);
void TM1_set_duty(int n);
void TM1_EX3(void);
int main(void)
{

#if LAB_OPG == 1
	
	initLEDport();
	initTM1_1HZ();
	
	PORTB = 0; // turn off LED  
	/* important note here
	PIN PB5 is also connected to OC1A
	*/
	
    while (1) 
    {
		
			
    }
	
	
#elif LAB_OPG == 2
	initSwitchPort();
	initLEDport();
	// PB5 is OCN1A
	PORTB = 0;
	initTM1_PHM_PHASE();
	
	TM1_set_duty(50);
	uint8_t BUT_input = 0;
	
	while(1)
	{
		
		if(switchOn(0))
		{
			TM1_set_duty(5);
		}
		if(switchOn(1))
		{
			TM1_set_duty(50);
		}
		if(switchOn(2))
		{
			TM1_set_duty(95);
		}
	}

#elif LAB_OPG == 3
	initSwitchPort();
	//initLEDport();
	PORTB = 0;
	TM1_EX3();
	while(1)
	{
		if(switchOn(0)){OCR1A = 15288;} 
		else if(switchOn(1)){OCR1A = 13620;} 
		else if(switchOn(2)){OCR1A = 12134;} 
		else if(switchOn(3)){OCR1A = 11454;} 
		else if(switchOn(4)){OCR1A = 10203;} 
		else if(switchOn(5)){OCR1A = 9090;} 
		else if(switchOn(6)){OCR1A = 8098;} 
		else if(switchOn(7)){OCR1A = 7644;} 
	
		if(switchStatus())
		{
			DDRB |= 0b00100000;
		
		}else{
			DDRB &= 0b11011111;
		}
	
	}
	

#endif
}


void initTM1_1HZ(void)
{
	// TABLE 17-2 (145) (TABLE17-3  for TCCR1A settings)
	//CTC -> |WGMn2|WGMn1|WGMn0|  (OCRnA top value)
	//			1	   0		0
	/*TCCR1A
	COM1A1  COM1A0  --  --  -- --  WGM11 WGM10*/
	TCCR1A = 0b01000000;
	/*TCCR1B 
	-- -- -- WGMn3 WGMn2 CS12 CS11 CS10*/
	
	/*formula
	Fpin = Fosc / (2 * N * (1 + OCRn))
	0.5Hz = 16MHz / (2 * 1024 * (1  + OCRn ))
	rearrange
	OCRN = (16MHz *2 / ((2^11))) -1 = 15625
	
	The goal is 1 full period every second, a single cycle of this toggles the output 
	meaning only half a cycle
	thus the frequency should be 0.5Hz (low for 1s/2 and high for 1s/2
 	
	*/
	TCCR1B |= (1<<WGM12) | (1<<CS12) | (1<<CS10); 
	OCR1A = 15625;
	
}
void initTM1_PHM_PHASE(void)
{
	
	/*
	PWM phase correct 10-bit
	no prescaler
	*/
	
	/*table 17.4*/
	
	TCCR1A |= ((1<<COM1A1) & ~(1<<COM1A0) | (1<<WGM11) | (1<<WGM10));
	TCCR1B |= (1<<CS10);
	
	
	
}
void TM1_set_duty(int n)
{
	int duty;
	if( n<= 0)
	{
		duty = 1;
	}else if(n>100)
	{
		duty = 100;
	}else{
		duty = n;
	}
	
	OCR1A = (duty * 1023)/ 100;
}

void TM1_EX3(void)
{
	TCCR1A = 0b01000000;
	TCCR1B = 0b00001001;
}