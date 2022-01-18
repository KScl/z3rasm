pushpc

; -----------------------------------------------------------------------------
; Overwrite old function for drawing a segment of a character
; -----------------------------------------------------------------------------
org $0ef482
RenderCharOverlap:
{
	SEP #$20                                ; 8-bit mode
	LDA #$0F : STA $0f                      ; Loop counter

	REP #$21                              ; 16-bit mode, carry clear
	LDA $1ce6 : AND #$0007 : BEQ .noshift ; Get offset amount; if zero, go into shorter loop

	; Loop for shifting required
	EOR #$0007                  ; We want the inverse of the offset amount, for how many instructions to skip
	ADC #.shift_slide : STA $00 ; Store jump pointer
	SEP #$20                    ; 8-bit mode
	--
		LDA [$04], Y   ; Grab segment
		BEQ +          ; Short circuit if empty
		XBA : LDA #$00 ; Set up accumulator for shift

		; Move segment into position between tiles
		REP #$20              ; 16-bit mode
		JMP ($0000)           ; Relative jump to the pointer we set up earlier
		.shift_slide : LSR #7 ; Slide down shift rights to get into position

		; Write segment to buffer
		SEP #$20                              ; 8-bit mode
		ORA $7F0010, X : STA $7F0010, X : XBA ; Draw right 8x8 tile
		ORA $7F0000, X : STA $7F0000, X       ; Draw left 8x8 tile

		+ : INX : INY : DEC $0f
	BPL --
	REP #$30 : RTS

	; Loop for no shifting
	.noshift
	SEP #$20 ; 8-bit mode
	--
		LDA [$04], Y                    ; Grab segment
		BEQ +                           ; Short circuit if empty
		ORA $7F0000, X : STA $7F0000, X ; Draw left 8x8 tile

		+ : INX : INY : DEC $0f
	BPL --
	REP #$30 : RTS
}
warnpc $ef4fa ; End location of original function
; -----------------------------------------------------------------------------
org $0efd7c ; Render width table
    db $08, $01, $ff
; -----------------------------------------------------------------------------
; Patch jump-to-data out of text commands,
; replace with a command to erase part of the dialog window for cursor movement
; -----------------------------------------------------------------------------
org $0ef234
	dw RenderClearCursor
org $0efd80
RenderClearCursor:
{
	REP #$30
	LDA $1CF0 : AND #$00FF : CMP #$0003 : BPL +
	LDX #$02A0 : LDY #$0003 : BRA ++ ; Dialogs with other text (indented)
	+ : LDX #$0000 : LDY #$0005 : ++ ; Save&Quit dialogs, etc
	-
	LDA #$0000
	STA $7F0000, X : STA $7F0002, X : STA $7F0004, X : STA $7F0006, X
	STA $7F0008, X : STA $7F000A, X : STA $7F000C, X : STA $7F000E, X
	STA $7F0010, X : STA $7F0012, X : STA $7F0014, X : STA $7F0016, X
	STA $7F0018, X : STA $7F001A, X : STA $7F001C, X : STA $7F001E, X
	TXA : CLC : ADC #$0140 : TAX
	DEY : BPL -
    STZ $1CDD : INC $1CD9 : SEP #$30 : STZ $1CE6 ; Move text pointer
	RTS
}
warnpc $f0000
; -----------------------------------------------------------------------------
; Hook to make lowercase letters render, replacing kanji
; -----------------------------------------------------------------------------
org $0ef516
	jml RenderNewChar
org $0ef520
    RenderNewChar_returnOriginal:
org $0ef567
    RenderNewChar_returnUncompressed:
; -----------------------------------------------------------------------------
pullpc

RenderNewChar:
{
	AND #$01FF
	CMP #$0100 : !BGE +
	; Character from original font
	STA $0e : ASL : TAX : ASL : ADC $0e
	JML RenderNewChar_returnOriginal

	+ ; New lowercase font characters
	AND #$001F
	ASL : TAX
    PHB : PEA $3333 : PLB : PLB ; partially taken from SMZ3
    ASL #5 : TAY
    LDX #$00000 : -
    ; Buffer 11px wide. Last three pixels are storred flipped and rotated.
    ; To return to correct orientation: 90 degrees CCW, flip vertically.
    LDA.w LowercaseFont, y : STA.l $7EBFC0, x
    INX : INY : CPX #$002C : BNE - ; 2 planes, 22 rows
    PLB
    LDA #$00BD : STA $0e
    JML RenderNewChar_returnUncompressed
}