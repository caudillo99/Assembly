MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 ;INCLUDE procs.inc
 
       LOCALS

   .DATA
        new_line    db   10,'$'
        captura     db   'Ingrese un dato: ', '$'
        isEqu       db   'Son iguales', '$'
        noEqu       db   'No son iguales','$'

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	            ;Inicializar DS al la direccion
				mov ds,ax     	            ; del segmento de datos (.DATA)

                call clrsc
                mov cx,2
        
        @@print:xor ax,ax
                call getchar                ;lee un caracter de teclado
                push ax
                mov dx, offset new_line
                call puts                   ; imprime un salto de linea
                loop @@print

                pop ax
                pop bx
                cmp al, bl                  ; compara si el caracter ingresado 
                je @@if_equal               ; son iguales
                
                mov dx, offset noEqu        ; imprime el mensaje correspondiente.
                call puts
                jmp @@fin                   ; salta al final del programa

     @@if_equal:mov dx, offset isEqu     
                call puts                   ; imprime el mensaje indicando que son  iguales 
		  @@fin:mov ah,04ch                 ; finaliza el programa
				mov al,0                
				int 21h                 
                
    ENDP

    getchar     PROC
                push dx

                mov dx, offset captura
                mov ah, 09h                 ;servicio que muestra una cadena con terminacion '$'
                int 21h                     ; de la interrupcion 21h

                mov ah, 01h                 ; servicio que permite la captura desde teclado, el resultado se guarda en AL
                int 21h                     ; de la interrupcion 21h

                pop dx
                ret
    ENDP

    puts    PROC
            push dx                         ; guarda el registro DX ya que no se va a modificar 
            mov ah,09h                      ; llama al servicio 09h el cual imprime una cadena en pantalla
            int 21h                         ; a la cual pertenece a la interrupcion 21h
            pop dx                          ; salva el registro DX.
            ret
    ENDP

    clrsc   PROC
            push dx
            push cx

            mov cx, 25
    @@clear:mov dx, offset new_line
            call puts
            loop @@clear

            pop cx
            pop dx
            ret
    ENDP
END