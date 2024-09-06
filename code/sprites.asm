; Definase un sprite como la siguiente estructura
; ancho::int, alto::int, imagen::{row::{pixel}}
;   ---------------------------------------
; Definase un pixel como la sifuente estructura
; invisible::1b, rojo::5b, verde::5b, azul::5b

; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
RENDER
st                              r3,SPECIAL_R3_SAVE_SPRT
st                              r7,SPECIAL_R7_SAVE_SPRT

and                             r3,r3,0
jsr                             RENDER_COLOR

ld                              r3,SPECIAL_R3_SAVE_SPRT
ld                              r7,SPECIAL_R7_SAVE_SPRT
ret

SPECIAL_R3_SAVE_SPRT    .BLKW   1
SPECIAL_R7_SAVE_SPRT    .BLKW   1


; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma el offset de color (r3)
RENDER_COLOR
st                              r0,SPRITE_SAVE_R0
st                              r1,SPRITE_SAVE_R1
st                              r2,SPRITE_SAVE_R2
st                              r3,SPRITE_SAVE_R3
st                              r4,SPRITE_SAVE_R4
st                              r5,SPRITE_SAVE_R5
st                              r6,SPRITE_SAVE_R6
st                              r7,SPRITE_SAVE_R7

st                              r3,COLOR
ldr                             r3,r0,0
ldr                             r4,r0,1
jsr                             CHECK
ld                              r5,PANTALLA
jsr                             GET_START_PIXEL
add                             r0,r0,2
jsr                             PRINT_IMAGE

ld                              r0,SPRITE_SAVE_R0
ld                              r1,SPRITE_SAVE_R1
ld                              r2,SPRITE_SAVE_R2
ld                              r3,SPRITE_SAVE_R3
ld                              r4,SPRITE_SAVE_R4
ld                              r5,SPRITE_SAVE_R5
ld                              r6,SPRITE_SAVE_R6
ld                              r7,SPRITE_SAVE_R7

ret


; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
UNRENDER
st                              r0,SPRITE_SAVE_R0
st                              r1,SPRITE_SAVE_R1
st                              r2,SPRITE_SAVE_R2
st                              r3,SPRITE_SAVE_R3
st                              r4,SPRITE_SAVE_R4
st                              r5,SPRITE_SAVE_R5
st                              r6,SPRITE_SAVE_R6
st                              r7,SPRITE_SAVE_R7

ldr                             r3,r0,0
ldr                             r4,r0,1
jsr                             CHECK
ld                              r5,PANTALLA
jsr                             GET_START_PIXEL
add                             r0,r0,2
jsr                             PRINT_BACKGROUND

ld                              r0,SPRITE_SAVE_R0
ld                              r1,SPRITE_SAVE_R1
ld                              r2,SPRITE_SAVE_R2
ld                              r3,SPRITE_SAVE_R3
ld                              r4,SPRITE_SAVE_R4
ld                              r5,SPRITE_SAVE_R5
ld                              r6,SPRITE_SAVE_R6
ld                              r7,SPRITE_SAVE_R7

ret


; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
; Toma la direccion donde empezar a escribir (r5)
PRINT_BACKGROUND
add                             r1,r4,0

_BCKG_PRINT_LINE
add                             r2,r3,0
and                             r6,r6,0
_BCKG_PRINT_PIXEL
str                             r6,r5,0
add                             r5,r5,1
add                             r2,r2,-1
BRp                             _BCKG_PRINT_PIXEL

not                             r6,r3
add                             r6,r6,1
add                             r5,r5,r6
ld                              r6,ANCHO
add                             r5,r5,r6
add                             r1,r1,-1
BRp                             _BCKG_PRINT_LINE
ret    

; Offset de color
COLOR                   .BLKW   1

; Toma la dreccion de la imagen a printear (r0)
; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
; Toma la direccion donde empezar a escribir (r5)
PRINT_IMAGE
st                              r7,_RET_SAVE_PRINT
ld                              r7,COLOR
add                             r1,r4,0

_PRINT_LINE
add                             r2,r3,0
_PRINT_PIXEL
ldr                             r6,r0,0
BRn                             _SKIP_INVISIBLE
add                             r6,r6,r7
str                             r6,r5,0
_SKIP_INVISIBLE
add                             r0,r0,1
add                             r5,r5,1
add                             r2,r2,-1
BRp                             _PRINT_PIXEL

not                             r6,r3
add                             r6,r6,1
add                             r5,r5,r6
ld                              r6,ANCHO
add                             r5,r5,r6
add                             r1,r1,-1
BRp                             _PRINT_LINE
ld                              r7,_RET_SAVE_PRINT
ret    

; Return guardado
_RET_SAVE_PRINT    .BLKW        1 

SAVE_Y                  .BLKW   1
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma la direccion en memoria de la pantalla (r5)
; Devuelve la direccion en memoria del primer pixel del sprite (r5)
GET_START_PIXEL
st                              r2,SAVE_Y

ld                              r6,ANCHO
_ADD_Y
add                             r2,r2,-1
BRn                             _ADD_X
add                             r5,r5,r6
BRnzp                           _ADD_Y

_ADD_X
ld                              r2,SAVE_Y
add                             r5,r5,r1
ret


; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
CHECK
add                             r1,r1,0
BRn                             ERROR_NEGATIVE_POS
add                             r2,r2,0
BRn                             ERROR_NEGATIVE_POS
add                             r5,r1,r3
ld                              r6,ANCHO
not                             r6,r6
add                             r6,r6,1     ; Complemento a dos
add                             r5,r5,r6
BRp                             ERROR_OVERFLOW_POS
add                             r5,r2,r4
ld                              r6,ALTO
not                             r6,r6
add                             r6,r6,1     ; Complemento a dos
add                             r5,r5,r6
BRp                             ERROR_OVERFLOW_POS
ret


ERROR_NEGATIVE_POS
lea                             r0,NEGATIVE_POS
PUTS
HALT

ERROR_OVERFLOW_POS
lea                             r0,OVERFLOW_POS
PUTS
HALT

PANTALLA                .FILL   xC000
ANCHO                   .FILL   128 
ALTO                    .FILL   124
SPRITE_SAVE_R0          .BLKW   1
SPRITE_SAVE_R1          .BLKW   1
SPRITE_SAVE_R2          .BLKW   1
SPRITE_SAVE_R3          .BLKW   1
SPRITE_SAVE_R4          .BLKW   1
SPRITE_SAVE_R5          .BLKW   1
SPRITE_SAVE_R6          .BLKW   1
SPRITE_SAVE_R7          .BLKW   1

NEGATIVE_POS            .stRINGZ    "Sprite en posicion negativa"
OVERFLOW_POS            .stRINGZ    "Sprite se sale de la pantalla"

