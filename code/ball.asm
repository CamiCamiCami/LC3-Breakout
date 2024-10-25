; Definase una pelota como la siguiente estructura en memoria
; x::int, y::int, vx::int, vy::int

; Definase un eje de rebote como el siguiente tipo
; rebote_x::8b, reboten_y::8b

; Toma la direccion de una pelota (r0)
; Toma el eje de rebote (r1)
BALL_ON_COLLISION


; Toma una pelota (r0)
BALL_MOVE
ldr             r1,r0,0
ldr             r2,r0,2
add             r3,r1,r2
str             r3,r0,0

ldr             r1,r0,1
ldr             r2,r0,3
add             r3,r1,r2
str             r3,r0,1

ret
