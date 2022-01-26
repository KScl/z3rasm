;===================================================================================================

CreditsLineTable:
	fillword CreditsLineBlank : fill 800

;===================================================================================================

!CLINE = -1

;---------------------------------------------------------------------------------------------------

macro smallcredits(text, color)
	!CLINE #= !CLINE+1
	table "textmaps/credit_s_<color>.map"

	?line:
		db (32-(?end-?text))/2
		db 2*(?end-?text)-1
	?text:
		db "<text>"
	?end:

	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw ?line
	pullpc

endmacro

;---------------------------------------------------------------------------------------------------
macro bigcredits(text)
	!CLINE #= !CLINE+1
	table "textmaps/credit_b_hi.map"

	?line_top:
		db (32-(?end-?text))/2
		db 2*(?end-?text)-1
	?text:
		db "<text>"
	?end:

	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw ?line_top
	pullpc


	table "textmaps/credit_b_lo.map"
	?line_bottom:
		db (32-(?end-?text))/2
		db 2*(?end-?text)-1
		db "<text>"


	!CLINE #= !CLINE+1
	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw ?line_bottom
	pullpc

endmacro

;---------------------------------------------------------------------------------------------------

macro bigcreditsleft(text)
	!CLINE #= !CLINE+1
	table "textmaps/credit_b_hi.map"

	?line_top:
		db 2
		db 2*(?end-?text)-1
	?text:
		db "<text>"
	?end:

	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw ?line_top
	pullpc


	table "textmaps/credit_b_lo.map"
	?line_bottom:
		db 2
		db 2*(?end-?text)-1
		db "<text>"


	!CLINE #= !CLINE+1
	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw ?line_bottom
	pullpc

endmacro

;---------------------------------------------------------------------------------------------------

macro emptyline()
	!CLINE #= !CLINE+1
	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw CreditsEmptyLine
	pullpc
endmacro

macro blankline()
	!CLINE #= !CLINE+1
	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw CreditsLineBlank
	pullpc
endmacro

macro addarbline(l)
	!CLINE #= !CLINE+1
	pushpc
	org CreditsLineTable+!CLINE+!CLINE : dw <l>
	pullpc
endmacro

;===================================================================================================

CreditsEmptyLine:
	db $00, $01, $9F

CreditsLineBlank:
	db $FF

;---------------------------------------------------------------------------------------------------

%emptyline() ; Pretty sure this is required to be at the start. Don't touch.

%smallcredits("ORIGINAL GAME STAFF", "yellow")

%blankline()
%blankline()
%emptyline()

%smallcredits("EXECUTIVE PRODUCER", "green")

%blankline()

%bigcredits("HIROSHI YAMAUCHI")

%blankline()
%blankline()

%smallcredits("PRODUCER", "yellow")

%blankline()

%bigcredits("SHIGERU MIYAMOTO")

%blankline()
%blankline()

%smallcredits("DIRECTOR", "red")

%blankline()

%bigcredits("TAKASHI TEZUKA")

%blankline()
%blankline()

%smallcredits("SCRIPT WRITER", "green")

%blankline()

%bigcredits("KENSUKE TANABE")

%blankline()
%blankline()

%smallcredits("ASSISTANT DIRECTORS", "yellow")

%blankline()

%bigcredits("YASUHISA YAMAMURA")

%blankline()

%bigcredits("YOICHI YAMADA")

%blankline()
%blankline()

%smallcredits("SCREEN GRAPHICS DESIGNERS", "green")

%emptyline()
%emptyline()

%smallcredits("OBJECT DESIGNERS", "yellow")

%blankline()

%bigcredits("SOICHIRO TOMITA")

%blankline()

%bigcredits("TAKAYA IMAMURA")

%blankline()
%blankline()

%smallcredits("BACK GROUND DESIGNERS", "yellow")

%blankline()

%bigcredits("MASANAO ARIMOTO")

%blankline()

%bigcredits("TSUYOSHI WATANABE")

%blankline()
%blankline()

%smallcredits("PROGRAM DIRECTOR", "red")

%blankline()

%bigcredits("TOSHIHIKO NAKAGO")

%blankline()
%blankline()

%smallcredits("MAIN PROGRAMMER", "yellow")

%blankline()

%bigcredits("YASUNARI SOEJIMA")

%blankline()
%blankline()

%smallcredits("OBJECT PROGRAMMER", "green")

%blankline()

%bigcredits("KAZUAKI MORITA")

%blankline()
%blankline()

%smallcredits("PROGRAMMERS", "yellow")

%blankline()

%bigcredits("TATSUO NISHIYAMA")

