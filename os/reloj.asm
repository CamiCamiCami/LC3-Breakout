		.ORIG		x3000
		ld		r7,reloj
		ld		r6,inter

__loop		ldr		r0,r7,0
		brn		__exit
		brnzp		__loop


__exit
		HALT


reloj	.FILL	xFE08
inter	.FILL	xFE0A
