.MODEL SMALL
INCLUDE GENERAL.lib
.stack 
.data
    LETMENU DB 'MENU $'
    LET1 DB '1.-Leer la cadena $'
    LET2 DB '2.-Escanear la cadena $'
    LET3 DB '3.-Salir $'
    INGRESA DB 'Ingrese una cadena $'
    SALIDA DB 'La cadena ingresada es $'
    CAD DB 5 DUP (?),'$'
    COORDX DB ?,'$'
    COORDY DB ?,'$'
    CARCARTER DB ?,'$'
    BAND DB 1 DUP (?)
    BUSCA DB 'INTRODUCE LA LETRA A BUSCAR: $'
    NOENC DB  'LA LETRA NO SE ENCUENTRA EN LA CADENA $'
    ENC DB 'LA LETRA SI SE ENCUENTRA EN LA CADENA $'
    MENSAJE DB  'AUN NO HA INGRESADO UNA CADENA $'
    aux DB ?,'$'
.code
.486
    MAIN PROC FAR 
    MOV AX, @DATA
    MOV DS, AX 
    MOV ES,AX
      
    MENU:
      CALL LIMPIA
      CALL MOUSE
      cursorPos 05h, 27h
      IMPRIMIR LETMENU
      cursorPos 07h, 21h
      IMPRIMIR LET1
      cursorPos 08h, 21h
      IMPRIMIR LET2
      cursorPos 09h, 21h
      IMPRIMIR LET3
     
    BOTON:
      MOV AX,01H 
      INT 33H 
      MOV AX,03H 
      INT 33H 
      CMP BX,1 
      JE COORDENADAS 
      CMP BX,2 
      JMP BOTON

    COORDENADAS:
      RECUPERA_COORD CX 
      MOV COORDX, AL 
      RECUPERA_COORD DX
      MOV COORDY, AL 
      
      CMP COORDX,33       
      JB BOTON
      CMP COORDY, 07
      JE COMPARA
      CMP COORDY,08
      JE COMPARA1

      CMP COORDY,09
      JE COMPARA2
      JMP BOTON
   
    UNO:
       CALL LIMPIA
       cursorPos 07h, 19h
       IMPRIMIR INGRESA
       LEER CAD
       cursorPos 08h, 19h
       IMPRIMIR SALIDA
       IMPRIMIR CAD
       
       CALL PAUSE
       MOV BAND,1
       JMP MENU

    DOS:
       
       call MOUSE
       CALL LIMPIA
       cursorPos 07h, 17h
       IMPRIMIR BUSCA
       CALL LEER_CAR
       MOV CARCARTER,AL
       MOV DI, OFFSET CAD
       MOV CX, 5
       CLD
       REPNE SCASB
       cursorPos 08h, 17h
       JNZ NOENCUENTRA
       cursorPos 08h, 17h
       IMPRIMIR ENC
       MOV DI,0
       ;cursorPos 09h, 17h
       mov aux,22

    BUSCALETRA:
        add aux,1
        cursorPos 09h,aux
        MOV BL,CAD[DI]  
        CMP BL,CARCARTER 
        JE PINTALETRA
        COLOREAR BL,0FH
        INC DI
        CMP DI,5
        JB BUSCALETRA
        CALL PAUSE
        JMP MENU
        
    PINTALETRA:   
        COLOREAR BL,03H
        INC DI
        CMP DI,5
        JB BUSCALETRA
        CALL PAUSE
        JMP MENU

    NOENCUENTRA:
      cursorPos 08h, 17h
      IMPRIMIR NOENC 
      CALL PAUSE
      JMP MENU

  COMPARA:
      CMP COORDX,49 
      JA BOTON
      JMP UNO

  COMPARA1:
      CMP COORDX,53
      JA BOTON
      JMP VAL

 COMPARA2:
      CMP COORDX,41
      JA BOTON
      JMP SALIRSE
    VAL:
      CMP BAND,1
      JE DOS
      JNE ERROR

   ERROR:
     CALL LIMPIA
     cursorPos 08h, 17h
     IMPRIMIR MENSAJE
     CALL PAUSE
     JMP MENU
  SALIRSE:
      CALL ocultarPuntero
      mov al,03H
      int 10H
      .exit 
MAIN ENDP  

    
PAUSE ENDP    
END MAIN
