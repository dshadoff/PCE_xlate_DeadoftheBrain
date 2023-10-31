********************************************************************************
*                             Dead of the Brain 1                              *
*                          English Translation Patch                           *
*                          vDotB1_1.0E (29 Oct 2023)                           *
*                                                                              *
*                         Dave Shadoff -- Hacking and Translation              *
*                      Kazumi Watanabe -- Translation                          *
*                            turboxray -- Hacking                              *
********************************************************************************

Game Description:
-----------------
Cole's friend Doctor Cooger has made an incredible discovery which he wants
to show Cole but things go awry... Then, a zombie rampage which threatens
to destroy the town and Cole needs to do whatever is necessary in order to
try to save himself, his girlfriend Sheila, and Doctor Cooger.

Dead of the Brain 1 & 2 was the last official release to be published on the
PC Engine in Japan in 1999, and consists of two complete games.

The first of these two games was released on several home computers in
Japan (PC-98, FM Towns, X68000, MSX2) early in the 1990s, with Dead
of the Brain 2 being released only on PC-98 prior to this release.

The games are done in a Visual Novel style, similar to a point-and-click
adventure. You control Cole's actions as he tries to figure out how to save
himself and his friends.

There are some graphic scenes of violence and sexual situations in this game.
For this reason, the game carries an "18+" rating, and was marked as such in
Japan.


Translation Description:
------------------------
Dead of the Brain 1 & 2 consists of two complete games.
This patch is for "Dead of the Brain 1", making it fully-playable.

Voices have not been re-recorded but matching text displays in all cases, and
this text has been translated.


To apply the xdelta patch, you need to have the data track(s), specifically
Track 2 read from the disc as Mode 1, 2048-bytes per sector.




                    ****************************************
                    *          Table of Contents           *
                    ****************************************

  I.    Patching Instructions
  II.   Running the Game
  III.  Known Issues
  IV.   FAQ
  V.    Cheat Codes
  VI.   Author's Comments
  VII.  Special Thanks
  VIII. Version History

                    ****************************************
                    *       I. Patching Instructions       *
                    ****************************************

To use this translation, you'll need to apply a patch to a disc image of the 
game. Unfortunately, patching disc images can be complicated because there are
many CD image formats in use, and many ways that discs can be ripped
improperly.

The patch file included here is intended for a game ripped to CUE + WAV + ISO
format (such as would be ripped by Turborip). The "track02" file needs to
be in the 2048-byte sector format used by the PC Engine.


          Track 02  (i.e. "Dead of the Brain I & II (J)-02.iso" )
  CRC32:  f50eb992
  MD5:    3395af50b526b38ea8f75f26d0eed540
  SHA-1:  84b62e1a1a26cfc8c73648f71fa8b6c66ae37be1


  How to patch ISO+WAV+CUE image
  ------------------------------

If your disc image is already in ISO+WAV+CUE format, you can simply go to
this ROM patching website, and choose the correct file and enter the xdelta
file as the patch:

  https://www.marcrobledo.com/RomPatcher.js/
  
You will need to amend the CUE file entry/entries to point to the updated
data track.

If you have an image which is not in the stated format, your best bet might be
to burn the image to CD-R and re-rip with Turborip. Turborip also works great
if you happen to have one of the rare original discs.

Turborip can be found here:
https://www.ysutopia.net/forums/index.php?topic=69.0


                    ****************************************
                    *         II. Running the Game         *
                    ****************************************

This patch has been tested on several playback types including MiSTer and
the Mednafen emulator. If you encounter problems, I would be interested to
hear about the nature of the issues, but will prioritize making it work
properly on original hardware rather than all emulators.

You will need to use the 3.0 version of the BIOS, and the Japanese v3.0 CDROM
BIOS is the recommended one.

Also, this game expects a 2-button joypad to be used (do not use mouse or
6-button joypad mode).


                    ****************************************
                    *          III. Known Issues           *
                    ****************************************

There are no known issues at this time.


                    ****************************************
                    *               IV. FAQ                *
                    ****************************************
  
