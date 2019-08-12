
; PRG BASIC start

ov = $FB

* = $0801
basic_start:
	.word +				; Pointer to the next line
	.word 10			; Line 10
	.null $9E, format("%d", _start)	; SYS "<start>" "\0"
+	.word $0000                     ; End of BASIC program

_start:
	jsr $FF81	; Clear the screen
	
	; Setup overflow variable
	lda #(10 - 40 + 256)
	sta ov
	
	; Set initial X positions for both lines
	dex ; ldx #0
	ldy #39
	
	; Black background and border
	stx $D020
	stx $D021
	
	; Draw points
-	lda #$A0
p1	sta $0400, x
p2	sta $0400, y
	
	; Advance X positions
	inx
	dey
	
	; If second X goes negative, we're done!
	bmi *	; Finished
	
	; Test if we need to advance the Y position
+	;clc
	lda ov
	adc #25
	sta ov
	bcc -
	
	; Keep ov < 0
	;sec
	;lda ov
	sbc #40
	sta ov
	
	; Advance to the next line
	;clc
	lda p1 + 1
	adc #40
	sta p1 + 1
	sta p2 + 1
	bcc -
	inc p1 + 2
	inc p2 + 2
	
	bcs -

