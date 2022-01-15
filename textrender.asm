pushpc

org $0efd7c ; Render width table
    db $08, $01, $ff

org $0ef234
	dw RenderClear
org $0efd80
RenderClear:
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

org $0ef516
	jml RenderNewChar
org $0ef520
    RenderNewChar_returnOriginal:
org $0ef567
    RenderNewChar_returnUncompressed:

org $0ef4b3
	jml RenderCharOverlap
org $0ef4f2
	RenderCharOverlap_return:

org $539000
LowercaseFont:
	incbin lowerfont.gfx

pullpc

RenderNewChar:
{
	AND #$01FF
	CMP #$0100 : !BGE +
	STA $0e : ASL : TAX : ASL : ADC $0e
	JML RenderNewChar_returnOriginal

	+ ; New lowercase font characters
	AND #$001F
	ASL : TAX
    PHB : PEA $5353 : PLB : PLB ; partially taken from SMZ3
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

RenderCharOverlap:
{
	SEP #$20
	BEQ + : -
	CLC : ROR $02 : ROR $03 ; Move segment into position between tiles
	DEY : BNE -
	+
	LDX $0b
	LDA $02 : ORA $7F0000, X : STA $7F0000, X
	LDA $03 : ORA $7F0010, X : STA $7F0010, X
	LDY $0d
	JML RenderCharOverlap_return
}

; $0ef2d7 : RenderSingleCharacter