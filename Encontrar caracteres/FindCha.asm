introducir_cadena macro cadena
    mov ah, 3fh
    mov bx, 00
    mov cx, 6
    LEA dx,cadena
    int 21h
endm 
print macro letrero
    mov ah, 09h
    LEA dx,letrero
    int 21H
endm
leer_caracter macro cadena
    MOV AH,01H
    INT 21H
    MOV cadena,AL
endm
salto macro
    mov ah,02h
    mov dl,0ah ;salto de linea
    int 21h
    mov ah,02h
    mov dl,0dh ;retorno de carro
    int 21h
endm

.model small
.stack
.data
    letrero1 db 'ingrese una cadena $'
    letrero2 db 'ingrese un caracter $'
    letrero3 db 'esta en la posicion $'
    letrero4 db 'no encontrado','$'
    cadena1 db 40 dup (?), '$'
    caracter db 1 dup (?), '$'
    posicion db 1 dup (?), '$'
    valor db 1 dup (?),'$'
    contador db 0h
.code
    main proc far
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    print letrero1
    mov si, 0
    
    introducir_cadena cadena1
    print letrero2
    leer_caracter caracter
    mov cx,40
    mov contador,40
    lea di,cadena1
    
    repetir:
        repne scasb
        je encontrado
        jne no_encontrado
        
        encontrado:
            
            salto
            print letrero3

            mov valor,cl
            mov al,contador
            sub al,valor
            mov posicion,al
            add posicion,30h
            salto
            print posicion
            jmp salida
            
         no_encontrado:
            salto
            print letrero4
            jmp salida
    salida:
        .exit
    
    main endp
end main