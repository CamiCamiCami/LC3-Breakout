
MASK1                           .FILL   b0000000000000001
MASK2                           .FILL   b0000000100000000
BITSHIFT8_RIGTH
st                              r2,MISC_SAVE_R2
st                              r3,MISC_SAVE_R3
st                              r4,MISC_SAVE_R4
st                              r5,MISC_SAVE_R5

ld                              r2,MASK1
ld                              r3,MASK2
and                             r4,r4,0
and                             r5,r5,0
__BITSHIFT8_LOOP
and                             r5,r1,r3
brz                             __BITSHIFT8_PUT_0
add                             r4,r2,r4
__BITSHIFT8_PUT_0
add                             r2,r2,r2
add                             r3,r3,r3
brnp                            __BITSHIFT8_LOOP

add                             r1,r4,0
ld                              r2,MISC_SAVE_R2
ld                              r3,MISC_SAVE_R3
ld                              r4,MISC_SAVE_R4
ld                              r5,MISC_SAVE_R5
ret

MASK3                           .FILL   b0000000000000001
MASK4                           .FILL   b0000000000010000
BITSHIFT4_RIGTH
st                              r2,MISC_SAVE_R2
st                              r3,MISC_SAVE_R3
st                              r4,MISC_SAVE_R4
st                              r5,MISC_SAVE_R5

ld                              r2,MASK3
ld                              r3,MASK4
and                             r4,r4,0
and                             r5,r5,0
__BITSHIFT4_LOOP
and                             r5,r1,r3
brz                             __BITSHIFT4_PUT_0
add                             r4,r2,r4
__BITSHIFT4_PUT_0
add                             r2,r2,r2
add                             r3,r3,r3
brnp                            __BITSHIFT4_LOOP

add                             r1,r4,0
ld                              r2,MISC_SAVE_R2
ld                              r3,MISC_SAVE_R3
ld                              r4,MISC_SAVE_R4
ld                              r5,MISC_SAVE_R5
ret

MASK5                           .FILL   b0000000000000001
MASK6                           .FILL   b0000000000000100
BITSHIFT2_RIGTH
st                              r2,MISC_SAVE_R2
st                              r3,MISC_SAVE_R3
st                              r4,MISC_SAVE_R4
st                              r5,MISC_SAVE_R5

ld                              r2,MASK5
ld                              r3,MASK6
and                             r4,r4,0
and                             r5,r5,0
__BITSHIFT2_LOOP
and                             r5,r1,r3
brz                             __BITSHIFT2_PUT_0
add                             r4,r2,r4
__BITSHIFT2_PUT_0
add                             r2,r2,r2
add                             r3,r3,r3
brnp                            __BITSHIFT2_LOOP

add                             r1,r4,0
ld                              r2,MISC_SAVE_R2
ld                              r3,MISC_SAVE_R3
ld                              r4,MISC_SAVE_R4
ld                              r5,MISC_SAVE_R5
ret



MISC_SAVE_R0               .BLKW   1
MISC_SAVE_R1               .BLKW   1
MISC_SAVE_R2               .BLKW   1
MISC_SAVE_R3               .BLKW   1
MISC_SAVE_R4               .BLKW   1
MISC_SAVE_R5               .BLKW   1
MISC_SAVE_R6               .BLKW   1
MISC_SAVE_R7               .BLKW   1
