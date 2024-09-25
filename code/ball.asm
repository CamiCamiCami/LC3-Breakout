; Definase una pelota como la siguiente estructura en memoria
; x::int, y::int, vx::int, vy::int

; Definase un eje de rebote como el siguiente tipo
; rebote_x::8b, rebote_y::8b

; Toma la direccion de una pelota (r0)
; Toma el eje de rebote (r1)
BALL_ON_COLLISION
ret

BALL_MOVE
ret

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


BALL_WIDTH              .FILL   3
BALL_HEIGHT             .FILL   3