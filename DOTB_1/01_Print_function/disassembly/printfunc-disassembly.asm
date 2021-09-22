; "Dead of the Brain 1"
;
; Disassembly of the print routine
;
; CDROM offset (within Track 2):
; 0x15800 (matches with PC Engine mem addr = $C000)
;
;

0C000: 40            RTI
0C001: 85 3A         STA   $3A
0C003: A5 3B         LDA   $3B
0C005: 69 00         ADC   #$00
0C007: 85 3B         STA   $3B
0C009: AD 58 30      LDA   $3058
0C00C: F0 09         BEQ   $C017
0C00E: CE 58 30      DEC   $3058
0C011: 20 24 C0      JSR   $C024
0C014: 4C D5 BF      JMP   $BFD5
0C017: 9C B1 38      STZ   $38B1
0C01A: 68            PLA 
0C01B: 53 10         TAM   #$10
0C01D: 68            PLA 
0C01E: 53 08         TAM   #$08
0C020: 68            PLA 
0C021: 53 04         TAM   #$04
0C023: 60            RTS 
0C024: 03 00         ST0   #$00
0C026: A5 3C         LDA   $3C
0C028: 8D 02 00      STA   $0002
0C02B: A5 3D         LDA   $3D
0C02D: 8D 03 00      STA   $0003
0C030: 60            RTS 
0C031: 03 02         ST0   #$02
0C033: AD 51 30      LDA   $3051
0C036: 8D 02 00      STA   $0002
0C039: AD 52 30      LDA   $3052
0C03C: 8D 03 00      STA   $0003
0C03F: 60            RTS 

0C040: 00 40	; some sort of table of offsets
0C042: 00 48
0C044: 00 50
0C046: 00 58
0C048: 00 60
0C04A: 00 68
0C04C: 00 70
0C04E: 00 78
0C050: 00 80
0C052: 00 88
0C054: 00 90
0C056: 00 98

0C058: 64 6D         STZ   $6D
0C05A: A9 08         LDA   #$08
0C05C: 85 6F         STA   $6F
0C05E: A9 FC         LDA   #$FC
0C060: 85 6E         STA   $6E
0C062: 9C F2 34      STZ   $34F2
0C065: A9 70         LDA   #$70
0C067: 8D F3 34      STA   $34F3
0C06A: 43 04         TMA   #$04
0C06C: 48            PHA 
0C06D: 43 08         TMA   #$08
0C06F: 48            PHA 
0C070: 43 10         TMA   #$10
0C072: 48            PHA 
0C073: 18            CLC 
0C074: AD F1 34      LDA   $34F1
0C077: 6D 48 26      ADC   $2648
0C07A: 53 04         TAM   #$04
0C07C: 06 6C         ASL   $6C
0C07E: 26 6D         ROL   $6D
0C080: 06 6C         ASL   $6C
0C082: 26 6D         ROL   $6D
0C084: A9 00         LDA   #$00
0C086: 18            CLC 
0C087: 65 6C         ADC   $6C
0C089: 85 6C         STA   $6C
0C08B: A9 40         LDA   #$40
0C08D: 65 6D         ADC   $6D
0C08F: 85 6D         STA   $6D
0C091: C2            CLY 
0C092: 18            CLC 
0C093: B1 6C         LDA   ($6C),Y
0C095: 6D F1 34      ADC   $34F1
0C098: 6D 48 26      ADC   $2648
0C09B: 48            PHA 
0C09C: C8            INY 
0C09D: C8            INY 
0C09E: B1 6C         LDA   ($6C),Y
0C0A0: 18            CLC 
0C0A1: 69 40         ADC   #$40
0C0A3: 85 6B         STA   $6B
0C0A5: C8            INY 
0C0A6: B1 6C         LDA   ($6C),Y
0C0A8: 85 6A         STA   $6A
0C0AA: 68            PLA 
0C0AB: 53 04         TAM   #$04
0C0AD: 1A            INC 
0C0AE: 53 08         TAM   #$08
0C0B0: 1A            INC 
0C0B1: 53 10         TAM   #$10
0C0B3: A9 30         LDA   #$30
0C0B5: 85 6D         STA   $6D
0C0B7: A9 E6         LDA   #$E6
0C0B9: 85 6C         STA   $6C
0C0BB: AD F0 34      LDA   $34F0
0C0BE: 8D F3 34      STA   $34F3
0C0C1: C2            CLY 
0C0C2: 82            CLX 
0C0C3: 80 2A         BRA   $C0EF
0C0C5: E6 6B         INC   $6B
0C0C7: 10 26         BPL   $C0EF
0C0C9: 43 04         TMA   #$04
0C0CB: 1A            INC 
0C0CC: 1A            INC 
0C0CD: 53 04         TAM   #$04
0C0CF: 1A            INC 
0C0D0: 53 08         TAM   #$08
0C0D2: A9 40         LDA   #$40
0C0D4: 85 6B         STA   $6B
0C0D6: 80 17         BRA   $C0EF
0C0D8: E6 6D         INC   $6D
0C0DA: E6 6E         INC   $6E
0C0DC: D0 0D         BNE   $C0EB
0C0DE: 7F 6E FD      BBR7  $6E, $C0DE
0C0E1: C6 6F         DEC   $6F
0C0E3: D0 06         BNE   $C0EB
0C0E5: 4C 69 C1      JMP   $C169
0C0E8: C8            INY 
0C0E9: F0 ED         BEQ   $C0D8
0C0EB: E6 6A         INC   $6A
0C0ED: F0 D6         BEQ   $C0C5
0C0EF: B2 6A         LDA   ($6A)
0C0F1: 91 6C         STA   ($6C),Y
0C0F3: F0 05         BEQ   $C0FA
0C0F5: C9 FF         CMP   #$FF
0C0F7: D0 EF         BNE   $C0E8
0C0F9: CA            DEX 
0C0FA: E6 6A         INC   $6A
0C0FC: F0 55         BEQ   $C153
0C0FE: B2 6A         LDA   ($6A)
0C100: 22            SAX 
0C101: C8            INY 
0C102: F0 40         BEQ   $C144
0C104: CA            DEX 
0C105: F0 E4         BEQ   $C0EB
0C107: 91 6C         STA   ($6C),Y
0C109: C8            INY 
0C10A: F0 38         BEQ   $C144
0C10C: CA            DEX 
0C10D: F0 DC         BEQ   $C0EB
0C10F: 91 6C         STA   ($6C),Y
0C111: C8            INY 
0C112: F0 30         BEQ   $C144
0C114: CA            DEX 
0C115: F0 D4         BEQ   $C0EB
0C117: 91 6C         STA   ($6C),Y
0C119: C8            INY 
0C11A: F0 28         BEQ   $C144
0C11C: CA            DEX 
0C11D: F0 CC         BEQ   $C0EB
0C11F: 91 6C         STA   ($6C),Y
0C121: C8            INY 
0C122: F0 20         BEQ   $C144
0C124: CA            DEX 
0C125: F0 C4         BEQ   $C0EB
0C127: 91 6C         STA   ($6C),Y
0C129: C8            INY 
0C12A: F0 18         BEQ   $C144
0C12C: CA            DEX 
0C12D: F0 BC         BEQ   $C0EB
0C12F: 91 6C         STA   ($6C),Y
0C131: C8            INY 
0C132: F0 10         BEQ   $C144
0C134: CA            DEX 
0C135: F0 B4         BEQ   $C0EB
0C137: 91 6C         STA   ($6C),Y
0C139: C8            INY 
0C13A: F0 08         BEQ   $C144
0C13C: CA            DEX 
0C13D: F0 AC         BEQ   $C0EB
0C13F: 91 6C         STA   ($6C),Y
0C141: C8            INY 
0C142: D0 C0         BNE   $C104
0C144: E6 6D         INC   $6D
0C146: E6 6E         INC   $6E
0C148: D0 BA         BNE   $C104
0C14A: 7F 6E FD      BBR7  $6E, $C14A
0C14D: C6 6F         DEC   $6F
0C14F: D0 B3         BNE   $C104
0C151: 80 16         BRA   $C169
0C153: E6 6B         INC   $6B
0C155: 10 A7         BPL   $C0FE
0C157: 43 04         TMA   #$04
0C159: 1A            INC 
0C15A: 1A            INC 
0C15B: 53 04         TAM   #$04
0C15D: 1A            INC 
0C15E: 53 08         TAM   #$08
0C160: 1A            INC 
0C161: 53 10         TAM   #$10
0C163: A9 40         LDA   #$40
0C165: 85 6B         STA   $6B
0C167: 80 95         BRA   $C0FE

0C169: 68            PLA 
0C16A: 53 10         TAM   #$10
0C16C: 68            PLA 
0C16D: 53 08         TAM   #$08
0C16F: 68            PLA 
0C170: 53 04         TAM   #$04
0C172: 60            RTS 

0C173: EE EF 34      INC   $34EF
0C176: FF 6E 2A      BBS7  $6E, $C1A3
0C179: A9 FC         LDA   #$FC
0C17B: 85 6E         STA   $6E
0C17D: A9 30         LDA   #$30
0C17F: 85 6D         STA   $6D
0C181: 18            CLC 
0C182: 03 00         ST0   #$00
0C184: AD F2 34      LDA   $34F2
0C187: 8D 02 00      STA   $0002
0C18A: 69 00         ADC   #$00
0C18C: 8D F2 34      STA   $34F2
0C18F: AD F3 34      LDA   $34F3
0C192: 8D 03 00      STA   $0003
0C195: 69 02         ADC   #$02
0C197: 8D F3 34      STA   $34F3
0C19A: 03 02         ST0   #$02
0C19C: E3 E6 30 02 00 00 04  TIA   $30E6, $0002, $0400
0C1A3: 60            RTS 