%blankline()

%bigcredits("YUICHI YAMAMOTO")

%blankline()

%bigcredits("YOSHIHIRO NOMOTO")

%blankline()

%bigcredits("EIJI NOTO")

%blankline()

%bigcredits("SATORU TAKAHATA")

%blankline()

%bigcredits("TOSHIO IWAWAKI")

%blankline()

%bigcredits("SHIGEHIRO KASAMATSU")

%blankline()

%bigcredits("YASUNARI NISHIDA")

%blankline()
%blankline()

%smallcredits("SOUND COMPOSER", "red")

%blankline()

%bigcredits("KOJI KONDO")

%blankline()
%blankline()

%smallcredits("COORDINATORS", "green")

%blankline()

%bigcredits("KEIZO KATO")

%blankline()

%bigcredits("TAKAO SHIMIZU")

%blankline()
%blankline()

%smallcredits("PRINTED ART WORK", "yellow")

%blankline()

%bigcredits("YOICHI KOTABE")

%blankline()

%bigcredits("HIDEKI FUJII")

%blankline()

%bigcredits("YOSHIAKI KOIZUMI")

%blankline()

%bigcredits("YASUHIRO SAKAI")

%blankline()

%bigcredits("TOMOAKI KUROUME")

%blankline()
%blankline()

%smallcredits("SPECIAL THANKS TO", "red")

%blankline()

%bigcredits("NOBUO OKAJIMA")

%blankline()

%bigcredits("YASUNORI TAKETANI")

%blankline()

%bigcredits("KIYOSHI KODA")

%blankline()

%bigcredits("TAKAMITSU KUZUHARA")

%blankline()

%bigcredits("HIRONOBU KAKUI")

%blankline()

%bigcredits("SHIGEKI YAMASHIRO")

%blankline()

; Pad with extra lines
; Try to keep the padding equal after both credits sections
rep 16 : %emptyline()

;---------------------------------------------------------------------------------------------------

%smallcredits("RANDOMIZER CONTRIBUTORS", "red")

%blankline()
%blankline()
%emptyline()

%smallcredits("ITEM RANDOMIZER", "yellow")

%blankline()

%bigcredits("KATDEVSGAMES         VEETORP")

%blankline()

%bigcredits("CHRISTOSOWEN       DESSYREQT")

%blankline()

%bigcredits("SMALLHACKER           SYNACK")

%blankline()
%blankline()

%smallcredits("ENTRANCE RANDOMIZER", "green")

%blankline()

%bigcredits("AMAZINGAMPHAROS   LLCOOLDAVE")

%blankline()

%bigcredits("KEVINCATHCART    CASSIDYMOEN")

%blankline()
%blankline()

%smallcredits("ENEMY RANDOMIZER", "red")

%blankline()

%bigcredits("ZARBY89              SOSUKE3")

%blankline()

%bigcredits("ENDEROFGAMES")

%blankline()
%blankline()

%smallcredits("DOOR RANDOMIZER", "yellow")

%blankline()

%bigcredits("AERINON            COMPILING")

%blankline()
%blankline()

%smallcredits("MULTIWORLD RANDOMIZER", "green")

%blankline()

%bigcredits("BONTA              CAITSITH2")

%blankline()

%bigcredits("BERSERKER66")

%blankline()
%blankline()

%smallcredits("MSU SUPPORT", "red")

%blankline()

%bigcredits("QWERTYMODO")

%blankline()
%blankline()

%smallcredits("PALETTE SHUFFLER", "yellow")

%blankline()

%bigcredits("NELSON AKA SWR")

%blankline()
%blankline()

%smallcredits("SPRITE DEVELOPMENT", "green")

%blankline()

%bigcredits("MIKETRETHEWEY         IBAZLY")

%blankline()

%bigcredits("FISH_WAFFLE64        KRELBEL")

%blankline()

%bigcredits("ACHY                 ARTHEAU")

%blankline()

%bigcredits("GLAN                 TWROXAS")

%blankline()

%bigcredits("PLAGUEDONE         TARTHORON")

%blankline()
%blankline()

%smallcredits("YOUR SPRITE BY", "red")

%blankline()

%addarbline(YourSpriteCreditsHi)
%addarbline(YourSpriteCreditsLo)

%blankline()
%blankline()

%smallcredits("SPECIAL THANKS", "yellow")

%blankline()

%bigcredits("SUPERSKUJ          EVILASH25")

%blankline()

%bigcredits("MYRAMONG             JOSHRTA")

%blankline()

%bigcredits("WALKINGEYE     MATHONNAPKINS")

