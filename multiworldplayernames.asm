table textmaps/hud_font.map

;org $32DFD0	; PC 0x195FD0 -- 28 bytes
HUD_ReceivedFrom:
dw "RECEIVED FROM "

;org $32DFEC	; PC 0x195FEC -- 16 bytes
HUD_SentTo:
dw "SENT TO "

;org $32DFFC	; PC 0x195FFC
;--------------------------------------------------------------------------------
; Player names (32 bytes/player) - 255 players
;--------------------------------------------------------------------------------
!NM = 0
macro player_name()
	!NM #= !NM+1
	padword $007F
	?start : dw "PLAYER !NM" : pad ?start+$20
endmacro

PlayerNames:
rep 255 : %player_name()
