;================================================================================
; Spawn Zelda (or not)
;--------------------------------------------------------------------------------
SpawnZelda:
	LDA.l $7EF3CC : CMP #$08 : BEQ + ; don't spawn if dwarf is present
	CMP #$07 : BEQ + ; don't spawn if frog is present
	CMP #$0C : BEQ + ; don't spawn if purple chest is present
		CLC : RTL
	+
	SEC
RTL
;--------------------------------------------------------------------------------
!NMI_TIME = "$7EF43E"
!ESCAPE_TIME = "$7EF498"
;--------------------------------------------------------------------------------
EndRainState:
	LDA $7EF3C5 : CMP.b #$02 : !BGE + ; skip if past escape already
		LDA.b #$00 : STA !INFINITE_ARROWS : STA !INFINITE_BOMBS : STA !INFINITE_MAGIC
		LDA.b #$02 : STA $7EF3C5 ; end rain state

		; timestamp completing escape -- we don't bother checking if already set
		; because logically this can only occur once in any given playthrough
		REP #$20 ; set 16-bit accumulator
		LDA !NMI_TIME : STA !ESCAPE_TIME
		LDA !NMI_TIME+2 : STA !ESCAPE_TIME+2
		SEP #$20 ; set 8-bit accumulator
	+
RTL
;--------------------------------------------------------------------------------
