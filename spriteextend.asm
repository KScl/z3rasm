;==============================================================================
; Hook into vanilla table loading routine
;------------------------------------------------------------------------------
; uses free space in bank 0 to stay in bank
; to hopefully minimize any possible performance penalty of this code
; on the average case where vanilla assets are being loaded
pushpc
org $00e7b2 ; (LDA $d033, Y : STA $ca)
JMP.w CheckExtendSpriteTable

org $00cf46 ; Unused space filled with FF in vanilla.
dw $FFFF, $FFFF, $FFFF, $FFFF, $FFFF ; vanilla glitch compatibility?
CheckExtendSpriteTable:
{
	; 8 bit A + XY
	CPY #$7F : !BGE + ; If not extended...
		LDA $d033, Y : STA $ca ; bank number
		LDA $d112, Y : STA $c9 ; high byte
		LDA $d1f1, Y : STA $c8 ; low byte
		JMP.w $e7de ; continue where the old function left off
	+
	PHB : LDA.b #ESPTableBank>>16 : PHA : PLB ; set data bank to extend sprite table bank
	TYA : !SUB.b #$80 : TAY
	LDA.w ESPTableBank, Y : STA $ca ; bank number
	LDA.w ESPTableHigh, Y : STA $c9 ; high byte
	LDA.w ESPTableLow, Y  : STA $c8 ; low byte
	PLB ; restore data bank
	JMP.w $e7de
}
warnpc $00cfc0
;==============================================================================
; Overwrite vanilla sprite palette determination
;------------------------------------------------------------------------------
org $00e67c : Convert3BPPTo4BPPLow:
org $00e5ef : Convert3BPPTo4BPPHigh:

org $00e5d0
	; 16 bit A, 8 bit X
	SEP #$20 ; set 8-bit A
	PHB : LDA.b #HiPalFlag>>16 : PHA : PLB ; set data bank to flag table bank
	LDA.w HiPalFlag, X : BNE +
	PLB : REP #$20 : JMP.w Convert3BPPTo4BPPLow : +
	PLB : REP #$20 : JMP.w Convert3BPPTo4BPPHigh
warnpc $00e5ef
;------------------------------------------------------------------------------
pullpc
;==============================================================================
; Extend sprite table
;------------------------------------------------------------------------------
; index: Index of sprite sheet to use
;         - <= $6B to overwrite vanilla sheets
;         - >= $80 to write to new extend sheets
; label: location of sprite sheet to decompress
;------------------------------------------------------------------------------
macro spritesheet_fromlabel(index, label)
	pushpc
	if <index> <= $6B ; Replace vanilla sprite tables
		org $d033+<index> : db <label>>>16
		org $d112+<index> : db <label>>>8
		org $d1f1+<index> : db <label>
	elseif <index> >= $80 ; Extend sprite table
		org ESPTableBank+<index>-$80 : db <label>>>16
		org ESPTableHigh+<index>-$80 : db <label>>>8
		org ESPTableLow+<index>-$80  : db <label>
	else ; Space inbetween the two
		error "Invalid sprite bank <index> for <label>"
	endif
	pullpc
endmacro
;------------------------------------------------------------------------------
; Same as above, but takes a filename instead of a label
; and automatically imports
;------------------------------------------------------------------------------
macro spritesheet(index, filename)
	!ESPIDX #= <index>
	#ESPEntry!ESPIDX : incbin <filename>
	%spritesheet_fromlabel(<index>, ESPEntry!ESPIDX)
endmacro
;------------------------------------------------------------------------------
; Sets the given sprite sheet to use the upper 8 palette entries instead of
; the lower 8 palette entries by default. Usually used by items.
;------------------------------------------------------------------------------
macro spritesheet_hipal(index)
	pushpc
	org HiPalFlag+<index> : db 1
	pullpc
endmacro
;------------------------------------------------------------------------------
ESPTableBank:  fillbyte $00 : fill $80
ESPTableHigh:  fillbyte $FF : fill $80
ESPTableLow:   fillbyte $FF : fill $80
ESPReserved:   fillbyte $FF : fill $80
;------------------------------------------------------------------------------
HiPalFlag:     fillbyte $00 : fill $100
; vanilla hi palette entries
%spritesheet_hipal($52)
%spritesheet_hipal($53)
%spritesheet_hipal($5A)
%spritesheet_hipal($5B)
%spritesheet_hipal($5C)
%spritesheet_hipal($5E)
%spritesheet_hipal($5F)
;------------------------------------------------------------------------------
