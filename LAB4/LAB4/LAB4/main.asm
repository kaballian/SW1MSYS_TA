;
; LAB4.asm
;
; Created: 16-02-2026 20:19:13
; Author : alext
;


    LDI R16, HIGH(RAMEND)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16
    SER R16
    OUT DDRB, R16
    CLR R16
    OUT DDRA, R16



    // SW0-7 is connected to PA0-7
    // LED0-7 is connected to PB0-7
    //R20 til at holde PIN a STATE
    CLR R20


HERE:

// -> write a program that tests the 8 push buttons and plays the correct tone, while the buttons is beind held
// no button -> no sound
    //READ the PINA register, check if each bit is set, then load the value
    SBIS PINA, 7
    LDI R18, 239
    SBIS PINA, 6  
    LDI R18, 213
    SBIS PINA, 5 
    LDI R18, 190
    SBIS PINA, 4 
    LDI R18, 179
    SBIS PINA, 3 
    LDI R18, 160
    SBIS PINA, 2  
    LDI R18, 142
    SBIS PINA, 1 
    LDI R18, 127
    SBIS PINA, 0 
    LDI R18, 120
 
    //READ THE PINA register      
    IN R20, PINA
    CPI R20, 0xFF //check R20 med immidate 0xFF
    BREQ HERE // R20 = 0xFF, BREQ to here (no button is pressed)
    COM R16
    OUT PORTB, R16
    CALL DELAY
    RJMP HERE


//JMP unconditional jump, destination may be far away
//4 bytes
//RJMP unconditional jump relative to current PC
//range 2048 words, faster than JMP, limited range
// BREQ is a conditional jump,acts the same as a jump but adds a condition.

// Delay (R18*4us)
DELAY:
    LDI R17, 20
AGAIN:
    DEC R17
    BRNE AGAIN
    DEC R18
    BRNE DELAY
    RET