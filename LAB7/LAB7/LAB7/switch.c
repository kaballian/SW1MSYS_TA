#include "switch.h"

void initSwitchPort()
{
	DDRA = 0x00; // all inputs
}
unsigned char switchStatus()
{
	return PINA;
}
unsigned char switchOn(unsigned char switch_nr)
{
    if(switch_nr <= MAX_SW_NR)
	{
		/*
		
		read PINA, negate it
		AND switch nr together, if !0 return true
		
	ex	sw nr0b00001000
		sw nr	0b00001000   
		PINA	0b11110111   (pulled up)
	   ~PINA    0b00001000	 (negated PINA)
		
		
		&		0b00001000   (!0)
		
		
		if sw was not pressed
		
				0b00001000
				0b11111111
			~   0b00000000   (negated PINA)
			&	0b00000000	
		*/
		return ~PINA & switch_nr 
	}
}


