; Definase un sprite como la siguiente estructura
; ancho::int, alto::int, imagen::{row::{pixel}}
;   ---------------------------------------
; Definase un pixel como la sifuente estructura
; invisible::1b, rojo::5b, verde::5b, azul::5b


; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
RENDER
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
st                              r7,_RET_SAVE_PRINT
add                             r1,r4,0
st                              r3,ANCHO_PRINTEANDO
and                             r4,r4,0

add                             r6,r1,0
ld                              r1,PANTALLA
not                             r1,r1
add                             r1,r1,1
add                             r1,r1,r5
jsr                             BITSHIFT2_RIGHT
ld                              r0,BACKGROUND_IMAGE
add                             r0,r0,r1
add                             r1,r6,0

jsr                             DESCOMPRIMIR_PIXEL

and                             r4,r5,00011

_PRINT_LINE_BKGR
ld                             r2,ANCHO_PRINTEANDO
_PRINT_PIXEL_BKGR
add                             r4,r4,0
brnp                            __TODAVIA_HAY_BKGR
jsr                             DESCOMPRIMIR_PIXEL
add                             r0,r0,1
__TODAVIA_HAY_BKGR
ldr                             r6,r3,0
str                             r6,r5,0
add                             r5,r5,1     ; Aumenta en uno la posicion escritura
add                             r3,r3,1     ; Aumenta en uno la posicion de la matriz auxiliar
add                             r4,r4,-1    ; Disminuye el contador de la matriz auxiliar
add                             r2,r2,-1    ; Disminuye el contador de la fila
BRp                             _PRINT_PIXEL_BKGR

ld                              r6,ANCHO_PRINTEANDO
not                             r6,r6
add                             r6,r6,1
add                             r5,r5,r6
add                             r0,r0,r6
ld                              r6,ANCHO
add                             r5,r5,r6

add                             r6,r1,0
ld                              r1,PANTALLA
not                             r1,r1
add                             r1,r1,1
add                             r1,r1,r5
jsr                             BITSHIFT2_RIGHT
ld                              r0,BACKGROUND_IMAGE
add                             r0,r0,r1
add                             r1,r6,0

jsr                             DESCOMPRIMIR_PIXEL

and                             r4,r5,00011

add                             r1,r1,-1
BRp                             _PRINT_LINE_BKGR
ld                              r7,_RET_SAVE_PRINT
ret


RENDER_BACKGROUND
st                              r0,SPRITE_SAVE_R0
st                              r1,SPRITE_SAVE_R1
st                              r2,SPRITE_SAVE_R2
st                              r3,SPRITE_SAVE_R3
st                              r4,SPRITE_SAVE_R4
st                              r5,SPRITE_SAVE_R5
st                              r6,SPRITE_SAVE_R6
st                              r7,SPRITE_SAVE_R7

ld                              r1,CANT_PIXELES
and                             r4,r4,0
ld                              r0,BACKGROUND_IMAGE
ld                              r5,PANTALLA
__RENDER_BKGR_LOOP
add                             r4,r4,0
brp                             __QUEDAN
jsr                             DESCOMPRIMIR_PIXEL
add                             r0,r0,1
__QUEDAN
ldr                             r2,r3,0
str                             r2,r5,0
add                             r5,r5,1
add                             r4,r4,-1
add                             r1,r1,-1
brp                             __RENDER_BKGR_LOOP

ld                              r0,SPRITE_SAVE_R0
ld                              r1,SPRITE_SAVE_R1
ld                              r2,SPRITE_SAVE_R2
ld                              r3,SPRITE_SAVE_R3
ld                              r4,SPRITE_SAVE_R4
ld                              r5,SPRITE_SAVE_R5
ld                              r6,SPRITE_SAVE_R6
ld                              r7,SPRITE_SAVE_R7

ret



