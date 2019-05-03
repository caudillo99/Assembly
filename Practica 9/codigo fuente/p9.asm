
.MODEL small
.STACK 100h
    LOCALS
INCLUDE usr.inc
.DATA
    binario     db  'AL en binario: ',      '$'
    octal       db  'AL en octal: ',        '$'
    decimal     db  'AL en decimal: ',      '$'
    hexadecimal db  'AL en hexadecimal: ',  '$'
.CODE
    main        PROC
                mov ax, @DATA
                mov ds, ax

                mov ax, 100              ; Numero al cual se va convertir
                mov bx, 2              ; Base deseada 

                cmp bx, 16              ; Realiza comparaciones entre 16,10,8 y 2
                je @@hex                ; respectivamente para saber que mensaje imprimir
                cmp bx, 10              ; funciona como un tipo switch-case.
                je @@dec
                cmp bx, 8
                je @@oct
                mov dx, offset binario
                je @@print

          @@hex:mov dx, offset hexadecimal
                jmp @@print
          @@dec:mov dx, offset decimal
                jmp @@print
          @@oct:mov dx, offset octal
        @@print:call puts               ; Se imprime el mensaje correspondiente
                call changeBase         ; Se hace la llamada al procedimiento que convierte en una base dada por BX

                mov ah, 04ch            ; fin del programa.
                mov al, 0
                int 21h
                ret
    main        ENDP
    ;******************************           
    changeBase  PROC
                push bx                 ; Se guardan los registros utilizados
                push dx 
                push cx 
                push ax 

                xor cx,cx               ; Se inicializa en 0 la variable que nos srive de contador 

      @@no_zero:xor dx,dx               ; Se limpia el registro dx, los valores no se pierden porque se guardan en la pila
                div bx                  ; Se realiza la divison iterativa para acercarnos al cero
                push dx                 ; se guarda el valor del residuo en la pila.
                inc cx                  ; Se incrementa cx, para despues darle formato, dependiendo de la base que se haya elegido.
                or ax,ax                ; Revisa que el cociente no sea 0.
                jne @@no_zero           ; Mientras el cociente no sea 0, las instrucciones se repiten

    @@convierte:pop ax                  ; Se extraen los datos de la pila
                add ax,'0'              ; Se le suma un '0' ascii (48 decimal)   
                cmp ax,'9'              ; compara con el 9 ascii para darle el formato que la base requiera.
                jbe @@print             ; Si es menor o igual se manda a imprimir el valor.
                add ax,7                ; Si es mayor a 9 se le suma un 7 para que apunte a las letras (A,B,C...).      

        @@print:mov dx,ax   
                call putc               ; se imprime el valor
                loop @@convierte        ; Realiza la cantidad de veces que se hayan guardado valores en la pila en las instrucciones anteriores.

                pop ax                  ; Se remueven los registros de la pila
                pop cx  
                pop dx  
                pop bx
                ret
    changeBase  ENDP
    
END