;**********************************************************************
; Rutina: clrscr
; Descripcion: borra pantalla haciendo uso de la interrupci�n 
;              10H servicio 0 c
;        Nota:  Realmente hace un set screen modo 3 ( 80 x 25 16 colores)
;             
; Parametros:
;    Entrada:  ninguno 
;    Salida:   ninguno
;**********************************************************************
   extrn clrscr:near

   
;**********************************************************************
; Rutina: putchar 
; Descripcion: procedimiento que desplegar un caracter en pantalla
;              en la posici�n actual del cursor haciendo uso de la
;              int 21h servicio 02h del S.O. 
;        Nota: el cursos es actualizado a la siguiente posicion 
;
; Parametros:  
;    Entrada:  AL contiene el caracter a desplegar
;    Salida:   
;**********************************************************************   
   extrn putchar:near

   
;**********************************************************************
; Rutina: puts
; Descripcion: Despliega una cadena  terminada en 0 (null)
;
;  Parametros:
;     Entrada:  dx  contiene el aputador a la cadena a imprimir
;      Salida:  ninguno
;**********************************************************************
	extrn puts:near

	
;**********************************************************************
; Rutina: getchar 
; Descripcion: procedimiento que leer un caracter del teclado haciendo
;              uso de la int 21h servicio 01h del S.O. 
;        Nota: 1) La ejecuci�n del programa se teniene en espera de la tecla
;              2) Si se muestra el caracter tecleado en pantalla  
; Parametros:  
;    Entrada:  
;    Salida:   AL contiene el caracter tecleado
;**********************************************************************   
   extrn getchar:near

   
;**********************************************************************
; Rutina: getch 
; Descripcion: procedimiento que leer un caracter del teclado haciendo
;              uso de la int 21h servicio 08h del S.O. 
;        Nota: 1) La ejecuci�n del programa se teniene en espera de la tecla
;              2) No se muestra el caracter tecleado en pantalla  
; Parametros:  
;    Entrada:  
;    Salida:   AL contiene el caracter tecleado
;**********************************************************************
   extrn getch:near

   
;**********************************************************************
; Rutina: gotoxy
; Descripcion: posiciona el cursor en la posicion dada por BH y BL haciendo
;              uso de la interrupci�n 10H servicio 02 del BIOS
; Parametros:
;    Entrada:  BH posicion  x (columna) 
;              BL posicion  y (renglon) 
;    Salida:   ninguno
;**********************************************************************   
   extrn gotoxy:near

   
;**********************************************************************
; Rutina: kbhit
; Descripcion: procedimiento que verifica si se presion� tecla 
;              
;         Nota: no espera telca y no toma tecla del teclado. Si se desea
;               tomar la tecla deber� llamarse a getchar o getch despues
;               de que se ha detectado que se oprim� tecla;
; Parametros:  
;    Entrada:  ninguno
;    Salida:   AH=0 si no hay tecla AH=1 si hay tecla
;              AL=TECLA
;**********************************************************************
   extrn kbhit:near   ; AH=0 si no hay tecla AH=1 si hay tecla
                      ; AL=TECLA