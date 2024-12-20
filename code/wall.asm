; Toma la direccion en memoria de la pelota (r0)
; Devuelve si colisiono (r2)
CHECK_WALL_LEFT_COLL    ; ball.x <= Wall.width -> 0 <= ball.x - Wall.width
st                      r0,WALL_SAVE_R0
st                      r1,WALL_SAVE_R1
st                      r7,WALL_SAVE_R7

ldr                     r1,r0,0
jsr                     BITSHIFT8_RIGHT
add                     r0,r1,0

ld                      r2,WALL_WIDTH
not                     r2,r2
add                     r2,r2,1
add                     r0,r0,r2
brnz                    __WALL_LEFT_COLLIDED                                          
and                     r2,r2,0
__WALL_LEFT_COLLIDED
ld                      r0,WALL_SAVE_R0
ld                      r1,WALL_SAVE_R1
ld                      r7,WALL_SAVE_R7
ret

; Toma la direccion en memoria de la pelota (r0)
; Devuelve si colisiono (r2)
CHECK_WALL_RGHT_COLL    ; ball.x + Ball.width >= Screen.width - Wall.width -> 0 >= Screen.width - (Wall.width + ball.x + Ball.width)
st                      r0,WALL_SAVE_R0
st                      r1,WALL_SAVE_R1
st                      r7,WALL_SAVE_R7

ldr                     r1,r0,0
jsr                     BITSHIFT8_RIGHT
add                     r0,r1,0

ld                      r2,WALL_WIDTH
add                     r0,r2,r0
ld                      r2,BALL_WIDTH_PTR
ldr                     r2,r2,0
add                     r0,r2,r0
not                     r0,r0
add                     r0,r0,1
ld                      r2,ANCHO
add                     r0,r2,r0
brnz                    __WALL_RGHT_COLLIDED                                          
and                     r2,r2,0
__WALL_RGHT_COLLIDED
ld                      r0,WALL_SAVE_R0
ld                      r1,WALL_SAVE_R1
ld                      r7,WALL_SAVE_R7
ret

; Toma la direccion en memoria de la pelota (r0)
; Devuelve si colisiono (r2)
CHECK_WALL_UP_COLL      ; ball.y <= Wall.width -> 0 <= ball.y - Wall.width
st                      r0,WALL_SAVE_R0
st                      r1,WALL_SAVE_R1
st                      r7,WALL_SAVE_R7

ldr                     r1,r0,1
jsr                     BITSHIFT8_RIGHT
add                     r0,r1,0

ld                      r2,WALL_WIDTH
not                     r2,r2
add                     r2,r2,1
add                     r0,r0,r2
brnz                    __WALL_UP_COLLIDED                                          
and                     r2,r2,0
__WALL_UP_COLLIDED
ld                      r0,WALL_SAVE_R0
ld                      r1,WALL_SAVE_R1
ld                      r7,WALL_SAVE_R7
ret

; Toma la direccion en memoria de la pelota (r0)
; Devuelve si colisiono (r2)
CHECK_WALL_DOWN_COLL    ; ball.y + Ball.width >= Screen.height -> 0 >= Screen.height - (ball.y + Ball.height)
st                      r0,WALL_SAVE_R0
st                      r1,WALL_SAVE_R1
st                      r7,WALL_SAVE_R7

ldr                     r1,r0,1
jsr                     BITSHIFT8_RIGHT
add                     r0,r1,0

ld                      r2,BALL_HEIGHT_PTR
ldr                     r2,r2,0
add                     r0,r2,r0
not                     r0,r0
add                     r0,r0,1
ld                      r2,ALTO
add                     r0,r2,r0
brnz                    __WALL_DOWN_COLLIDED
and                     r2,r2,0
__WALL_DOWN_COLLIDED
ld                      r0,WALL_SAVE_R0
ld                      r1,WALL_SAVE_R1
ld                      r7,WALL_SAVE_R7
ret

BALL_HEIGHT_PTR         .FILL   BALL_HEIGHT
BALL_WIDTH_PTR          .FILL   BALL_WIDTH

WALL_SAVE_R0            .BLKW   1
WALL_SAVE_R1            .BLKW   1
WALL_SAVE_R7            .BLKW   1
WALL_WIDTH              .FILL   4
