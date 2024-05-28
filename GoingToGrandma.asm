
; version 10.4
.MODEL small
.STACK 100h


.DATA

column dw 10
row dw 120 
w equ 80
h equ 75
column_grandma dw 230
row_grandma dw 120 
decision dw ?
color db 0fh  
;================================
x_center_man dw 30
y_center_man dw 140
y_value_man dw 0
x_value_man dw 10  
length_man_of_stickman dw 10
h_man dw 30
;================================
x_centergrandma dw 250
y_centergrandma dw 145
y_valuegrandma dw 0
x_valuegrandma dw 10 
second_decision dw ? 
y_stickman dw 10
h_grandma dw 15 
;================================
count dw 2
     
.CODE

draw_roof_floor  proc 
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
    draw_roof_floor endp
draw_walls proc 
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
    draw_walls endp 
draw_roof_floor_grandma  proc 
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
    draw_roof_floor_grandma endp
    
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

 



     mov bx, x_value_man
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
     mov cx, x_value_man
     add cx, x_center_man 
     mov dx, y_value_man
     add dx, y_center_man
     int 10h
     mov cx, x_value_man 
     neg cx
     add cx, x_center_man 
     int 10h
     mov cx, y_value_man     
     add cx, x_center_man 
     mov dx, x_value_man
     add dx, y_center_man
     int 10h 
     mov cx, y_value_man 
     neg cx
     add cx, x_center_man 
     int 10h
     mov cx, x_value_man 
     add cx, x_center_man
     mov dx, y_value_man
     neg dx
     add dx, y_center_man
     int 10h

; 

    mov cx, x_value_man
     
    neg cx

    add cx, x_center_man 
    
    int 10h



    mov cx, y_value_man 

    add cx, x_center_man 

    mov dx, x_value_man

    neg dx

    add dx, y_center_man

    int 10h

; 

    mov cx, y_value_man 

    neg cx

    add cx, x_center_man 

    int 10h

 

condition1:

    cmp decision,0

    jg condition2      

    mov cx, y_value_man

    mov ax, 2

    imul cx 

    add ax, 3 

    mov bx, 2

    mul bx  

    add decision, ax

    mov bx, y_value_man

    mov dx, x_value_man

 

  

    inc y_value_man

    jmp drawcircle



condition2:

    mov cx, y_value_man 

    mov ax,2

    mul cx 

    mov bx,ax

    mov cx, x_value_man
    
    mov ax, -2 
    
    imul cx 

    add bx,ax

    add bx,5

    mov ax,2

    imul bx        

    add decision,ax

    mov bx, y_value_man

    mov dx, x_value_man

    cmp bx, dx

    ja donedrawing

    dec x_value_man    

    inc y_value_man

    jmp drawcircle
 
donedrawing: 
;Th_manE SPINE OF Th_manE STIKE MAN
    mov cx,x_center_man 
    mov dx,y_center_man 
    add dx,10
    add dx,h_man
    mov al,color
    mov ah,0ch 
    mov bx,length_man_of_stickman
    add bx,y_center_man
next3:
    int 10h
    dec dx
    cmp dx,bx
    jne next3
;R h_manand
    mov bx,10
    mov cx,x_center_man
    mov dx,y_center_man 
    add dx,15
    mov ah,0ch
   
lfh_manand:
    int 10h
    inc cx  
    inc dx 
    dec bx 
    cmp bx,0
    jne lfh_manand 
 ;l_and
    mov bx,10
    mov cx,x_center_man
    mov dx,y_center_man 
    add dx,15
    mov ah,0ch
    
rh_manandloop:
    int 10h
    dec cx ; increase x values 
    inc dx ; decrease y values
    dec bx ; decrease length_man
    cmp bx,0
    jne rh_manandloop
 
 ;lf lag
    mov bx,10
    mov cx,x_center_man
    mov dx,y_center_man 
    add dx,40
    mov ah,0ch
    
lfleg:
    int 10h
    inc cx  
    inc dx 
    dec bx 
    cmp bx,0
    jne lfleg 
 ;r lag
    mov bx,10
    mov cx,x_center_man
    mov dx,y_center_man 
    add dx,40
    mov ah,0ch
    
rlegloop:
    int 10h
    dec cx ; increase x values 
    inc dx ; decrease y values
    dec bx ; decrease length_man
    cmp bx,0
    jne rlegloop

