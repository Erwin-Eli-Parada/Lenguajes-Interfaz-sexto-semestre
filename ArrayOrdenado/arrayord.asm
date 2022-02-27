TITLE
.286

spila SEGMENT stack
      DB 32 DUP ('stack___')
spila ENDS

segdatos SEGMENT
    cadena DB 5 DUP(0), '$'
    espacio DB 0AH,0DH, '$'
segdatos ENDS

segcodigo SEGMENT 'CODE'
Assume ss:spila, ds:segdatos, cs:segcodigo

    Main PROC FAR
    PUSH DS
    PUSH 0
    MOV AX, segdatos
    MOV DS,AX
    
    MOV SI,0   
    LEER:
        MOV AH,01H
        INT 21H
        
        MOV BX[SI], AL
        INC SI
        CMP SI,4
        JBE LEER
        
    MOV SI,0
    MOV CX,4
    ORDENA:
        CMP SI,CX     
        JZ ITERACION 
        
        MOV AL, cadena[SI]
        MOV BL, cadena[SI+1]
        CMP AL,BL
        JA SWAP       
        INC SI
        JMP ORDENA

        SWAP:
            MOV cadena[SI],BL
            MOV cadena[SI+1],AL
            INC SI
            JMP ORDENA
        
        ITERACION:
            MOV SI,0
            DEC CX
            CMP CX,0
            JNZ ORDENA           
       
    MOV AH,09H
    LEA DX,espacio
    INT 21H
    MOV AH,09H
    LEA DX,cadena
    INT 21H
           
    RET
    Main ENDP
    segcodigo ENDS
END Main