0C1A4: 62            CLA 
0C1A5: 82            CLX 
0C1A6: 9D F6 34      STA   $34F6,X
0C1A9: 9D FE 34      STA   $34FE,X
0C1AC: E8            INX 
0C1AD: 9D F6 34      STA   $34F6,X
0C1B0: 9D FE 34      STA   $34FE,X
0C1B3: E8            INX 
0C1B4: 9D F6 34      STA   $34F6,X
0C1B7: 9D FE 34      STA   $34FE,X
0C1BA: E8            INX 
0C1BB: 9D F6 34      STA   $34F6,X
0C1BE: 9D FE 34      STA   $34FE,X
0C1C1: E8            INX 
0C1C2: 9D F6 34      STA   $34F6,X
0C1C5: 9D FE 34      STA   $34FE,X
0C1C8: E8            INX 
0C1C9: 9D F6 34      STA   $34F6,X
0C1CC: 9D FE 34      STA   $34FE,X
0C1CF: FE FE 34      INC   $34FE,X
0C1D2: E8            INX 
0C1D3: 9D F6 34      STA   $34F6,X
0C1D6: 9D FE 34      STA   $34FE,X
0C1D9: E8            INX 
0C1DA: 9D F6 34      STA   $34F6,X
0C1DD: A9 11         LDA   #$11
0C1DF: 9D FE 34      STA   $34FE,X
0C1E2: AD FF 1A      LDA   $1AFF
0C1E5: C9 51         CMP   #$51
0C1E7: D0 5A         BNE   $C243
0C1E9: 82            CLX 
0C1EA: 9E 02 1A      STZ   $1A02,X
0C1ED: 9E 12 1A      STZ   $1A12,X
0C1F0: 9E 22 1A      STZ   $1A22,X
0C1F3: 9E 32 1A      STZ   $1A32,X
0C1F6: E8            INX 
0C1F7: E0 08         CPX   #$08
0C1F9: D0 EF         BNE   $C1EA
0C1FB: 82            CLX 
0C1FC: 9E E0 1A      STZ   $1AE0,X
0C1FF: E8            INX 
0C200: E0 06         CPX   #$06
0C202: D0 F8         BNE   $C1FC
0C204: 82            CLX 
0C205: BD 02 1A      LDA   $1A02,X
0C208: 1D 12 1A      ORA   $1A12,X
0C20B: 1D 22 1A      ORA   $1A22,X
0C20E: 1D 32 1A      ORA   $1A32,X
0C211: D0 30         BNE   $C243
0C213: E8            INX 
0C214: E0 07         CPX   #$07
0C216: D0 ED         BNE   $C205
0C218: BD 02 1A      LDA   $1A02,X
0C21B: 1D 12 1A      ORA   $1A12,X
0C21E: 1D 22 1A      ORA   $1A22,X
0C221: 1D 32 1A      ORA   $1A32,X
0C224: 29 7F         AND   #$7F
0C226: D0 1B         BNE   $C243
0C228: 82            CLX 
0C229: BD E0 1A      LDA   $1AE0,X
0C22C: D0 15         BNE   $C243
0C22E: E8            INX 
0C22F: E0 04         CPX   #$04
0C231: D0 F6         BNE   $C229
0C233: AD E4 1A      LDA   $1AE4
0C236: 0D E5 1A      ORA   $1AE5
0C239: 29 0F         AND   #$0F
0C23B: D0 06         BNE   $C243
0C23D: 62            CLA 
0C23E: 8D F5 34      STA   $34F5
0C241: 18            CLC 
0C242: 60            RTS 
0C243: 82            CLX 
0C244: A9 FF         LDA   #$FF
0C246: 8D F5 34      STA   $34F5
0C249: 38            SEC 
0C24A: 60            RTS 
0C24B: AA            TAX 
0C24C: AD F5 34      LDA   $34F5
0C24F: D0 05         BNE   $C256
0C251: BD F6 34      LDA   $34F6,X
0C254: D0 00         BNE   $C256
0C256: 60            RTS 
0C257: AA            TAX 
0C258: A9 01         LDA   #$01
0C25A: 8D F4 34      STA   $34F4
0C25D: AD F5 34      LDA   $34F5
0C260: D0 2B         BNE   $C28D
0C262: 43 04         TMA   #$04
0C264: 48            PHA 
0C265: AD 48 26      LDA   $2648
0C268: 53 04         TAM   #$04
0C26A: 43 08         TMA   #$08
0C26C: 48            PHA 
0C26D: A9 43         LDA   #$43
0C26F: 53 08         TAM   #$08
0C271: 8A            TXA 
0C272: 0A            ASL 
0C273: 0A            ASL 
0C274: 8D 00 35      STA   $3500
0C277: 9C FF 34      STZ   $34FF
0C27A: 73 FE 34 32 1A 08 00  TII   $34FE, $1A32, $0008
0C281: A0 20         LDY   #$20
0C283: BD F6 34      LDA   $34F6,X
0C286: D0 38         BNE   $C2C0
0C288: FE F6 34      INC   $34F6,X
0C28B: 80 04         BRA   $C291
0C28D: 9C F4 34      STZ   $34F4
0C290: 60            RTS 
0C291: 73 00 40 00 60 00 20  TII   $4000, $6000, $2000
0C298: E8            INX 
0C299: 43 04         TMA   #$04
0C29B: 1A            INC 
0C29C: 53 04         TAM   #$04
0C29E: 18            CLC 
0C29F: A9 20         LDA   #$20
0C2A1: 6D FF 34      ADC   $34FF
0C2A4: 8D FF 34      STA   $34FF
0C2A7: D0 03         BNE   $C2AC
0C2A9: EE 00 35      INC   $3500
0C2AC: 73 FE 34 32 1A 08 00  TII   $34FE, $1A32, $0008
0C2B3: 88            DEY 
0C2B4: D0 DB         BNE   $C291
0C2B6: 68            PLA 
0C2B7: 53 08         TAM   #$08
0C2B9: 68            PLA 
0C2BA: 53 04         TAM   #$04
0C2BC: 9C F4 34      STZ   $34F4
0C2BF: 60            RTS 
0C2C0: 73 00 60 00 40 00 20  TII   $6000, $4000, $2000
0C2C7: E8            INX 
0C2C8: 43 04         TMA   #$04
0C2CA: 1A            INC 
0C2CB: 53 04         TAM   #$04
0C2CD: 18            CLC 
0C2CE: A9 20         LDA   #$20
0C2D0: 6D FF 34      ADC   $34FF
0C2D3: 8D FF 34      STA   $34FF
0C2D6: D0 03         BNE   $C2DB
0C2D8: EE 00 35      INC   $3500
0C2DB: 73 FE 34 32 1A 08 00  TII   $34FE, $1A32, $0008
0C2E2: 88            DEY 
0C2E3: D0 DB         BNE   $C2C0
0C2E5: 68            PLA 
0C2E6: 53 08         TAM   #$08
0C2E8: 68            PLA 
0C2E9: 53 04         TAM   #$04
0C2EB: 9C F4 34      STZ   $34F4
0C2EE: 60            RTS 
0C2EF: AA            TAX 
0C2F0: 9E F6 34      STZ   $34F6,X
0C2F3: 60            RTS 

;
; Get ready to print a message
;
0C2F4: 43 04         TMA   #$04		; save MMRs for later
0C2F6: 48            PHA 
0C2F7: 43 08         TMA   #$08		; Note: Text will be mapped in from $4000-$9FFF
0C2F9: 48            PHA 
0C2FA: 43 10         TMA   #$10
0C2FC: 48            PHA 
0C2FD: AD 87 35      LDA   $3587	; calculate starting bank
0C300: 18            CLC 
0C301: 6D 48 26      ADC   $2648
0C304: 53 04         TAM   #$04		; set up memory banks in MMRs
0C306: 1A            INC 
0C307: 53 08         TAM   #$08
0C309: 1A            INC 
0C30A: 53 10         TAM   #$10
0C30C: AD 10 35      LDA   $3510	; this is message #
0C30F: 0A            ASL 		; shift-left for 2-byte code
0C310: A8            TAY 
0C311: B9 00 40      LDA   $4000,Y	; find pointer in bank of pointers @ $4000
0C314: 85 76         STA   $76		; store message start address at $76/77 in ZP
0C316: C8            INY 
0C317: B9 00 40      LDA   $4000,Y
0C31A: 85 77         STA   $77
0C31C: AD 13 35      LDA   $3513	; check control byte
0C31F: 29 04         AND   #$04		; not sure about this bit or the $1F/$3F values
0C321: D0 0A         BNE   $C32D	; but it's the same operation as the 07 bytecode does
0C323: A9 3F         LDA   #$3F
0C325: 8D 1B 35      STA   $351B	; appears to set a 'blank tile', or list of available
0C328: 8D 1C 35      STA   $351C	; tiles for use as reconfigurable graphics tiles
0C32B: 80 08         BRA   $C335
0C32D: A9 1F         LDA   #$1F
0C32F: 8D 1B 35      STA   $351B	; appears to set a 'blank tile', or list of available
0C332: 8D 1C 35      STA   $351C	; tiles for use as reconfigurable graphics tiles
0C335: 9C 25 35      STZ   $3525	; blank out SJIS temporary area
0C338: 9C 26 35      STZ   $3526
0C33B: AD 13 35      LDA   $3513
0C33E: 48            PHA 
0C33F: 9C 13 35      STZ   $3513	; clear out PRINTFLAGS value
0C342: 20 78 C7      JSR   $C778
0C345: 68            PLA 
0C346: 8D 13 35      STA   $3513	; then restore it
0C349: 9C 1A 35      STZ   $351A
0C34C: 9C 1B 35      STZ   $351B
0C34F: F3 1A 35 1A 35 04 00  TAI   $351A, $351A, $0004	; clear $351A-$351D
0C356: F3 1A 35 1E 35 05 00  TAI   $351A, $351E, $0005	; clear $351E-$3523
0C35D: A9 01         LDA   #$01
0C35F: 8D 23 35      STA   $3523	; set to maximum text speed (1 char/VSYNC)
0C362: 8D 24 35      STA   $3524	; set 'current countdown'
0C365: 20 BF CA      JSR   $CABF
0C368: 20 CF CA      JSR   $CACF
0C36B: A9 02         LDA   #$02		; accelerator key = button II 
0C36D: 8D 16 35      STA   $3516
0C370: A9 01         LDA   #$01
0C372: 8D 12 35      STA   $3512	; enable bytecode processing
0C375: 68            PLA 		; restore MMRs
0C376: 53 10         TAM   #$10
0C378: 68            PLA 
0C379: 53 08         TAM   #$08
0C37B: 68            PLA 
0C37C: 53 04         TAM   #$04
0C37E: 60            RTS 		; return

;
; Clear display area (text box)
;
; Inputs:
; -------
; A = 0:
;       clear whole text box display area
;
; A != 0, X = $FF:
;       clear only last line of text box display area
;
; A != 0, X != $FF:
;       clear only line #x (note: 16x16 virtual tiles !)
;       of text box display area
;
0C37F: 62            CLA 
0C380: C9 00         CMP   #$00
0C382: F0 03         BEQ   $C387	; entire box
0C384: 4C 9D C3      JMP   $C39D
;
; clear whole box:
;
0C387: AE 0C 35      LDX   $350C	; setup start X/Y
0C38A: AC 0D 35      LDY   $350D
0C38D: 20 4B CB      JSR   $CB4B	; convert to video BAT addr
0C390: 20 D1 C3      JSR   $C3D1	; set something in $357E (blank tile pointer ?)
0C393: AD 0F 35      LDA   $350F	; # lines (16x16 virtual)
0C396: 0A            ASL 		; change to 8x8 real 
0C397: A8            TAY
0C398: 20 E3 C3      JSR   $C3E3	; clear line
0C39B: 80 33         BRA   $C3D0	; exit

0C39D: E0 FF         CPX   #$FF		; clear last line only ?
0C39F: F0 17         BEQ   $C3B8	; yes
0C3A1: 8A            TXA 		; get virtual line (16x16) to clear
0C3A2: 0A            ASL 
0C3A3: 18            CLC 
0C3A4: 6D 0D 35      ADC   $350D	; add to beginning of box
0C3A7: A8            TAY 
0C3A8: AE 0C 35      LDX   $350C	; load beginning of box
0C3AB: 20 4B CB      JSR   $CB4B	; convert to video BAT addr
0C3AE: 20 D1 C3      JSR   $C3D1	; set something in $357E (blank tile pointer ?)
0C3B1: A0 02         LDY   #$02		; 2 real lines to clear
0C3B3: 20 E3 C3      JSR   $C3E3	; clear them
0C3B6: 80 18         BRA   $C3D0	; exit

0C3B8: AD 0F 35      LDA   $350F	; load end index
0C3BB: 3A            DEC 		; one less
0C3BC: 0A            ASL 		; convert to 8x8 Y-index
0C3BD: 18            CLC 
0C3BE: 6D 0D 35      ADC   $350D	; add to beginning of box
0C3C1: A8            TAY 
0C3C2: AE 0C 35      LDX   $350C	; load beginning X of box
0C3C5: 20 4B CB      JSR   $CB4B	; convert to video BAT addr
0C3C8: 20 D1 C3      JSR   $C3D1	; set something in $357E (blank tile pointer ?)
0C3CB: A0 02         LDY   #$02		; 2 real lines to clear
0C3CD: 20 E3 C3      JSR   $C3E3	; clear line
0C3D0: 60            RTS 

;
; Set up $357E/$357F with 'blank/empty' tile reference
;
0C3D1: AD 20 35      LDA   $3520	; current virtual 16x16 tile
0C3D4: 48            PHA 
0C3D5: AD 1C 35      LDA   $351C	; # of tiles (final tile is a blank one)
0C3D8: 8D 20 35      STA   $3520
0C3DB: 20 42 C7      JSR   $C742	; populate $357E/357F with BAT value (ptr to char VRAM)
0C3DE: 68            PLA 
0C3DF: 8D 20 35      STA   $3520	; restore to original
0C3E2: 60            RTS 

