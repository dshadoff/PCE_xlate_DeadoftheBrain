	.list
	.mlist
	.bank $0

;
; Dead of the Brain #1 Patches to print function
;


;
; First, Font will occupy space from $DB00 to $DFFF
; (0x17380 on disk)
;
FONT	EQU	$DB80

;-----------
;PATCH1 in code:
;
;  Catch print function just as it reads a text (non-control) byte
;  The patch should decide whether to continue to treat it like Kanji
;  or like ASCII
;

	.ORG	$C4A0
;	This is 0x15CA0 on disk

	.code
	JMP	PTCH1

;-----------
;PATCH2 in code:
;
	.ORG	$C4CF
;	This is 0x15CCF on disk
	JMP	PTCH2

;-----------
;PATCH3 in code:
;
;  Catch print function as it prepares to fetch the graphic representation
;  of the caharacter to print.  The implication is that the patch will
;  supply an alternate 16x16 kanji graphic (but only left half) for ASCII
;  characters
;
	.ORG	$C785
;	This is 0x15F85 on disk

	JMP	PTCH3

;-----------
;PATCH4 in code (deprecated):
;
;  Catch print function as it decides how to deal with bit-shift and
;  new tile allocation, before mixing the new graphic tiles with the
;  old ones.
;  The implication here is that ASCII is 8-bits wide, not 12 (or 16)
; 
	.ORG	$C7BD
;	This is 0x15FBD on disk

;	JMP	PTCH4

;-----------
;PATCH5 in code:
;
;  Catch print function as it tries to adjust the "residual bit shift"
;  value, based on prior value and character width.
;  The implication is that original code assumed 12 pixels wide, but
;  ASCII characters will be 8 pixels wide.
;
	.ORG	$C8ED
;	This is 0x160ED on disk

	JMP	PTCH5


;
;------------
; These are variables in use by the routine (so I don't need to steal
; any from the existing routine)
;

	.ORG	$DA5C
CHARIND:
	.DB	0

TMPVLO:	.DB	0
TMPVHI:	.DB	0

ASCIFLAG:
	.DB	0

;-----------
;PATCH1 itself:

	.ORG	$DA60
;	This is 0x17260 on disk

PTCH1:	STA	$3526		; original instruction
	CMP	#$80		; is it <#$80 (i.e. ASCII) ?
	BCC	PTCH1A		; YES, goto PTCH1A
	STZ	ASCIFLAG	; NO, clear the ASCIFLAG
	JMP	$C4A3		; continue as it nothing happened

PTCH1A:	LDA	#1		; set the ASCIFLAG
	STA	ASCIFLAG
	LDA	$3526		; get value back into 'A' as needed
	JMP	$C4AD		; continue (increment pointer)

;----------
;PATCH2 itself:
;	.ORG	$????	; consecutive
PTCH2:	LDA	ASCIFLAG	; check if we are using ASCII
	BEQ	PTCH2Z		; if not, return
	LDA	$351A		; instead of comparing against #$0C,
	CMP	#$08		; compare against width of #$08
	JMP	$C4D4

PTCH2Z:	LDA	$351A		; original instruction
	JMP	$C4D2		; continue as if nothing happened


;----------
;PATCH3 itself:
;	.ORG	$????	; consecutive

PTCH3:	LDA	ASCIFLAG	; check if we are using ASCII
	BEQ	PTCH3Z		; if not, return
	JSR	ASCISTUP	; do the ASCII SETUP
	JMP	$C7AB		; go back to just after Kanji call

PTCH3Z:	LDA	$3525		; original instruction
	JMP	$C788		; continue as if nothing happened

;----------
; PATCH4 itself:
;	.ORG	$????	; consecutive

PTCH4:	STA	$357A		; original instruction
	LDA	ASCIFLAG	; check if we are using ASCII
	BEQ	PTCH4Z		; if not, return
	LDA	$357A
	CMP	#$08		; compare against #$08, not #$0C
	JMP	$C7C2

PTCH4Z:	LDA	$357A		; If not ASCII, return to original stream
	JMP	$C7C0


;----------
; PATCH5 itself:
;	.ORG	$????	; consecutive

PTCH5:	LDA	ASCIFLAG	; check if we are using ASCII
	BEQ	PTCH5Z		; if not, return
	LDA	$351A
	CMP	#$08
	BCC	PTCH5X		; if less than
PTCH5A:	CMP	#$0C
	BNE	PTCH5B
	TII	$3529,$3549,$0020
PTCH5B:	SEC
	SBC	#$08
	JMP	$C8F7		; return to middle of code sequence (STA $351A)

PTCH5X:	CLC			; if less than
	ADC	#$08		; add 8 instead of value in $3518 (from PRINTFLAGS)
	JMP	$C906		; return to middle of code sequence (STA $351A)

PTCH5Z:	LDA	$351A		; original instruction
	JMP	$C8F0
	

ASCISTUP:			; loads ASCII character into $3526 as if it were Kanji
	PHX
	PHY
	LDA	$3526	; get ASCII value
	SEC
	SBC	#$20	; font starts at $20 (space)
	STA	CHARIND

	LDA	CHARIND		; use CHARIND as index for ASCII value

	STA	TMPVLO		; get index and place into TMPVLO/HI to calculate offset
	STZ	TMPVHI		; from bbase of FONT definition

	ASL	TMPVLO		; Double the offset
	ROL	TMPVHI

	LDA	TMPVLO		; Add character index again (now, 3 times original)
	CLC
	ADC	CHARIND
	STA	TMPVLO
	LDA	TMPVHI
	ADC	#$00
	STA	TMPVHI

	ASL	TMPVLO		; Double the index again (now 6 times orig)
	ROL	TMPVHI

	ASL	TMPVLO		; Double the index again (now 12 times orig)
	ROL	TMPVHI

	LDA	#LOW(FONT)	; add address of font def'n table
	CLC
	ADC	TMPVLO
	STA	TMPVLO
	STA	<$70
	LDA	#HIGH(FONT)
	ADC	TMPVHI
	STA	TMPVHI
	STA	<$71

	CLY
	CLX
FNTLP	LDA	[$70],Y
	STA	$3529,X
	INX
	STZ	$3529,X
	INX
	INY
	CPY	#12		; 12 decimal (font height)
	BNE	FNTLP
FNTLP1	STZ	$3529,X
	INX
	CPX	#$20
	BNE	FNTLP1
	
	PLY
	PLX
	RTS

