; Definase el Estado del Juego como la siguiente estructura en memoria
; pelota::Ball, restantes::int, ladrillos::{ladrillo::Brick}


; Toma la direccion del estado del juego (r0)
__CHECK_COLLISIONS
and                 r6,r6,0
add                 r6,r0,0


