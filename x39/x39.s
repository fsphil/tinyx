
ov = $22 ; == $40, initial value for the overflow counter
pt = $39 ; == $D020, border colour ptr, copied from the BASIC line number
ct = $D5 ; == $27 / 39, number of passes. Decrementing, finished at -1

* = $0802

basic_start:
	.byte $01	; High byte of the pointer to the next line
	.word $D020	; Line number, abused to store border colour pointer
	.text $9E, format("%d", start + 1),$FE	; "SYS<start>"

start:
scroll:	jsr $E8EA
	
loop:	ldy ct
	
	; Set the border and background black ; 6
	;
	; Assumes A and Y are zero on the first pass
	
	lda #$A0
	sta (pt), y
	
	; Print the block characters on row 24 ; 8
	;lda #$A0
p1:	sta $07C0
p2:	sta $07C0, y
	
	; Advance X positions ; 6
	
	inc p1 + 1
	;dec ct
	
	; Test if we're finished ; 4
	;bmi *	; Infinite loop when finished
	
	; Test if we need to scroll ; 6
	;
	; By a happy coincidence, the value to be added
	; to *ov is the block character $A0 already in A
	
	;clc
	adc ov
	sta ov
	
	dec ct
	bcc loop
	
	; Scroll the screen up one line ; 4
	bcs scroll - 2

