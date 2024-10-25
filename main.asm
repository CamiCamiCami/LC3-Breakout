                .ORIG   x3000

and                     r0,r0,0
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,4

ld                      r6,CLOCK


MAIN_LOOP
jsr                     PADDLE_UNRENDER
jsr                     PADDLE_UPDATE
jsr                     PADDLE_RENDER
jsr                     WAIT
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


; Toma la direccion en memoria de la pelota (r0)
; Toma la paleta (r1)
; Toma la direccion en memoria de la matriz de ladrillos (r2)
; Toma la cantidad de ladrillos (r3)
UPDATE
st              r0,SAVE_R0
st              r1,SAVE_R1
st              r2,SAVE_R2
st              r3,SAVE_R3
st              r6,SAVE_R6
st              r7,SAVE_R7

jsr             BALL_UNRENDER
jsr             BALL_UPDATE
ld              r0,SAVE_R1
jsr             PADDLE_UNRENDER
jsr             PADDLE_UPDATE

ld              r0,SAVE_R1
ld              r1,SAVE_R0
jsr             PADDLE_CHECK_COLL
add             r2,r2,0
BRnp            __HANDLE_PADDLE_COLL

ld              r0,SAVE_R0
jsr             CHECK_WALL_LEFT_COLL
add             r2,r2,0
BRnp            __HANDLE_X_WALL_COLL
jsr             CHECK_WALL_RGHT_COLL
add             r2,r2,0
BRnp            __HANDLE_X_WALL_COLL
jsr             CHECK_WALL_UP_COLL
add             r2,r2,0
BRnp            __HANDLE_Y_WALL_COLL
jsr             CHECK_WALL_DOWN_COLL
add             r2,r2,0
BRnp            __HANDLE_DEATH_COLL


ld              r6,BRICK_STRUCT_LEN
ld              r0,SAVE_R2
ld              r1,SAVE_R0
__BRICKS_COLL_LOOP
jsr             BRICK_CHECK_COLL
add             r2,r2,0
BRnp            __HANDLE_BRICK_COLL
add             r0,r0,r6
add             r3,r3,-1
brp             __BRICKS_COLL_LOOP

__AFTER_COLL_HANDLE
ld              r0,SAVE_R0
jsr             BALL_RENDER

ld              r0,SAVE_R1
jsr             PADDLE_RENDER

ld              r0,SAVE_R0
ld              r1,SAVE_R1
ld              r2,SAVE_R2
ld              r3,SAVE_R3
ld              r6,SAVE_R6
ld              r7,SAVE_R7

ret


__HANDLE_Y_WALL_COLL
ld              r1,LOW_UP
jsr             BALL_ON_COLLISION
brnzp           __AFTER_COLL_HANDLE

__HANDLE_X_WALL_COLL
ld              r1,HIGH_UP
jsr             BALL_ON_COLLISION
brnzp           __AFTER_COLL_HANDLE

__HANDLE_DEATH_COLL
HALT

__HANDLE_BRICK_COLL
and             r3,r3,0
add             r6,r0,0     ; r6 guarda el ladrillo
ld              r0,SAVE_R0
jsr             BALL_UNDO_MOVE_X
add             r5,r0,0     ; r5 guarda la pelota
add             r0,r6,0     ; carga en r0 el ladrillo
jsr             BRICK_CHECK_COLL
add             r2,r2,0
brz             __BRCK_NO_Y                     
ld              r2,LOW_UP
add             r3,r2,r3
__BRCK_NO_Y
add             r0,r5,0     ; carga en r0 la pelota
jsr             BALL_UNDO_MOVE_Y
jsr             BALL_MOVE_X
add             r0,r6,0
add             r1,r5,0
jsr             BRICK_CHECK_COLL
add             r2,r2,0
ld              r2,HIGH_UP
add             r3,r2,r3
__BRCK_NO_X
add             r0,r5,0
add             r1,r3,0
jsr             BALL_ON_COLLISION
brnzp           __AFTER_COLL_HANDLE



__HANDLE_PADDLE_COLL


; Toma la direccion en memoria de la pelota (r0)
; Devuelve un booleano (r1)
CHECK_BORDER_COLL
ret


CHECK_COLLISIONS
and             r5,r5,0
and             r6,r6,0

jsr             BORDER_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2

jsr             BORDER_COLL_WRAP
add             r5,r5,r1
add             r6,r6,r2







; Chequea colision con las paredes
BORDER_COLL_WRAP
and             r2,r2,0
and             r1,r1,0
ld              r0,SAVE_PELOTA
jsr             CHECK_BORDER_COLL

add             r2,r2,0
brz             __BORDER_COLL_NOT

jsr             BALL_UNDO_MOVE_X
jsr             CHECK_BORDER_COLL
add             r2,r2,0
brz             __NOT_BORDER_COLL_Y
add             r1,r2,0
__NOT_BORDER_COLL_Y

jsr             BALL_UNDO_MOVE_Y
jsr             BALL_MOVE_X
jsr             CHECK_BORDER_COLL

__BORDER_COLL_NOT
ret

; Chequea colision con la paleta
BORDER_COLL_WRAP
and             r2,r2,0
ld              r0,SAVE_PALETA
ld              r1,SAVE_PELOTA
jsr             PADDLE_CHECK_COLL
add             r1,r2,0
and             r2,r2,0
ret

; Chequea colision con las paredes
BORDER_COLL_WRAP
and             r2,r2,0
and             r1,r1,0
ld              r0,SAVE_PELOTA
jsr             CHECK_BORDER_COLL

add             r2,r2,0
brz             __BORDER_COLL_NOT

jsr             BALL_UNDO_MOVE_X
jsr             CHECK_BORDER_COLL
add             r2,r2,0
brz             __NOT_BORDER_COLL_Y
add             r1,r2,0
__NOT_BORDER_COLL_Y

jsr             BALL_UNDO_MOVE_Y
jsr             BALL_MOVE_X
jsr             CHECK_BORDER_COLL

__BORDER_COLL_NOT
ret

BRICK_STRUCT_LEN    .FILL   3
CLOCK               .FILL   xFE08
HIGH_UP             .FILL   xFF00
LOW_UP              .FILL   x00FF

SAVE_PELOTA     .BLKW   1
SAVE_PALETA     .BLKW   1
SAVE_LADRILLOS  .BLKW   1
SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
SAVE_SALTO      .BLKW   1
