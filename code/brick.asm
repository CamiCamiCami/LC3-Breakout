; Definase un ladrillo como la siguiente estructura en memoria
; x::int, y::int, muerto::1b, estado::15b
; las coordenadas x, y refieren a la ezquina superior izquerda del bloque


; Toma un puntero a un ladrillo (r1)
BRICK_ON_COLLISION
st                  r0,BRICKS_SAVE_R0
st                  r7,BRICKS_SAVE_R7
ldr                 r0,r1,2
add                 r0,r0,-1
str                 r0,r1,2
brn                 __UNRENDER_DEAD_BRCK
brzp                __RERENDER_BRICK
__RENDER_WRAP_RETURN
ld                  r0,BRICKS_SAVE_R0
ld                  r7,BRICKS_SAVE_R7
ret

__UNRENDER_DEAD_BRCK
add                 r0,r1,0
jsr                 BRICK_UNRENDER
brnzp               __RENDER_WRAP_RETURN

__RERENDER_BRICK
add                 r0,r1,0
jsr                 BRICK_RENDER
brnzp               __RENDER_WRAP_RETURN

; Toma un puntero a una pelota (r0)
; Toma un puntero a un ladrillo (r1)
; Devuelve un booleano (r2)
BRICK_CHECK_COLL
st                              r0,BRICKS_SAVE_R0
st                              r1,BRICKS_SAVE_R1
st                              r3,BRICKS_SAVE_R3
st                              r4,BRICKS_SAVE_R4
st                              r5,BRICKS_SAVE_R5
st                              r6,BRICKS_SAVE_R6
st                              r7,BRICKS_SAVE_R7

ld                              r1,BRICKS_SAVE_R1
ldr                             r4,r1,2
brn                             __BRICK_NO_COLL
ldr                             r4,r1,0
ldr                             r5,r1,1

ldr                             r1,r0,0
jsr                             BITSHIFT8_RIGTH
add                             r2,r1,0
ldr                             r1,r0,1
jsr                             BITSHIFT8_RIGTH
add                             r3,r1,0

ld                              r6,BALL_HEIGHT
add                             r1,r3,r6
not                             r1,r1
add                             r1,r1,1
add                             r0,r5,r1
brp                             __BRICK_NO_COLL

ld                              r6,BRICK_HEIGHT
not                             r1,r3
add                             r1,r1,1
add                             r0,r1,r6
add                             r0,r0,r5
brn                             __BRICK_NO_COLL

ld                              r6,BALL_WIDTH
add                             r1,r2,r6
not                             r1,r1
add                             r1,r1,1
add                             r0,r4,r1
brp                             __BRICK_NO_COLL

ld                              r6,BRICK_WIDTH
not                             r1,r2
add                             r1,r1,1
add                             r0,r1,r6
add                             r0,r0,r4
brn                             __BRICK_NO_COLL

and                             r2,r2,0
add                             r2,r2,1

__BRICK_COLL_END
ld                              r0,BRICKS_SAVE_R0
ld                              r1,BRICKS_SAVE_R1
ld                              r3,BRICKS_SAVE_R3
ld                              r4,BRICKS_SAVE_R4
ld                              r5,BRICKS_SAVE_R5
ld                              r6,BRICKS_SAVE_R6
ld                              r7,BRICKS_SAVE_R7
ret

__BRICK_NO_COLL
and                             r2,r2,0
brnzp                           __BRICK_COLL_END




BRICKS_SAVE_R0      .BLKW   1
BRICKS_SAVE_R1      .BLKW   1
BRICKS_SAVE_R2      .BLKW   1
BRICKS_SAVE_R3      .BLKW   1
BRICKS_SAVE_R4      .BLKW   1
BRICKS_SAVE_R5      .BLKW   1
BRICKS_SAVE_R6      .BLKW   1
BRICKS_SAVE_R7      .BLKW   1

BRICK_WIDTH     .FILL   16
BRICK_HEIGHT    .FILL   4


BRICK           .FILL   4
                .FILL   10
                .FILL   3