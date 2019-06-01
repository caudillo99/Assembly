; 1. Crear el archivo gets.asm con el siguiente codigo.

; 2. Crear archivo usr.inc con la siguiente declaracion.    
;   extrn:gets

; 3. Ensamblar gets.asm
;   tasm gets.asm

; 4. Crear la libreria usr.lib
; tlib usr +gets

; 5. Incluir usr.inc en el archivo formato.asm
;   INCLUDE procs.inc
;   INCLUDE usr.inc
;   ...
;   DATA
;       cad db 32 dup(?)
;   ...
;   .CODE
;   ... 
;   mov dx, offset cad
;   call gets
;   ...

; 6. Ensamblar formato.asm
;   tasm formato.asm

; 7. Encadenar:
;   tlink formato.obj,,,pclib06.lib usr.lib

;CR EQU 13
;LF EQU 10

_DATA  segment byte public 'DATA'
_DATA ends

_TEXT segment byte public 'CODE'
    assume cs:_TEXT, ds:_DATA
    getchar     PROC
                mov ah, 01h
                int 21h
                ret
    getchar     ENDP

    putc       PROC
                push dx                 ; Se guarda registro DX en la pila
                mov ah, 02h             ; Se utiliza el servicio 02h la cual imprime un caracter
                int 21h                 ; de la interrupcion 21h
                pop dx                  ; Se retira el dato guardado en la pila.
                ret 
    putc       ENDP    

    puts        PROC    
                push ax                 ; Se guardan los registros AX y DX
                push dx 
                mov ah, 09h             ; Se utiliza el servicio 09h el cual imprime una cadena con terminacion '$'
                int 21h                 ; la cual pertenece a la interrupcion 21h.
                pop dx                  
                pop ax                  ; Se retiran los registros de la pila.
                ret 
    puts        ENDP

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

    atoi    PROC
            push bx
            push dx
            push si
            push cx
            push es

            mov es,bx
            xor ax,ax           ;iniciar en cero el registros AX
            mov cl, es:[80h]    ; CL tiene la cantidad de parametros
            dec cl              ; Se resta 1 por el espacio en blanco
            cmp cl, 0
            je @@final
            mov bl, 10          ; Multiplicador de unidades; decenas,centas, millates,etc.
            mov si, 82h         ; indice donde inicia los numeros ingresados por consola.

            @@doo:
                mul bl          ; multiplica AL
                mov dl, es:[si] ; Se extrae el dato actual
                sub dl, '0'     ; Se Resta con un 0 ascii para convertirlo en numero.
                add al, dl      ; Se agrega el valor a DL
                inc si          ; Nos movemos al siguiente numero.
            loop @@doo          ; La cantidad de veces esta dada por los parametros ingresados.
            @@final:
            pop es
            pop cx
            pop si
            pop dx
            pop bx
            ret
    atoi    ENDP

    clscr   PROC
            push ax
            
            mov al,7    ; carga la pagina 7 del modo grafico
            mov ah,0h   ; llama al servicio de bios (grafico)
            int 10h     ; de la int 10h
            
            pop ax
            ret
    clscr   ENDP  

_TEXT ends
    PUBLIC getchar
    PUBLIC putc
    PUBLIC puts
    PUBLIC changeBase
    PUBLIC atoi
    PUBLIC clscr
END