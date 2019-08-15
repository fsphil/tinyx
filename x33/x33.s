
ov = $90 ; == $40, initial value for the overflow counter
ct = $D5 ; == $27 / 39, number of passes. Decrementing, finished at -1
lp = $D1 ; == $07C0, pointer to bottom line. Set by the kernal scroller

; Set the load address such that the last two bytes of the program
; are written to the BASIC warm start vector.
* = $0302 - (end - scroll)

scroll:	jsr $E8EA	; Kernal scroll up, also sets lp pointer to $07C0
loop:	ldy ct		; Load the decrementing counter into Y (39 > -1)
	lda #$A0	; Load the PETSCII block / black col / ov step value
	sta $D020, y	; On the last two passes, sets the background black
	sta (lp), y	; Draw block (right > left line)
p1:	sta $07C0	; Draw block (left > right line)
	inc p1 + 1	; Increment pointer for the left > right line
	adc ov		; Add step value $A0 to ov
	sta ov
	dec ct		; Decrement the Y counter
	bmi *		; If it goes negative, we're finished
	bcc loop	; Repeat. If ov didn't overflow, don't scroll
	jmp scroll	; Repeat. If ov overflowed, scroll. The address of
			; this JMP is at $0302, the BASIC warm start vector
end:

