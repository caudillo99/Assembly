;**********************************************************************
; Rutina: getchar
; Descripcion: procedimiento que captura un caracter del teclado.
; 
; Parametros:  
;    Entrada:  AL caracter a imprimir
;    Salida:   ninguno
;**********************************************************************
extrn getchar: near

;**********************************************************************
; Rutina: putc
; Descripcion: procedimiento que imprima un caracter.
; 
; Parametros:  
;    Entrada:  AL caracter a imprimir
;    Salida:   ninguno
;**********************************************************************
extrn putc: near

;**********************************************************************
; Rutina: puts
; Descripcion: procedimiento que imprime una cadena con terminacion '$'
; Parametros:  
;    Entrada:  DX apuntador a cadena
;    Salida:   ninguno
;**********************************************************************
extrn puts: near

;**********************************************************************
; Rutina: changeBase
; Descripcion: procedimiento que captura una cadena. La captura termina
;              al presionar Enter.
; 
; Parametros:  
;    Entrada:  AX numero a convertir.
;              BX base en la que se quiere imprimir AX.
;    Salida:   ninguno
;**********************************************************************
extrn changeBase: near

;**********************************************************************
; Rutina: atoi
; Descripcion: Procedimiento que devuelve en AX el valor de los parametros
;              capturados por consola
; 
; Parametros:  
;    Entrada:  BX direccion de PSP.
;    Salida:   AX numero almacenado
;**********************************************************************
extrn atoi: near

;**********************************************************************
; Rutina: clscr
; Descripcion: Procedimiento que limpia pantalla.
; 
; Parametros:  
;    Entrada:  Ninguno
;    Salida:   Ninguno
;**********************************************************************
extrn clscr: near