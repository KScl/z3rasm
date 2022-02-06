;================================================================================
; Sprite Graphic Table : bbbbbbbb --yyxxxx
; b: Sprite graphics bank to use (00-6B, or >=80 for extend sprites)
; y: y coordinate of which 8x8 tile to use
;     - you probably want 0 or 2
; x: x coordinate of which 8x8 tile to use
;     - you probably want an even number unless you're doing narrow sprites
; e.g.: $28 cooresponds to $03C0 in the original table
;--------------------------------------------------------------------------------
; See also the beginning of newitems.asm for the graphic table itself.
;================================================================================
; New sprite tile loading code
;--------------------------------------------------------------------------------
org $00e7a6 : DecompressSpriteLow:
;--------------------------------------------------------------------------------
; $00d51b : GetAnimatedSpriteTile
; 8 bit A & X
; in:
;  - A: which item sprite should be rendered
;
; This function appears to just be used to animate rupees that are being held
; over the player's head / over a treasure chest. The decompression routines are
; not run again, it just sets up the pointers as if they were and jumps back
; into writing to the 4BPP buffer.
;
; We don't need to touch this function's code at all, we just need to update
; where it goes afterwards to match our rewritten function.
org $00d52b : BRA NewItemRender_PreDecompLanding
;--------------------------------------------------------------------------------
; $00d52d : GetAnimatedSpriteTile_variable
; 8 bit A & X
; in:
;  - A: which item sprite should be rendered
;  - !TILE_UPLOAD_OFFSET_OVERRIDE: If nonzero, where to render tile to in VRAM
;
; This function has been mostly rewritten as it was being hooked into from at
; least three different places already.
org $00d52d
NewItemRender:
{
	; Set data bank to current bank
	PHB : PHK : PLB

	; Get the sprite sheet that the item graphic will come from.
	; Vanilla code decompressed the chosen sheet high and forcibly decompressed
	; $5A low. We don't bother decompressing anything high and just decompress
	; our chosen sheet low as it's a complete waste of time when we're just
	; taking one 16x16 tile.
	ASL : TAX : PHX                     ; shift to get table offset, save the result
	LDA.l SpriteGraphicTable+1, X : TAY ; load sheet number from table
	JSR DecompressSpriteLow
	PLX

	; Get the position of the tile we want from the sheet that we just
	; decompressed, and add the location of the buffer to it.
	.getoffset
	REP #$31                                 ; set 16-bit A + X, clear carry
	LDA.l SpriteGraphicTable, X : AND #$003F ; get graphic offsets from table
	STA.b $0e : ASL : ADC.b $0e : ASL #3     ; multiply by $18
	ADC.b $00

	JSL.l LoadModifiedTileBufferAddress
	BRA .return ; Skip old code

	.PreDecompLanding
	PLA : ASL : TAX : BRA .getoffset

	padbyte $EA : pad $00d564 ; pad with NOPs to reach old code
	.return
}
warnpc $00d564
;--------------------------------------------------------------------------------
