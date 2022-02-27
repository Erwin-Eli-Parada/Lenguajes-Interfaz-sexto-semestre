introducir macro chain
    mov ah, 3fh
    mov bx, 00
    mov cx, 6
    LEA dx,chain
    int 21h
endm 
print macro letrero
    mov ah, 09h
    LEA dx,letrero
    int 21H
endm
leer macro cadena
    MOV AH,01H
    INT 21H
    MOV cadena,AL
endm
salto macro
    mov ah,02h
    mov dl,0ah ;salto de l?nea
    int 21h
    mov ah,02h
    mov dl,0dh ;retorno de carro
    int 21h
endm

.model small
.stack
.data
    cadena db 5 dup(?),'$'
    cadena2 db 5 dup(?),'$'
    cadena3 db 1 dup(?),'$'
    letrero1 DB 'Son iguales','$'
    letrero2 DB 'No son iguales','$'
    letrero3 DB 'desea continuar','$'
    comparador1 db 'n','$'
.code
    main proc far
    mov ax, seg @data
    mov ds, ax
    mov es, ax
    
    repeticion:
        introducir cadena
        LEA si,cadena
        introducir cadena2
        LEA di,cadena2
    
        repe cmpsb
        JE iguales
        JNE no_iguales
    
    comparacion:
        salto
        print letrero3
        salto
        leer cadena3
        salto
        mov ah, cadena3
        cmp ah, comparador1
        JE fin
        JNE repeticion
        
    iguales:
        print letrero1
        jmp comparacion
   
    no_iguales:
        print letrero2
        jmp comparacion
       
    fin:
        .exit
    
    main endp
end main