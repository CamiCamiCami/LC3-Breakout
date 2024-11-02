                        .ORIG   x3000

SETUP
brnzp                   MAIN_LOOP


BALL                    .FILL   64
                        .FILL   100
                        .FILL   1
                        .FILL   -1

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


UPDATE
lea             r0,BALL
jsr             BALL_UNRENDER
jsr             BALL_MOVE
lea             r0,PADDLE
jsr             PADDLE_UNRENDER
jsr             PADDLE_MOVE

jsr             CHECK_COLLISIONS

not             r2,r2           ; |
not             r1,r1           ; |  OR implementado con AND y NOT
and             r3,r2,r1        ; |  (No existe OR nativo en LC3)
not             r3,r3           ; |
brz             __NO_COLLISION
lea             r0,BALL
jsr             BALL_ON_COLLISION
__NO_COLLISION

lea             r0,BALL
jsr             BALL_RENDER
lea             r0,PADDLE
jsr             PADDLE_RENDER

ret



CHECK_COLLISIONS
and             r5,r5,0
and             r6,r6,0

jsr             WALL_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2

jsr             PADDLE_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2

ret




; Chequea colision con las paredes
WALL_COLL_WRAP
and             r2,r2,0
and             r1,r1,0
and             r3,r3,0
lea             r0,BALL
jsr             CHECK_WALL_DOWN_COLL
brnp            GAME_OVER

jsr             CHECK_WALL_LEFT_COLL
add             r3,r2,r3
jsr             CHECK_WALL_RGHT_COLL
add             r3,r2,r3

jsr             CHECK_WALL_UP_COLL
add             r1,r2,0
add             r2,r3,0
ret

; Chequea colision con la paleta
PADDLE_COLL_WRAP
and             r2,r2,0
lea             r0,PADDLE
lea             r1,BALL
jsr             PADDLE_CHECK_COLL
add             r1,r2,0
and             r2,r2,0
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


SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
