                        .ORIG   x3000

SETUP
brnzp                   MAIN_LOOP


BALL                    .FILL   b0100000000000000
                        .FILL   b0110010000000000
                        .FILL   b0000000010000000
                        .FILL   b1111111110000000

PADDLE                  .FILL   64

BRICKS                  .FILL   30
                        .FILL   40
                        .FILL   3

                        .FILL   80
                        .FILL   40
                        .FILL   3

                        .FILL   100
                        .FILL   40
                        .FILL   3

BRICK_MATRIX_LEN        .FILL   3

MAIN_LOOP
jsr                     UPDATE
brnzp                   MAIN_LOOP

WAIT
and                     r1,r1,0
add                     r1,r1,3
__WAIT
ldr                     r2,r6,0
brzp                    __WAIT
add                     r1,r1,-1
brp                     __WAIT
ret

GAME_OVER
HALT

UPDATE_RET      .BLKW   1
UPDATE
st              r7,UPDATE_RET
lea             r0,BALL
jsr             BALL_UNRENDER
jsr             BALL_MOVE
lea             r0,PADDLE
jsr             PADDLE_UNRENDER
jsr             PADDLE_MOVE

jsr             CHECK_COLLISIONS

not             r2,r2           ; |
not             r1,r1           ; |  
and             r3,r2,r1        ; |  OR implementado con AND y NOT
not             r2,r2           ; |  (No existe OR nativo en LC3)
not             r1,r1           ; | 
not             r3,r3           ; |
brz             __NO_COLLISION
lea             r0,BALL
jsr             BALL_ON_COLLISION
__NO_COLLISION

lea             r0,BALL
jsr             BALL_RENDER
lea             r0,PADDLE
jsr             PADDLE_RENDER

ld              r7,UPDATE_RET
ret


CHECK_COLLISIONS_RET    .BLKW   1
CHECK_COLLISIONS
st              r7,CHECK_COLLISIONS_RET
and             r5,r5,0
and             r6,r6,0

jsr             WALL_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2

jsr             PADDLE_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2

add             r1,r5,0
add             r2,r6,0
ld              r7,CHECK_COLLISIONS_RET
ret



; Chequea colision con las paredes
WALL_COLL_WRAP_RET    .BLKW   1
WALL_COLL_WRAP
st              r7,WALL_COLL_WRAP_RET
and             r2,r2,0
and             r1,r1,0
and             r3,r3,0
lea             r0,BALL
jsr             CHECK_WALL_DOWN_COLL
add             r2,r2,0
brnp            GAME_OVER

jsr             CHECK_WALL_LEFT_COLL
add             r3,r2,r3
jsr             CHECK_WALL_RGHT_COLL
add             r3,r2,r3

jsr             CHECK_WALL_UP_COLL
add             r1,r2,0
add             r2,r3,0
ld              r7,WALL_COLL_WRAP_RET
ret

; Chequea colision con la paleta
PADDLE_COLL_WRAP_RET  .BLKW   1
PADDLE_COLL_WRAP
st              r7,PADDLE_COLL_WRAP_RET
and             r2,r2,0
lea             r0,PADDLE
lea             r1,BALL
jsr             PADDLE_CHECK_COLL
add             r1,r2,0
and             r2,r2,0
ld              r7,PADDLE_COLL_WRAP_RET
ret

; Chequea colision con los bloques
BRICKS_COLL_WRAP
ld              r3,BRICK_MATRIX_LEN
and             r2,r2,0
and             r1,r1,0

__BRICKS_COLL_LOOP
add             r3,r3,-1
brz             __BRICK_COLL_END
ldr             r0,r3,0
lea             r1,BALL

__BRICK_COLL_NOT
brnzp           __BRICKS_COLL_LOOP
__BRICK_COLL_END
ret


CLOCK               .FILL   xFE08
HIGH_UP             .FILL   xFF00
LOW_UP              .FILL   x00FF

SAVE_R0         .BLKW   1
SAVE_R1         .BLKW   1
SAVE_R2         .BLKW   1
SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
SAVE_R7         .BLKW   1
