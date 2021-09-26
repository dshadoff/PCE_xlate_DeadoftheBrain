# Overview

The script is in a fairly easy-to-extract format.
The bulk of it comes in blocks which are loaded into standard banks, the script is entirely in 2-byte SJIS, and
the script uses a token system for some additional control over how it is displayed.

Changing the print function to use ASCII frees up some space, as English takes up more characters than Japanese
(although this is roughly similar if every Japanese character takes 2 bytes).

The token system allows for the script to speed up, slow down, prompt for input, and other features.  The extracted
script uses key words surrounded by less-than and greater-than symbols to represent these tokens so that they can
be human-readable.
 
A brief overview of the token system:

| Bytecode | Command length | Token in extracted script | Meaning
| -------- | -------------- | ------------------------- | -------
| 0 | 1 | ENDMSG_0 | End-of-message delimiter
| 1 | 1 | ENDMSG_1 | End-of-message delimiter
| 2 | 2 | WAITKEY= | Prompt for joypad input (see below)
| 3 | 1 | CR | End-of-line delimiter (Carriage-return)
| 4 | 2 | CODE04= | As yet unclear
| 5 | 2 | TEXTSPEED= | Text speed; wait <n> frames between characters
| 6 | 2 | CODE06= | As yet unclear
| 7 | 2 | PRINTFLAGS= | TBD
| 8 | 1 | CLEAR | Clear display box
| 9 | 2 | CODE09= | As yet unclear
| 10 | 1 | TOPLEFT | Move cursor to the top-left of the display box
| 11 | 2 | WAIT= | Pause; wait <n> seconds before resuming
| 12 | 2 | FASTTEXTKEY= | Speed text printing based on joypad input (see below)

Control byte used for joypad input (WAITKEY and FASTTEXTKEY tokens):

| Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 | Pad button
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----------
|  X  |     |     |     |     |     |     |     | Left
|     |  X  |     |     |     |     |     |     | Down
|     |     |  X  |     |     |     |     |     | Right
|     |     |     |  X  |     |     |     |     | Up
|     |     |     |     |  X  |     |     |     | Run
|     |     |     |     |     |  X  |     |     | Select
|     |     |     |     |     |     |  X  |     | II
|     |     |     |     |     |     |     |  X  | I



