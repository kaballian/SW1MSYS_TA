;**********************************
;******** MSYS, LAB5,DEL 2 ********
;**********************************
;****** INITIERING ****************
   LDI  R16,HIGH(RAMEND)
   OUT  SPH,R16
   LDI  R16,LOW(RAMEND)
   OUT  SPL,R16

   CLR  R16
   OUT  DDRA,R16   ;Hele PA = indgange (switches)
   
   SER  R17
   OUT  DDRB,R17   ;Hele PB = udgange (LEDs)
   OUT  PORTB,R16  ;Sluk alle lysdioder

;****** PROGRAM-LOOP **************
 HERE:
   SBIS PINA,7     ;Hvis SW7 trykket  
   CALL KNAP7      ;- kald kode for SW7
   SBIS PINA,6     ;Hvis SW6 trykket 
   CALL KNAP6      ;- kald kode for SW6   
   SBIS PINA,5     ;Hvis SW5 trykket 
   CALL KNAP5      ;- kald kode for SW5   
   SBIS PINA,4     ;Hvis SW4 trykket 
   CALL KNAP4      ;- kald kode for SW4   
   SBIS PINA,3     ;Hvis SW3 trykket 
   CALL KNAP3      ;- kald kode for SW3   
   SBIS PINA,2     ;Hvis SW2 trykket 
   CALL KNAP2      ;- kald kode for SW2   
   SBIS PINA,1     ;Hvis SW1 trykket 
   CALL KNAP1      ;- kald kode for SW1   
   SBIS PINA,0     ;Hvis SW0 trykket 
   CALL KNAP0      ;- kald kode for SW0   
   CALL DELAY      ;Vent "et par sekunder"
   RJMP HERE       ;Gentag loop
;**********************************
KNAP7:
   IN   R16,PINB        ;PORTB = PORTB + 1
   INC  R16
   OUT  PORTB,R16  
   RET
;**********************************
KNAP6:
   IN   R16,PINB        ;PORTB = PORTB - 1
   DEC  R16
   OUT  PORTB,R16
   RET
;**********************************
KNAP5:
   IN   R16,PINB        ;SWAP PORTB
   SWAP R16
   OUT  PORTB,R16
   RET
;**********************************
KNAP4:
   IN   R16,PINB        ;Inverter hele PORTB
   COM  R16
   OUT  PORTB,R16
   RET
;**********************************
KNAP3:
   IN   R16,PINB        ;PORTB = PORTB / 8
   LSR  R16
   LSR  R16
   LSR  R16
   OUT  PORTB,R16
   RET
;**********************************
KNAP2:
   IN   R16,PINB        ;PORTB = PORTB / 7
   LDI  R17,7           ;(Se side 167 i bogen)
   CLR  R18
L1:INC  R18
   SUB  R16,R17
   BRCC L1
   DEC  R18
   OUT  PORTB,R18
   RET
;**********************************
KNAP1:
   IN   R16,PINB        ;Sluk LED7 og LED0
   LDI  R17,0b01111110
   AND  R16,R17
   OUT  PORTB,R16
   RET
;**********************************
KNAP0:
   IN   R16,PINB        ;Tænd LED7 og LED0
   LDI  R17,0b10000001
   OR   R16,R17
   OUT  PORTB,R16
   RET
;**********************************
DELAY:                  ;Vent et par sekunder
   LDI  R31,130
LOOP:
   DEC  R29
   BRNE LOOP
   DEC  R30
   BRNE LOOP
   DEC  R31
   BRNE LOOP
   RET
;**********************************
 


