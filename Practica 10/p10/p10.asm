    MODEL small
.STACK 100h
;----- Insert INCLUDE "filename" directives here
;----- Insert EQU and = equates here
INCLUDE usr.inc
LOCALS
.DATA
    new_line    db      13,10,'$'
    msg1        db      '243 al cuadrado: ','$'
    msg2        db      'Capture un numero: ','$'
    msg21       db      ' al cuadrado = ', '$'
    msg3        db      'radio: ','$'
    msg31       db      'altura: ','$'
    msg32       db      'Volumen: ','$'
    msg6        db      'pulgadas = ','$'
    msg61       db      'pies = ','$'
    msg62       db      'metros = ','$'
    msg8        db      "Capture: " ,32,'$'
    msg82       db      32 dup('$')
    mayor       db      "Mayor: ", '$'
    msgPrimo    db      " Es primo",13,10,'$'
    msgNoPrimo  db      " No es primo",13,10,'$'
    msg14       db      "Anita lava la tina", 0
    msg142       db      "Anita lava la tina", 13,10,'$'
    msg15       db      "palabra", '$'
    veces       db      " veces:", '$'
    msg17       db      "1234",0
    palind      db      "Es palindromo", '$'
    nopalind    db      "No es palindromo", '$'
    msg11       db      32 dup('$')
    perimetro   db      "perimetro:", '$'
    celsius     db      " celsius a farenheit:", '$'
