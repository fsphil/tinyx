
; This is a slightly modified version of Petri Häkkinen's 31 byte version.
; Uses the kernal newline function to save two bytes.

ov = $0D ; == $FF, initial value for the overflow counter

; Set the load address such that the last two bytes of the program
; are written to the BASIC idle vector.
* = $0304 - (end - scroll)

scroll:	jsr $AAD7
loop:	lda #$A0
	sta $D3E0 - $80, x
	sta $0400 + 40*24 + 39 - $80 + 1, y
	sta $0400 + 40*24 - $7B - 1, x
	adc ov
	sta ov
	dex
	iny
	bmi *
	bcc loop
	jmp scroll
end:

