MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 ;INCLUDE procs.inc
 
       LOCALS

   .DATA
        new_line    db   10,'$'
        captura     db   'Ingrese un dato: ', '$'
        isNum       db   'Es numero', '$'
        isNotNum    db   'No es numero','$'

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	            ;Inicializar DS al la direccion
				mov ds,ax     	            ; del segmento de datos (.DATA)

                call getchar                ;lee un caracter de teclado
                mov dx, offset new_line
                call puts                   ; imprime un salto de linea

                cmp al, '0'                 ; compara si el caracter ingresado 
                jb @@no_num                 ; si es menor a 0 entonces no es numero
                cmp al, '9'                 ; lo vuleve a comparar con el 9
                ja @@no_num                 ; si es mayor significa que no es numero
                mov dx, offset isNum        ; imprime el mensaje correspondiente.
                call puts
                jmp @@fin                   ; salta al final del programa
       @@no_num:mov dx, offset isNotNum     
                call puts                   ; imprime el mensaje que no es numero 
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
END