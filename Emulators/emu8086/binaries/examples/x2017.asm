; * * * * * * * * * *
;
; x2017.asm assembles
; by emu8086 assembler
; into 375 bytes
;
; * * * * * * * * * *
;
; image drawing
; demostration
;
; * * * * * * * * * *

org 0x100

icon_width = 16   
screen_width = 320
screen_height = 200

jmp start

thank_you   db  ' Thank you! ', 0 
star_x      dw  144
star_y      dw  84
star_colour db  2

; * * * * * * * * * *

start   proc    far
mov     ax, cs
mov     ds, ax
mov     es, ax

mov ah, 0
mov al, 13h
int 10h

draw_star:

mov bx, star_x
mov dx, star_y
mov si, star
call puticon
inc star_colour
       
mov cx, 10
mov dx, 0
mov ah, 86h
int 15h

jmp draw_star

; * * * * * * * * * *

ret
start   endp



; * * * * * * * * * *
; * input: bx = x
; *        dx = y
; *        si = image
puticon proc
mov ax, 0A000h
mov es, ax
mov ax, screen_width
mul dx
add bx, ax
jnc no_carry
inc dx
no_carry:
mov cx, icon_width
next_y:
push    cx
mov cx, icon_width
next_x:
mov di, bx
mov al, [si]
cmp al, 0
je  transparent
mov al, star_colour
mov es:[di], al
transparent:
inc si
add bx, 1      
jnc no_car_x
inc dx      
no_car_x:
loop    next_x
pop cx
add bx, screen_width-icon_width
jnc no_car_y
inc dx      
no_car_y:
loop    next_y
ret
puticon endp
; * * * * * * * * * *
           
star:
db   0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
db   1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0
db   0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0
db   0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0
db   0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0
db   0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0
db   0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0
db   0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0
db   1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
db   0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0
db   0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0
db   0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0
db   0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0
db   0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0
db   0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0
db   1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0
       


; * * * * * * * * * *
; *                 *
; *     end         *
; *                 *
; *                 *
; * * * * * * * * * *
;
;
;
;
;

