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

CLOCK           .FILL   xFE08

SAVE_R0         .BLKW   1
SAVE_R1         .BLKW   1
SAVE_R2         .BLKW   1
SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
SAVE_R7         .BLKW   1
