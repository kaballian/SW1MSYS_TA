;********** MSYS, LAB1 **********
;********************************

;********** INITIERING **********


/*
highest valid RAM address in MCU
AVR regs are 8 bits wide,
so 1 byte is the lower byte and 1 is the high byte

compiler knows SPH is the upper 8 bits and SPL is the lower 8 bits, this it "Knows" what to do


the stack pointer starts from the top and grows DOWNWARDS!
load the high byte first then the low byte

look at page 14 in datasheet for AVR CPU GPIO working registers
Section 7.6 explains the stack pointer - the SP must be set to point above 0x0200, 
everything below this point is not SRAM, but GPIO registers
Data address space:

0x0000 ??
        ?  R0  (CPU register)
        ?  R1
        ?  ...
0x001F ??  R31
??????????????????????
0x0020 � 0x005F  I/O registers
??????????????????????
0x0060 � 0x01FF  Extended I/O
??????????????????????
0x0200 � RAMEND  SRAM

*/


   LDI  R16,HIGH(RAMEND) ;Initialize Stack Pointer
   OUT  SPH,R16
   LDI  R16,LOW(RAMEND)
   OUT  SPL,R16           
   SER  R16              ;PORTB = Outputs
   OUT  DDRB,R16

;********** PROGRAM-LOOP ********
   

LOOP:
   INC R16
   OUT PORTB, R16
   CALL DELAY 
   JMP LOOP

DELAY:
   CLR R17
   LDI R18, 200
AGAIN:
   DEC R17
   BRNE AGAIN
   DEC R18
   BRNE AGAIN
   RET


// trykknap incrementer lyset
   //DDRx data direction     0 = input, 1 = output
   //PORTx output/pull up, what you drive   0 = pin goes low, 1 = pin goes high   - PR5824 ex externally pulled up
   //PINx, pins tate, what you read          
   CLR R16  ; PORTC = inputs
   OUT DDRC, R16

   CLR R17  // button state
   CLR R18  // current state
   CLR R19  // LED
   CLR R20  // DELAY1
   CLR R21  // DELAY2
   CLR R22  // DELAY3




// program loops and checks PIN state, if a change is on a pin, JUMP TO PRESSED LABEL
LOOP:
   SBIS PINC
   RJMP PRESSED  // jump to pressed function
   RJMP LOOP //loop again


PRESSED:
   IN R19, PINC ; reads  entire port register to R19
   ANDI R19, 0b00000001 // check only PIN0
   OUT PORTB, R19
   CALL DELAY
   RJMP



DELAY:
   DEC R20
   BRNE DELAY
   DEC R21
   BRNE DELAY
   DEC R22
   BRNE DELAY
   RET

   
   
   

