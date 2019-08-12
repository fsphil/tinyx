
ov = $22 ; == $40, initial value for the overflow counter
ct = $D5 ; == $27 / 39, number of passes. Decrementing, finished at -1

* = $01F8

	.word scroll - 1
scroll:	jsr $E8EA
loop:	ldy ct
	lda #$A0
	sta $D020, y
p1:	sta $07C0
	sta ($D1), y
	inc p1 + 1
	adc ov
	sta ov
	dec ct
	bmi *
	bcc loop
	bcs scroll

