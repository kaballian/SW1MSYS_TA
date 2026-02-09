/*
* MSYS lab 3

*/
   

    LDI  R16,HIGH(RAMEND) ;Initialize Stack Pointer
    OUT  SPH,R16
    LDI  R16,LOW(RAMEND)
    OUT  SPL,R16           
    SER  R16              ;PORTB = Outputs
    OUT  DDRB,R16
    CLR  R16                 ; sluk alle dioder
    OUT  PORTB, R16
    CLR  R21
    CLR  R22

// loop

/*
Tone Frekvens | T = 1/f | T/2 | (T/2)/(4us)
c | 523,25 Hz   | 1911  us |  956 us|  239
D | 587,33 Hz   | 1792  us |  851 us|  213
E | 659,26 Hz   | 1517  us |  758 us|  190
F | 698,46 Hz   | 1432  us |  716 us|  179
G | 783,99 Hz   | 1276  us |  638 us|  160
A | 880,00 Hz   | 1136  us |  568 us|  142
H | 987,77 Hz   | 1012  us |  506 us|  127
C | 1046,50 Hz  | 956   us |  478 us|  120

*/

;c
LDI R20, 239
    call TONE
;D
LDI R20, 213
    call TONE
;E
LDI R20, 190
    call TONE
;F
LDI R20, 179
    call TONE
;G
LDI R20, 160 
    call TONE
;A
LDI R20, 142
    call TONE
;H
LDI R20, 127
    call TONE
;C
LDI R20, 120
    call TONE

HERE:
JMP HERE  ;remain here


// delay (R18 * 4us)
// creates a delay that is 4us * the number in the register

DELAY:
    LDI R17, 21 ; <<----
AGAIN:           ; cycles | branch | NOT branch |     1/16MHz = 62.5ns
    DEC R17         ; 1 | 1                       
    BRNE AGAIN      ; 2 | 1                              
    DEC R18         ; 1 | 1     
    BRNE DELAY      ; 2 | 1   
    RET             ; 4

/*
one iteraton = 3 (taken) | one iteration = 4 (not taken)
(N-1) * taken + last * not taken
inner:
(N-1) * 3 + 2 => 3N - 3+2

62.5ns * N = 4e-6 -> N = 4e-6/62.5e-9 = 64

3N ~~ 64 => N=64/3 

(21-1) * 3 + 1 * 2 = 
*/


//solution than works
; TONE:
; ; LDI R18, 200 ; <<--- remove for part 2
;             ; insert part 2 code



;     LDI R21, 250  ; load 250 to R21
; TONE_LOOP:
;     COM R22       ; ones complement on R22 (inverting all bits)
;     OUT PORTB, R22 ; send it to portb'
;     MOV R18, R20    ; copy R20 values to R18
;     CALL DELAY      ; self explanatory lule
;     DEC R21         ; decrement by 1
;     BRNE TONE_LOOP
;     RET


// bonus solution, length independen of frequency
// R19 = note duration for all freqs
// R20 = half period delay 
// calc length of tone: toggle = 300ms / (T/2)
TONE:
    LDI R19, 200 ; move the note length into R19

TONE_LOOP:
    COM R22
    OUT PORTB, R22
    MOV R18, R20
    CALL DELAY
    DEC R20
    BRNE TONE_LOOP

    RET









