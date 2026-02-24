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
    CLR R16
    LDI R16, 0b00000001 // bit 0, (led 0)
    OUT DDRB, R16
    CLR R16
    OUT DDRA, R16



    // SW0-7 is connected to PA0-7
    // LED0-7 is connected to PB0-7
    //R20 til at holde PIN a STATE
    CLR R20

HERE:
    SBIS PINA, 7
    LDI R20, 255
    SBIS PINA, 6  
    LDI R20, 128
    SBIS PINA, 5 
    LDI R20, 64
    SBIS PINA, 4 
    LDI R20, 32
    SBIS PINA, 3 
    LDI R20, 16
    SBIS PINA, 2  
    LDI R20, 8
    SBIS PINA, 1 
    LDI R20, 4
    SBIS PINA, 0 
    LDI R20, 2

    SBI PORTB, 0

    MOV R18, R20
    CALL DELAY

    CBI PORTB, 0

    LDI R18, 128
    call DELAY

    JMP HERE






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

    