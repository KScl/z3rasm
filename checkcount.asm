pushpc
org $0DEDE8 ; (LDA #$16F2 : STA $00)
JSL.l ShowCheckCounter : NOP
pullpc

!ITEM_TOTAL = "$7EF423"

ShowCheckCounter:
{
	PHX ; save things we're about to clobber

	; draw checkmark above checks
	LDA #$2826 : STA $16F6
	LDA !ITEM_TOTAL

	LDX #$2827
	CMP.w #100 : !BLT + : LDX #$2817 : !SUB.w #100
	CMP.w #100 : !BLT + : INX        : !SUB.w #100
	CMP.w #100 : !BLT + : INX        : !SUB.w #100 ; doubtful we'll ever go past 399 checks
	+ : STX $1734 ; hundredths digit

	ASL : TAX : LDA HudDigitTable, X : PHA ; needed twice, save so we can get it back
	AND #$000F : BNE + : LDA #$0011 : +
	!ADD.w #$2816 : STA $1736 ; tenths digit

	PLA : XBA ; get back what we fetched earlier, get the other byte there
	AND #$000F : BNE + : LDA #$0011 : +
	!ADD.w #$2816 : STA $1738 ; ones digit

	PLX ; restore what we clobbered

	; move heart piece display slightly to the left
	LDA #$16EE : STA $00 ; (almost) what we wrote over 
	RTL
}
