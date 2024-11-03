; Definase un ladrillo como la siguiente estructura en memoria
; x::int, y::int, muerto::1b, estado::15b


; Toma un puntero a un ladrillo (r1)
BRICK_ON_COLLISION
st                  r0,BRICKS_SAVE_R0
st                  r7,BRICKS_SAVE_R7
ldr                 r0,r1,2
add                 r0,r0,-1
str                 r0,r1,2
brnz                __UNRENDER_DEAD_BRCK
brp                 __RERENDER_BRICK
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
st                  r0,BRICKS_SAVE_R0
st                  r1,BRICKS_SAVE_R1
st                  r3,BRICKS_SAVE_R3
st                  r4,BRICKS_SAVE_R4
st                  r5,BRICKS_SAVE_R5
st                  r7,BRICKS_SAVE_R7

ldr                 r1,r1,2
brn                 __BRICK_NO_COLLISION

ldr                 r1,r0,0
jsr                 BITSHIFT8_RIGTH
add                 r2,r1,0
ldr                 r1,r0,1
jsr                 BITSHIFT8_RIGTH
add                 r3,r1,0
ld                  r1,BRICKS_SAVE_R1

ldr                 r4,r1,0
not                 r4,r4
add                 r4,r4,1
add                 r4,r4,r2
brn                 __BRICK_NO_COLLISION

ldr                 r5,r1,1
not                 r5,r5
add                 r5,r5,1
add                 r5,r5,r3
brn                 __BRICK_NO_COLLISION

ld                  r2,BRICK_WIDTH
not                 r2,r2
add                 r2,r2,1
add                 r4,r4,r2
brp                 __BRICK_NO_COLLISION

ld                  r2,BRICK_HEIGHT
not                 r2,r2
add                 r2,r2,1
add                 r5,r5,r2
brp                 __BRICK_NO_COLLISION

__COLLISION_DETECTED
and                 r2,r2,0
add                 r2,r2,1
brnzp               __END_CHK_COLL

__BRICK_NO_COLLISION
and                 r2,r2,0

__END_CHK_COLL
ld                  r0,BRICKS_SAVE_R0
ld                  r1,BRICKS_SAVE_R1
ld                  r3,BRICKS_SAVE_R3
ld                  r4,BRICKS_SAVE_R4
ld                  r5,BRICKS_SAVE_R5
ld                  r7,BRICKS_SAVE_R7

ret




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
