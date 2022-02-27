PILA SEGMENT STACK "STACK"
    DB 32 DUP('STACK___')
PILA ENDS

DATOS SEGMENT 
    A DB (0)
    B DB (?)
DATOS ENDS 

CODE SEGMENT "CODE"
    ASSUME CS:CODE,DS:DATOS,SS:PILA
    MAIN PROC FAR 
        PUSH DS
        PUSH 0 

        MOV AX,DATOS
        MOV DS,AX

        MOV AH,A
        CMP AH,B
        JA SUMAB
        ADD AH,1
        MOV A,AH
        JMP FIN

        SUMAB: ADD B,1
        FIN: RET
    ENDP MAIN
CODE ENDS
END MAIN