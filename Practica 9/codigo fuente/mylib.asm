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

_TEXT ends
    PUBLIC putc
    PUBLIC puts

END