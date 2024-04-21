; version 10
; a short program to check how
; set and get pixel color works
.MODEL small
.STACK 100h


.DATA

column dw 10
row dw 120 
w equ 60
h equ 60
column_grandma dw 230
row_grandma dw 120 
     
.CODE

drawall  proc 
      ; white
	PUSH BP         ; save BP on stack
    MOV BP, SP
	mov cx, [bp+10]; column
    mov dx, [bp+8];row
    add cx, [bp+6] 
    mov al,[bp+4]
    mov ah, 0ch
    next:
    int 10h
    dec cx
	cmp cx,column
	jne next
	pop bp
    ret 8
    drawall endp
drawfloor proc 
    PUSH BP         ; save BP on stack
    MOV BP, SP
	mov cx, [bp+10]; column
    mov dx, [bp+8];row
    add dx, [bp+6] 
    mov al,[bp+4]
    mov ah, 0ch
    next1:
    int 10h
    dec dx
	cmp dx,row
	jne next1
	pop bp
    ret 8 
    drawfloor endp 
drawall_grandma  proc 
      ; white
	PUSH BP         ; save BP on stack
    MOV BP, SP
	mov cx, [bp+10]; column
    mov dx, [bp+8];row
    add cx, [bp+6] 
    mov al,[bp+4]
    mov ah, 0ch
    next2:
    int 10h
    dec cx
	cmp cx,column_grandma
	jne next2
	pop bp
    ret 8
    drawall_grandma endp
    
    proc diagonalL
 mov bp,sp
 pusha
 

 mov bx, [bp+2] ; length
 mov cx, [bp+4] ; x values
 mov dx, [bp+6] ; y values
 mov ax, [bp+8] ; color
 
 mov ah,0ch ; change color for a single pixel.
 diagonalLLoop:
 int 10h
 inc cx ; increase x values 
 inc dx ; increase y values
 dec bx ; decrease length
 cmp bx,0
 jne diagonalLLoop
 popa
 ret
    endp diagonalL  
    proc diagonalR
 mov bp,sp
 pusha
 

 mov bx, [bp+2] ; length
 mov cx, [bp+4] ; x values
 mov dx, [bp+6] ; y values
 mov ax, [bp+8] ; color
 
 mov ah,0ch ; change color for a single pixel.
 diagonalRLoop:
 int 10h
 inc cx ; increase x values 
 dec dx ; decrease y values
 dec bx ; decrease length
 cmp bx,0
 jne diagonalRLoop
 popa
 ret
 endp diagonalR

start:
	mov ax, @data
    mov ds, ax 
	
	mov ah, 0   ; set display mode function.
	mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
	int 10h     ; set it!
    xor ax,ax
    push column
    push row
    push w
    push 0fh 
    call drawall
    
    push column
    mov cx,row
    add cx,h
    push cx
    push w
    push 0fh 
    call drawall 
    
    push column
    push row
    push h
    push 0fh 
    call drawfloor
     
    mov cx,column
    add cx, w
    push cx
    push row
    push h
    push 0fh 
    call drawfloor
    
    push 0fh
    push row
    push column
    push 30
    call  diagonalr
     
     
    push 0fh
    push 90
    push 40
    push 30
    call diagonalL 
   
    ;home of grandma
    push column_grandma
    push row_grandma
    push w
    push 0fh 
    call drawall_grandma
    
    push column_grandma
    mov cx,row_grandma
    add cx,h
    push cx
    push w
    push 0fh 
    call drawall_grandma 
    
    push column_grandma
    push row_grandma
    push h
    push 0fh 
    call drawfloor
     
    mov cx,column_grandma
    add cx, w
    push cx
    push row_grandma
    push h
    push 0fh 
    call drawfloor
 
     push 0fh
    push row_grandma
    push column_grandma
    push 30
    call  diagonalr
     
     
    push 0fh
    mov cx,row_grandma
    sub cx,30
    push cx
    mov cx,column_grandma
    add cx,30
    push cx
    push 30
    call diagonalL



exit:
			

  mov AH,4CH
  int 21h

END start

