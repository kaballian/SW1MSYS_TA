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


/*
   LDI  R16,200
   STS  0x280,R16
   LDI  R16,5
   LDI  R17,17
   LDS  R16,0x280
   DEC  R16
   MOV  R18,R16
   ADD  R17,R18
   INC  R17
   INC  R17
   COM  R17
HER:
   JMP  HER 
   */