.ORIG                       x3000

; Definase un sprite como la siguiente estructura
; ancho::int, alto::int, imagen::{row::{pixel}}
;   ---------------------------------------
; Definase un pixel como la sifuente estructura
; invisible::1b, rojo::5b, verde::5b, azul::5b

lea                         r0,HAMMER_SICKLE
ld                          r1,POS_X
ld                          r2,POS_Y
ld                          r3,HAMMER_SICKLE_C


; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma el offset de color (r3)
RENDER
BRnzp                       SAVE
SAVE_RET
st                          r3,COLOR
ldr                         r3,r0,0
ldr                         r4,r0,1
jsr                         CHECK
ld                          r5,PANTALLA
jsr                         GET_START_PIXEL
add                         r0,r0,2
jsr                         PRINT_IMAGE
BRnzp                       LOAD
LOAD_RET
HALT

; Offset de color
COLOR              .BLKW    1


; Toma la dreccion de la imagen a printear (r0)
; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
; Toma la direccion donde empezar a escribir (r5)
; Return guardado
_RET_SAVE_PRINT    .BLKW    1 
PRINT_IMAGE
st                          r7,_RET_SAVE_PRINT
ld                          r7,COLOR
add                         r1,r4,0

_PRINT_LINE
add                         r2,r3,0
_PRINT_PIXEL
ldr                         r6,r0,0
BRn                         _SKIP_INVISIBLE
add                         r6,r6,r7
str                         r6,r5,0
_SKIP_INVISIBLE
add                         r0,r0,1
add                         r5,r5,1
add                         r2,r2,-1
BRp                         _PRINT_PIXEL

not                         r6,r3
add                         r6,r6,1
add                         r5,r5,r6
ld                          r6,ANCHO
add                         r5,r5,r6
add                         r1,r1,-1
BRp                         _PRINT_LINE
ld                          r7,_RET_SAVE_PRINT
ret                    

SAVE_Y        .BLKW         1
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma la direccion en memoria de la pantalla (r5)
; Devuelve la direccion en memoria del primer pixel del sprite (r5)
GET_START_PIXEL
st                          r2,SAVE_Y

ld                          r6,ANCHO
_ADD_Y
add                         r2,r2,-1
BRn                         _ADD_X
add                         r5,r5,r6
BRnzp                       _ADD_Y

_ADD_X
ld                          r2,SAVE_Y
add                         r5,r5,r1
ret


; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
CHECK
add                         r1,r1,0
BRn                         ERROR_NEGATIVE_POS
add                         r2,r2,0
BRn                         ERROR_NEGATIVE_POS
add                         r5,r1,r3
ld                          r6,ANCHO
not                         r6,r6
add                         r6,r6,1     ; Complemento a dos
add                         r5,r5,r6
BRp                         ERROR_OVERFLOW_POS
add                         r5,r2,r4
ld                          r6,ALTO
not                         r6,r6
add                         r6,r6,1     ; Complemento a dos
add                         r5,r5,r6
BRp                         ERROR_OVERFLOW_POS
ret


ERROR_NEGATIVE_POS
lea                         r0,NEGATIVE_POS
PUTS
HALT

ERROR_OVERFLOW_POS
lea                         r0,OVERFLOW_POS
PUTS
HALT

SAVE
lea                         r6,GUARDAR
str                         r0,r6,0
str                         r1,r6,1
str                         r2,r6,2
str                         r3,r6,3
str                         r4,r6,4
str                         r5,r6,5
str                         r6,r6,6
str                         r7,r6,7
BRnzp                       SAVE_RET

LOAD
lea                         r6,GUARDAR
ldr                         r0,r6,0
ldr                         r1,r6,1
ldr                         r2,r6,2
ldr                         r3,r6,3
ldr                         r4,r6,4
ldr                         r5,r6,5
ldr                         r6,r6,6
ldr                         r7,r6,7
BRnzp                       LOAD_RET

PANTALLA        .FILL       xC000
ANCHO           .FILL       128
ALTO            .FILL       124
GUARDAR         .BLKW       8
NEGATIVE_POS    .stRINGZ    "Sprite en posicion negativa"
OVERFLOW_POS    .stRINGZ    "Sprite se sale de la pantalla"