.CODE ;----- Insert program, subrutine call, etc., here
        main    PROC
                mov ax,@data    ;Inicializar DS al la direccion
                mov ds,ax       ; del segmento de datos (.DATA)
                mov ah, 62h     ; BX tiene la direccion de PSP
                int 21h
                ;call anexo1
                ;call anexo2
                ;call anexo3
                call anexo5
                ;call anexo6
                ;call anexo8
                ;call anexo9
                ;call anexo11
                ;call anexo12
                ;call anexo14
                ;mov dx, offset msg142
                ;call puts
                ;cmp  ah,1
                ;jne @@nopalindd
                ;mov dx, offset palind
                ;call puts
                ;jmp @@aqui
                ;@@nopalindd:
                ;mov dx,offset nopalind
                ;call puts
                ;@@aqui:
                ;call anexo15
                ;mov ax,365
                ;call anexo16
                ;call anexo17
                ;call anexo18_2
                ;call anexo18_12
                ;call anexo18_14

                mov ah,04ch ; fin de programa
                mov al,0
                int 21h
                ret
        main    ENDP

        ; Calcula el cuadrado de 243
        anexo1  PROC
                push ax
                push bx
                push dx

                mov dx, offset msg1
                call puts
                xor dx,dx
                mov ax, 243
                mov bx, 243
                mul bx
                mov bx, 10
                call anexo16
                mov dx, offset new_line
                call puts
                mov dx, offset new_line
                call puts
                
                pop dx
                pop bx
                pop ax
                ret
        anexo1  ENDP

        ; Captura un numero, y lo eleva al cuadrado.
        anexo2  PROC
                push dx
                push ax
                push bx
                push cx

                mov dx,offset msg2
                call puts
                mov ah, 01h                     ;captura un caracter del teclado.
                int 21h
                mov dx, offset new_line
                call puts
                mov dl,al
                call putc                       ; caracter capturado
                mov dx, offset msg21            ; mensaje de elevado
                call puts                     
                mov ah, 0
                sub al, '0'                     ; se convierte en numero puro.
                mov cl, al                      ; se copia el valor en otro resgistro
                mul cl                          ; se multiplica por si mismo.
                mov bx, 10                      ; base en la que se imprime el numero
                call anexo16                 ; imprime el numero en pantalla
                mov dx, offset new_line
                call puts
                mov dx, offset new_line
                call puts
                pop cx
                pop bx
                pop ax
                pop dx
                ret
        anexo2  ENDP
        
        ; calcular el area y volumen de un cilindro; radio y altura
        ; se capturan desde el teclado.
        anexo3  PROC
                push ax
                push bx
                push cx
                push dx

                mov ax,03h              ; se redondea a 3 PI.
                mul al
                push ax                 ; se guarda pi al cuadrado en la pila.
                
                mov dx, offset msg3
                call puts               ; se imprime que capture el radio.
                mov ah,01h              ; se espera la captura del usuario imprimiendo la captura en pantalla.
                int 21h
                xor ah,ah
                sub al, '0'
                push ax                 ; se guarda el numero capturado

                mov dx, offset new_line
                call puts               ; se imprime un salto de linra.

                mov dx, offset msg31
                call puts               ; se imprime que capture la altura.
                mov ah,01h              ; se espera la captura del usuario imprimiendo la captura en pantalla.
                int 21h
                xor ah,ah
                sub al, '0'             ; se convierte en numero puro.
                
                pop bx                  ; se extraen ambos registros de la pila y se multiplican
                pop cx
                mul bl
                mul cl
                
                mov dx, offset new_line
                call puts
                mov dx, offset msg32
                call puts
                mov bx,10               ; Base a imprimir.
                call anexo16         ; se imprime el resyultado. 
                mov dx, offset new_line
                call puts
                mov dx, offset new_line
                call puts
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        anexo3  ENDP
        
        ;calcular perimetro y la superficie de un cuadrado dada la 
        ; longitud de su lado.
        ; YA ESTA LISTO EN UBUNTU
        anexo4  PROC
                push ax
                push bx
                push cx
                push dx
                mov dx, offset perimetro
                call puts
                mov al,11
                mov bl, 17
                mul bl
                mov bx,10
                call changeBase
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        anexo4  ENDP
        
        ;Convertir de celsius a farenheit
        ; YA ESTA LISTO EN UBUNTU
        anexo5  PROC
                push ax
                push bx
                push dx

                xor ax,ax
                mov al, 2
                mov bl, 9
                mul bl
                add al, 32

                mov dl,bl
                add dl, '0'

                push ax
                call putc
                pop ax
                mov dx, offset celsius
                call puts

                mov bx,10
                call changeBase
                pop dx
                pop bx
                pop ax
                ret
        anexo5  ENDP

        ;convertir metros a pies y pulgadas
        anexo6  PROC
                push ax
                push bx
                push dx
                xor ax,ax
                
                mov dx, offset msg62
                call puts
                
                mov al,10               ;En AL se guardan los metros
                mov bx, 10
                call anexo16
                mov dx, offset new_line
                call puts
                
                mov dx, offset msg61
                call puts
                mov bl, 3              ;en Bl la equivalencia de metros a pulgadas
                mul bl
                mov bx, 10
                call anexo16
                
                xor bx,bx
                mov bl,12
                mul bl
                mov bx,10

                mov dx, offset new_line
                call puts
                
                mov dx, offset msg6
                call puts
                call anexo16
                mov dx, offset new_line
                call puts
                mov dx, offset new_line
                call puts
                
                pop dx
                pop bx
                pop ax
                ret
        anexo6  ENDP

        ; Calcular maximo comun divisor de dos numeros enteros
        ; por el algoritmo de Euclides.
        anexo7  PROC
                ret
        anexo7  ENDP
        
        ;Leer e imprimir una serie de numeros distintos de cero.
        anexo8  PROC
                push ax
                push bx
                push dx
                push si

                mov dx, offset msg8
                call puts
                mov dx, offset msg82    ; direccion de la cadena donde se almacena los caractertes.

                mov si, 0
                mov bx,dx
                @@doo:
                        mov ah, 01h
                        int 21h

                        cmp al, '0'
                        je @@fin

                        cmp al,8
                        jnz @@write             ; escribe el caracter si no es un backspace
                        
                        dec si
                        mov al, 32
                        call putc
                        mov al, 8
                        call putc
                        jmp @@doo
                @@write:
                        mov [bx+si], al
                        inc si
                        jmp @@doo
                @@fin:
                mov dx, offset new_line
                call puts
                xor dx,dx
                mov dx,bx
                call puts
                pop si
                pop dx
                pop bx
                pop ax
                ret
        anexo8  ENDP

        ;imprimer la suma de serie de numeros 3,6,9,12...99.
        anexo9  PROC
                push ax
                push bx
                push cx
                push dx
                xor ax,ax
                mov cx, 32
                mov al,3
                mov bx,10
                call anexo16
                mov dx, offset new_line
                call puts
                mov dl,3
                @@doo:
                        add al,dl
                        mov bx,10
                        call anexo16
                        push dx
                        mov dx, offset new_line
                        call puts
                        pop dx
                        loop @@doo
                mov dx, offset new_line
                call puts       
                pop dx
                pop cx
                pop bx
                pop ax
                ret
        anexo9  ENDP

        ; Leer 3 numeros  y encontrar si uno de ellos es la suma
        ; de los otros dos
        anexo10 PROC
                ret
        anexo10 ENDP

        ;leer cuatros numeros e imprimir el mayor de los 4.
        anexo11  PROC
                push ax
                push bx
                push dx
                push si

                mov dx, offset msg8
                call puts
                mov dx, offset msg11    ; direccion de la cadena donde se almacena los caractertes.

                mov si, 0
                mov bx,dx
                @@doo:
                        mov ah, 01h
                        int 21h

                        cmp al, 13
                        je @@fin

                        cmp al,8
                        jnz @@write             ; escribe el caracter si no es un backspace
                        
                        dec si
                        mov al, 32
                        call putc
                        mov al, 8
                        call putc
                        jmp @@doo
                @@write:
                        mov [bx+si], al
                        inc si
                        jmp @@doo
                @@fin:
                mov dl, [bx]
                mov si, 1

                @@compara:
                cmp byte ptr[bx+si], '$'
                je @@final
                cmp dl, [bx+si]
                jb @@menor
                inc si
                jmp @@compara
                @@menor:
                mov dl, [bx+si]
                inc si
                jmp @@compara
                
                @@final:
                push dx
                mov dx, offset mayor
                call puts
                pop dx
                call putc
                pop si
                pop dx
                pop bx
                pop ax
                ret
        anexo11  ENDP
        
        ; Determinar si un numero N es primo
        anexo12 PROC
                push si
                push dx
                push cx
                push bx
                push ax

                mov si,0
                mov al,99               ; AL contiene numero a verificar si es primo o no.
                mov cl,al               ; se lo pasa al contador.
                mov dl,al
                mov bx,10
                xor ah,ah
                call anexo16
                @@doo:  mov al,dl
                        xor ah,ah
                        div cl
                        cmp ah, 0
                        jnz @@si_residuo
                        inc si
                        cmp si,2
                        ja @@no_primo
                        @@si_residuo:
                        dec cl
                        cmp cl,0
                        je @@es_primo 
                        jmp @@doo
                
                @@es_primo:
                        mov dx, offset msgPrimo
                        call puts
                        jmp @@finP
                @@no_primo:
                        mov dx, offset msgNoPrimo
                        call puts
                @@finP:
                pop ax
                pop bx
                pop cx
                pop dx
                pop si 
                ret
        anexo12 ENDP

        ; Determinar el salario semanal de un trabajador, dada la tarifa
        ; horario y el numero de hora trabajadas diariamente. 
        anexo13 PROC
                ret
        anexo13 ENDP

        ; Determinar si una palabra es palindromo.
        anexo14 PROC
                push bx  ;salvar registros
                push cx
                push si
                push di
                mov dx, offset msg14
                mov bx,dx
                mov si,dx
                mov di,bx

                doo:    
                cmp ds:byte ptr[si],0
                je @@finwh
                mov ah,ds:byte ptr[si]
                cmp ah,'A'
                jb contine
                cmp ah,'Z'
                ja contine
                add ah,32

                contine:
                mov ds:byte ptr[di],ah
                inc si
                cmp ds:byte ptr[di],32
                je doo
                inc di
                jmp doo
                @@finwh:
                xor ax,ax
                mov ds:[di],al
                xor cx,cx

                cuenta:         
                cmp ds:byte ptr[bx],0
                je stop
                mov al,[bx]
                push ax
                inc cx
                inc bx
                jmp cuenta

                stop:
                mov si,dx

                looop:           
                pop ax
                cmp ds:byte ptr[si],al
                jne noopalindrome
                inc si
                loop looop

                ispalindromee: 
                mov ah,1
                jmp fin
                noopalindrome:
                mov ah,0
                fin:
                pop di
                pop si
                pop cx
                pop bx
                ret
        anexo14 ENDP
        
        ;Contar el numero de occurencias de cada letra en una palabra.
        anexo15 PROC
                push ax
                push cx
                push dx
                push si

                mov bx, offset msg15
                xor ax,ax
                call strlen                     ; CX tiene el tamanio de la cadena
                mov si, 0
                
                @@pushStr:
                mov al, [bx+si]                 ; primer caracter de la cadena
                push ax
                inc si
                loop @@pushStr
                
                mov cx,0
                xor si,si                        ; Si = 0
                push cx                         ; guarda el contador en la pila
                comparaa:
                        pop cx
                        pop ax
                        push cx
                        call strlen
                @@ocurrencias:
                        cmp al, [bx+si]
                        jne @@next
                        inc dl
                @@next:
                        inc si
                        loop @@ocurrencias

                        push dx
                        push ax
                        mov dl, al
                        call putc
                        mov dl, '='
                        call putc
                        pop ax
                        pop dx
                        xor ah,ah
                        mov al,dl
                        push bx
                        mov bx, 10
                        call changeBase ; imprime el numero de ocuerrencias
                        pop bx
                        mov dx, offset new_line
                        call puts
                        call strlen
                        mov dx,cx
                        pop cx
                        inc cx
                        cmp cx,dx
                        je @@fin
                        push cx
                        jmp comparaa
                @@fin:
                pop si
                pop dx
                pop cx
                pop ax
                ret
        anexo15 ENDP
        
        strlen  PROC
                push si
                push bx
                push ax
                xor cx,cx
                mov bx, offset msg15
                mov si, 0
                @@size:
                        mov al, [bx+si]
                        cmp al,'$'
                        je @@fin
                        inc si
                        jmp @@size
                @@fin:
                dec si
                mov cx,si
                pop ax
                pop bx
                pop si
                ret
        strlen  ENDP

        ; Itoa, integer to text.
        anexo16 PROC
                push bx                 ; Se guardan los registros utilizados
                push dx 
                push cx 
                push ax 

                mov bx,10
                xor cx,cx               ; Se inicializa en 0 la variable que nos srive de contador 

                @@no_zero:
                xor dx,dx               ; Se limpia el registro dx, los valores no se pierden porque se guardan en la pila
                div bx                  ; Se realiza la divison iterativa para acercarnos al cero
                push dx                 ; se guarda el valor del residuo en la pila.
                inc cx                  ; Se incrementa cx, para despues darle formato, dependiendo de la base que se haya elegido.
                or ax,ax                ; Revisa que el cociente no sea 0.
                jne @@no_zero           ; Mientras el cociente no sea 0, las instrucciones se repiten

                @@convierte:
                pop ax                  ; Se extraen los datos de la pila
                add ax,'0'              ; Se le suma un '0' ascii (48 decimal)   
                cmp ax,'9'              ; compara con el 9 ascii para darle el formato que la base requiera.
                jbe @@print             ; Si es menor o igual se manda a imprimir el valor.
                add ax,7                ; Si es mayor a 9 se le suma un 7 para que apunte a las letras (A,B,C...).      

                @@print:
                mov dx,ax   
                call putc               ; se imprime el valor
                loop @@convierte        ; Realiza la cantidad de veces que se hayan guardado valores en la pila en las instrucciones anteriores.

                pop ax                  ; Se remueven los registros de la pila
                pop cx  
                pop dx  
                pop bx
                ret
        anexo16 ENDP

        ; Atoi -> text to integer.
        anexo17 PROC
                push dx
                push cx
                push bx
		push ax
		push si
                
                mov bx, offset msg17
		xor ax, ax              ; Si inicia en 0 el acumulador
		xor si, si	        ; Se inicializa en 0 el indice del array.
		mov cl, 10	        ; Multiplicador 

	        @@convert: 
		mul cl			; Se multiplica por 10 para llegar al
	 	mov dl, [bx+si]		; guarda el caracter en DL
		sub dl, '0'		; se le resta 48 (Equivalente a '0') 
		add al, dl		; Se guardan los numeros en AL
					; numero guardado en B
		inc si			; se incrementa el valor de SI
		cmp byte ptr[bx+si], 0	; se verifica si ha llegado al null
		jnz @@convert		; si no es igual a null, regresa y se 
					; vuelve a ejecutar las instrucciones.	
		call anexo16	        ; imprime el numero guardado en AX.       
                pop si
                pop ax
                pop bx
                pop cx
                pop dx
                ret
        anexo17 ENDP

        ; Capturar por linea de comandos y hacer los programas
        ; 2,4,10,12 y 14.
        anexo18_2       PROC
                        push ax
                        push bx
                        push dx
                        mov ah, 62h
                        int 21h
                        call atoi
                        mov dl,al
                        mul dl

                        mov bx, 10
                        call changeBase

                        pop dx
                        pop bx
                        pop ax
                        ret

        anexo18_2       ENDP

        anexo18_12      PROC
                        push si
                        push dx
                        push cx
                        push bx
                        push ax

                        mov ah, 62h
                        int 21h
                        call atoi       ;ax contiene el valor
                        mov si,0        ; indice que lleva la cantidad de numero divisibles 
                        mov cl,al       ; se lo pasa al contador.
                        mov dl,al
                        mov bx,10
                        xor ah,ah
                        call anexo16
                        @@doo:  mov al,dl
                                xor ah,ah
                                div cl
                                cmp ah, 0
                                jnz @@si_residuo
                                inc si
                                cmp si,2
                                ja @@no_primo
                                @@si_residuo:
                                dec cl
                                cmp cl,0
                                je @@es_primo 
                                jmp @@doo

                        @@es_primo:
                                mov dx, offset msgPrimo
                                call puts
                                jmp @@finP
                        @@no_primo:
                                mov dx, offset msgNoPrimo
                                call puts
                        @@finP:
                        pop ax
                        pop bx
                        pop cx
                        pop dx
                        pop si 
                        ret
        anexo18_12      ENDP


        anexo18_14      PROC
                        push ax
                        push bx
                        push cx
                        push dx
                        push di
                        push si
                        push es

                        mov dx,0
                        mov ah, 62h
                        int 21h
                        mov es,bx
                        mov si, 80h
                        mov cx, es:[si]
                        mov bx, offset msg11
                        mov di,0
                        mov si, 82h
                        
                        @fill:
                                mov dl, es:[si]
                                push dx
                                inc si
                        loop @fill
                        mov si, 80h
                        mov cx, es:[si]
                        mov si, 82h

                        @comparaaa:
                        pop dx
                        cmp dl, es:[si]
                        jne @nonpalin
                        inc si
                        loop @comparaaa

                        mov dx, offset palind
                        call puts
                        jmp @@finale

                        @nonpalin:
                        dec cx
                        @aqui:pop dx
                        loop @aqui
                        mov dx, offset nopalind
                        call puts
                        @@finale:

                        pop es
                        pop si
                        pop di
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
        anexo18_14      ENDP


        getc    PROC
                mov ah, 01h
                int 21h
                xor ah,ah
        getc    ENDP
END