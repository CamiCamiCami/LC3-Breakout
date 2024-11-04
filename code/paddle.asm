; Definase una paleta como la siguiente estructura en memoria
; x::int

; Toma una paleta (r0)
PADDLE_MOVE
st                              r1,PADDLE_SAVE_R1
st                              r2,PADDLE_SAVE_R2
st                              r3,PADDLE_SAVE_R3

add                             r3,r0,0
ldr                             r0,r0,0

ld                              r1,HAS_KEYBOARD_INPUT
ldr                             r1,r1,0
brzp                            __FINISH_UPDATE
ld                              r1,KEYBOARD_INPUT
ldr                             r1,r1,0

ld                              r2,A_ASCII
add                             r2,r2,r1
brz                             __PADDLE_GO_LEFT

ld                              r2,D_ASCII
add                             r2,r2,r1
brz                             __PADDLE_GO_RIGHT

__FINISH_UPDATE
str                             r0,r3,0
add                             r0,r3,0
ld                              r1,PADDLE_SAVE_R1
ld                              r2,PADDLE_SAVE_R2
ld                              r3,PADDLE_SAVE_R3
ret

__PADDLE_GO_LEFT
ld                              r1,PADDLE_VELOCITY
not                             r1,r1
add                             r1,r1,1  
add                             r0,r0,r1
brn                             __MAX_LEFT
brnzp                           __FINISH_UPDATE

__PADDLE_GO_RIGHT
ld                              r1,PADDLE_VELOCITY
add                             r0,r0,r1
ld                              r2,PADDLE_MAX_X
not                             r2,r2
add                             r2,r2,1
add                             r2,r0,r2
brp                             __MAX_RIGHT
brnzp                           __FINISH_UPDATE

__MAX_LEFT
ld                              r0,PADDLE_MIN_X
brnzp                           __FINISH_UPDATE

__MAX_RIGHT
ld                              r0,PADDLE_MAX_X
brnzp                           __FINISH_UPDATE


PADDLE_CHECK_COLL
st                              r0,PADDLE_SAVE_R0
st                              r1,PADDLE_SAVE_R1
st                              r3,PADDLE_SAVE_R3
st                              r4,PADDLE_SAVE_R4
st                              r5,PADDLE_SAVE_R5
st                              r6,PADDLE_SAVE_R6
st                              r7,PADDLE_SAVE_R7

ldr                             r1,r0,0
jsr                             BITSHIFT8_RIGHT
add                             r2,r1,0
ldr                             r1,r0,1
jsr                             BITSHIFT8_RIGHT
add                             r3,r1,0

ld                              r1,PADDLE_SAVE_R1
ldr                             r4,r1,0
ld                              r5,PADDLE_Y

ld                              r6,BALL_HEIGHT
add                             r1,r3,r6
not                             r1,r1
add                             r1,r1,1
add                             r0,r5,r1
brp                             __PADDLE_NO_COLL

ld                              r6,PADDLE_HEIGHT
not                             r1,r3
add                             r1,r1,1
add                             r0,r1,r6
add                             r0,r0,r5
brn                             __PADDLE_NO_COLL

ld                              r6,BALL_WIDTH
add                             r1,r2,r6
not                             r1,r1
add                             r1,r1,1
add                             r0,r4,r1
brp                             __PADDLE_NO_COLL

ld                              r6,PADDLE_WIDTH
not                             r1,r2
add                             r1,r1,1
add                             r0,r1,r6
add                             r0,r0,r4
brn                             __PADDLE_NO_COLL

and                             r2,r2,0
add                             r2,r2,1

__PADDLE_COLL_END
ld                              r0,PADDLE_SAVE_R0
ld                              r1,PADDLE_SAVE_R1
ld                              r3,PADDLE_SAVE_R3
ld                              r4,PADDLE_SAVE_R4
ld                              r5,PADDLE_SAVE_R5
ld                              r6,PADDLE_SAVE_R6
ld                              r7,PADDLE_SAVE_R7
ret

__PADDLE_NO_COLL
and                             r2,r2,0
brnzp                           __PADDLE_COLL_END            


PADDLE_SAVE_R0                  .BLKW   1
PADDLE_SAVE_R1                  .BLKW   1
PADDLE_SAVE_R2                  .BLKW   1
PADDLE_SAVE_R3                  .BLKW   1
PADDLE_SAVE_R4                  .BLKW   1
PADDLE_SAVE_R5                  .BLKW   1
PADDLE_SAVE_R6                  .BLKW   1
PADDLE_SAVE_R7                  .BLKW   1


PADDLE_HEIGHT                   .FILL   3
PADDLE_WIDTH                    .FILL   20
HAS_KEYBOARD_INPUT              .FILL   xFE00
KEYBOARD_INPUT                  .FILL   xFE02
A_ASCII                         .FILL   -97
D_ASCII                         .FILL   -100
PADDLE_VELOCITY                 .FILL   2
PADDLE_MAX_X                    .FILL   104
PADDLE_MIN_X                    .FILL   4
