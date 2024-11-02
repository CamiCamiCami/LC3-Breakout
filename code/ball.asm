; Definase una pelota como la siguiente estructura en memoria
; x::int, y::int, vx::int, vy::int

; Toma la direccion de una pelota (r0)
; Toma el rebote en Y (r1)
; Toma el rebote en X (r2)
BALL_ON_COLLISION
st                      r3,BALL_SAVE_R3
brz                     r1,__ON_COLL_NO_Y
ldr                     r3,r0,3
not                     r3,r3
add                     r3,r3,1
str                     r3,r0,3
__ON_COLL_NO_Y
brz                     r2,__ON_COLL_NO_X
ldr                     r3,r0,2
not                     r3,r3
add                     r3,r3,1
str                     r3,r0,2
__ON_COLL_NO_X
ret

BALL_MOVE


BALL_UNDO_MOVE
ret

BALL_MOVE_X
ret

BALL_UNDO_MOVE_X
ret

BALL_MOVE_Y
ret

BALL_UNDO_MOVE_Y
ret

BALL_SAVE_R3            .BLKW   1

BALL_WIDTH              .FILL   3
BALL_HEIGHT             .FILL   3