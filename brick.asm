; Definase un ladrillo como la siguiente estructura en memoria
; x::int, y::int, muerto::int, estado::int


; Toma un puntero a un ladrillo (r0)
ON_COLLISION
st                  r1,SAVE_R1
ldr                 r1,r0,3
add                 r1,r1,-1
BRn                 __ON_DESTROYED
BRzp                __ON_NOT_DESTROYED 

__ON__DESTROYED
and                 r1,r1,0
add                 r1,r1,1
str                 r1,r0,2
BRnzp               __ON_COLLISION_END

__ON_NOT_DESTROYED
str                 r1,r0,3
BRnzp               __ON_COLLISION_END

__ON_COLLISION_END
ld                  r1,SAVE_R1
ret





SAVE_R0     .BLKW   1
SAVE_R1     .BLKW   1
SAVE_R2     .BLKW   1
SAVE_R3     .BLKW   1
SAVE_R4     .BLKW   1
SAVE_R5     .BLKW   1
SAVE_R6     .BLKW   1
SAVE_R7     .BLKW   1