;================================================================================
; Credits Statistics
;--------------------------------------------------------------------------------
;(address, type, shiftRight, bits, digits, xPos, lineNumber)
%AddStat($7EF458, 1, 0, 32, 4, !STAT_TIME_X,       !FOUND_SWORD_LINE)
%AddStat($7EF45C, 1, 0, 32, 4, !STAT_TIME_X,       !FOUND_BOOTS_LINE)
%AddStat($7EF460, 1, 0, 32, 4, !STAT_TIME_X,       !FOUND_FLUTE_LINE)
%AddStat($7EF464, 1, 0, 32, 4, !STAT_TIME_X,       !FOUND_MIRROR_LINE)
%AddStat($7EF452, 0, 4, 04, 2, !STAT_WITH_TOTAL_X, !BOSSES_SWORD_0_LINE)
%AddStat($7EF425, 0, 4, 04, 2, !STAT_WITH_TOTAL_X, !BOSSES_SWORD_1_LINE)
%AddStat($7EF425, 0, 0, 04, 2, !STAT_WITH_TOTAL_X, !BOSSES_SWORD_2_LINE)
%AddStat($7EF426, 0, 4, 04, 2, !STAT_WITH_TOTAL_X, !BOSSES_SWORD_3_LINE)
%AddStat($7EF426, 0, 0, 04, 2, !STAT_WITH_TOTAL_X, !BOSSES_SWORD_4_LINE)
%AddStat($7EF46D, 0, 0, 08, 3, !STAT_OTHER_X,      !CHEST_TURNS_LINE)
%AddStat($7EF420, 0, 0, 08, 3, !STAT_OTHER_X,      !BOOTS_BONKS_LINE)
%AddStat($7EF46E, 0, 0, 08, 2, !STAT_OTHER_X,      !MIRROR_BONKS_LINE)
%AddStat($7EF42D, 0, 0, 08, 2, !STAT_OTHER_X,      !SAVE_QUITS_LINE)
%AddStat($7EF449, 0, 0, 08, 2, !STAT_OTHER_X,      !DEATHS_LINE)
%AddStat($7EF453, 0, 0, 08, 3, !STAT_OTHER_X,      !REVIVES_LINE)
%AddStat($7EF444, 1, 8, 32, 4, !STAT_TIME_X,       !MENU_TIME_LINE)
%AddStat($7F5038, 1, 0, 32, 4, !STAT_TIME_X,       !LAG_TIME_LINE)

; Shouldn't ever change these
%AddStat($7EF423, 0, 0, 10, 3, !TOTAL_CHECKS_X,    !TOTAL_CHECKS_LINE)
%AddStat($7EF43E, 1, 0, 32, 4, !TOTAL_TIME_X,      !TOTAL_TIME_LINE)

; Padding for extra stats
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Extra stat 1 ($23F898)
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Extra stat 2 ($23F8A0)
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Extra stat 3 ($23F8A8)

; Terminator
dw $FFFF
;--------------------------------------------------------------------------------
