; version 10.1
; a short program to check how
; set and get pixel color works
.MODEL small
.STACK 100h


.DATA

column dw 10
row dw 120 
w equ 80
h equ 75
column_grandma dw 230
row_grandma dw 120
x_center dw 20
y_center dw 130
y_value dw 0
x_value dw 10 
decision dw ?
color db 0fh 
y_stickman dw 150
x_stickman dw 30
h_man dw 30

 
     
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
    
    
    proc stickman

 



     mov bx, x_value
     mov ax,2
     mul bx
     mov bx,3
     sub bx,ax 
     mov decision,bx
     mov al,color
     mov ah,0ch
     drawcircle:
     mov al,color
     mov ah,0ch 
     mov cx, x_value
     add cx, x_center 
     mov dx, y_value
     add dx, y_center
     int 10h
     mov cx, x_value 
     neg cx
     add cx, x_center 
     int 10h
     mov cx, y_value     
     add cx, x_center 
     mov dx, x_value
     add dx, y_center
     int 10h 
     mov cx, y_value 
     neg cx
     add cx, x_center 
     int 10h
     mov cx, x_value 
     add cx, x_center
     mov dx, y_value
     neg dx
     add dx, y_center
     int 10h

; 

 mov cx, x_value 
 neg cx

 add cx, x_center 

 int 10h



 mov cx, y_value 

 add cx, x_center 

 mov dx, x_value

 neg dx

 add dx, y_center

 int 10h

; 

 mov cx, y_value 

 neg cx

 add cx, x_center 

 int 10h

 

condition1:

 cmp decision,0

 jg condition2      

 mov cx, y_value

 mov ax, 2

 imul cx 

 add ax, 3 

 mov bx, 2

 mul bx  

 add decision, ax

 mov bx, y_value

 mov dx, x_value

 

  

 inc y_value

 jmp drawcircle



condition2:

 mov cx, y_value 

 mov ax,2

 mul cx 

 mov bx,ax

 mov cx, x_value

 mov ax, -2

 imul cx 

 add bx,ax

 add bx,5

 mov ax,2

 imul bx        

 add decision,ax

 mov bx, y_value

 mov dx, x_value

 cmp bx, dx

 ja donedrawing

 dec x_value    

 inc y_value

 jmp drawcircle
 
donedrawing:
mov cx,x_stickman
mov dx,y_stickman
add dx,h_man
mov al,0fh
mov ah,0ch
next3:
int 10h
dec dx
cmp dx,y_stickman
jne next3
;lf hand
mov bx,10
mov cx,30
mov dx,155
mov ah,0ch
mov al,0fh
lfhand:
int 10h
 inc cx  
 inc dx 
 dec bx 
 cmp bx,0
 jne lfhand 
 ;r_hand
    mov bx,10
    mov cx,30
    mov dx,155
    mov ah,0ch
    mov al,0fh
rhandloop:
int 10h
dec cx ; increase x values 
 inc dx ; decrease y values
 dec bx ; decrease length
 cmp bx,0
 jne rhandloop
 
 ;lf lag
mov bx,10
mov cx,30
mov dx,180
mov ah,0ch
mov al,0fh
lfleg:
int 10h
 inc cx  
 inc dx 
 dec bx 
 cmp bx,0
 jne lfleg 
 ;r lag
    mov bx,10
    mov cx,30
    mov dx,180
    mov ah,0ch
    mov al,0fh
rlegloop:
int 10h
dec cx ; increase x values 
 inc dx ; decrease y values
 dec bx ; decrease length
 cmp bx,0
 jne rlegloop
 
 
 
 
  

ret
endp stickman
    
    
    
    
    
    

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
    push 40
    call diagonalr
     
     
    push 0fh
    push 80
    push 50
    push 40
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
    push 40
    call  diagonalr
     
     
    push 0fh
    mov cx,row_grandma
    sub cx,40
    push cx
    mov cx,column_grandma
    add cx,40
    push cx
    push 40
    call diagonalL 
    
     int 10h 

 mov x_center,30

 mov y_center,140

 mov y_value,0

 mov x_value,10

 call stickman



exit:
			

  mov AH,4CH
  int 21h

END start


