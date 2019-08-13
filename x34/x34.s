
ov = $22 ; == $40, initial value for the overflow counter
ct = $D5 ; == $27 / 39, number of passes. Decrementing, finished at -1
lp = $D1 ; == $07C0, pointer to bottom line. Set by the kernal scroller

	; Overwrite the return address of the kernal loader on the stack
	; with a pointer to our own code
	
	* = $01F8
	.word scroll - 1
	
scroll:	jsr $E8EA	; Kernal scroll up, also sets lp pointer to $07C0
loop:	ldy ct		; Load the decrementing counter into Y (39 > -1)
	lda #$A0	; Load the PETSCII block / black col / ov step value
	sta $D020, y	; On the last two passes, sets the background black
p1:	sta $07C0	; Draw first block (left > right line)
	sta (lp), y	; Draw second block (right > left line)
	inc p1 + 1	; Increment pointer for the left > right line
	adc ov		; Add step value $A0 to ov
	sta ov
	dec ct		; Decrement the Y counter
	bmi *		; If it goes negative, we're finished
	bcc loop	; Repeat. If ov didn't overflow, don't scroll
	bcs scroll	; Repeat. If ov overflowed, scroll