;
; Clear lines
;
0C3E3: DA            PHX 
0C3E4: C0 00         CPY   #$00		; if Y = 0, exit/return
0C3E6: F0 3C         BEQ   $C424
0C3E8: 03 00         ST0   #$00		; set VRAM write address
0C3EA: AD 7C 35      LDA   $357C	; video address (BAT) setup previously
0C3ED: 8D 02 00      STA   $0002
0C3F0: AD 7D 35      LDA   $357D
0C3F3: 8D 03 00      STA   $0003
0C3F6: AD 0E 35      LDA   $350E	; hox many horizontal 16x16 boxes ?
0C3F9: 0A            ASL 		; change to 8x8 physical tiles
0C3FA: AA            TAX 
0C3FB: E0 00         CPX   #$00		; if horizontal loop finsihed,
0C3FD: F0 11         BEQ   $C410	; exit loop to C410
0C3FF: 03 02         ST0   #$02		; set to VRAM data access mode
0C401: AD 7E 35      LDA   $357E	; put BLANK tile index into this BAT
0C404: 8D 02 00      STA   $0002
0C407: AD 7F 35      LDA   $357F
0C40A: 8D 03 00      STA   $0003
0C40D: CA            DEX 		; one less tile to write
0C40E: 80 EB         BRA   $C3FB	; and loop
0C410: AD 7C 35      LDA   $357C	; horiz line done; next line setup
0C413: 18            CLC 
0C414: 69 40         ADC   #$40		; add #$40 to start address
0C416: 8D 7C 35      STA   $357C
0C419: AD 7D 35      LDA   $357D
0C41C: 69 00         ADC   #$00
0C41E: 8D 7D 35      STA   $357D
0C421: 88            DEY 		; one less vertical line to do
0C422: 80 C0         BRA   $C3E4	; and loop
0C424: FA            PLX 
0C425: 60            RTS 		; return

;
; This appears to be the entry point for printing
; a character (or doing other operations)
; I expect this is executed once per VSYNC
; (60 times per second)
;
0C426: AD 12 35      LDA   $3512	; check start/stop flag
0C429: D0 03         BNE   $C42E
0C42B: 4C 28 C5      JMP   $C528	; if 0, go to an RTS
0C42E: C9 02         CMP   #$02
0C430: D0 03         BNE   $C435
0C432: 4C 29 C5      JMP   $C529	; clear display area & zero flag

0C435: C9 03         CMP   #$03
0C437: D0 03         BNE   $C43C	; not 0, 2, or 3 - print normally
0C439: 4C 0C C5      JMP   $C50C	; countdown while doing "WAIT" bytecode

0C43C: 43 04         TMA   #$04		; save these three MMR bank pointers
0C43E: 48            PHA 
0C43F: 43 08         TMA   #$08
0C441: 48            PHA 
0C442: 43 10         TMA   #$10
0C444: 48            PHA 
0C445: AD 87 35      LDA   $3587	; calculate starting bank of text
0C448: 18            CLC 
0C449: 6D 48 26      ADC   $2648
0C44C: 53 04         TAM   #$04		; and set those three MMRs to point
0C44E: 1A            INC 		; to that big block of memory
0C44F: 53 08         TAM   #$08
0C451: 1A            INC 
0C452: 53 10         TAM   #$10
0C454: 20 30 C5      JSR   $C530	; zero out $3527
0C457: AD 28 22      LDA   $2228	; read joypad 1 (held keys)
0C45A: CD 16 35      CMP   $3516	; does it match accelerator key ?
0C45D: F0 13         BEQ   $C472	; yes
0C45F: CE 24 35      DEC   $3524	; regular countdown
0C462: AD 24 35      LDA   $3524
0C465: F0 03         BEQ   $C46A	; reached zero
0C467: 4C 01 C5      JMP   $C501
0C46A: AD 23 35      LDA   $3523	; setup countdown for next character
0C46D: 8D 24 35      STA   $3524
0C470: 80 10         BRA   $C482	; now go get next character to process

0C472: CE 24 35      DEC   $3524	; keys held -> accelerate
0C475: AD 24 35      LDA   $3524        ; also countdown
0C478: F0 03         BEQ   $C47D	; reached zero
0C47A: 4C 01 C5      JMP   $C501
0C47D: A9 01         LDA   #$01		; minimal countdown for next character
0C47F: 8D 24 35      STA   $3524

;
; now it's time to get next character
;
0C482: A5 76         LDA   $76 		; setup pointer into text
0C484: 18            CLC
0C485: 6D 1E 35      ADC   $351E	; $76/7 + $3512/3 -> $72/3
0C488: 85 72         STA   $72
0C48A: A5 77         LDA   $77
0C48C: 6D 1F 35      ADC   $351F
0C48F: 85 73         STA   $73

0C491: C2            CLY 		; get next byte
0C492: B1 72         LDA   ($72),Y
0C494: C9 10         CMP   #$10		; is it speical character ? (<$10)
0C496: 90 03         BCC   $C49B	; yes
0C498: 4C A0 C4      JMP   $C4A0

0C49B: 0A            ASL 		; use 2-byte values @ $C534
0C49C: AA            TAX 		; as a jump-table !
0C49D: 7C 34 C5      JMP   ($C534,X)

;
;----------------------
; This is the patch point for grabbing the printable character
;----------------------
;
0C4A0: 8D 26 35      STA   $3526	; normal kanji; store it - PATCH POINT #1
0C4A3: A0 01         LDY   #$01		; along with next byte
0C4A5: B1 72         LDA   ($72),Y	; at $3525/26
0C4A7: 8D 25 35      STA   $3525
0C4AA: 20 13 CB      JSR   $CB13	; increment text pointer twice
0C4AD: 20 13 CB      JSR   $CB13	; (SJIS is 2-byte)

0C4B0: AD 21 35      LDA   $3521	; is cursor beyond right edge ?
0C4B3: CD 0E 35      CMP   $350E
0C4B6: D0 17         BNE   $C4CF	; no
0C4B8: 9C 21 35      STZ   $3521	; yes, reset to left
0C4BB: 9C 1A 35      STZ   $351A
0C4BE: EE 22 35      INC   $3522	; next line
0C4C1: AD 22 35      LDA   $3522	; is cursor beyond bottom edge ?
0C4C4: CD 0F 35      CMP   $350F
0C4C7: D0 06         BNE   $C4CF	; no
0C4C9: CE 22 35      DEC   $3522	; yes, reset to bottom line
0C4CC: 20 58 C6      JSR   $C658	; and scroll up one line

0C4CF: AD 1A 35      LDA   $351A	; residual shift amount - PATCH POINT #2
0C4D2: C9 0C         CMP   #$0C		; is it big ?
0C4D4: B0 1B         BCS   $C4F1	; >$0C (implies enough space for this char)
					; (i.e. '0x00' value falls through)
0C4D6: AD 21 35      LDA   $3521	; get x-position
0C4D9: 0A            ASL 		; change virtual 16x16 to real 8x8
0C4DA: 18            CLC 
0C4DB: 6D 0C 35      ADC   $350C	; add to base x-position
0C4DE: AA            TAX 
0C4DF: AD 22 35      LDA   $3522	; get y-line
0C4E2: 0A            ASL 		; change virtual 16x16 to real 8x8
0C4E3: 18            CLC 
0C4E4: 6D 0D 35      ADC   $350D	; add to base y-position
0C4E7: A8            TAY 
0C4E8: 20 4B CB      JSR   $CB4B	; translate to VRAM BAT addr
0C4EB: 20 E4 C6      JSR   $C6E4	; Allocate new tile for graphics definition
0C4EE: EE 21 35      INC   $3521	; increment X-pos

0C4F1: 20 78 C7      JSR   $C778	; print kanji character
0C4F4: AD 23 35      LDA   $3523	; get character delay (in VSYNCs)
0C4F7: D0 03         BNE   $C4FC	; if nonzero, then we're done for this VSYNC
0C4F9: 4C 82 C4      JMP   $C482	; otherwise, loop back for next char
0C4FC: 80 03         BRA   $C501	; else exit

0C4FE: 9C 12 35      STZ   $3512	; end message code ends up here

0C501: 68            PLA 		; restore those 3 MMR pointers
0C502: 53 10         TAM   #$10		; to their original values
0C504: 68            PLA 
0C505: 53 08         TAM   #$08
0C507: 68            PLA 
0C508: 53 04         TAM   #$04
0C50A: 80 1C         BRA   $C528	; this is actually a RTS

;
; This routine is executed during a "WAIT" instruction
; (bytecode 0B), instead of processing characters
;
0C50C: AD 7B 35      LDA   $357B	; come here if $3512 flag = 3
0C50F: C9 3B         CMP   #$3B
0C511: F0 05         BEQ   $C518	; count up to $3B (59 decimal); at 60 counts per second,
0C513: EE 7B 35      INC   $357B	; each unit of the WAIT (0B) bytecode is 1 second
0C516: 80 10         BRA   $C528
0C518: 9C 7B 35      STZ   $357B
0C51B: CE 7A 35      DEC   $357A	; once $3B is reached, count down
0C51E: AD 7A 35      LDA   $357A	; from value in $357A
0C521: D0 05         BNE   $C528
0C523: A9 01         LDA   #$01
0C525: 8D 12 35      STA   $3512	; allow bytecode processing again
0C528: 60            RTS 		; exit

0C529: 20 7F C3      JSR   $C37F	; clear display area
0C52C: 9C 12 35      STZ   $3512	; and halt bytecode processing
0C52F: 60            RTS 

0C530: 9C 27 35      STZ   $3527
0C533: 60            RTS 


; Jump table
; ----------
0C534: 4E C5         .DEFW $C54E	; bytecode 00 (end message)
0C536: 4E C5         .DEFW $C54E	; bytecode 01 (end message)
0C538: 51 C5         .DEFW $C551	; bytecode 02 (wait for key)
0C53A: 77 C5         .DEFW $C577	; bytecode 03 (newline)
0C53C: 94 C5         .DEFW $C594	; bytecode 04 (set BAT palette
0C53E: A6 C5         .DEFW $C5A6	; bytecode 05 (textspeed)
0C540: BA C5         .DEFW $C5BA	; bytecode 06 (set color-in-BAT-palette)
0C542: CA C5         .DEFW $C5CA	; bytecode 07 (set Printflags
0C544: 00 C6         .DEFW $C600	; bytecode 08 (clear)
0C546: 0A C6         .DEFW $C60A	; bytecode 09 (print special graphic character)
0C548: 21 C6         .DEFW $C621	; bytecode 0A (topleft)
0C54A: 30 C6         .DEFW $C630	; bytecode 0B (wait)
0C54C: 48 C6         .DEFW $C648	; bytecode 0C (set accelerate key)


;
; Code 00 and 01 (end message)
;
0C54E: 4C FE C4      JMP   $C4FE

;
; Code 02 (wait for key)
;
0C551: A0 01         LDY   #$01		; get next byte from bytestream
0C553: B1 72         LDA   ($72),Y
0C555: 8D 15 35      STA   $3515	; and put it in $3515
0C558: 20 13 CB      JSR   $CB13	; inc message pointer twice
0C55B: 20 13 CB      JSR   $CB13	; (2-byte code)
0C55E: AD 2D 22      LDA   $222D	; read "newly-pressed keys" from joypad 1
0C561: 2D 15 35      AND   $3515	; check if they match the mask
0C564: F0 03         BEQ   $C569	; no
0C566: 4C 82 C4      JMP   $C482
0C569: 20 25 CB      JSR   $CB25	; decrement message pointer twice in order
0C56C: 20 25 CB      JSR   $CB25	; to repeat this check over and over
0C56F: A9 01         LDA   #$01		; check it every VSYNC, not at TEXTSPEED
0C571: 8D 24 35      STA   $3524
0C574: 4C 01 C5      JMP   $C501	; exit

;
; Code 03 (new line)
;
0C577: 9C 21 35      STZ   $3521	; set X pos to beginning of line
0C57A: EE 22 35      INC   $3522	; inc the Y pos
0C57D: AD 22 35      LDA   $3522	; is it beyond bottom edge ?
0C580: CD 0F 35      CMP   $350F
0C583: D0 06         BNE   $C58B	; no, it's OK
0C585: CE 22 35      DEC   $3522	; back it off to the last displayable line then
0C588: 20 58 C6      JSR   $C658	; scroll the box up a line
0C58B: 9C 1A 35      STZ   $351A	; reset a counter (???)
0C58E: 20 13 CB      JSR   $CB13	; inc pointer into text block (1 byte code)
0C591: 4C 01 C5      JMP   $C501	; exit

;
; Code 04 (set BAT palette number)
;
0C594: A0 01         LDY   #$01		; get next byte from bytestream
0C596: B1 72         LDA   ($72),Y
0C598: 29 F0         AND   #$F0
0C59A: 8D 14 35      STA   $3514	; and store top 4 bits of it at $3514
0C59D: 20 13 CB      JSR   $CB13	; inc message pointer twice
0C5A0: 20 13 CB      JSR   $CB13	; for 2-byte code
0C5A3: 4C 82 C4      JMP   $C482	; instead of exit, loop back for another code/character

;
; Code 05 (set text speed)
;
0C5A6: A0 01         LDY   #$01		; get next byte from bytestream
0C5A8: B1 72         LDA   ($72),Y	; (it's a countdown for intra-character delays)
0C5AA: 8D 23 35      STA   $3523	; store it at $3523
0C5AD: 1A            INC 
0C5AE: 8D 24 35      STA   $3524	; initial setting of the 'current countdown' counter
0C5B1: 20 13 CB      JSR   $CB13	; inc message pointer
0C5B4: 20 13 CB      JSR   $CB13	; inc message pointer (it's a 2-byte code)
0C5B7: 4C 01 C5      JMP   $C501	; exit

;
; Code 06 (set BAT color-in-palette)
;
0C5BA: A0 01         LDY   #$01		; get next byte
0C5BC: B1 72         LDA   ($72),Y
0C5BE: 8D 17 35      STA   $3517	; and put it at $3517
0C5C1: 20 13 CB      JSR   $CB13	; inc message pointer
0C5C4: 20 13 CB      JSR   $CB13	; enough for a 2-byte code
0C5C7: 4C 82 C4      JMP   $C482	; instead of exit, loop back for another code/character

;
; Code 07 (set printflags)
;
0C5CA: A0 01         LDY   #$01		; get next byte
0C5CC: B1 72         LDA   ($72),Y
0C5CE: 8D 13 35      STA   $3513	; and put it at $3513
0C5D1: 20 13 CB      JSR   $CB13	; inc message pointer
0C5D4: 20 13 CB      JSR   $CB13	; enough for a 2-byte code
0C5D7: AD 13 35      LDA   $3513	; grab value at $3513
0C5DA: 29 02         AND   #$02		; check if 2nd lowest bit is set
0C5DC: F0 0C         BEQ   $C5EA	; no
0C5DE: AD 13 35      LDA   $3513	; yes - shift value right 4 bits
0C5E1: 4A            LSR 
0C5E2: 4A            LSR 
0C5E3: 4A            LSR 
0C5E4: 4A            LSR 
0C5E5: 8D 18 35      STA   $3518	; and store it at $3518
0C5E8: F0 00         BEQ   $C5EA
0C5EA: AD 13 35      LDA   $3513	; check if 3rd lowest bit is set
0C5ED: 29 04         AND   #$04
0C5EF: D0 07         BNE   $C5F8	; if so, go there
					; (???? horizontal width maybe ????)
0C5F1: A9 3F         LDA   #$3F		; $3513 is like XXXXX0XX
0C5F3: 8D 1C 35      STA   $351C	; then put $3F into $351C (tile pool size)
0C5F6: 80 05         BRA   $C5FD
0C5F8: A9 1F         LDA   #$1F		; otherwise, $3513 is like XXXXX1XX
0C5FA: 8D 1C 35      STA   $351C	; then put $1F into $351C (tile pool size)
0C5FD: 4C 82 C4      JMP   $C482	; instead of exit, loop back for another code/character

;
; Code 08 (clear display area)
;
0C600: 62            CLA 
0C601: 20 80 C3      JSR   $C380	; clear box
0C604: 20 13 CB      JSR   $CB13	; inc text message pointer
0C607: 4C 01 C5      JMP   $C501	; exit

;
; Code 09 (print special character)
;
0C60A: A9 01         LDA   #$01		; store value of 1 at $3527
0C60C: 8D 27 35      STA   $3527
0C60F: A0 01         LDY   #$01		; get next byte from bytestream
0C611: B1 72         LDA   ($72),Y
0C613: 8D 28 35      STA   $3528	; store it at $3528
0C616: A9 FF         LDA   #$FF		; fill kanji code area ($3525/36)
0C618: 8D 26 35      STA   $3526	; with value 'FFFF'
0C61B: 8D 25 35      STA   $3525
0C61E: 4C A0 C4      JMP   $C4A0	; and go to print routine

;
; Code 0A (move to top left)
;
0C621: 9C 21 35      STZ   $3521	; move cursor to left
0C624: 9C 22 35      STZ   $3522	; move cursor to top
0C627: 9C 1A 35      STZ   $351A	; clear residual shift amount (pixels in tile)
0C62A: 20 13 CB      JSR   $CB13	; inc pointer into text block (1-byte code)
0C62D: 4C 01 C5      JMP   $C501	; exit

;
; Code 0B (pause)
;
0C630: A0 01         LDY   #$01		; get next byte
0C632: B1 72         LDA   ($72),Y
0C634: 8D 7A 35      STA   $357A	; and store it at $357A
0C637: 9C 7B 35      STZ   $357B
0C63A: 20 13 CB      JSR   $CB13	; inc message pointer
0C63D: 20 13 CB      JSR   $CB13	; enough for 2-byte code
0C640: A9 03         LDA   #$03		; put a '3' at $3512 control byte
0C642: 8D 12 35      STA   $3512
0C645: 4C 01 C5      JMP   $C501	; exit

;
; Code 0C (set accelerator key)
;
0C648: A0 01         LDY   #$01		; get next byte
0C64A: B1 72         LDA   ($72),Y
0C64C: 8D 16 35      STA   $3516	; and put it at $3516
0C64F: 20 13 CB      JSR   $CB13	; inc message pointer
0C652: 20 13 CB      JSR   $CB13	; enough for 2-byte code
0C655: 4C 01 C5      JMP   $C501	; exit

;
; Scroll display area
;
0C658: DA            PHX 
0C659: 5A            PHY 
0C65A: AE 0C 35      LDX   $350C	; start with min X/Y position in display box
0C65D: AC 0D 35      LDY   $350D
0C660: 20 4B CB      JSR   $CB4B	; calculate VRAM address & put in $357C/D
0C663: AD 0F 35      LDA   $350F	; get number of 16x16 virtual lines
0C666: 3A            DEC 		; minus one
0C667: 0A            ASL 
0C668: AA            TAX 		; put it in X
0C669: 03 01         ST0   #$01		; set VRAM read adress
0C66B: AD 7C 35      LDA   $357C	; set it to the calculated VRAM BAT addr
0C66E: 18            CLC 		; but add $80 to it (ie. two 8x8 lines, or one 16x16)
0C66F: 69 80         ADC   #$80
0C671: 8D 02 00      STA   $0002
0C674: AD 7D 35      LDA   $357D
0C677: 69 00         ADC   #$00
0C679: 8D 03 00      STA   $0003
0C67C: 03 02         ST0   #$02		; set VRAM data access
0C67E: DA            PHX 
0C67F: AD 0E 35      LDA   $350E	; get number of 16x16 virtual horizontal char's
0C682: 0A            ASL 		; multiply by 2 to get actual 8x8 character width
0C683: A8            TAY 
0C684: 82            CLX 
0C685: AD 02 00      LDA   $0002	; copy data from VRAM
0C688: 9D 29 35      STA   $3529,X	; into $3529 data buffer
0C68B: E8            INX 
0C68C: AD 03 00      LDA   $0003
0C68F: 9D 29 35      STA   $3529,X
0C692: E8            INX 
0C693: 88            DEY 
0C694: C0 00         CPY   #$00		; and loop until whole line (up to 32 8x8 tiles)
0C696: D0 ED         BNE   $C685	; is copied into buffer
0C698: FA            PLX 
0C699: 03 00         ST0   #$00		; set VRAM write address
0C69B: AD 7C 35      LDA   $357C	; set it to calculated address
0C69E: 8D 02 00      STA   $0002
0C6A1: AD 7D 35      LDA   $357D
0C6A4: 8D 03 00      STA   $0003
0C6A7: 03 02         ST0   #$02		; set to access VRAM data
0C6A9: DA            PHX 
0C6AA: AD 0E 35      LDA   $350E	; get number of 16x16 virtual horizontal char's
0C6AD: 0A            ASL  		; multiply by 2 to get actual 8x8 character width
0C6AE: A8            TAY 
0C6AF: 82            CLX 
0C6B0: BD 29 35      LDA   $3529,X	; copy data from $3529 buffer
0C6B3: 8D 02 00      STA   $0002	; into VRAM
0C6B6: E8            INX 
0C6B7: BD 29 35      LDA   $3529,X
0C6BA: 8D 03 00      STA   $0003
0C6BD: E8            INX 
0C6BE: 88            DEY 
0C6BF: C0 00         CPY   #$00		; and loop until whole line (up to 32 8x8 tiles)
0C6C1: D0 ED         BNE   $C6B0	; is copied into buffer
0C6C3: FA            PLX 
0C6C4: AD 7C 35      LDA   $357C	; take starting address
0C6C7: 18            CLC 		; and add $40 to it (one line down)
0C6C8: 69 40         ADC   #$40		; in order to reset starting address
0C6CA: 8D 7C 35      STA   $357C
0C6CD: AD 7D 35      LDA   $357D
0C6D0: 69 00         ADC   #$00
0C6D2: 8D 7D 35      STA   $357D
0C6D5: CA            DEX 		; decrement counter for number of lines to copy
0C6D6: E0 00         CPX   #$00
0C6D8: D0 8F         BNE   $C669	; not done; continue
0C6DA: A9 01         LDA   #$01		; set up to clear the final line of scroll area
0C6DC: A2 FF         LDX   #$FF
0C6DE: 20 80 C3      JSR   $C380	; and make the call to go do it
0C6E1: 7A            PLY 
0C6E2: FA            PLX 
0C6E3: 60            RTS 		; return

;
; Put tile reference into BAT table, then allocate new tile in cyclic buffer
; (last one reserved as blank)
;
0C6E4: DA            PHX 
0C6E5: 5A            PHY 
					; first, put current virtual tile (based on $3520)
					; into BAT pointer format, and load that into
					; the BAT addr in $357C/D:
					;
0C6E6: 03 00         ST0   #$00		; set VRAM write address
0C6E8: AD 7C 35      LDA   $357C	; with the BAT address calculated by routine at $CB4B
0C6EB: 8D 02 00      STA   $0002
0C6EE: AD 7D 35      LDA   $357D
0C6F1: 8D 03 00      STA   $0003
0C6F4: 20 42 C7      JSR   $C742	; set address into $357E, of current 16x16 virtual tile
0C6F7: 82            CLX 
0C6F8: C2            CLY 
0C6F9: 03 02         ST0   #$02		; set to access VRAM data
0C6FB: AD 7E 35      LDA   $357E
0C6FE: 8D 02 00      STA   $0002	; store it in the BAT address
0C701: 18            CLC 
0C702: 69 01         ADC   #$01
0C704: 8D 7E 35      STA   $357E	; and INC it for the next time
0C707: AD 7F 35      LDA   $357F
0C70A: 8D 03 00      STA   $0003	; store MSB also
0C70D: 69 00         ADC   #$00
0C70F: 8D 7F 35      STA   $357F
0C712: C8            INY 
0C713: C0 02         CPY   #$02		; repeat twice to store 2 of them horizontally
0C715: D0 E2         BNE   $C6F9

0C717: 03 00         ST0   #$00		; set VRAM write address
0C719: AD 7C 35      LDA   $357C	; set it with same calculated address
0C71C: 18            CLC 
0C71D: 69 40         ADC   #$40		; but one line down
0C71F: 8D 02 00      STA   $0002
0C722: AD 7D 35      LDA   $357D
0C725: 69 00         ADC   #$00
0C727: 8D 03 00      STA   $0003
0C72A: E8            INX 
0C72B: E0 02         CPX   #$02
0C72D: D0 C9         BNE   $C6F8	; repeat twice to store a line twice (vertically)

0C72F: EE 20 35      INC   $3520	; set it to next available dynamic tile
0C732: AD 20 35      LDA   $3520
0C735: CD 1C 35      CMP   $351C	; are all of them allocated ?
0C738: F0 02         BEQ   $C73C	; yes
0C73A: 80 03         BRA   $C73F	; anyway, exit

0C73C: 9C 20 35      STZ   $3520
0C73F: 7A            PLY 
0C740: FA            PLX 
0C741: 60            RTS 

;
; calculate BAT reference value (pointer to graphic tiles, to place into BAT)
;
0C742: AD 08 35      LDA   $3508	; get address from $3508/9 and place it in $357E/F
					; (init $7000 = start of tile pool)
0C745: 8D 7E 35      STA   $357E
0C748: AD 09 35      LDA   $3509
0C74B: 8D 7F 35      STA   $357F
0C74E: C2            CLY 
0C74F: 4E 7F 35      LSR   $357F	; shift it right
0C752: 6E 7E 35      ROR   $357E
0C755: C8            INY 
0C756: C0 04         CPY   #$04		; loop 4 times
0C758: D0 F5         BNE   $C74F

0C75A: AD 20 35      LDA   $3520	; take value in $3520 and multiply by 4
0C75D: 0A            ASL 		; this is likely the counter for the dynamic 16x16 tile
0C75E: 0A            ASL
0C75F: 18            CLC 
0C760: 6D 7E 35      ADC   $357E	; add to $357E - it's the 'character' pointer to
0C763: 8D 7E 35      STA   $357E	; the graphic 'tile' definition elsewhere in VRAM
0C766: AD 7F 35      LDA   $357F
0C769: 69 00         ADC   #$00
0C76B: 8D 7F 35      STA   $357F
0C76E: AD 7F 35      LDA   $357F	; 'OR' the topmost 4 bits - the 'BAT palette'
0C771: 0D 14 35      ORA   $3514
0C774: 8D 7F 35      STA   $357F
0C777: 60            RTS 		; exit

;
; print kanji character
;
0C778: AD 25 35      LDA   $3525	; check SJIS character at $3525/6
0C77B: 0D 26 35      ORA   $3526
0C77E: F0 23         BEQ   $C7A3	; if empty, go to $C7A3
0C780: AD 27 35      LDA   $3527	; if $3527 nonzero, get custom kanji character
0C783: D0 23         BNE   $C7A8

					; PATCH POINT #3
0C785: AD 25 35      LDA   $3525	; set up for System Card Call - load SJIS value
0C788: 85 F8         STA   $F8
0C78A: AD 26 35      LDA   $3526
0C78D: 85 F9         STA   $F9
0C78F: A9 29         LDA   #$29		; return graphics buffer address = $3529
0C791: 85 FA         STA   $FA
0C793: A9 35         LDA   #$35
0C795: 85 FB         STA   $FB
0C797: AD 13 35      LDA   $3513	; grab flag for 12x12 or 16x16 kanji
0C79A: 29 01         AND   #$01
0C79C: 85 FF         STA   $FF
0C79E: 20 60 E0      JSR   $E060	; get kanji graphics
0C7A1: 80 08         BRA   $C7AB
;
0C7A3: 20 BF CA      JSR   $CABF	; clear buffer @ $3529 - blank out kanji area
0C7A6: 80 03         BRA   $C7AB

0C7A8: 20 DF CA      JSR   $CADF	; get graphics for custom character and put in $3529
0C7AB: AD 13 35      LDA   $3513	; check how character alignment is done
0C7AE: 29 02         AND   #$02		; should we deal with offset bits ?
0C7B0: D0 03         BNE   $C7B5	; yes
0C7B2: 4C A9 C8      JMP   $C8A9	; else no bit-shifting: so don't bother with the
					; second buffer for shift-mixing at $3549

0C7B5: AD 1A 35      LDA   $351A	; residual shift amount non-zero ?
0C7B8: D0 03         BNE   $C7BD	; yes
0C7BA: 4C A2 C8      JMP   $C8A2	; no, just straight print: copy $3529 straight
					; into $3549 buffer without mixing

0C7BD: 8D 7A 35      STA   $357A	; store at $357A -- PATCH POINT #4
					; ACTUALLY DON'T PATCH HERE !!!!!
0C7C0: C9 0C         CMP   #$0C
					; NOTE: with PRINTFLAGS=43, offset bits should
					; only ever have values of $00, $04, $08, $0C

0C7C2: F0 07         BEQ   $C7CB	; = $0C
0C7C4: B0 02         BCS   $C7C8	; > $0C : this basically shouldn't happen !!
0C7C6: 80 03         BRA   $C7CB	; < $0C (general non-zero case)

;
; bit-shift the kanji graphics as necessary
;
0C7C8: 20 37 CB      JSR   $CB37	; > $0C: (decrement virtual tile index)

0C7CB: 9C 7B 35      STZ   $357B	; this is counter for y-index into character
0C7CE: 82            CLX 
0C7CF: 9C 74 35      STZ   $3574
0C7D2: 9C 75 35      STZ   $3575
0C7D5: BD 49 35      LDA   $3549,X	; load byte from "previous character" buffer
0C7D8: 8D 79 35      STA   $3579	; store 2 bytes of gfx backwards @ $3579/78
0C7DB: E8            INX 
0C7DC: BD 49 35      LDA   $3549,X
0C7DF: 8D 78 35      STA   $3578
0C7E2: CA            DEX
0C7E3: BD 29 35      LDA   $3529,X	; get same line of gfx from "new character"
0C7E6: 8D 73 35      STA   $3573	; store 2 bytes of gfx backwards @ $3573/72
0C7E9: E8            INX 
0C7EA: BD 29 35      LDA   $3529,X
0C7ED: 8D 72 35      STA   $3572
0C7F0: AC 7A 35      LDY   $357A	; # bits to shift
0C7F3: C0 00         CPY   #$00
0C7F5: F0 0F         BEQ   $C806	; if 0, no loop
0C7F7: 0E 72 35      ASL   $3572	; shift new character into empty buffer @ $3574/5
0C7FA: 2E 73 35      ROL   $3573
0C7FD: 2E 74 35      ROL   $3574
0C800: 2E 75 35      ROL   $3575
0C803: 88            DEY 
0C804: 80 ED         BRA   $C7F3	; loop
0C806: CA            DEX 		; start @ top of line again
0C807: AD 75 35      LDA   $3575	; 'OR' the shifted new gfx together with old gfx
0C80A: 0D 79 35      ORA   $3579
0C80D: 9D 29 35      STA   $3529,X	; and store it into the display buffer
0C810: E8            INX 
0C811: AD 74 35      LDA   $3574	; repeat for byte #2 on the same line
0C814: 0D 78 35      ORA   $3578
0C817: 9D 29 35      STA   $3529,X
0C81A: CA            DEX 
0C81B: AD 73 35      LDA   $3573	; store the leftover graphics into 'old gfx buffer'
0C81E: 9D 49 35      STA   $3549,X
0C821: E8            INX 
0C822: AD 72 35      LDA   $3572	; repeat for byte 2 of same line
0C825: 9D 49 35      STA   $3549,X
0C828: E8            INX 
0C829: EE 7B 35      INC   $357B	; loop to next line
0C82C: AD 7B 35      LDA   $357B
0C82F: C9 10         CMP   #$10		; until 16 lines complete
0C831: D0 9C         BNE   $C7CF

0C833: 9C 1D 35      STZ   $351D	; start loop
0C836: AD 1D 35      LDA   $351D	; get counter
0C839: 0A            ASL		; double it (for offset into table of 16-bit values)
0C83A: A8            TAY 
0C83B: BE 0A C9      LDX   $C90A,Y	; load 16-bit value into Y:X
0C83E: C8            INY 
0C83F: B9 0A C9      LDA   $C90A,Y
0C842: A8            TAY 
0C843: 20 0C CA      JSR   $CA0C	; calculate ???? based on X:Y and set VRAM write addr.
0C846: 03 02         ST0   #$02		; set video controller to receive data
0C848: 20 1A C9      JSR   $C91A

0C84B: AD 1D 35      LDA   $351D	; repeat this offset exercise
0C84E: 0A            ASL 
0C84F: A8            TAY 
0C850: BE 0A C9      LDX   $C90A,Y
0C853: C8            INY 
0C854: B9 0A C9      LDA   $C90A,Y
0C857: A8            TAY 
0C858: 20 0C CA      JSR   $CA0C	; calculate ??? based on X:Y and set VRAM write addr.
0C85B: 03 02         ST0   #$02		; set controller to receive data
0C85D: 20 3F C9      JSR   $C93F

0C860: AD 1D 35      LDA   $351D	; repeat 8 times
0C863: C9 08         CMP   #$08
0C865: D0 CF         BNE   $C836

0C867: AD 1A 35      LDA   $351A
0C86A: F0 71         BEQ   $C8DD
0C86C: 9C 1D 35      STZ   $351D
0C86F: AD 1D 35      LDA   $351D
0C872: 0A            ASL 
0C873: A8            TAY 
0C874: BE 0A C9      LDX   $C90A,Y
0C877: C8            INY 
0C878: B9 0A C9      LDA   $C90A,Y
0C87B: A8            TAY 
0C87C: 20 B9 C9      JSR   $C9B9
0C87F: 03 02         ST0   #$02
0C881: 20 1A C9      JSR   $C91A

0C884: AD 1D 35      LDA   $351D
0C887: 0A            ASL 
0C888: A8            TAY 
0C889: BE 0A C9      LDX   $C90A,Y
0C88C: C8            INY 
0C88D: B9 0A C9      LDA   $C90A,Y
0C890: A8            TAY 
0C891: 20 B9 C9      JSR   $C9B9
0C894: 03 02         ST0   #$02
0C896: 20 3F C9      JSR   $C93F

0C899: AD 1D 35      LDA   $351D
0C89C: C9 08         CMP   #$08
0C89E: D0 CF         BNE   $C86F
0C8A0: 80 3B         BRA   $C8DD


;
; print kanji without bit shift
;
0C8A2: 73 29 35 49 35 20 00  TII   $3529, $3549, $0020	; no shift needed; move
                                        ; old character to old character buffer
0C8A9: 9C 1D 35      STZ   $351D
0C8AC: AD 1D 35      LDA   $351D
0C8AF: 0A            ASL 
0C8B0: A8            TAY 
0C8B1: BE 0A C9      LDX   $C90A,Y
0C8B4: C8            INY 
0C8B5: B9 0A C9      LDA   $C90A,Y
0C8B8: A8            TAY 
0C8B9: 20 66 C9      JSR   $C966
0C8BC: 03 02         ST0   #$02
0C8BE: 20 1A C9      JSR   $C91A
0C8C1: AD 1D 35      LDA   $351D
0C8C4: 0A            ASL 
0C8C5: A8            TAY 
0C8C6: BE 0A C9      LDX   $C90A,Y
0C8C9: C8            INY 
0C8CA: B9 0A C9      LDA   $C90A,Y
0C8CD: A8            TAY 
0C8CE: 20 66 C9      JSR   $C966
0C8D1: 03 02         ST0   #$02
0C8D3: 20 3F C9      JSR   $C93F
0C8D6: AD 1D 35      LDA   $351D
0C8D9: C9 08         CMP   #$08
0C8DB: D0 CF         BNE   $C8AC

0C8DD: EE 1B 35      INC   $351B
0C8E0: AD 1B 35      LDA   $351B
0C8E3: CD 1C 35      CMP   $351C
0C8E6: F0 02         BEQ   $C8EA
0C8E8: 80 03         BRA   $C8ED
0C8EA: 9C 1B 35      STZ   $351B

0C8ED: AD 1A 35      LDA   $351A	; PATCH POINT #5
0C8F0: C9 0C         CMP   #$0C		; check for residual shift amount
0C8F2: 90 0B         BCC   $C8FF
0C8F4: 38            SEC 
0C8F5: E9 0C         SBC   #$0C		; reduce the residual shift amount
0C8F7: 8D 1A 35      STA   $351A
0C8FA: 20 37 CB      JSR   $CB37
0C8FD: 80 0A         BRA   $C909
0C8FF: AD 1A 35      LDA   $351A
0C902: 18            CLC 
0C903: 6D 18 35      ADC   $3518
0C906: 8D 1A 35      STA   $351A
0C909: 60            RTS 

;
; lookup table
;
0C90A: 00 00 
0C90C: 00 00
0C90E: 01 00
0C910: 01 00
0C912: 10 00
0C914: 10 00
0C916: 11 00
0C918: 11 00

;
; take 2 bits of color (within palette) data, and change to VRAM data
;
0C91A: AD 17 35      LDA   $3517
0C91D: 29 03         AND   #$03
0C91F: 0A            ASL 
0C920: AA            TAX 
0C921: 7C 24 C9      JMP   ($C924,X)

;
; Jump table
;
0C924: 2C C9		; addr for routine to load two bits (00) of color data into VRAM
0C926: 31 C9		; addr for routine to load two bits (01) of color data into VRAM
0C927: 36 C9		; addr for routine to load two bits (10) of color data into VRAM
0C92A: 3B C9		; addr for routine to load two bits (11) of color data into VRAM

0C92C: 20 77 CA      JSR   $CA77
0C92F: 80 0D         BRA   $C93E

0C931: 20 88 CA      JSR   $CA88
0C934: 80 08         BRA   $C93E

0C936: 20 9A CA      JSR   $CA9A
0C939: 80 03         BRA   $C93E

0C93B: 20 AC CA      JSR   $CAAC
0C93E: 60            RTS 

;
; take 2 bits of color (within palette) data, and change to VRAM data
;
0C93F: AD 17 35      LDA   $3517
0C942: 4A            LSR 
0C943: 4A            LSR 
0C944: 29 03         AND   #$03
0C946: 0A            ASL 
0C947: AA            TAX 
0C948: 7C 4B C9      JMP   ($C94B,X)

;
; Jump table
;
0C94B: 53 C9		; addr for routine to load two bits (00) of color data into VRAM
0C94D: 58 C9		; addr for routine to load two bits (01) of color data into VRAM
0C94F: 5D C9		; addr for routine to load two bits (10) of color data into VRAM
0C951: 62 C9		; addr for routine to load two bits (11) of color data into VRAM

0C953: 20 77 CA      JSR   $CA77
0C956: 80 0D         BRA   $C965

0C958: 20 88 CA      JSR   $CA88
0C95B: 80 08         BRA   $C965

0C95D: 20 9A CA      JSR   $CA9A
0C960: 80 03         BRA   $C965

0C962: 20 AC CA      JSR   $CAAC
0C965: 60            RTS 

0C966: BD 29 35      LDA   $3529,X
0C969: 99 69 35      STA   $3569,Y
0C96C: E8            INX 
0C96D: E8            INX 
0C96E: C8            INY 
0C96F: C0 08         CPY   #$08
0C971: D0 F3         BNE   $C966
0C973: 9C 71 35      STZ   $3571
0C976: 9C 7B 35      STZ   $357B
0C979: AD 1B 35      LDA   $351B
0C97C: 8D 7A 35      STA   $357A
0C97F: 82            CLX 
0C980: 0E 7A 35      ASL   $357A
0C983: 2E 7B 35      ROL   $357B
0C986: E8            INX 
0C987: E0 06         CPX   #$06
0C989: D0 F5         BNE   $C980
0C98B: AD 08 35      LDA   $3508
0C98E: 18            CLC 
0C98F: 6D 7A 35      ADC   $357A
0C992: 8D 0A 35      STA   $350A
0C995: AD 09 35      LDA   $3509
0C998: 6D 7B 35      ADC   $357B
0C99B: 8D 0B 35      STA   $350B
0C99E: 03 00         ST0   #$00
0C9A0: AD 1D 35      LDA   $351D
0C9A3: 0A            ASL 
0C9A4: 0A            ASL 
0C9A5: 0A            ASL 
0C9A6: 18            CLC 
0C9A7: 6D 0A 35      ADC   $350A
0C9AA: 8D 02 00      STA   $0002
0C9AD: AD 0B 35      LDA   $350B
0C9B0: 69 00         ADC   #$00
0C9B2: 8D 03 00      STA   $0003
0C9B5: EE 1D 35      INC   $351D
0C9B8: 60            RTS 
0C9B9: BD 49 35      LDA   $3549,X
0C9BC: 99 69 35      STA   $3569,Y
0C9BF: E8            INX 
0C9C0: E8            INX 
0C9C1: C8            INY 
0C9C2: C0 08         CPY   #$08
0C9C4: D0 F3         BNE   $C9B9
0C9C6: 9C 71 35      STZ   $3571
0C9C9: 9C 7B 35      STZ   $357B
0C9CC: AD 1B 35      LDA   $351B
0C9CF: 8D 7A 35      STA   $357A
0C9D2: 82            CLX 
0C9D3: 0E 7A 35      ASL   $357A
0C9D6: 2E 7B 35      ROL   $357B
0C9D9: E8            INX 
0C9DA: E0 06         CPX   #$06
0C9DC: D0 F5         BNE   $C9D3
0C9DE: AD 08 35      LDA   $3508
0C9E1: 18            CLC 
0C9E2: 6D 7A 35      ADC   $357A
0C9E5: 8D 0A 35      STA   $350A
0C9E8: AD 09 35      LDA   $3509
0C9EB: 6D 7B 35      ADC   $357B
0C9EE: 8D 0B 35      STA   $350B
0C9F1: 03 00         ST0   #$00
0C9F3: AD 1D 35      LDA   $351D
0C9F6: 0A            ASL 
0C9F7: 0A            ASL 
0C9F8: 0A            ASL 
0C9F9: 18            CLC 
0C9FA: 6D 0A 35      ADC   $350A
0C9FD: 8D 02 00      STA   $0002
0CA00: AD 0B 35      LDA   $350B
0CA03: 69 00         ADC   #$00
0CA05: 8D 03 00      STA   $0003
0CA08: EE 1D 35      INC   $351D
0CA0B: 60            RTS 

;
; Take 16x16 tile at $3529 and turn into 8x8 tile
; at $3569
;
0CA0C: BD 29 35      LDA   $3529,X	; take one quadrant of 16x16 tile
0CA0F: 99 69 35      STA   $3569,Y	; and extract 8x8 tile into $3569 (8-byte buffer)
0CA12: E8            INX 
0CA13: E8            INX 
0CA14: C8            INY 
0CA15: C0 08         CPY   #$08
0CA17: D0 F3         BNE   $CA0C

0CA19: 9C 71 35      STZ   $3571
0CA1C: 9C 7B 35      STZ   $357B
0CA1F: AD 1B 35      LDA   $351B	; index into pool of 16x16 virtual tiles
0CA22: D0 06         BNE   $CA2A	; if not first tile, go to $CA2A

0CA24: AD 1C 35      LDA   $351C	; if first tile, take "last tile" (dedicated blank)
0CA27: 3A            DEC 		; and DEC
0CA28: 80 10         BRA   $CA3A

0CA2A: AD 1B 35      LDA   $351B	; decrement current virtual tile index
0CA2D: 3A            DEC 
0CA2E: C9 FF         CMP   #$FF		; if underflow (i.e. it was $00 just now)
0CA30: F0 02         BEQ   $CA34
0CA32: 80 06         BRA   $CA3A

0CA34: AD 1C 35      LDA   $351C	; if first tile, take "last tile" (dedicated blank)
0CA37: 3A            DEC		; and DEC
0CA38: 80 00         BRA   $CA3A

0CA3A: 8D 7A 35      STA   $357A	; take value in $357A, and shift 6 bits left
0CA3D: 82            CLX		; (i.e. multiply by 64)
0CA3E: 0E 7A 35      ASL   $357A
0CA41: 2E 7B 35      ROL   $357B
0CA44: E8            INX 
0CA45: E0 06         CPX   #$06
0CA47: D0 F5         BNE   $CA3E

0CA49: AD 08 35      LDA   $3508	; add base VRAM address of character def'n data 
0CA4C: 18            CLC 
0CA4D: 6D 7A 35      ADC   $357A
0CA50: 8D 0A 35      STA   $350A
0CA53: AD 09 35      LDA   $3509
0CA56: 6D 7B 35      ADC   $357B
0CA59: 8D 0B 35      STA   $350B

0CA5C: 03 00         ST0   #$00
0CA5E: AD 1D 35      LDA   $351D	; take value in $351D (??)
0CA61: 0A            ASL		; multiply by 8
0CA62: 0A            ASL 
0CA63: 0A            ASL 
0CA64: 18            CLC 
0CA65: 6D 0A 35      ADC   $350A	; Add to VRAM address just calculated
0CA68: 8D 02 00      STA   $0002
0CA6B: AD 0B 35      LDA   $350B
0CA6E: 69 00         ADC   #$00
0CA70: 8D 03 00      STA   $0003
0CA73: EE 1D 35      INC   $351D
0CA76: 60            RTS

;
; translate 2 bits of color data into bitplanes (00 color) 
;
0CA77: 82            CLX 
0CA78: A9 00         LDA   #$00
0CA7A: 8D 02 00      STA   $0002
0CA7D: A9 00         LDA   #$00
0CA7F: 8D 03 00      STA   $0003
0CA82: E8            INX 
0CA83: E0 08         CPX   #$08
0CA85: D0 F1         BNE   $CA78
0CA87: 60            RTS 

;
; translate 2 bits of color data into bitplanes (01 color) 
;
0CA88: 82            CLX 
0CA89: BD 69 35      LDA   $3569,X
0CA8C: 8D 02 00      STA   $0002
0CA8F: A9 00         LDA   #$00
0CA91: 8D 03 00      STA   $0003
0CA94: E8            INX 
0CA95: E0 08         CPX   #$08
0CA97: D0 F0         BNE   $CA89
0CA99: 60            RTS 

;
; translate 2 bits of color data into bitplanes (10 color) 
;
0CA9A: 82            CLX 
0CA9B: A9 00         LDA   #$00
0CA9D: 8D 02 00      STA   $0002
0CAA0: BD 69 35      LDA   $3569,X
0CAA3: 8D 03 00      STA   $0003
0CAA6: E8            INX 
0CAA7: E0 08         CPX   #$08
0CAA9: D0 F0         BNE   $CA9B
0CAAB: 60            RTS 

;
; translate 2 bits of color data into bitplanes (11 color) 
;
0CAAC: 82            CLX 
0CAAD: BD 69 35      LDA   $3569,X
0CAB0: 8D 02 00      STA   $0002
0CAB3: BD 69 35      LDA   $3569,X
0CAB6: 8D 03 00      STA   $0003
0CAB9: E8            INX 
0CABA: E0 08         CPX   #$08
0CABC: D0 EF         BNE   $CAAD
0CABE: 60            RTS 

;
; Clear $3529 buffer area
;
0CABF: A9 00         LDA   #$00
0CAC1: 8D 29 35      STA   $3529
0CAC4: 8D 2A 35      STA   $352A
0CAC7: F3 29 35 29 35 20 00  TAI   $3529, $3529, $0020
0CACE: 60            RTS 

;
; Clear $3549 buffer area
;
0CACF: A9 00         LDA   #$00
0CAD1: 8D 49 35      STA   $3549
0CAD4: 8D 4A 35      STA   $354A
0CAD7: F3 49 35 49 35 20 00  TAI   $3549, $3549, $0020
0CADE: 60            RTS 

;
; Get graphics for custom characters
;
0CADF: DA            PHX 
0CAE0: 5A            PHY 
0CAE1: AD 28 35      LDA   $3528	; get character
0CAE4: 8D 7A 35      STA   $357A	; put it in $357A/B
0CAE7: 9C 7B 35      STZ   $357B	; shift left 5 bits (multiply by 32 bytes per char def'n)
0CAEA: 82            CLX 
0CAEB: 0E 7A 35      ASL   $357A
0CAEE: 2E 7B 35      ROL   $357B
0CAF1: E8            INX 
0CAF2: E0 05         CPX   #$05
0CAF4: D0 F5         BNE   $CAEB
0CAF6: A9 92         LDA   #$92		; add $CB92 to value in
0CAF8: 18            CLC 		; $357A/B
0CAF9: 6D 7A 35      ADC   $357A
0CAFC: 85 70         STA   $70		; and store it in ZP $70/71
0CAFE: A9 CB         LDA   #$CB
0CB00: 6D 7B 35      ADC   $357B
0CB03: 85 71         STA   $71
0CB05: C2            CLY 
0CB06: B1 70         LDA   ($70),Y	; get $20 bytes from that
0CB08: 99 29 35      STA   $3529,Y	; address and put them at
0CB0B: C8            INY 		; $3529
0CB0C: C0 20         CPY   #$20
0CB0E: D0 F6         BNE   $CB06
0CB10: 7A            PLY 
0CB11: FA            PLX 
0CB12: 60            RTS 		; then return

;
; Inc text pointer @ $351E/1F
;
0CB13: AD 1E 35      LDA   $351E
0CB16: 18            CLC 
0CB17: 69 01         ADC   #$01
0CB19: 8D 1E 35      STA   $351E
0CB1C: AD 1F 35      LDA   $351F
0CB1F: 69 00         ADC   #$00
0CB21: 8D 1F 35      STA   $351F
0CB24: 60            RTS 

;
; Dec text pointer @ $351E/1F
;
0CB25: AD 1E 35      LDA   $351E
0CB28: 38            SEC 
0CB29: E9 01         SBC   #$01
0CB2B: 8D 1E 35      STA   $351E
0CB2E: AD 1F 35      LDA   $351F
0CB31: E9 00         SBC   #$00
0CB33: 8D 1F 35      STA   $351F
0CB36: 60            RTS 

;
; Dec $351B, reloading from $351C when zero
; -> decrement index of current virtual tile number
;
0CB37: AD 1B 35      LDA   $351B
0CB3A: F0 05         BEQ   $CB41	; if already zero, goto $CB41
0CB3C: CE 1B 35      DEC   $351B	; else, decrement index
0CB3F: 80 09         BRA   $CB4A	; and return

0CB41: AD 1C 35      LDA   $351C	; if zero, take # of tiles in pool
0CB44: 3A            DEC		; and decrement (last tile = blank)
0CB45: 8D 1B 35      STA   $351B	; and put it into index
0CB48: 80 00         BRA   $CB4A	; useless instruction
0CB4A: 60            RTS 

;
; convert X/Y location into Video address
;
; input:  X = x-coordinate of tile position
;         Y = y-coordinate of tile position
;
; output: BAT address value in $357C/7D
;
0CB4B: 9C 7D 35      STZ   $357D	; scratch values in $357D/7E
0CB4E: 9C 7E 35      STZ   $357E	; first, set to zero
0CB51: C0 00         CPY   #$00
0CB53: F0 14         BEQ   $CB69
0CB55: AD 7D 35      LDA   $357D	; add $40 for each 'Y' value
0CB58: 18            CLC 
0CB59: 69 40         ADC   #$40
0CB5B: 8D 7D 35      STA   $357D
0CB5E: AD 7E 35      LDA   $357E
0CB61: 69 00         ADC   #$00
0CB63: 8D 7E 35      STA   $357E
0CB66: 88            DEY 
0CB67: 80 E8         BRA   $CB51	; loop until 'Y' = 0
0CB69: 8A            TXA 
0CB6A: 18            CLC 
0CB6B: 6D 7D 35      ADC   $357D	; now add 'X' value
0CB6E: 8D 7C 35      STA   $357C	; note: storing in $357C/7D (not 7D/7E)
0CB71: AD 7E 35      LDA   $357E
0CB74: 69 00         ADC   #$00
0CB76: 8D 7D 35      STA   $357D
0CB79: 60            RTS 

;
; unknown data
;
0CB7A: 00 40
0CB7C: 00 40
0CB7E: 00 40
0CB80: 00 40
0CB82: 00 40
0CB84: 00 40
0CB86: 00 40
0CB88: 00 40
0CB8A: 00 40
0CB8C: 00 40
0CB8E: 00 40
0CB90: 00 40

;
; graphics for custom character
;
0CB92: 03 00	; ------XX--------
0CB94: 7F F8	; -XXXXXXXXXXXX---
0CB96: 08 40	; ----X----X------
0CB98: 0F C0	; ----XXXXXX------
0CB9A: 08 40	; ----X----X------
0CB9C: 0F C0	; ----XXXXXX------
0CB9E: 08 40	; ----X----X------
0CBA0: 3F F0	; --XXXXXXXXXX----
0CBA2: 20 10	; --X--------X----
0CBA4: 2F D0	; --X-XXXXXX-X----
0CBA6: 28 50	; --X-X----X-X----
0CBA8: 2F F0	; --X-XXXXXXXX----
0CBAA: 00 00
0CBAC: 00 00
0CBAE: 00 00
0CBB0: 00 00


0CBB2: AD 64 2F      LDA   $2F64
0CBB5: D0 07         BNE   $CBBE
0CBB7: AD 91 3C      LDA   $3C91
0CBBA: F0 02         BEQ   $CBBE
0CBBC: 80 01         BRA   $CBBF
0CBBE: 60            RTS 
0CBBF: 43 04         TMA   #$04
0CBC1: 48            PHA 
0CBC2: A9 02         LDA   #$02
0CBC4: 18            CLC 
0CBC5: 6D 48 26      ADC   $2648
0CBC8: 53 04         TAM   #$04
0CBCA: AD 91 3C      LDA   $3C91
0CBCD: CD BC 35      CMP   $35BC
0CBD0: F0 1D         BEQ   $CBEF
0CBD2: C9 01         CMP   #$01
0CBD4: D0 10         BNE   $CBE6
0CBD6: 20 7A D5      JSR   $D57A
0CBD9: 9C 91 3C      STZ   $3C91
0CBDC: 9C BC 35      STZ   $35BC
0CBDF: 9C BB 35      STZ   $35BB
0CBE2: 68            PLA 
0CBE3: 53 04         TAM   #$04
0CBE5: 60            RTS 
0CBE6: 8D BC 35      STA   $35BC
0CBE9: 20 5B D2      JSR   $D25B
0CBEC: 20 D1 D3      JSR   $D3D1
0CBEF: AD BB 35      LDA   $35BB
0CBF2: C9 03         CMP   #$03
0CBF4: D0 07         BNE   $CBFD
0CBF6: 20 D4 CC      JSR   $CCD4
0CBF9: 68            PLA 
0CBFA: 53 04         TAM   #$04
0CBFC: 60            RTS 
0CBFD: AD BB 35      LDA   $35BB
0CC00: C9 04         CMP   #$04
0CC02: F0 06         BEQ   $CC0A
0CC04: C9 05         CMP   #$05
0CC06: F0 02         BEQ   $CC0A
0CC08: 80 25         BRA   $CC2F
0CC0A: AD D2 35      LDA   $35D2
0CC0D: 29 08         AND   #$08
0CC0F: D0 1E         BNE   $CC2F
0CC11: AE D2 35      LDX   $35D2
0CC14: BD AB D8      LDA   $D8AB,X
0CC17: 8D C5 35      STA   $35C5
0CC1A: AD D2 35      LDA   $35D2
0CC1D: 0A            ASL 
0CC1E: AA            TAX 
0CC1F: 20 2F D4      JSR   $D42F
0CC22: AD D2 35      LDA   $35D2
0CC25: 1A            INC 
0CC26: 8D D2 35      STA   $35D2
0CC29: C9 04         CMP   #$04
0CC2B: D0 E4         BNE   $CC11
0CC2D: 80 32         BRA   $CC61
0CC2F: AD D2 35      LDA   $35D2
0CC32: 29 08         AND   #$08
0CC34: D0 6D         BNE   $CCA3
0CC36: AD D2 35      LDA   $35D2
0CC39: 29 04         AND   #$04
0CC3B: D0 24         BNE   $CC61
0CC3D: AD D1 35      LDA   $35D1
0CC40: 3A            DEC 
0CC41: 8D D1 35      STA   $35D1
0CC44: D0 5D         BNE   $CCA3
0CC46: A9 3C         LDA   #$3C
0CC48: 8D D1 35      STA   $35D1
0CC4B: AE D2 35      LDX   $35D2
0CC4E: BD AB D8      LDA   $D8AB,X
0CC51: 8D C5 35      STA   $35C5
0CC54: AD D2 35      LDA   $35D2
0CC57: 0A            ASL 
0CC58: AA            TAX 
0CC59: 20 2F D4      JSR   $D42F
0CC5C: EE D2 35      INC   $35D2
0CC5F: 80 42         BRA   $CCA3
0CC61: AD D2 35      LDA   $35D2
0CC64: 29 10         AND   #$10
0CC66: D0 3B         BNE   $CCA3
0CC68: AD D2 35      LDA   $35D2
0CC6B: 09 18         ORA   #$18
0CC6D: 8D D2 35      STA   $35D2
0CC70: AD BB 35      LDA   $35BB
0CC73: D0 03         BNE   $CC78
0CC75: 20 90 D5      JSR   $D590
0CC78: AD BB 35      LDA   $35BB
0CC7B: C9 05         CMP   #$05
0CC7D: D0 0A         BNE   $CC89
0CC7F: A9 80         LDA   #$80
0CC81: 8D 91 3C      STA   $3C91
0CC84: 8D BC 35      STA   $35BC
0CC87: 80 08         BRA   $CC91
0CC89: A9 03         LDA   #$03
0CC8B: 8D 91 3C      STA   $3C91
0CC8E: 8D BC 35      STA   $35BC
0CC91: A9 00         LDA   #$00
0CC93: 8D CE 35      STA   $35CE
0CC96: AD D0 35      LDA   $35D0
0CC99: 8D CF 35      STA   $35CF
0CC9C: A2 06         LDX   #$06
0CC9E: 20 C6 D3      JSR   $D3C6
0CCA1: 80 03         BRA   $CCA6
0CCA3: 20 28 D3      JSR   $D328
0CCA6: AD D2 35      LDA   $35D2
0CCA9: 29 08         AND   #$08
0CCAB: F0 03         BEQ   $CCB0
0CCAD: 20 57 D4      JSR   $D457
0CCB0: AD CE 35      LDA   $35CE
0CCB3: 29 80         AND   #$80
0CCB5: F0 19         BEQ   $CCD0
0CCB7: AD BB 35      LDA   $35BB
0CCBA: C9 05         CMP   #$05
0CCBC: D0 0A         BNE   $CCC8
0CCBE: A9 40         LDA   #$40
0CCC0: 8D 91 3C      STA   $3C91
0CCC3: 8D BC 35      STA   $35BC
0CCC6: 80 08         BRA   $CCD0
0CCC8: A9 02         LDA   #$02
0CCCA: 8D 91 3C      STA   $3C91
0CCCD: 8D BC 35      STA   $35BC
0CCD0: 68            PLA 
0CCD1: 53 04         TAM   #$04
0CCD3: 60            RTS 
0CCD4: 20 28 D3      JSR   $D328
0CCD7: 20 EA D4      JSR   $D4EA
0CCDA: 60            RTS 
0CCDB: AD 90 3C      LDA   $3C90
0CCDE: F0 0C         BEQ   $CCEC
0CCE0: AD 12 35      LDA   $3512
0CCE3: D0 07         BNE   $CCEC
0CCE5: AD 64 2F      LDA   $2F64
0CCE8: D0 02         BNE   $CCEC
0CCEA: 80 01         BRA   $CCED
0CCEC: 60            RTS 
0CCED: 43 04         TMA   #$04
0CCEF: 48            PHA 
0CCF0: A9 02         LDA   #$02
0CCF2: 18            CLC 
0CCF3: 6D 48 26      ADC   $2648
0CCF6: 53 04         TAM   #$04
0CCF8: AD 90 3C      LDA   $3C90
0CCFB: 0A            ASL 
0CCFC: AA            TAX 
0CCFD: 7C 00 CD      JMP   ($CD00,X)

0CD00: EF CE
0CD02: CF CD
0CD04: FF CD
0CD06: FF CD
0CD08: FF CD
0CD0A: 8B CD
0CD0C: 8B CD
0CD0E: 8B CD
0CD10: 8B CD
0CD12: 8B CD
0CD14: 8B CD
0CD16: 24 CD
0CD18: 58 CD
0CD1A: 58 CD
0CD1C: 58 CD
0CD1E: 58 CD
0CD20: FF CD
0CD22: FF CD

0CD24: AD 90 3C      LDA   $3C90
0CD27: CD BA 35      CMP   $35BA
0CD2A: F0 12         BEQ   $CD3E
0CD2C: 8D BA 35      STA   $35BA
0CD2F: 20 54 D1      JSR   $D154
0CD32: 20 7B D6      JSR   $D67B
0CD35: 9C 92 3C      STZ   $3C92
0CD38: 9C C1 35      STZ   $35C1
0CD3B: 9C D3 35      STZ   $35D3
0CD3E: 20 F3 CE      JSR   $CEF3
0CD41: A0 01         LDY   #$01
0CD43: 20 04 CF      JSR   $CF04
0CD46: 20 C4 CF      JSR   $CFC4
0CD49: AD 90 3C      LDA   $3C90
0CD4C: D0 06         BNE   $CD54
0CD4E: 9C BA 35      STZ   $35BA
0CD51: 20 D8 D6      JSR   $D6D8
0CD54: 68            PLA 
0CD55: 53 04         TAM   #$04
0CD57: 60            RTS 

0CD58: AD 90 3C      LDA   $3C90
0CD5B: CD BA 35      CMP   $35BA
0CD5E: F0 12         BEQ   $CD72
0CD60: 8D BA 35      STA   $35BA
0CD63: 20 85 D1      JSR   $D185
0CD66: 20 7B D6      JSR   $D67B
0CD69: 9C 92 3C      STZ   $3C92
0CD6C: 9C C1 35      STZ   $35C1
0CD6F: 9C D3 35      STZ   $35D3
0CD72: 20 F3 CE      JSR   $CEF3
0CD75: C2            CLY 
0CD76: 20 04 CF      JSR   $CF04
0CD79: 20 C4 CF      JSR   $CFC4
0CD7C: AD 90 3C      LDA   $3C90
0CD7F: D0 06         BNE   $CD87
0CD81: 9C BA 35      STZ   $35BA
0CD84: 20 D8 D6      JSR   $D6D8
0CD87: 68            PLA 
0CD88: 53 04         TAM   #$04
0CD8A: 60            RTS 

0CD8B: AD 90 3C      LDA   $3C90
0CD8E: CD BA 35      CMP   $35BA
0CD91: F0 0F         BEQ   $CDA2
0CD93: 8D BA 35      STA   $35BA
0CD96: 20 85 D1      JSR   $D185
0CD99: 9C 92 3C      STZ   $3C92
0CD9C: 9C C1 35      STZ   $35C1
0CD9F: 9C D3 35      STZ   $35D3
0CDA2: 20 F3 CE      JSR   $CEF3
0CDA5: C2            CLY 
0CDA6: 20 04 CF      JSR   $CF04
0CDA9: 20 C4 CF      JSR   $CFC4
0CDAC: AD 90 3C      LDA   $3C90
0CDAF: D0 1A         BNE   $CDCB
0CDB1: AD BA 35      LDA   $35BA
0CDB4: C9 09         CMP   #$09
0CDB6: D0 0D         BNE   $CDC5
0CDB8: A8            TAY 
0CDB9: B9 FB D5      LDA   $D5FB,Y
0CDBC: A8            TAY 
0CDBD: A9 F0         LDA   #$F0
0CDBF: 8D C5 35      STA   $35C5
0CDC2: 20 0B D6      JSR   $D60B
0CDC5: 9C BA 35      STZ   $35BA
0CDC8: 20 DD D1      JSR   $D1DD
0CDCB: 68            PLA 
0CDCC: 53 04         TAM   #$04
0CDCE: 60            RTS 

0CDCF: AD 90 3C      LDA   $3C90
0CDD2: CD BA 35      CMP   $35BA
0CDD5: F0 0C         BEQ   $CDE3
0CDD7: 8D BA 35      STA   $35BA
0CDDA: 20 54 D1      JSR   $D154
0CDDD: 9C 92 3C      STZ   $3C92
0CDE0: 9C C1 35      STZ   $35C1
0CDE3: 20 F3 CE      JSR   $CEF3
0CDE6: C2            CLY 
0CDE7: 20 04 CF      JSR   $CF04
0CDEA: 20 C4 CF      JSR   $CFC4
0CDED: AD 90 3C      LDA   $3C90
0CDF0: D0 09         BNE   $CDFB
0CDF2: 9C BA 35      STZ   $35BA
0CDF5: 20 DD D1      JSR   $D1DD
0CDF8: 20 46 D2      JSR   $D246
0CDFB: 68            PLA 
0CDFC: 53 04         TAM   #$04
0CDFE: 60            RTS 

0CDFF: AD 90 3C      LDA   $3C90
0CE02: CD BA 35      CMP   $35BA
0CE05: F0 37         BEQ   $CE3E
0CE07: 8D BA 35      STA   $35BA
0CE0A: 20 5B D2      JSR   $D25B
0CE0D: 20 F3 CE      JSR   $CEF3
0CE10: 20 D1 D3      JSR   $D3D1
0CE13: AD 90 3C      LDA   $3C90
0CE16: C9 03         CMP   #$03
0CE18: F0 06         BEQ   $CE20
0CE1A: C9 11         CMP   #$11
0CE1C: F0 02         BEQ   $CE20
0CE1E: 80 1E         BRA   $CE3E
0CE20: AE D2 35      LDX   $35D2
0CE23: BD AB D8      LDA   $D8AB,X
0CE26: 8D C5 35      STA   $35C5
0CE29: AD D2 35      LDA   $35D2
0CE2C: 0A            ASL 
0CE2D: AA            TAX 
0CE2E: 20 2F D4      JSR   $D42F
0CE31: AD D2 35      LDA   $35D2
0CE34: 1A            INC 
0CE35: 8D D2 35      STA   $35D2
0CE38: C9 04         CMP   #$04
0CE3A: D0 E4         BNE   $CE20
0CE3C: 80 32         BRA   $CE70
0CE3E: AD D2 35      LDA   $35D2
0CE41: 29 08         AND   #$08
0CE43: D0 72         BNE   $CEB7
0CE45: AD D2 35      LDA   $35D2
0CE48: 29 04         AND   #$04
0CE4A: D0 24         BNE   $CE70
0CE4C: AD D1 35      LDA   $35D1
0CE4F: 3A            DEC 
0CE50: 8D D1 35      STA   $35D1
0CE53: D0 62         BNE   $CEB7
0CE55: A9 3C         LDA   #$3C
0CE57: 8D D1 35      STA   $35D1
0CE5A: AE D2 35      LDX   $35D2
0CE5D: BD AB D8      LDA   $D8AB,X
0CE60: 8D C5 35      STA   $35C5
0CE63: AD D2 35      LDA   $35D2
0CE66: 0A            ASL 
0CE67: AA            TAX 
0CE68: 20 2F D4      JSR   $D42F
0CE6B: EE D2 35      INC   $35D2
0CE6E: 80 47         BRA   $CEB7
0CE70: AD D2 35      LDA   $35D2
0CE73: 29 10         AND   #$10
0CE75: D0 40         BNE   $CEB7
0CE77: AD D2 35      LDA   $35D2
0CE7A: 09 18         ORA   #$18
0CE7C: 8D D2 35      STA   $35D2
0CE7F: 9C 93 3C      STZ   $3C93
0CE82: 20 90 D5      JSR   $D590
0CE85: 20 CE D7      JSR   $D7CE
0CE88: A9 00         LDA   #$00
0CE8A: 8D CE 35      STA   $35CE
0CE8D: AD D0 35      LDA   $35D0
0CE90: 8D CF 35      STA   $35CF
0CE93: A2 06         LDX   #$06
0CE95: 20 C6 D3      JSR   $D3C6
0CE98: 20 54 D1      JSR   $D154
0CE9B: AD 90 3C      LDA   $3C90
0CE9E: C9 10         CMP   #$10
0CEA0: 30 0D         BMI   $CEAF
0CEA2: AD B8 35      LDA   $35B8
0CEA5: 29 F0         AND   #$F0
0CEA7: 09 08         ORA   #$08
0CEA9: 8D B8 35      STA   $35B8
0CEAC: 20 7B D6      JSR   $D67B
0CEAF: 9C 92 3C      STZ   $3C92
0CEB2: 9C C1 35      STZ   $35C1
0CEB5: 80 03         BRA   $CEBA
0CEB7: 20 28 D3      JSR   $D328
0CEBA: AD D2 35      LDA   $35D2
0CEBD: 29 08         AND   #$08
0CEBF: F0 0B         BEQ   $CECC
0CEC1: 20 57 D4      JSR   $D457
0CEC4: A0 01         LDY   #$01
0CEC6: 20 04 CF      JSR   $CF04
0CEC9: 20 C4 CF      JSR   $CFC4
0CECC: AD 90 3C      LDA   $3C90
0CECF: D0 1E         BNE   $CEEF
0CED1: 20 5F D5      JSR   $D55F
0CED4: 20 7A D5      JSR   $D57A
0CED7: AD BA 35      LDA   $35BA
0CEDA: C9 10         CMP   #$10
0CEDC: 30 08         BMI   $CEE6
0CEDE: 9C BA 35      STZ   $35BA
0CEE1: 20 D8 D6      JSR   $D6D8
0CEE4: 80 09         BRA   $CEEF
0CEE6: 9C BA 35      STZ   $35BA
0CEE9: 20 DD D1      JSR   $D1DD
0CEEC: 20 46 D2      JSR   $D246
0CEEF: 68            PLA 
0CEF0: 53 04         TAM   #$04
0CEF2: 60            RTS 

0CEF3: AD 94 3C      LDA   $3C94
0CEF6: 0A            ASL 
0CEF7: A8            TAY 
0CEF8: B9 00 40      LDA   $4000,Y
0CEFB: 85 7E         STA   $7E
0CEFD: C8            INY 
0CEFE: B9 00 40      LDA   $4000,Y
0CF01: 85 7F         STA   $7F
0CF03: 60            RTS 
0CF04: AD 90 3C      LDA   $3C90
0CF07: C9 0B         CMP   #$0B
0CF09: 30 14         BMI   $CF1F
0CF0B: 18            CLC 
0CF0C: AD BF 3D      LDA   $3DBF
0CF0F: 69 08         ADC   #$08
0CF11: 8D BE 35      STA   $35BE
0CF14: 18            CLC 
0CF15: AD C1 3D      LDA   $3DC1
0CF18: 69 08         ADC   #$08
0CF1A: 8D C0 35      STA   $35C0
0CF1D: 80 0C         BRA   $CF2B
0CF1F: AD BF 3D      LDA   $3DBF
0CF22: 8D BE 35      STA   $35BE
0CF25: AD C1 3D      LDA   $3DC1
0CF28: 8D C0 35      STA   $35C0
0CF2B: B1 7E         LDA   ($7E),Y
0CF2D: 8D BD 35      STA   $35BD
0CF30: CD BE 35      CMP   $35BE
0CF33: B0 7A         BCS   $CFAF
0CF35: C8            INY 
0CF36: B1 7E         LDA   ($7E),Y
0CF38: 8D BF 35      STA   $35BF
0CF3B: C8            INY 
0CF3C: C8            INY 
0CF3D: B1 7E         LDA   ($7E),Y
0CF3F: 18            CLC 
0CF40: 6D BF 35      ADC   $35BF
0CF43: CD C0 35      CMP   $35C0
0CF46: 90 6A         BCC   $CFB2
0CF48: 88            DEY 
0CF49: B1 7E         LDA   ($7E),Y
0CF4B: 18            CLC 
0CF4C: 6D BD 35      ADC   $35BD
0CF4F: B0 07         BCS   $CF58
0CF51: CD BE 35      CMP   $35BE
0CF54: 90 5B         BCC   $CFB1
0CF56: 80 05         BRA   $CF5D
0CF58: CD BE 35      CMP   $35BE
0CF5B: B0 54         BCS   $CFB1
0CF5D: AD BF 35      LDA   $35BF
0CF60: CD C0 35      CMP   $35C0
0CF63: B0 4C         BCS   $CFB1
0CF65: C8            INY 
0CF66: C8            INY 
0CF67: B1 7E         LDA   ($7E),Y
0CF69: 29 7F         AND   #$7F
0CF6B: 1A            INC 
0CF6C: 8D C4 35      STA   $35C4
0CF6F: AD 90 3C      LDA   $3C90