ret
endp stickman
    
    
    
;________________________________________________________________________________________
    
 

proc grandma

 



     mov bx, x_valuegrandma
     mov ax,2
     mul bx
     mov bx,3
     sub bx,ax 
     mov second_decision,bx
     mov al,color
     mov ah,0ch
     drawsecond_circle:
     mov al,color
     mov ah,0ch 
     mov cx, x_valuegrandma
     add cx, x_centergrandma 
     mov dx, y_valuegrandma
     add dx, y_centergrandma
     int 10h
     mov cx, x_valuegrandma 
     neg cx
     add cx, x_centergrandma 
     int 10h
     mov cx, y_valuegrandma     
     add cx, x_centergrandma 
     mov dx, x_valuegrandma
     add dx, y_centergrandma
     int 10h 
     mov cx, y_valuegrandma 
     neg cx
     add cx, x_centergrandma 
     int 10h
     mov cx, x_valuegrandma 
     add cx, x_centergrandma
     mov dx, y_valuegrandma
     neg dx
     add dx, y_centergrandma
     int 10h

; 

    mov cx, x_valuegrandma 
    neg cx

    add cx, x_centergrandma 

    int 10h



    mov cx, y_valuegrandma 

    add cx, x_centergrandma 

    mov dx, x_valuegrandma

    neg dx

    add dx, y_centergrandma

    int 10h

; 

    mov cx, y_valuegrandma 

    neg cx

    add cx, x_centergrandma 

    int 10h

 

conditio3:

    cmp second_decision,0

    jg condition4      

    mov cx, y_valuegrandma

    mov ax, 2

    imul cx 

    add ax, 3 

    mov bx, 2

    mul bx  

    add second_decision, ax

    mov bx, y_valuegrandma

    mov dx, x_valuegrandma

 

  

    inc y_valuegrandma

    jmp drawsecond_circle



condition4:

    mov cx, y_valuegrandma 

    mov ax,2

    mul cx 

    mov bx,ax

    mov cx, x_valuegrandma

    mov ax, -2

    imul cx 

    add bx,ax

    add bx,5

    mov ax,2

    imul bx        

    add second_decision,ax
                                             
                                             
    mov bx, y_valuegrandma

    mov dx, x_valuegrandma

    cmp bx, dx

    ja second_donedrawing

    dec x_valuegrandma    

    inc y_valuegrandma

    jmp drawsecond_circle
 
second_donedrawing: 
;woman spine 
    mov cx,x_centergrandma
    mov dx,y_stickman 
    add dx,h_grandma 
    add dx,y_centergrandma
    mov bx,y_centergrandma
    add bx,y_stickman
    mov al,0fh
    mov ah,0ch
next5:
    int 10h
    dec dx
    cmp dx,bx
    jne next5
;lf hand
    mov bx,10
    mov cx,x_centergrandma
    mov dx,y_centergrandma 
    add dx,h_grandma
    mov ah,0ch
    mov al,0fh
grandma_lfhand:
    int 10h
    inc cx  
    inc dx 
    dec bx 
    cmp bx,0
    jne grandma_lfhand 
 ;r_hand
    mov bx,10
    mov cx,x_centergrandma
    mov dx,y_centergrandma 
    add dx,h_grandma
    mov ah,0ch
    mov al,0fh
grandma_rhandloop:
    int 10h
    dec cx ; increase x values 
    inc dx ; decrease y values
    dec bx ; decrease length
    cmp bx,0
    jne grandma_rhandloop
 
;lf lag
    mov bx,10
    mov cx,x_centergrandma
    mov dx,y_centergrandma
    add dx,25
    mov ah,0ch
    mov al,0fh
grandma_lfleg:
    int 10h
    inc cx  
    inc dx 
    dec bx 
    cmp bx,0
    jne grandma_lfleg 
 ;r lag
    mov bx,10
    mov cx,x_centergrandma
    mov dx,y_centergrandma
    add dx,25
    mov ah,0ch
    mov al,0fh
grandma_rlegloop:
    int 10h
    dec cx ; increase x values 
    inc dx ; decrease y values
    dec bx ; decrease length
    cmp bx,0
    jne grandma_rlegloop 
 
;woman scart 
    mov dx,y_centergrandma
    add dx,35
    mov cx,x_centergrandma
    add cx,10
    mov bx,y_centergrandma
    add bx,95
