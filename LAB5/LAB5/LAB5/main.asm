

//LAB5


    LDI R16,HIGH(RAMEND)
    OUT SPH, R16
    LDI R16,LOW(RAMEND)
    OUT SPL, R16

// 1- create a function to add two 32 bit numbers together

// 2- write a program that uses multiple ASM instructions

// 3- write and test functions that uses bitmasking




/*
ADD Rd, Rr
ADC Rd, Rr
SUB Rd, Rr
SBC Rd, Rr
MUL Rd, Rr

*/

// 1 (1*10^9 + 2*10^9)
// 32 bit value 1
// 0011 1011 1001 1010 1100 1010 0000 0000
// 32 bit value 2
// 0111 0111 0011 0101 1001 0100 0000 0000
/*
LSB first
Value 1 gets assigned R19-R16

R16 = 00000000
R17 = 11001010
R18 = 10011010
R19 = 00111011

Value 2 gets assigned R23-R20 
R20 = 00000000 
R21 = 10010100
R22 = 00110101
R23 = 01110111

addition goes as follows

R16 = R16 + R20  (may generate a carry)
R17 = R17 + R21 + C
R18 = R18 + R22 + C
R19 = R19 + R23 + C


*/

// load all registers
    LDI R16, 0b00000000
    LDI R17, 0b11001010
    LDI R18, 0b10011010
    LDI R19, 0b00111011
    LDI R20, 0b00000000
    LDI R21, 0b10010100
    LDI R22, 0b00110101
    LDI R23, 0b01110111

// do calculation

    ADD R16, R20
    ADC R17, R21
    ADC R18, R22
    ADC R19, R23
//UNSIGNED BTW!
    
