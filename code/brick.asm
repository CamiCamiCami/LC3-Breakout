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

; Toma un puntero a una pelota (r0)
; Toma un puntero a un ladrillo (r1)
; Devuelve un booleano (r2)
BRICK_CHECK_COLL
st                  r0,SAVE_R0
st                  r3,SAVE_R3
st                  r4,SAVE_R4
st                  r5,SAVE_R5

ldr                 r2,r0,0
ldr                 r3,r0,1

ldr                 r4,r1,0
not                 r4,r4
add                 r4,r4,1
add                 r4,r4,r2
brn                 __NO_COLLISION

ldr                 r5,r1,1
not                 r5,r5
add                 r5,r5,1
add                 r5,r5,r3
brn                 __NO_COLLISION

ld                  r2,BRICK_WIDTH
not                 r2,r2
add                 r2,r2,1
add                 r4,r4,r2
brp                 __NO_COLLISION

ld                  r2,BRICK_HEIGHT
not                 r2,r2
add                 r2,r2,1
add                 r5,r5,r2
brp                 __NO_COLLISION

__COLLISION_DETECTED
and                 r2,r2,0
add                 r2,r2,1
brnzp               __END_CHK_COLL

__NO_COLLISION
and                 r2,r2,0

__END_CHK_COLL
ld                  r0,SAVE_R0
ld                  r3,SAVE_R3
ld                  r4,SAVE_R4
ld                  r5,SAVE_R5

ret

; Toma un puntero a un ladrillo (r0)
BRICK_RENDER
st                  r0,SAVE_R0
st                  r1,SAVE_R1
st                  r2,SAVE_R2
st                  r3,SAVE_R3
st                  r7,SAVE_R7

ldr                 r1,r0,2
brn                 __TERMINATE_RENDER
lea                 r3,BRICK_COLORS
add                 r3,r1,r3
ldr                 r3,r3,0
ldr                 r1,r0,0
ldr                 r2,r0,1
ld                  r0,BRICK_SPRITE
jsr                 RENDER_COLOR

__TERMINATE_RENDER
ld                  r0,SAVE_R0
ld                  r1,SAVE_R1
ld                  r2,SAVE_R2
ld                  r3,SAVE_R3
ld                  r7,SAVE_R7

ret

BRICK_COLORS    .FILL   x03E0
                .FILL   x7FE0
                .FILL   x7DE0
                .FILL   x7C00

BRICK_WIDTH     .FILL   16
BRICK_HEIGHT    .FILL   4