%blankline()

%bigcredits("EMOSARU               PINKUS")

%blankline()

%bigcredits("YUZUHARA       SAKURATSUBASA")

%blankline()

; Pad with extra lines
; Try to keep the padding equal after both credits sections
rep 16 : %emptyline()

;===================================================================================================

print "Line number: !CLINE | Expected: 290"

if !CLINE > 290
	error "Too many credits lines. !CLINE > 290"

elseif !CLINE < 290
	warn "Too few credits lines. !CLINE < 290; Adding additional empties for alignment."

endif


; Set line always to line up with stats
!CLINE #= 290

;===================================================================================================

!STAT_TIME_X = 19
!STAT_WITH_TOTAL_X = 22
!STAT_OTHER_X = 25

%smallcredits("THE IMPORTANT STUFF", "yellow")

%blankline()
%blankline()
%emptyline()

%smallcredits("TIME FOUND", "green")

%blankline()

!FOUND_SWORD_LINE #= !CLINE+1 : %bigcreditsleft("FIRST SWORD")

%blankline()

!FOUND_BOOTS_LINE #= !CLINE+1 : %bigcreditsleft("PEGASUS BOOTS")

%blankline()

!FOUND_FLUTE_LINE #= !CLINE+1 : %bigcreditsleft("FLUTE")

%blankline()

!FOUND_MIRROR_LINE #= !CLINE+1 : %bigcreditsleft("MIRROR")

%blankline()
%blankline()

%smallcredits("BOSS KILLS", "yellow")

%blankline()

!BOSSES_SWORD_0_LINE #= !CLINE+1 : %bigcreditsleft("SWORDLESS                /13")

%blankline()

!BOSSES_SWORD_1_LINE #= !CLINE+1 : %bigcreditsleft("FIGHTER'S SWORD          /13")

%blankline()

!BOSSES_SWORD_2_LINE #= !CLINE+1 : %bigcreditsleft("MASTER SWORD             /13")

%blankline()

!BOSSES_SWORD_3_LINE #= !CLINE+1 : %bigcreditsleft("TEMPERED SWORD           /13")

%blankline()

!BOSSES_SWORD_4_LINE #= !CLINE+1 : %bigcreditsleft("GOLDEN SWORD             /13")

%blankline()
%blankline()

%smallcredits("GAME STATS", "red")

%blankline()

!CHEST_TURNS_LINE #= !CLINE+1 : %bigcreditsleft("CHEST TURNS")

%blankline()

!BOOTS_BONKS_LINE #= !CLINE+1 : %bigcreditsleft("BONKS")

%blankline()

!MIRROR_BONKS_LINE #= !CLINE+1 : %bigcreditsleft("MIRROR BONKS")

%blankline()

!SAVE_QUITS_LINE #= !CLINE+1 : %bigcreditsleft("SAVE AND QUITS")

%blankline()

!DEATHS_LINE #= !CLINE+1 : %bigcreditsleft("DEATHS")

%blankline()

!REVIVES_LINE #= !CLINE+1 : %bigcreditsleft("FAERIE REVIVALS")

%blankline()

!MENU_TIME_LINE #= !CLINE+1 : %bigcreditsleft("TOTAL MENU TIME")

%blankline()

!LAG_TIME_LINE #= !CLINE+1 : %bigcreditsleft("TOTAL LAG TIME")

%blankline()
%blankline()

%smallcredits("EXTRA STATS", "green")

%blankline()

%addarbline(ExtraStat1Hi) : %addarbline(ExtraStat1Lo) ; 357

%blankline()

%addarbline(ExtraStat2Hi) : %addarbline(ExtraStat2Lo) ; 360

%blankline()

%addarbline(ExtraStat3Hi) : %addarbline(ExtraStat3Lo) ; 363

%blankline()

; Pad with extra lines
rep 14 : %emptyline()

;===================================================================================================

if !CLINE > 379
	error "Too many stats lines. !CLINE > 379"

elseif !CLINE < 379
	error "Too few stats lines. !CLINE < 379"

endif

;===================================================================================================

!TOTAL_CHECKS_X = 21
!TOTAL_TIME_X = 19

!TOTAL_CHECKS_LINE #= !CLINE+1 : %addarbline(CollectionRateHi) : %addarbline(CollectionRateLo)

%blankline()

!TOTAL_TIME_LINE #= !CLINE+1 : %bigcreditsleft("TOTAL TIME")

%blankline()

%emptyline()
%emptyline()
%emptyline()
%emptyline()
%emptyline()
%emptyline()

;---------------------------------------------------------------------------------------------------
