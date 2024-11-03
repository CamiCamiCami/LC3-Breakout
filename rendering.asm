HMR_AND_SCKL        .FILL   __HMR_AND_SCKL
BRICK_SPRITE        .FILL   __BRICK_SPRITE
PADDLE_SPRITE       .FILL   __PADDLE_SPRITE
BALL_SPRITE         .FILL   __BALL_SPRITE

; toma la pelota (r0)
BALL_RENDER
st                              r0,RENDERING_SAVE_R0
st                              r1,RENDERING_SAVE_R1
st                              r2,RENDERING_SAVE_R2
st                              r7,RENDERING_SAVE_R7

ldr                             r1,r0,1
jsr                             BITSHIFT8_RIGTH
add                             r2,r1,0
ldr                             r1,r0,0
jsr                             BITSHIFT8_RIGTH
ld                              r0,BALL_SPRITE

jsr                             RENDER

ld                              r0,RENDERING_SAVE_R0
ld                              r1,RENDERING_SAVE_R1
ld                              r2,RENDERING_SAVE_R2
ld                              r7,RENDERING_SAVE_R7
ret
         
; toma x e y
BALL_UNRENDER
st                              r0,RENDERING_SAVE_R0
st                              r1,RENDERING_SAVE_R1
st                              r2,RENDERING_SAVE_R2
st                              r7,RENDERING_SAVE_R7

jsr                             BITSHIFT8_RIGTH
add                             r0,r1,0
add                             r1,r2,0
jsr                             BITSHIFT8_RIGTH
add                             r2,r1,0
add                             r1,r0,0
ld                              r0,BALL_SPRITE

jsr                             UNRENDER

ld                              r0,RENDERING_SAVE_R0
ld                              r1,RENDERING_SAVE_R1
ld                              r2,RENDERING_SAVE_R2
ld                              r7,RENDERING_SAVE_R7
ret







; Toma un puntero a un ladrillo (r0)
BRICK_RENDER
st                  r0,RENDERING_SAVE_R0
st                  r1,RENDERING_SAVE_R1
st                  r2,RENDERING_SAVE_R2
st                  r3,RENDERING_SAVE_R3
st                  r7,RENDERING_SAVE_R7

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
ld                  r0,RENDERING_SAVE_R0
ld                  r1,RENDERING_SAVE_R1
ld                  r2,RENDERING_SAVE_R2
ld                  r3,RENDERING_SAVE_R3
ld                  r7,RENDERING_SAVE_R7

ret

BRICK_UNRENDER
st                              r0,RENDERING_SAVE_R0
st                              r1,RENDERING_SAVE_R1
st                              r2,RENDERING_SAVE_R2
st                              r7,RENDERING_SAVE_R7

ldr                             r1,r0,0
ldr                             r2,r0,1
ld                              r0,BRICK_SPRITE

jsr                             UNRENDER

ld                              r0,RENDERING_SAVE_R0
ld                              r1,RENDERING_SAVE_R1
ld                              r2,RENDERING_SAVE_R2
ld                              r7,RENDERING_SAVE_R7

ret

PADDLE_RENDER
st                              r0,RENDERING_SAVE_R0
st                              r1,RENDERING_SAVE_R1
st                              r2,RENDERING_SAVE_R2
st                              r7,RENDERING_SAVE_R7

ldr                             r0,r0,0
add                             r1,r0,0
ld                              r0,PADDLE_SPRITE
ld                              r2,PADDLE_Y

jsr                             RENDER

ld                              r0,RENDERING_SAVE_R0
ld                              r1,RENDERING_SAVE_R1
ld                              r2,RENDERING_SAVE_R2
ld                              r7,RENDERING_SAVE_R7

ret

; toma x e y
PADDLE_UNRENDER
st                              r0,RENDERING_SAVE_R0
st                              r7,RENDERING_SAVE_R7

ld                              r0,PADDLE_SPRITE
ld                              r2,PADDLE_Y

jsr                             UNRENDER

ld                              r0,RENDERING_SAVE_R0
ld                              r7,RENDERING_SAVE_R7

ret


RENDERING_SAVE_R0               .BLKW   1
RENDERING_SAVE_R1               .BLKW   1
RENDERING_SAVE_R2               .BLKW   1
RENDERING_SAVE_R3               .BLKW   1
RENDERING_SAVE_R4               .BLKW   1
RENDERING_SAVE_R5               .BLKW   1
RENDERING_SAVE_R6               .BLKW   1
RENDERING_SAVE_R7               .BLKW   1

PADDLE_Y                        .FILL   120

BRICK_COLORS    .FILL   x03E0
                .FILL   x7FE0
                .FILL   x7DE0
                .FILL   x7C00
