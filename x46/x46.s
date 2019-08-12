
; PRG BASIC start

ov = $39 ; BASIC line number, low byte, is copied here
ct = $D5 ; Maximum length of logical screen line, 39 / $27

* = $0801
basic_start:
	.word +				; Pointer to the next line
	.byte $40			; Line number low byte, abused to store the ov init value
	.byte $00			; Line number high byte, unused for the moment
	.text $9E, format("%d", start)	; "SYS<start>:"
+	;.word $0000			; End of BASIC program
	
	; Assuming all registers are zero
	
start:	; Set the border and background black ; 6
	sta $D020
	sta $D021
	
loop:	; Set the blocks ; 8
	lda #$A0
p1:	sta $07C0
p2:	sta $07C0 + 39
	
	; Advance X positions ; 6
	inc p1 + 1
	dec p2 + 1
	
	; Test if we're finished ; 4
	dec ct
	bmi *	; Finished
	
	; Test if we need to advance the Y position ; 6
	;clc
	adc ov
	sta ov
	bcc loop
	
	; Advance to the next line ; 4
	jsr $E8EA
	beq loop

