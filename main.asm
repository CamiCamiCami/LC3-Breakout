                .ORIG   x3000

and                     r0,r0,0
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,15
add                     r0,r0,4

MAIN_LOOP
jsr                     PADDLE_UPDATE
jsr                     BACKGROUND_RENDER
jsr                     PADDLE_RENDER
brnzp                   MAIN_LOOP

BACKGROUND_RENDER
st                      r0,SAVE_R0
st                      r1,SAVE_R1
st                      r2,SAVE_R2
st                      r3,SAVE_R3
st                      r7,SAVE_R7

ld                      r0,BACKGROUND
and                     r1,r1,0
and                     r2,r2,0
and                     r3,r3,0

jsr                     RENDER

ld                      r0,SAVE_R0
ld                      r1,SAVE_R1
ld                      r2,SAVE_R2
ld                      r3,SAVE_R3
ld                      r7,SAVE_R7

ret



SAVE_R0         .BLKW   1
SAVE_R1         .BLKW   1
SAVE_R2         .BLKW   1
SAVE_R3         .BLKW   1
SAVE_R4         .BLKW   1
SAVE_R5         .BLKW   1
SAVE_R6         .BLKW   1
SAVE_R7         .BLKW   1
