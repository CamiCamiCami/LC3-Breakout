; Definase un ladrillo como la siguiente estructura en memoria
; x::int, y::int, muerto::1b, estado::15b


; Toma un puntero a un ladrillo (r0)
BRICK_ON_COLLISION
st                  r1,SAVE_R1
ldr                 r1,r0,3
add                 r1,r1,-1
str                 r1,r0,3
ld                  r1,SAVE_R1
ret

; Toma un puntero a un ladrillo (r0)
BRICK_RENDER
st                  r0,SAVE_R0
st                  r1,SAVE_R1
st                  r2,SAVE_R2
st                  r3,SAVE_R3
st                  r7,SAVE_R7

ldr                 r1,r0,3
lea                 r3,BRICK_COLORS
add                 r3,r1,r3
ldr                 r3,r3,0
ldr                 r1,r0,0
ldr                 r2,r0,1
ld                  r0,BRICK_SPRITE
jsr                 RENDER

ld                  r0,SAVE_R0
ld                  r1,SAVE_R1
ld                  r2,SAVE_R2
ld                  r3,SAVE_R3
ld                  r7,SAVE_R7

ret


LADRILLO_EJ     .FILL   50
                .FILL   100
                .FILL   3

BRICK_COLORS    .FILL   x03E0
                .FILL   x7FE0
                .FILL   x7DE0
                .FILL   x7C00

SAVE_R0         .BLKW   1
SAVE_R1         .BLKW   1
SAVE_R2         .BLKW   1
SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
SAVE_R7         .BLKW   1
