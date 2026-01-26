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
0x0020 – 0x005F  I/O registers
??????????????????????
0x0060 – 0x01FF  Extended I/O
??????????????????????
0x0200 – RAMEND  SRAM


*/
   LDI  R16,HIGH(RAMEND) ;Initialize Stack Pointer
   OUT  SPH,R16
   LDI  R16,LOW(RAMEND)
   OUT  SPL,R16           
   SER  R16              ;PORTB = Outputs
   OUT  DDRB,R16
;********** PROGRAM-LOOP ********
   CLR  R16
LOOP:
   LDI  R17,1           ;R17 = 1 
   ADD  R16,R17         ;R16 = R16 + R17
   CALL DISP_AND_DELAY  ;Display R16       pushes return address, the addres of the next instruction after call onto the stack and sets PC = address of DISP_AND_DELAY
   JMP  LOOP            ;Jump to "LOOP"  unconditional JUMP back

;********** DISPLAY R16 *********
;********** AND DELAY ***********
DISP_AND_DELAY:
   MOV  R17,R16		; R17->R16
   OUT  PORTB,R17	; R17->PORTB (LEDS)
   CLR  R17			; R17 = 0
   CLR  R18			; R18 = 0
   LDI  R19,100		; R19 = 100
AGAIN:
   DEC  R17			; R17 = R17 - 1		(0 - 1 -> 255)  Z = 0      
   BRNE AGAIN		; IF Z != 0 -> AGAIN, else if Z = 0 -> continue   (inner looper)
   DEC  R18			; R18 = R18 - 1		(0 - 1 -> 255)	Z = 0
   BRNE AGAIN		; IF Z != 0 -> AGAIN, else if Z = 0 -> continue (loop R17 again)  (mid loop)
   DEC  R19			; as above 
   BRNE AGAIN		; as above (outer loop)
   RET				; pops the return address from the stack back into the PC, so execution resumes from the instruction after the CALL (JMP inst)
;********************************


