; "Dead of the Brain 1"
;
; Disassembly of the print routine
;
; CDROM offset (within Track 2):
; 0x15800 (matches with PC Engine mem addr = $C000)


; Notes:
; ------
;
; RAM usage:
;
; zero-page:
; ----------
; $70/71 = pointer used for copying special chr to kanji mem (CADF routine)
; $72/73 = actual text pointer (based from $76/77 + $351E/F)
; $76/77 = base addres of block of text
;
;
; RAM:
; ----
;
; $3508/9 = VRAM addr of start of graphic data, where tiles are defined
;           (i.e. $00/$70 -> $7000)
; $350A/B = VRAM addr of graphic data of specific tile being worked on
;           (i.e. $C0/$7F -> $7FC0)

; $350C = min x-position of display block (in 8x8 tiles) (i.e. $22)
; $350D = min y-position of display block (in 8x8 tiles) (i.e. $05)
;
; $350E = max x-size of display block (in 16x16 virtual tiles) (i.e. $0E)
; $350F = max y-size of display block (in 16x16 virtual tiles) (i.e. $03)
;
; $3510 = Message number (within block) to print
;
; $3512 = control byte (bitmask)
;         start/stop flag for text display
;         Values:
;         00 = bytecode processing is stopped
;         01 = bytecode prcoessing is enabled
;         02 = clear screen, then set to 0 (to stop processing)
;         03 = currently in a WAIT state during a (0B) bytecode
;
; $3513 = control byte (bitmask) -> usually set to 0x43
;         ** set by 07 bytecode **
;         XXXXXXXX
;         XXXX     -> backset # pixels from a 16-pixel character size
;                     (ie. use 4 for 12-pixel, 2 for 14-pixel, etc.)
;                     (used for left-shifting a font bitmap)
;             X    -> ??
;              X   -> how many tiles to use in pool (at $351C)
;                     (0 = 0x3F; 1 = 0x1F)
;               X  -> flag indicating whether to use above pixel adjust
;                     (0=ignore, 1=use)
;                X -> kanji size; 0=16x16, 1=12x12
;
; $3514 = BAT pallete color (this tile) -> always 0xF0 in text
;         ** set by 04 bytecode **
;         XXXX0000
;
; $3515 = control byte for joypad key used in "wait for joypad key"
;         ** set by 02 bytecode **
;         XXXXXXXX
;         X        -> left
;          X       -> down
;           X      -> right
;            X     -> up
;             X    -> run
;              X   -> select
;               X  -> two
;                X -> one
;
; $3516 = joypad key to accelerate printing display
;         ** set by 0C bytecode **
;         XXXXXXXX
;         X        -> left
;          X       -> down
;           X      -> right
;            X     -> up
;             X    -> run
;              X   -> select
;               X  -> two
;                X -> one
;
; $3517 = Graphics pallet color (pixels in character)
;         -> always 0x0F in text
;         ** set by 06 bytecode **
;
; $3518 = left-shift bitmap amount
;         ** set when 07 bytecode set - as a dependent value
;         0000XXXX -> backset # pixels from a 16-pixel character size
;                     (ie. use 4 for 12-pixel, 2 for 14-pixel, etc.)
;                     (used for left-shifting a font bitmap)
;
; $3519 = unused ?
;
; $351A = residual shift amount for next character (4 after printing 1 char)
;
; $351B = current index of 16x16 virtual tile being defined
;         (ie. 2nd half of cross-tile data)
;
; $351C = maximum index of 16x16 virtual tile which can be defined
;         (either $1F or $3F - generally $3F)
;         ** set when 07 bytecode set - as a dependent value
;
; $351D = ??
;
; $351E/F = offset within text message
;
; $3520 = current index of which 16x16 virtual tile is being defined (pre-alloc); value
;         incremented early, before graphic data is mixed
;
; $3521 = x-offset of cursor pos in text display area (starts as $00); value
;         gets increased as tile gets mapped to BBAT, but before graphic data loaded
;
; $3522 = y-offset of cursor pos in text display area (starts as $00)
;
; $3523 = countdown time for delay between prcoessing
;         characters (iterations) -> reload value0
;         ** set by 05 bytecode **
;
; $3524 = countdown time for delay between processing
;         characters (iterations) -> current countdown value
;
; $3525/6 = temporary area for kanji SJIS value
;
; $3527/8 = address work area used for special 16x16 character
;           address calculation
;           ** set within processing of 09 bytecode **
;           for CODE09=XX,
;             $3527 = 01 (CODE09 in use)
;             $3528 = XX
;
; $3529-$3548 = "new graphics" buffer for kanji
; $3549-$3568 = "previous graphics" buffer for kanji
;
; $3569-$3571 = buffer for kanji to turn into tiles data
;               (8 bytes / 1 8x8 tile)
;
; $3572/3 = scratch memory used for mixing graphics
;           (from the $3529-based buffer)
;
; $3574/5 = scratch memory used for mixing graphics
;           (spillover from shift-left of the $3572-3 line)
;
; $3578/9 = scratch memory used for mixing graphics
;           (from the $3549-based buffer)
;
; $357A/B = used for count up/down of WAIT during print
;           ** set by 0B bytecode **
;           (also used as scratchpad during graphics display)
;
; $357C/D = Video address calculated by routine at $CB4B
;           based on X and Y coordinates
;           In other words, pointer to BAT addr in VidMem (i.e. ST0 val)
; $357E   = scratch variable for same routine
;
; $357E/F = returned from routine at $C742
;           Used for pointer to VidAddr for loading graphics tile data
;           this is the BAT value to load into VidMem (i.e. ST2 val)
;
; (4 after printing 1 char) (4 after printing 1 char)
