; Definase un sprite como la siguiente estructura
; width::8bit, heigth::8bit, sprite::{row::{pixel::int}}


; Toma la direccion en memoria de un sprite (r0)
; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
RENDER
BRnzp                       SAVE
SAVE_RET

jsr                         CHECK



START


; Toma la posicion x de la esquina superior izquierda (r1)
; Toma la posicion y de la esquina superior izquierda (r2)
; Toma el largo de un sprite (r3)
; Toma el alto de un sprite (r4)
CHECK
add                         r1,r1,0
BRn                         ERROR_NEGATIVE_POS
add                         r2,r2,0
BRn                         ERROR_NEGATIVE_POS
add                         r5,r1,r3
add                         r5,r5,-128
BRzp                        ERROR_OVERFLOW_POS
add                         r5,r2,r4
add                         r5,r5,-128
BRzp                        ERROR_OVERFLOW_POS
ret


ERROR_NEGATIVE_POS
LEA                         r0,NEGATIVE_POS
PUTS
HALT

ERROR_OVERFLOW_POS
LEA                         r0,OVERFLOW_POS
PUTS
HALT

SAVE
ST                          r3,GUARDAR
ST                          r4,GUARDAR+1
ST                          r5,GUARDAR+2
ST                          r6,GUARDAR+3
ST                          r7,GUARDAR+4
BRnzp                       SAVE_RET

LOAD
LD                          r3,GUARDAR
LD                          r4,GUARDAR+1
LD                          r5,GUARDAR+2
LD                          r6,GUARDAR+3
LD                          r7,GUARDAR+4

PANTALLA        .FILL       xC000
LARGO           .FILL       128
GUARDAR         .BLKW       5
NEGATIVE_POS    .STRINGZ    "Sprite en posicion negativa"
OVERFLOW_POS    .STRINGZ    "Sprite se sale de la pantalla"