CUATRO_PIXELES          .BLKW   4
ANCHO_PRINTEANDO        .BLKW   1
; Toma la dreccion de la imagen a printear (r0)
; Toma el ancho de un sprite (r3)
; Toma el alto de un sprite (r4)
; Toma la direccion donde empezar a escribir (r5)
PRINT_IMAGE
st                              r7,_RET_SAVE_PRINT
add                             r1,r4,0
st                              r3,ANCHO_PRINTEANDO
and                             r4,r4,0

_PRINT_LINE
ld                             r2,ANCHO_PRINTEANDO
_PRINT_PIXEL
add                             r4,r4,0
brnp                            __TODAVIA_HAY
jsr                             DESCOMPRIMIR_PIXEL
add                             r0,r0,1
__TODAVIA_HAY
ldr                             r6,r3,0
brn                             __SKIP_INVISIBLE
str                             r6,r5,0
__SKIP_INVISIBLE
add                             r5,r5,1     ; Aumenta en uno la posicion escritura
add                             r3,r3,1     ; Aumenta en uno la posicion de la matriz auxiliar
add                             r4,r4,-1    ; Disminuye el contador de la matriz auxiliar
add                             r2,r2,-1    ; Disminuye el contador de la fila
BRp                             _PRINT_PIXEL

ld                              r6,ANCHO_PRINTEANDO
not                             r6,r6
add                             r6,r6,1
add                             r5,r5,r6
ld                              r6,ANCHO
add                             r5,r5,r6
add                             r1,r1,-1
BRp                             _PRINT_LINE
ld                              r7,_RET_SAVE_PRINT
ret    

DESCMPR_PIXEL_RET          .BLKW   1
DESCOMPRIMIR_PIXEL
st                              r7,DESCMPR_PIXEL_RET
lea                             r7,MATRIZ_COLORES
lea                             r3,CUATRO_PIXELES
ldr                             r4,r0,0

; Primer Color
and                             r6,r4,b01111
add                             r6,r7,r6
ldr                             r6,r6,0
str                             r6,r3,3

add                             r6,r1,0
add                             r1,r4,0
jsr                             BITSHIFT4_RIGHT
lea                             r7,MATRIZ_COLORES
add                             r4,r1,0
add                             r1,r6,0

; Segundo Color
and                             r6,r4,b01111
add                             r6,r7,r6
ldr                             r6,r6,0
str                             r6,r3,2

add                             r6,r1,0
add                             r1,r4,0
jsr                             BITSHIFT4_RIGHT
lea                             r7,MATRIZ_COLORES
add                             r4,r1,0
add                             r1,r6,0

; Tercer Color
and                             r6,r4,b01111
add                             r6,r7,r6
ldr                             r6,r6,0
str                             r6,r3,1

add                             r6,r1,0
add                             r1,r4,0
jsr                             BITSHIFT4_RIGHT
lea                             r7,MATRIZ_COLORES
add                             r4,r1,0
add                             r1,r6,0

; Cuarto Color
and                             r6,r4,b01111
add                             r6,r7,r6
ldr                             r6,r6,0
str                             r6,r3,0

and                             r4,r4,0
add                             r4,r4,4
ld                              r7,DESCMPR_PIXEL_RET
ret

; Return guardado
_RET_SAVE_PRINT         .BLKW   1 

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

MATRIZ_COLORES          .FILL   x8000   ; Invisible
                        .FILL   x7800   ; Rojo
                        .FILL   x7C00   ; Bordo
                        .FILL   x7DE0   ; Naranja
                        .FILL   x7FE0   ; Amarillo
                        .FILL   x03E0   ; Verde
                        .FILL   x001F   ; Azul
                        .FILL   x2DEF   ; Gris
                        .FILL   x1CFF   ; Celeste


PANTALLA                .FILL   xC000
ANCHO                   .FILL   128 
ALTO                    .FILL   124
CANT_PIXELES            .FILL   15872
BACKGROUND_IMAGE        .FILL   __BACKGROUND_SPRITE
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