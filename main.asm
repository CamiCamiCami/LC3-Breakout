                        .ORIG   x3000

SETUP
jsr             RENDER_BACKGROUND

lea             r0,BRICKS
ld              r1,BRICK_MATRIX_LEN
ld              r2,BRICK_STRUCT_SIZE

__BRICKS_INIT_LOOP
jsr             BRICK_RENDER
add             r0,r0,r2
add             r1,r1,-1
brp             __BRICKS_INIT_LOOP

lea                     r0,BALL
jsr                     BALL_RENDER
lea                     r0,PADDLE
jsr                     PADDLE_RENDER

brnzp                   MAIN_LOOP


BALL                    .FILL   b0100000000000000
                        .FILL   b0110010000000000
                        .FILL   b0000000110000000
                        .FILL   b1111111010000000

PADDLE                  .FILL   64

BRICKS                  .FILL   16
                        .FILL   40
                        .FILL   3

                        .FILL   32
                        .FILL   40
                        .FILL   3

                        .FILL   48
                        .FILL   40
                        .FILL   3

                        .FILL   64
                        .FILL   40
                        .FILL   3

                        .FILL   80
                        .FILL   40
                        .FILL   3

                        .FILL   96
                        .FILL   40
                        .FILL   3  

                        .FILL   16
                        .FILL   44
                        .FILL   3

                        .FILL   32
                        .FILL   44
                        .FILL   3

                        .FILL   48
                        .FILL   44
                        .FILL   3

                        .FILL   64
                        .FILL   44
                        .FILL   3

                        .FILL   80
                        .FILL   44
                        .FILL   3

                        .FILL   96
                        .FILL   44
                        .FILL   3

                        .FILL   16
                        .FILL   48
                        .FILL   3

                        .FILL   32
                        .FILL   48
                        .FILL   3

                        .FILL   48
                        .FILL   48
                        .FILL   3

                        .FILL   64
                        .FILL   48
                        .FILL   3

                        .FILL   80
                        .FILL   48
                        .FILL   3

                        .FILL   96
                        .FILL   48
                        .FILL   3         

BRICK_MATRIX_LEN        .FILL   18
BRICK_STRUCT_SIZE       .FILL   3

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

UPDATE_BALL_OLD_X   .BLKW   1
UPDATE_BALL_OLD_Y   .BLKW   1
UPDATE_PADDLE_OLD_X .BLKW   1
UPDATE_RET          .BLKW   1
UPDATE
st              r7,UPDATE_RET

lea             r0,BALL
ldr             r1,r0,0
st              r1,UPDATE_BALL_OLD_X
ldr             r1,r0,1
st              r1,UPDATE_BALL_OLD_Y
jsr             BALL_MOVE

lea             r0,PADDLE
ldr             r1,r0,0
st              r1,UPDATE_PADDLE_OLD_X
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
jsr             BALL_UNDO_MOVE
jsr             BALL_ON_COLLISION
__NO_COLLISION

lea             r0,BALL
ld              r1,UPDATE_BALL_OLD_X
jsr             BITSHIFT8_RIGHT
add             r2,r1,0
ldr             r1,r0,0
jsr             BITSHIFT8_RIGHT
not             r2,r2
add             r2,r2,1
add             r1,r2,r1
brnp            __BALL_RERENDER

ld              r1,UPDATE_BALL_OLD_Y
jsr             BITSHIFT8_RIGHT
add             r2,r1,0
ldr             r1,r0,1
jsr             BITSHIFT8_RIGHT
not             r2,r2
add             r2,r2,1
add             r1,r2,r1
brnp            __BALL_RERENDER
brnzp           __BALL_STAY

__BALL_RERENDER
ld              r1,UPDATE_BALL_OLD_X
ld              r2,UPDATE_BALL_OLD_Y
jsr             BALL_UNRENDER
lea             r0,BALL
jsr             BALL_RENDER
__BALL_STAY

lea             r0,PADDLE
ld              r2,UPDATE_PADDLE_OLD_X
ldr             r1,r0,0
not             r2,r2
add             r2,r2,1
add             r1,r2,r1
brnp            __PADDLE_RERENDER
brnzp           __PADDLE_STAY

__PADDLE_RERENDER
ld              r1,UPDATE_PADDLE_OLD_X
jsr             PADDLE_UNRENDER
lea             r0,PADDLE
jsr             PADDLE_RENDER
__PADDLE_STAY

ld              r7,UPDATE_RET
ret

CHECK_COLLISIONS_R5     .BLKW   1
CHECK_COLLISIONS_R6     .BLKW   1
CHECK_COLLISIONS_RET    .BLKW   1
CHECK_COLLISIONS
st              r7,CHECK_COLLISIONS_RET
and             r5,r5,0
and             r6,r6,0

st              r5,CHECK_COLLISIONS_R5
st              r6,CHECK_COLLISIONS_R6
jsr             WALL_COLL_WRAP
ld              r5,CHECK_COLLISIONS_R5
ld              r6,CHECK_COLLISIONS_R6
add             r5,r5,r1
add             r6,r6,r2

st              r5,CHECK_COLLISIONS_R5
st              r6,CHECK_COLLISIONS_R6
jsr             PADDLE_COLL_WRAP
ld              r5,CHECK_COLLISIONS_R5
ld              r6,CHECK_COLLISIONS_R6
add             r5,r5,r1
add             r6,r6,r2

st              r5,CHECK_COLLISIONS_R5
st              r6,CHECK_COLLISIONS_R6
jsr             BRICKS_COLL_WRAP
ld              r5,CHECK_COLLISIONS_R5
ld              r6,CHECK_COLLISIONS_R6
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
and             r1,r1,0
and             r2,r2,0
lea             r1,PADDLE
lea             r0,BALL
jsr             PADDLE_CHECK_COLL
and             r1,r1,0
add             r2,r2,0
brz             __PADDLE_COLL_NOT

lea             r1,PADDLE
jsr             BALL_UNDO_MOVE_X
jsr             PADDLE_CHECK_COLL
add             r3,r2,0
jsr             BALL_MOVE_X
jsr             BALL_UNDO_MOVE_Y
jsr             PADDLE_CHECK_COLL
jsr             BALL_MOVE_Y
add             r1,r3,0

__PADDLE_COLL_NOT
ld              r7,PADDLE_COLL_WRAP_RET
ret

; Chequea colision con los bloques
BRICKS_COLL_WRAP_RET  .BLKW   1
BRICKS_COLL_WRAP
st              r7,BRICKS_COLL_WRAP_RET
lea             r1,BRICKS
ld              r4,BRICK_MATRIX_LEN
ld              r3,BRICK_STRUCT_SIZE
and             r5,r5,0
and             r6,r6,0
lea             r0,BALL

__BRICKS_COLL_LOOP
jsr             BRICK_CHECK_COLL
add             r2,r2,0
brz             __BRICK_COLL_NOT
jsr             BALL_UNDO_MOVE_X
jsr             BRICK_CHECK_COLL
add             r5,r5,r2
jsr             BALL_MOVE_X
jsr             BALL_UNDO_MOVE_Y
jsr             BRICK_CHECK_COLL
add             r6,r6,r2
jsr             BALL_MOVE_Y
jsr             BRICK_ON_COLLISION
__BRICK_COLL_NOT
add             r1,r1,r3
add             r4,r4,-1
brp             __BRICKS_COLL_LOOP
add             r1,r5,0
add             r2,r6,0
ld              r7,BRICKS_COLL_WRAP_RET
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
