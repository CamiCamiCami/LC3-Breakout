; Definase una pelota como la siguiente estructura en memoria
; x::racional8, y::racional8, vx::racional8, vy::racional8

; Toma la direccion de una pelota (r0)
; Toma el rebote en Y (r1)
; Toma el rebote en X (r2)
BALL_ON_COLLISION
st                      r3,BALL_SAVE_R3
add                     r1,r1,0
brz                     __ON_COLL_NO_Y
ldr                     r3,r0,3
not                     r3,r3
add                     r3,r3,1
str                     r3,r0,3
__ON_COLL_NO_Y
add                     r2,r2,0
brz                     __ON_COLL_NO_X
ldr                     r3,r0,2
not                     r3,r3
add                     r3,r3,1
str                     r3,r0,2
__ON_COLL_NO_X
ld                      r3,BALL_SAVE_R3
ret

; Toma una pelota (r0)
BALL_MOVE
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,0
ldr             r2,r0,2
add             r3,r1,r2
str             r3,r0,0

ldr             r1,r0,1
ldr             r2,r0,3
add             r3,r1,r2
str             r3,r0,1

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret

BALL_UNDO_MOVE
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,0
ldr             r2,r0,2
not             r2,r2
add             r2,r2,1
add             r3,r1,r2
str             r3,r0,0

ldr             r1,r0,1
ldr             r2,r0,3
not             r2,r2
add             r2,r2,1
add             r3,r1,r2
str             r3,r0,1

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret

BALL_MOVE_X
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,0
ldr             r2,r0,2
add             r3,r1,r2
str             r3,r0,0

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret

BALL_UNDO_MOVE_X
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,0
ldr             r2,r0,2
not             r2,r2
add             r2,r2,1
add             r3,r1,r2
str             r3,r0,0

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret

BALL_MOVE_Y
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,1
ldr             r2,r0,3
add             r3,r1,r2
str             r3,r0,1

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret

BALL_UNDO_MOVE_Y
st              r1,BALL_SAVE_R1
st              r2,BALL_SAVE_R2

ldr             r1,r0,1
ldr             r2,r0,3
not             r2,r2
add             r2,r2,1
add             r3,r1,r2
str             r3,r0,1

ld              r1,BALL_SAVE_R1
ld              r2,BALL_SAVE_R2
ret


BALL_HEIGHT                     .FILL   3
BALL_WIDTH                      .FILL   3

BALL_SAVE_R0                    .BLKW   1
BALL_SAVE_R1                    .BLKW   1
BALL_SAVE_R2                    .BLKW   1
BALL_SAVE_R3                    .BLKW   1
BALL_SAVE_R4                    .BLKW   1
BALL_SAVE_R5                    .BLKW   1
BALL_SAVE_R6                    .BLKW   1
BALL_SAVE_R7                    .BLKW   1
