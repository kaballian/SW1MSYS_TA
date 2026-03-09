#ifndef SWITCH_H
#define SWITCH_H

#define MAX_SW_NR 7
void initSwitchPort();
unsigned char switchStatus();
unsigned char switchOn(unsigned char switch_nr);




#endif