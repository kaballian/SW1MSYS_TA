/*
 * LAB6.c
 *
 * Created: 02-03-2026 20:47:07
 * Author : alext
 */ 

#include <avr/io.h>
#define F_CPU 16000000
#include <util/delay.h>
void play_tone(uint8_t t)
{
	PORTB = 0xFF;
	_delay_us(t*4);
}
#define LAB6_1


int main(void)
{
    uint8_t i = 0;
	uint8_t BUT_input = 0;
	uint8_t freq = 0;
	long on_time = 0, off_time = 0; 
	int duty_95 = 95;
	int duty_5	= 5;
	long period = 0;
    DDRA = 0x00; //port A is input
	DDRB = 0xFF; //port B is output
	
	#ifdef LAB6_1
		while (1)
		{
			BUT_input = PINA;
			switch (BUT_input)
			{
				case 0b10000000:
				play_tone(239);
				break;
				case 0b01000000:
				play_tone(213);
				break;
				case 0b00100000:
				play_tone(190);
				break;
				case 0b00010000:
				play_tone(179);
				break;
				case 0b00001000:
				play_tone(160);
				break;
				case 0b00000100:
				play_tone(142);
				break;
				case 0b00000010:
				play_tone(127);
				break;
				case 0b00000001:
				play_tone(120);
				break;
				
				default:
				break;
			}
		}
	#else
		while(1)
		{
			BUT_input = PINA;
			switch(BUT_input)
			{
				case 0b00000001:
				period = 100000;  //100000us
				on_time = period * duty_5;
				off_time = period - on_time;
				break;
				case 0b00000010:
				period = 100000;
				on_time = period * duty_95;
				off_time = period - on_time;
				break;
				case 0b00000100:
				period = 1000;
				on_time = period * duty_5;
				off_time = period - on_time;
				break;
				case 0b00001000:
				period = 1000;
				on_time = period * duty_95;
				off_time = period - on_time;
				break;
			}
			
			
			PORTA = 0x01;
			_delay_us(on_time);
			PORTA = 0x00;
			_delay_us(off_time);
			
		}
	
	
	#endif
}



