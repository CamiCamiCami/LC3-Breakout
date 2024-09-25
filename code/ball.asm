; Definase una pelota como la siguiente estructura en memoria
; x::int, y::int, vx::int, vy::int

; Definase un eje de rebote como el siguiente tipo
; rebote_x::8b, reboten_y::8b

; Toma la direccion de una pelota (r0)
; Toma el eje de rebote (r1)

BALL_ON_COLLISION
ret

BALL_MOVE
ret

BALL_UNDO_MOVE
ret

BALL_MOVE_X
ret

BALL_UNDO_MOVE_X
ret

BALL_MOVE_Y
ret

BALL_UNDO_MOVE_Y
ret

; toma la pelota (r0)
BALL_RENDER
st                              r0,SAVE_R0
st                              r1,SAVE_R1
st                              r2,SAVE_R2
st                              r7,SAVE_R7

ldr                             r1,r0,0
ldr                             r2,r0,1
ld                              r0,BALL_SPRITE

jsr                             RENDER

ld                              r0,SAVE_R0
ld                              r1,SAVE_R1
ld                              r2,SAVE_R2
ld                              r7,SAVE_R7

ret
         
BALL_UNRENDER
st                              r0,SAVE_R0
st                              r1,SAVE_R1
st                              r2,SAVE_R2
st                              r7,SAVE_R7

ldr                             r1,r0,0
ldr                             r2,r0,1
ld                              r0,BALL_SPRITE

jsr                             UNRENDER

ld                              r0,SAVE_R0
ld                              r1,SAVE_R1
ld                              r2,SAVE_R2
ld                              r7,SAVE_R7

ret
