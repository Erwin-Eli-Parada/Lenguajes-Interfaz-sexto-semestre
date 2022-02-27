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
    mov bh,00
    mov dl,0ah ;salto de linea
    int 21h
    mov ah,02h
    mov dl,0dh ;retorno de carro
    int 21h
endm
salto2 macro x,y
    mov ah,02h
    mov bh,00
    mov dl,x
    mov dh,y
    int 10h
    ;mov dl,0ah ;salto de linea
    ;int 21h
    ;mov ah,02h
    ;mov dl,0dh ;retorno de carro
    ;int 21h
endm
limpiar macro
    mov ax,0600h
    mov bh,10
    mov cx,0000h
    mov dx,184fh
    int 10h
endm

.model small
.stack
.data
    letrero1 db 'ingrese una cadena $'
    letrero2 db 'ingrese un caracter $'
    letrero3 db 'esta en la posicion $'
    letrero4 db 'no encontrado$'
    letrero5 db '1 leer cadena$'
    num equ $-letrero5
    letrero6 db '2 escanear cadena$'
    num2 equ $-letrero6
    letrero7 db '3 salir$'
    num3 equ $-letrero7
    cadena1 db 40 dup (' '), '$'
    caracter db 1 dup (?), '$'
    posicion db 1 dup (?), '$'
    valor db 1 dup (?),'$'
    contador db 0h
    coorx db ?,'$'
    coory db ?,'$'
.code
    main proc far
    mov ax,@data
    mov ds,ax
    mov es,ax
    menu: ;posiciona el mouse
        limpiar ;limpia la pantalla       
        salto2 20,10
        print letrero5  ;imprimir las opciones
        salto2 20,11
        print letrero6
        salto2 20,12
        print letrero7
    
    mouse: ;funcion del mouse
        mov ax,01h ;activar el mouse
        int 33h    
        mov ax,03h ;obtener coordendas
        int 33h  
        cmp bx,1  ;comparar que boton fue presionado
        je coor
        jne mouse
        
    coor:  ;obtener las coordendas del mouse
        mov ax,cx ;primero las x
        mov bl,8
        div bl
        mov coorx,al
        
        mov ax,dx ;luego las y
        div bl
        mov coory,al
        
        cmp coory,0
        je leer_cadena
        cmp coory,1
        je escanear_cadena
        cmp coory,2
        je salida
        cmp coory,2
        jne menu2
    menu2:
        jmp menu
    mouse2:
        jmp mouse
        
    salida:
        cmp coorx,num3
        jnbe mouse2
        .exit
    leer_cadena:
        cmp coorx,num
        jnbe mouse2
        mov ah,02h
        mov dx,0000h
        mov bh,00h
        int 10h
        limpiar
        print letrero1
        mov si, 0
        introducir_cadena cadena1
        jmp menu
        
    escanear_cadena:
        cmp coorx,num2
        jnbe mouse2
        mov ah,02h
        mov dx,0000h
        mov bh,00h
        int 10h
        limpiar
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
            mov ah,01h
            int 21h
            jmp menu
            
        no_encontrado:
            salto
            print letrero4
            mov ah,01h
            int 21h
            jmp menu
    
    main endp
end main
    