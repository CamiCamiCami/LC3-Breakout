; Definase una paleta como la siguiente estructura en memoria
; Paleta = int

; Toma una paleta (r0)
PADDLE_UPDATE
st                              r1,SAVE_R1
st                              r2,SAVE_R2

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
ld                              r1,SAVE_R1
ld                              r2,SAVE_R2
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

; Toma un paleta (r0)

ldr                 r2,r1,0
ldr                 r3,r1,1

; Revisa si la pelota está a la altura de la paleta
PADDLE_CHECK_Y
ld                              r4,PADDLE_Y
not                             r4,r4
add                             r4,r4,5
add                             r4,r3,r4
brzp                            PADDLE_SAME_Y

PADDLE_CHECK_COLL
not                             r0,r0
add                             r0,r0,4
add                             r5,r2,r0
brn                             PADDLE_COLLISION

ld                              r4,PADDLE_WIDTH
add                             r4,r0,r4
not                             r4,r4
add                             r4,r4,1
add                             r4,r2,r4
brn                             PADDLE_COLLISION

PADDLE_RENDER
st                              r0,SAVE_R0
st                              r1,SAVE_R1
st                              r2,SAVE_R2
st                              r7,SAVE_R7

add                             r1,r0,0
ld                              r0,PADDLE_SPRITE
ld                              r2,PADDLE_Y

jsr                             RENDER

ld                              r0,SAVE_R0
ld                              r1,SAVE_R1
ld                              r2,SAVE_R2
ld                              r7,SAVE_R7

ret


PADDLE_UNRENDER
st                              r0,SAVE_R0
st                              r1,SAVE_R1
st                              r2,SAVE_R2
st                              r7,SAVE_R7

add                             r1,r0,0
ld                              r0,PADDLE_SPRITE
ld                              r2,PADDLE_Y

jsr                             UNRENDER

ld                              r0,SAVE_R0
ld                              r1,SAVE_R1
ld                              r2,SAVE_R2
ld                              r7,SAVE_R7

ret


HAS_KEYBOARD_INPUT      .FILL   xFE00
KEYBOARD_INPUT          .FILL   xFE02
A_ASCII                 .FILL   -97
D_ASCII                 .FILL   -100
PADDLE_VELOCITY         .FILL   1
PADDLE_MAX_X            .FILL   108
PADDLE_MIN_X            .FILL   0
PADDLE_Y                .FILL   120
PADDLE_WIDTH            .FILL   16