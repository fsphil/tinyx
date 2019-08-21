
; Set the load address such that the last two bytes of the program
; are written to the BASIC idle vector at $0302
* = $0304 - (end - start)

start:	lda #$A0
	sta $D3E0 - 1, x
	sta $07C0 + 39 - $FA, y
	sta $07C0 - 1, x
	iny
	dex
	beq *
	jsr $B699
	bcc start
	jsr $AAD7
	jmp start
end:

