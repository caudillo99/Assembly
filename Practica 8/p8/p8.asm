MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
        new_line    db   13,10,0
        msg1        db  'Hola Mundo',0
        msg2        db  'Ingrese digito: ',0
        msg2_1      db  'Ingresaste: ',0
        msg3        db  'Ingrese un digito (hex): ',0
        msg3_1      db  'En decimal: ',0
        msg4        db  '*',0
        msg5        db  'Captura 2 letras mayusculas: ',0
        msg5_1      db  'Letras ordenadas: ',0
        msg6        db  'Captura 2 letras (mayuscula y minuscula): ',0
        msg6_1      db  ' es minuscula',0
        msg6_2      db  ' es mayuscula',0
        flag        db  0
        msg7        db  32 dup(0)
        msg8        db  'Nombre de un animal: ',0
        leon        db  'El leon hace roooar',0
        gato        db  'El gato hace miau',0
        perro       db  'El perro hace woof',0
        vaca        db  'La vaca hace muuu',0
        tigre       db  'El tigre hace grrr',0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

                call clrscr
                
                ; Llamada a los programas 
				call anexo1
                call anexo2
				call anexo3
                call anexo4
                call anexo5 
                call anexo6
                call anexo7
                call anexo8

				mov ah,04ch             ; fin de programa
				mov al,0                
				int 21h                 
                
    ENDP

    anexo1      PROC
                push dx                 ; se guarda el valor del registro DX

                mov dx, offset msg1     ; se le pasa el mensaje "Hola mundo " al registro DX para imprimirlo
                call puts               

                mov dx, offset new_line ; se imprime dos salto de linea
                call puts
                call puts

                pop dx                  ; se quita el registro DX de la pila
                ret
    ENDP

    anexo2      PROC
                push dx
                push ax
                
                xor ax,ax               ; inicializa en 0 el registro AX
                mov dx, offset msg2     ; Mueve el mensaje a DX
                call puts               ; imprime el mensaje en pantalla
                call getchar            ; espera a la captura del usuaio

                mov dx, offset new_line ; Imprime un salto de linea
                call puts

                mov dx, offset msg2_1   ; Imprime el segundo mensaje del numero
                                        ; que se ha capturado
                call puts
                call putchar            ; imprime en pantalla el numero capturado
                
                mov dx, offset new_line
                call puts
                call puts

                pop ax
                pop dx
                ret
    ENDP

    anexo3      PROC

                ; se guardan los registros
                push dx
                push cx
                push bx
                push ax
                
                xor ax,ax               ; se inicializa en 0 el registro AX
                xor dx,dx               ; se inicializa en 0 el registro DX
                mov dx, offset msg3     ; se le pasa el mensaje a DX
                call puts               ; se imprime el mensaje en pantalla

                call getchar            ; recibe un numero capturado por el usuario

                mov dx, offset new_line ; le pasa a DX un salto de linea
                call puts               ; imprime el salto de linea en pantalla

                mov dx, offset msg3_1   ; se le pasa el mensaje a DX
                call puts               ; se imprime en pantalla el mensaje 

                xor cx,cx               ; se inicializa en 0 el registro CX
                sub ax,311              ; se le hace una resta al numero capturado por 
                                        ; el usuario, ya que es lo guarda como ascii y no como un numero puro.
                mov bx, 10              ; se asigna la base (decimal) al registro BX
                
      @@no_zero:xor dx,dx               ; se limpia el registro DX, posteriomente los valores
                                        ; guardados en el se guardan en la pila asi que no se pierden.
                div bx                  ; se hace division por la base
                push dx                 ; se guarda el residuo en la pila
                inc cx                  ; incrementa el valor de CX
                or ax, ax               ; se verifica que el conciente no sea 0.
                jne @@no_zero           ; mientras no sea 0 le iteracion sigue.

    @@convierte:pop ax                  ; Se extraen los datos de la pila
                add ax,'0'              ; Se le suma un '0' ascii (48 decimal) para imprimir el valor en ascii
        @@print:call putchar            ; se imprime el valor
                loop @@convierte        ; asi suceavmente hasta que hayamos retirados los valores insertados en la pila

                mov dx, offset new_line ; se imprime un salto de linea para darle formato
                call puts
                call puts
                
                ; se remueven los registros utilizados de la pila
                pop ax
                pop bx
                pop cx
                pop dx
                ret
    ENDP

    anexo4      PROC
                ; se guardan los registros a utilizar
                push bx
                push cx
                push dx

                xor bx, bx                  ; se inicializa en 0 el registro bx, ya que se utilizara como contador.
        @@while:mov cx, 5                   ; numero de veces que se van a imprimir los asteriscos.
                mov dx, offset msg4         ; se le pasa el asterisco al registro DX para poderlo imprimir, utilizando el 
                                            ; procedimiento puts.
      @@imprime:call puts                   ; Se imprime  5 veces que es la cantidad guardad en CX.
                loop @@imprime

                mov dx, offset new_line     ; se imprime un salto de linea.
                call puts                   
                inc bx                      ; incrementa nuestro contador BX.
                cmp bx,5                    ; compara que los renglones no sean mayor a 5
                jb @@while                  ; mientras la condicion se cumpla seguira imprimiendo hasta llegar a 5x5
                
                mov dx, offset new_line
                call puts
                call puts
                ; se quitan los registros utilizados de la pila
                pop dx
                pop cx
                pop bx
                ret
    ENDP

    anexo5      PROC
                push dx

                mov bx, 1                   ; Utilizamos a BX como un auxiliar de contador
        @@veces:mov cx, bx                  ; copiamos el valor de BX a CX 
                mov dx, offset msg4         ; movemos el mensaje a DX para imprimirlo
        @@print:call puts                   ; imprime la cantidad de veces que haya en CX
                loop @@print

                mov dx, offset new_line     ; imprime un salto de linea
                call puts
                cmp flag,1                  ; si la bandera es 1 salta al paso donde se comienza a decrementar
                                            ; el registro BX para imprimir la bajada de la piramide
                je @@resta                  
                inc bx                      ; incrementa BX para despues pasar ese valor a CX
                cmp bx, 5
                jbe @@veces                 ; esta parte es la impresion de la subida de la piramide
                mov flag, 1                 ; cuando haya llegado a 5 la bandera se activa
                dec bx                      ; e inicia el decremento de la piramide
                @@resta:dec bx
                cmp bx,0                    ; una vez que sea igual a 0 significa que ha llegado al fin del programa.
                jnz @@veces                 

                pop dx
                ret
    ENDP

    anexo6      PROC
                push dx
                push ax

                xor ax, ax

                mov dx, offset msg5
                call puts

                call getchar                ; captura la primer letra
                push ax                     ; se guarda la letra en la pila

                mov bx,ax                   ; se guarda temporalmente el valor del primer dato
                xor ax,ax                   ; se limpia AX
                call getchar                ; se captura la sgunda letra
                mov dx, offset new_line
                call puts                   ; se imprime un salto de linea
                mov dx, offset msg5_1       ; se imprime el mensaje de letras ordenadas
                call puts
                cmp bx,ax                   ; compara las dos letras y determina cual es minuscula y cual mayuscula
                                            ; mediante sus valores(ascii)
                jb @@primerLetra            ; si estan en orden sigue igual
                call putchar                ; si no esta en orden imprime la segunda letra

  @@primerLetra:pop ax                      ; despues saca de la pila la primer letra capturada
                call putchar                ; posteriormente la imprime

                mov dx, offset new_line     ; realiza un salto de linea para darle formato
                call puts
                call puts

                pop ax                      ; retira los registros utilizados de la pila.
                pop dx
                ret
    ENDP

    anexo7      PROC
                push dx                     ; se guardan los registros a utilizar dentro de la pila
                push ax
                push cx
                
                xor cx,cx                   ; se inicializa nuestro contador en 0
                mov dx, offset msg6
                call puts                   ; se imprime el mensje de captura
                
      @@captura:xor ax,ax                   ; cada que se vaya a realizar una nueva captura se pone en 0 el registro AX
                                            ; con el fin de no tener basura en la parte alta, ya que la captura se guarda 
                                            ; en la parte baja.
                call getchar
                inc cx                      ; se incrementa en 1 el contador para saber cuantas veces se ha realiza un push
                push ax                     ; se guarda el dato capturado en la pila
                cmp cx,2                    ; si ha el contador ha llegado a 2 salimos de la captura y pasaamos a comparar.
                jb @@captura

                mov dx, offset new_line
                call puts

        @@print:pop ax                      ; se retiran los datos de la pila uno por uno.
                cmp al, 'Z'                 ; se compara con las letras mayusculas
                jbe @@mayuscula             ; si lo es hace un salto al mensaje apropiado
                
                call putchar
                mov dx, offset msg6_1       ; si es minuscula se escribe en pantalla el mensaje apropiado
                call puts
                mov dx, offset new_line
                call puts
                dec cx
                cmp cx,0                    ; verifica que el contador no haya llegado a 0
                jnz @@print
                jmp @@fin                   ; si el contador ha llegado a 0 hace un salto al final del procedimiento
                
    @@mayuscula:call putchar
                mov dx, offset msg6_2       ; en caso de que la letra sea mayuscula se imprime el mensaje apropiado
                call puts
                mov dx, offset new_line
                call puts
                dec cx
                cmp cx,0                    ; verifica que el contador no haya llegado a 0
                jnz @@print
                
          @@fin:mov dx, offset new_line     ; imprime un salto de linea y sale del procedimiento
                call puts
                call puts
                pop cx                      ; se retiran los datos de la pila
                pop ax
                pop dx
                ret
    ENDP

    anexo8      PROC
                push dx

                mov dx, offset msg8         ; mensaje de las instrucciones
                call puts
                
                mov dx, offset msg7         ; se pasa la cadena en donde el usuario va escribir el nombre del animal 
                call gets                   ; llamada a la fucion gets la cual lee una cadena y la guarda en dx
                mov dx, offset new_line     ; se realiza un salto de linea.
                call puts
                
                cmp byte ptr[msg7], 'v'     ; depende de la letra que se encuentre en el inicio de la cadena se va a 
                                            ; imprimir le onomatopeya
                je @@vaca
                cmp byte ptr[msg7], 't'
                je @@tigre
                cmp byte ptr[msg7], 'p'
                je @@perro
                cmp byte ptr[msg7], 'g'
                je @@gato

                mov dx, offset leon
                jmp @@print
                @@vaca:mov dx, offset vaca  ; si el animal es vaca se imprime la onomatopeya y asi en los demas animales.
                jmp @@print
                @@tigre: mov dx, offset tigre
                jmp @@print
                @@perro:mov dx, offset perro
                jmp @@print
                @@gato: mov dx, offset gato

                @@print: call puts          ; impresion de la onomatopeya

                pop dx                      ; se retiran los registros guardados en la pila
                ret
    ENDP

    gets        PROC
                push ax
                push bx
                push si

                mov bx,dx               ; se guarda la direccion de la cadena para poder direccionar.
                xor ax,ax               ; AX se inicializa en 0.
                xor si,si               ; SI se inicializa en 0.

            @@do:call getchar           ; Pide un caracter
                
                cmp al,13               ; compara que no sea un retorno de carro
                jz @@final              ; si lo es, termina y brinca hacia la condicion final
                
                cmp al,8
                jnz @@write             ; escribe el caracter si no es un backspace

                dec si
                mov al, 32
                call putchar
                mov al,8
                call putchar
                jmp @@do

        @@write:mov [bx+si], al         ; guarda el caracter en la primera posicion del arerglo
                inc si                  ; se desplaza a la siguiente posicion del array
                jmp @@do                ; mientras no sea CR, el ciclo sigue 

         @@final:inc si                 ; se desplaza a la ultima posicion del arreglo
                mov al, 0
                mov [bx+si], al         ; termina la cadena con un 0.
                
                pop si                  ; libera los registros usados de la pila.
                pop bx
                pop ax
                ret
    ENDP
END