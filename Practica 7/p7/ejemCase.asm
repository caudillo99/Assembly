MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 ;INCLUDE procs.inc
 
       LOCALS

   .DATA
        new_line    db   10,'$'
        option      db   'Opcion  ', '$'
        captura     db   'Elija una opcion: ','$'
        nopc        db   'No existe opcion', '$'
        isEqu       db   'Son iguales', '$'
        noEqu       db   'No son iguales','$'

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
		mov ax,@data 	            ;Inicializar DS al la direccion
		mov ds,ax     	            ; del segmento de datos (.DATA)

                call clrsc
                mov cx,5
                mov al, '1'

        @@print:mov dx, offset option
                call puts                   ; imprime un salto de linea
                mov dl,al
                inc al
                call putc
                mov dx, offset new_line
                call puts
                loop @@print

                call getchar
                mov dx, offset new_line
                call puts

                cmp al, '1'
                je @@case1
                cmp al, '2'
                je @@case2
                cmp al, '3'
                je @@case3
                cmp al, '4'
                je @@case4
                cmp al, '5'
                je @@case5
                mov dx, offset nopc
                call puts
                jmp @@fin
        @@case1:mov dx,offset option
                call puts
                mov dl, '1'
                call putc
                jmp @@fin
        @@case2:mov dx,offset option
                call puts
                mov dl, '2'
                call putc
                jmp @@fin
        @@case3:mov dx,offset option
                call puts
                mov dl, '3'
                call putc
                jmp @@fin
        @@case4:mov dx,offset option
                call puts
                mov dl, '4'
                call putc
                jmp @@fin
        @@case5:mov dx,offset option
                call puts
                mov dl, '5'
                call putc
                jmp @@fin

          @@fin:mov ah,04ch                 ; finaliza el programa
		mov al,0                
		int 21h                 
                
    ENDP

    putc        PROC
                push dx
                push ax

                mov ah, 02h
                int 21h
                
                pop ax
                pop dx
                ret
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