woman:
    int 10h
    dec cx 
    ;cmp to the end of the skert
    cmp cx,bx
    jne woman
 
 
    mov dx,y_centergrandma
    add dx,45            
    mov cx,x_centergrandma
    sub cx,5
    mov bx,y_centergrandma
    add bx,35
    grandma_leg:
    int 10h
    dec dx
    cmp dx,bx
    jne grandma_leg 
 
 
    mov dx,y_centergrandma
    add dx,45
    mov cx,x_centergrandma
    add cx,5
    mov bx,y_centergrandma
    add bx,35
grandma_leg1:
    int 10h
    dec dx
    cmp dx,bx
    jne grandma_leg1
 
  

ret
endp grandma

     
    

start:
	mov ax, @data
    mov ds, ax 
	
	mov ah, 0   ; set display mode function.
	mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
	int 10h     ; set it!
    xor ax,ax
    ;draw the roof
    push column
    push row
    push w
    push 1h 
    call draw_roof_floor
    
    push column
    mov cx,row
    add cx,h
    push cx
    push w
    push 1h 
    call draw_roof_floor 
    
    push column
    push row
    push h
    push 1h 
    call draw_walls
     
    mov cx,column
    add cx, w
    push cx
    push row
    push h
    push 1h 
    call draw_walls
    
    push 1h
    push row
    push column
    push 40
    call diagonalr
     
     
    push 1h
    push 80
    push 50
    push 40
    call diagonalL 
   
    ;===home of grandma===
    ;draw the roof
    push column_grandma
    push row_grandma
    push w
    push 4h 
    call draw_roof_floor_grandma
    ;draw the floor
    push column_grandma
    mov cx,row_grandma
    add cx,h
    push cx
    push w
    push 4h 
    call draw_roof_floor_grandma 
    ;draw left wall
    push column_grandma
    push row_grandma
    push h
    push 4h 
    call draw_walls
    ;draw r wall 
    mov cx,column_grandma
    add cx, w
    push cx
    push row_grandma
    push h
    push 4h 
    call draw_walls
    ;draw l roof
    push 4h
    push row_grandma
    push column_grandma
    push 40
    call  diagonalr
     
     
    push 4h
    mov cx,row_grandma
    sub cx,40
    push cx
    mov cx,column_grandma
    add cx,40
    push cx
    push 40
    call diagonalL 
    int 10h     
    
    call stickman
    call grandma
 ;see if the user typed x or o/in the right time
 Redraw:           

    mov ah,01h

    int 16h    
    jz Redraw
    mov ah,00h
    int 16h 
    
    
    cmp al,120
    je test2 
    
     cmp al,111
    je test1
    jmp Redraw
    test1: 
    cmp count,1
    je draw_third_time
    jmp Redraw 
    test2:
    cmp count,2
    je draw_second_time
    jmp Redraw 
    ;show the man waking to grandma
    draw_second_time:
    mov x_center_man , 30
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    mov color,0h
    call stickman 
    
    mov color ,0fh
    mov x_center_man , 130
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman 
    
    mov color ,0h
    mov x_center_man , 130
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman  
    
    mov color ,0fh
    mov x_center_man , 160
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman  
    
    mov color ,0h
    mov x_center_man , 160
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman 
    
    mov color ,0fh
    mov x_center_man , 190
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman  
    
    mov color ,0h
    mov x_center_man , 190
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman  
    
    
    mov color ,0fh
    mov x_center_man , 290
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman 
    mov count ,1  
    jmp Redraw 
    ;draw the man waking back
draw_third_time:    
    mov color ,0h
    mov x_center_man , 290
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman 
    
    mov color ,0fh
    mov x_center_man , 190
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman
    
    mov color ,0h
    mov x_center_man , 190
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10  
    call stickman 
    
    mov color ,0fh
    mov x_center_man , 160
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman 
    
    mov color ,0h
    mov x_center_man , 160
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman
    
        mov color ,0fh
    mov x_center_man , 130
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman
    
    mov color ,0h
    mov x_center_man , 130
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    call stickman
    
    
    mov x_center_man , 30
    mov y_center_man , 140
    mov y_value_man , 0
    mov x_value_man , 10 
    mov color,0fh 
    call stickman
     mov count ,2  
    jmp Redraw
exit:
			

  mov AH,4CH
  int 21h

END start