Q. I'm stuck! What do I do next!?

A. There are longplay videos on Youtube; at least one of them is on a PC-98
version using an older English translation. You may be able to quickly scan
through the video to find the area where you are stuck. The solutions to
various scenarios are basically the same, although hitboxes on PC Engine may
be slightly offset from where they are on the PC-98.

Truthfully, there isn't much player interaction on this game, so it mostly
comes down to:
 A) Click on every possible place in the room to find clues when 'exploring'
 B) When in 'action' spots, you will need to think fast and perform the correct
operation quickly. This is not always obvious, but the game does allow for
basically infinite retries of those fight scenes.


                    ****************************************
                    *            V. Cheat Codes            *
                    ****************************************

While extracting text, I did discover that there is a debug/test room for
validating things. However, I was not able to find out how to get to it, so
it remains translated but not tested.

If you determine how to access this area, please let me know by one of the
following:

  A) Tag me in a tweet on Twitter (aka 'X'): @Shadoff_d
     (Note: I may not see direct messages on Twitter)

  B) Send me a direct message on romhacking.net - although I check this less
     often

  C) I'm also on Discord on various servers, but these change from time to
     time.

  D) or email: daves@interlog.com (although this address may change in the
     future).


                    ****************************************
                    *         VI. Author's Comments        *
                    ****************************************
  
This translation has been discussed as being one of the most-desired
translations since it was released in 1999, and indeed I was also one of the
people who wanted it translated.

Initial work on extracting the script and hacking the print function started
between 2005 and 2007, and while 90% of the script was properly extracted (one
block was simply overlooked - not a technical issue), we weren't quite able to
get the variable-width print function working to our satisfaction back then.

An initial French translation was created, but the project was put on the back
burner as everybody became busy for several years.

In 2018, I resurrected the project, ported the technical code to different
tools (SQLite3 and C), and rewrote the print function to be as simple as
possible, given that the original programming was extremely convoluted.
This was successful, and I ended up going with a fixed-width font for
simplicity.

Initial tests looked OK, and we saw that the script needed formatting and
timing adjustment (the initial sequence is timed to synchronize with a
voice-over).

Despite many requests for an English translator to join the team, there were
no volunteers - not in 2007, not in 2018. So the project was again put on
hold pending availability of key people.

As I had been studying Japanese for many years by 2021, I decided to try my
own hand at translating it - with assistance from my Japanese tutor, Kazumi
Watanabe, who validated every translated line, checking overall translation,
including nuance and idioms. Of course, I was in charge of the overall edit,
ensuring that things sounded natural and no modern (post-1990s) idioms were
employed, and trying to ensure that characters kept "in character".

This was by far the largest language translation I have done to-date (even if
the hacking work is not). I have a deeper appreciation for the work involved
in doing these, and the details which need to be dealt with.

Translation is very time-consuming (at least for me), and the translation work
took over 2 years to complete. Finally in October 2023, the English translation
of Dead of the Brain 1 was completed and play-tested.

The tools built for script extraction/insertion and editing for DotB1 also
function perfectly for DotB2, but I don't currently have any plans to translate
the text of DotB2.
...I would happily work with the right translator however.

However, be forewarned that there is over twice as much text as DotB1.

  
                    ****************************************
                    *         VII. Special Thanks          *
                    ****************************************

Special thanks goes to Shubibinman for his work on the French translation, and
always being supportive of the project - especially when things were not
looking so easy.

Special thanks to Diogo Ribiero (4lorn), whose work on several other
translation projects reawoke my interest in working on them. Without his
efforts, I don't think I would have worked on the English translation portion
fo this project.

Thanks to NightWolve for his play-testing and feedback, including many typos
that I had made, and also for writing TurboRip.

Also, thanks to all the other members of the PC Engine programming community 
who are also working on their own translations, tools, and other technology.
It's inspiring to see what people are doing, and their work has motivated me
to keep pushing forward on this project, time and time again.


                    ****************************************
                    *        VIII. Version History         *
                    ****************************************

vDotB1_1.0E (29 Oct 2023): Initial release.
