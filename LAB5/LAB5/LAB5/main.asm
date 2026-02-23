

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
//UNSIGNED BTW! - only works as unsigned, due to the fact signed is 2.147.483.647 as max value
    
//Ex 2

//Port A is inputs

    CLR R16
    OUT DDRA, R16
   
//Port B is outputs
    SER R16
    OUT DDRB, R16
//turn off all LEDs
    CLR R16
    OUT PORTB, R16

//pool all the PINS
HERE:
    //sample inputs ONCE

    IN R20, PINA
    COM R20


    SBRS R20, 7
    RJMP CASE_6:
    IN R16, PORTB
    INC R16
    OUT PORTB, R16
    
CASE_6:
    SBRS R20, 6
    RJMP CASE_5
    IN R16, PORTB
    DEC R16
    OUT PORTB, R16

CASE_5:
    SBRS R20, 5
    RJMP CASE_4
    IN R16, PORTB
    SWAP R16
    OUT PORTB, R16


CASE_4:

    SBRS R20, 4
    RJMP CASE_3
    IN R16, PORTB
    COM R16,
    OUT PORTB, R16

CASE_3:
    SBRS R20, 3
    RJMP CASE_2
    IN R16, PORTB
    LDI R17, 4
SHIFT_LOOP:
    LSR R16
    DEC R17
    BRNE SHIFT_LOOP
    OUT PORTB, R16


CASE_2:
    SBRS PINA, 2
    //TODO - ignore for now

CASE_1:
    SBRS R20, 1
    RJMP CASE_0
    IN R16, PORTB
    ANDI R16, 0b01111110
    OUT PORTB, R16

CASE_0:
    SBRS R20, 0
    JMP MAIN
    IN R16, PORTB,
    ORI R16, 0b11111111
    OUT PORTB, R16
    
//SW7 - inc PORTB
//SW6 - dec PORTB
//SW5 - value of LED7-4 switches with LED3-0 (use a SWAPF or something)
//SW4 - complement all LED's
//SW3 - value of PORTB is divided by 8 (shift down)
//SW2 - value of PORTB is divided by 7 (actual divison)
//SW1 - LED7 & 0 are turned off, while others are unaffected
//SW0 - LED7 & 0 are turned on, while others are unaffected

    //READ PIN A

 
    CALL DELAY_1S
    
    RJMP HERE

DELAY_1S:
    LDI R18, 100 ; outer loop
OUTER:
    LDI R19, 200 ; middle
MIDDLE:
    LDI R20, 200 ; inner
INNER:
    DEC R20
    BRNE INNER
    DEC R19
    BRNE MIDDLE
    DEC R18
    BRNE OUTER
    RET



; // OFFICIAL LØSNING


;  HERE:
;    LDI  R20,2             ;Tænd LED 2
;    CALL LED_ON
;    CALL DELAY

;    LDI  R20,7             ;Tænd LED 7
;    CALL LED_ON
;    CALL DELAY

;    SER  R16               ;Tænd alle LEDs
;    OUT  PORTB,R16
;    CALL DELAY

;    LDI  R20,5             ;Sluk LED 5
;    CALL LED_OFF
;    CALL DELAY

;    LDI  R20,0             ;Sluk LED 0
;    CALL LED_OFF
;    CALL DELAY

;    LDI  R20,0             ;Toggle LED 0
;    CALL LED_TOGGLE
;    CALL DELAY

;    LDI  R20,7             ;Toggle LED 7
;    CALL LED_TOGGLE
;    CALL DELAY

;    CLR  R16               ;Sluk alle LEDs
;    OUT  PORTB,R16
;    CALL DELAY

;    JMP HERE               ;Gentag loop

; ;************ LED_OFF **********
; ;***** Slukker en LED på PB ****
; ;***** Bit nr.(0-7) i R20   ****
; ;*******************************
; LED_OFF:
;    LDI  R21,1             ;R21 = 0b00000001
;    CPI  R20,0
;    BREQ KLAR1             ;Hop, hvis LED nr. = 0
; IGEN1:
;    LSL  R21               ;Venstre-skift R21
;    DEC  R20               ;ialt "LED nr." pladser
;    BRNE IGEN1
; KLAR1:
;    COM  R21               ;Inverter "masken" 
;    IN   R20,PINB          ;Aflæs alle LEDs
;    AND  R20,R21           ;- lav bitvis AND   
;    OUT  PORTB,R20         ;- og skriv ud til LEDs igen
;    RET	
; ;*******************************

; ;************ LED_ON ***********
; ;***** Taender en LED på PB ****
; ;***** Bit nr.(0-7) i R20   ****
; ;*******************************
; LED_ON:

;    ;<-------- Skriv den manglende kode her


;    RET	
; ;*******************************

; ;********** LED_TOGGLE *********
; ;***** Toggler en LED på PB ****
; ;***** Bit nr.(0-7) i R20   ****
; ;*******************************
; LED_TOGGLE:

;    ;<-------- Skriv den manglende kode her

;    RET	
; ;*******************************

; ;*******************************
; DELAY:
;    LDI  R31,130
;    CLR  R30
;    CLR  R29
; LOOP:
;    DEC  R29
;    BRNE LOOP
;    DEC  R30
;    BRNE LOOP
;    DEC  R31
;    BRNE LOOP
;    RET
; ;*******************************