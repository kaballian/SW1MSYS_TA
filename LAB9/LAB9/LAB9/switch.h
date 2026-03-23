#ifndef SWITCH_H
#define SWITCH_H

#include <avr/io.h>

#define MAX_SW_NR 7
void initSwitchPort();
unsigned char switchStatus();
unsigned char switchOn(unsigned char switch_nr);




#endif