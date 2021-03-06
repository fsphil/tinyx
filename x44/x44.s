
ov = $22 ; == $40
pt = $39
ct = $D5 ; Maximum length of logical screen line, 39 / $27

* = $0802
basic_start:
	.byte $01	; Pointer to the next line (not really)
	.word $D020	; Line number low byte, abused to store border colour address
	.text $9E, format("%d", start)	; "SYS<start>", no terminator
	;.word $0000	; End of BASIC program, not used
	
start:	; Set the border and background black ; 6
	;
	; Assumes A and Y are zero
	
	sta (pt), y
	sta $D021
	
loop:	; Print the block characters on row 24 ; 8
	
	lda #$A0
p1:	sta $07C0
p2:	sta $07C0 + 39
	
	; Advance X positions ; 6
	
	inc p1 + 1
	dec p2 + 1
	
	; Test if we're finished ; 4
	
	dec ct
	bmi *	; Infinite loop when finished
	
	; Test if we need to scroll ; 6
	;
	; By a happy coincidence, the value to be added
	; to *ov is the block character $A0 already in A
	
	;clc
	adc ov
	sta ov
	bcc loop
	
	; Scroll the screen up one line ; 4
	
	jsr $E8EA
	beq loop

