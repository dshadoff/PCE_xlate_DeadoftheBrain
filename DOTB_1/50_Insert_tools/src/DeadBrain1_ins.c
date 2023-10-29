/*
 ============================================================================
 Name        : DeadBrain1_ins.c
 Author      : Dave Shadoff
 Version     :
 Copyright   : (C) 2018-2023 Dave Shadoff
 Description : Re-inserter for text of Dead of the Brain 1 (and 2)
 ============================================================================
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sqlite3.h>


#define DEAD1			// re-insert for dead of the brain 1
//#define DEAD2		// re-insert for dead of the brain 2

//#define EN		// use English database
#define FR	// use French database


// modify these two as needed:
//
#define UPDATE_DB			1				// 0 = test pass (do not update); 1 = update
#define UPDATE_ISO			1				// 0 = test pass (do not update); 1 = update




//		Dead of the Brain 1 - re-insert program re-implementation
//

#define	PATH_SEPARATOR	"/"

char * currPath;


#ifdef DEAD1
#ifdef EN
char * db_fname = "DotB1_text.db";
#else
char * db_fname = "DotB1_text_fr.db";
#endif
#endif

#ifdef DEAD2
#ifdef EN
char * db_fname = "DotB2_text.db";
#else
char * db_fname = "DotB2_text_fr_20230814_Shubi.db";
#endif
#endif

//char * iso_name = "/mnt/hgfs/Documents/media/games/Dead of the Brain I & II (E)/Dead of the Brain I & II (E)-02.iso";
char * template_iso_name = "Dead of the Brain I & II (E)-02_printpatch.iso";
char * iso_name = "track02.iso";



typedef struct token {
	unsigned char byte_val;
	int len;
	char  * tokenname;
} token;

#define		ENDMSG_0			0
#define		ENDMSG_1			1
#define		WAITKEY				2		// 2-byte
#define		CR					3
#define		CODE04				4		// 2-byte
#define		TEXTSPEED			5		// 2-byte
#define		CODE06				6		// 2-byte
#define		PRINTFLAGS			7		// 2-byte
#define		CLEAR				8
#define		CODE09				9		// 2-byte
#define		TOPLEFT				10
#define		WAIT				11	// 2-byte
#define		FASTTEXTKEY			12	// 2-byte

#define	NUM_TOKENS	13

token token_list[NUM_TOKENS] = {
		{0, 1, "<ENDMSG_0>" },
		{1, 1, "<ENDMSG_1>" },
		{2, 2, "<WAITKEY=" },
		{3, 1, "<CR>" },
		{4, 2, "<CODE04=" },
		{5, 2, "<TEXTSPEED=" },
		{6, 2, "<CODE06=" },
		{7, 2, "<PRINTFLAGS=" },
		{8, 1, "<CLEAR>" },
		{9, 2, "<CODE09=" },
		{10, 1, "<TOPLEFT>" },
		{11, 2, "<WAIT=" },
		{12, 2, "<FASTTEXTKEY="}
};



typedef struct utf8_latin {
		unsigned char numbyte;	// length of UTF-8 code sequence (2 or 3 bytes)
		unsigned char byte1;
		unsigned char byte2;
		unsigned char byte3;
		char new_charval;
} utf8_latin;

#define NUM_LATIN	14

utf8_latin accented_list[NUM_LATIN] = {
	{ 2, 0xC3, 0xA0, 0x00, 0x26 },		// a + accent grave
	{ 2, 0xC3, 0xA2, 0x00, 0x25 },		// a + accent circumflex
	{ 2, 0xC3, 0xA7, 0x00, 0x23 },		// c + cedille
	{ 2, 0xC3, 0xA8, 0x00, 0x60 },		// e + accent grave
	{ 2, 0xC3, 0xA9, 0x00, 0x5C },		// e + accent acute
	{ 2, 0xC3, 0xAA, 0x00, 0x5E },		// e + accent circumflex
	{ 2, 0xC3, 0xAB, 0x00, 0x65 },		// e + diaresis (but make it just a lowercase e)
	{ 2, 0xC3, 0xAE, 0x00, 0x7B },		// i + accent circumflex
	{ 2, 0xC3, 0xAF, 0x00, 0x7C },		// i + diaresis
	{ 2, 0xC3, 0xB4, 0x00, 0x40 },		// o + accent circumflex
	{ 2, 0xC3, 0xB9, 0x00, 0x7E },		// u + accent grave
	{ 2, 0xC3, 0xBB, 0x00, 0x7D },		// u + accent circumflex
	{ 2, 0xc2, 0xb0, 0x00, 0x6f },		// floating lowercase "o" -> normal lowercase "o"
	//
//	{ 3, 0xe3, 0x80, 0x80, 0x20 },		// wide space -> normal space
//	{ 3, 0xe2, 0x80, 0xa6, 0x2e },		// ellipsis -> one dot
	//
	{ 3, 0xe2, 0x80, 0x99, 0x27 }		// right apostrophe -> normal apostrophe
};


typedef struct translation_row {
		char orig_data[8192];
		char human_translation[8192];
		char final_coded_bytes[8192];
		char diskaddr_hex[256];
		char memaddr_hex[256];
		int file_id;
		int address;
		int numbytes;
		int not_message;
		int use_orig_data;
		int orig_data_size;
		int orig_disk_addr;
		int orig_mem_addr;
		int human_translation_size;
		int final_coded_size;
		int final_coded_diskaddr;
		int final_coded_memaddr;
} translation_row;

translation_row trans_row[8000];


//
// file input/output - keep them global in scope for the time being
//
FILE *ftemplate;
FILE *fextract;
sqlite3 *db;


// Completed (English DotB1):
// sections 1-12  = 644
// sections 13    = 118
// sections 14    = 48
// sections 15    = 117
// sections 16    = 48
// sections 17-18 = 219
// sections 19-20 = 95
// sections 21    = 106
// sections 22-25 = 24
// sections 26-27 = 117
// sections 28    = 78
// sections 29-33 = 312
// sections 34-53 = 462
// sections 54-55 = 99
// sections 56-57 = 66
// sections 58-59 = 46
// sections 60-61 = 28
// sections 62-63 = 8
// ---------------------
// Total = 2635/2637 = 99.9%

// June  6 2023 = 68.6%
// June 11 2023 = 72.8%
// Sept  1 2023 = 76.5%
// Sept  6 2023 = 80.0%
// Sept 14 2023 = 84.3%
// Oct   6 2023 = 88.0%
// Oct   8 2023 = 92.0%
// Oct  11 2023 = 99.9%


// Blocks for Dead of the Brain 1:
//
#ifdef DEAD1
#ifdef EN
int block[][2] = {			// second column is the fileId number (because we may not process all consecutively, or even at once)
		0x070F800, 1,		// string 1-80			// Scene 1A - Introduction A   (80 strings)
		0x0715800, 2,		// string 81-83						// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x075E000, 3,		// string 84-87			// Scene 1B - Introduction B   (4 strings)
		0x0764000, 4,		// string 88-90						// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x07A7000, 5,		// string 91-213		// Scene 2  - Cole's Apartment to police station exterior  (123 strings)
		0x07AD000, 6,		// string 214-216					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x07E7000, 7,		// string 217-340		// Scene 14 - Cain rescues Sheila   (124 strings)
		0x07ED000, 8,		// string 341-343					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0827000, 9,		// string 344-451		// Scene 4  - Police Station (return to first floor)   (108 strings)
		0x082D000, 10,		// string 452-525		// Scene 5  - Hotel A, entry   (74 strings)
		0x0867000, 11,		// string 526-641		// Scene 6  - Hotel B, room    (116 strings)
		0x086D000, 12,		// string 642-644					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x08A7000, 13,		// string 645-762		// Scene 15(1) - Cole trying key at Doc's (with Sheila)   (118 strings)  (IN PROGRESS)
		0x08AD000, 14,		// string 763-810				// string #47 points to empty space   (48 strings)  (IN PROGRESS)
		0x08E7000, 15,		// string 811-927		// Scene 15(2) - Cole trying key at Doc's (without Sheila)   (117 strings)  (IN PROGRESS)
		0x08ED000, 16,		// string 928-975				// string @ 0x7037 contains a 00 byte; also problems in final string   (48 strings)  (IN PROGRESS)
		0x0927000, 17,		// string 976-1098		// Scene 7a - Hotel C, second floor (a)  (123 strings)
		0x092D000, 18,		// string 1099-1194		// Scene 7b - Hotel C, second floor (b)  (96 strings)
		0x0969000, 19,		// string 1195-1286		// Scene 16 - Meet Cain in parking, hotel attack
																// Note that 4 strings are encoded without separators; also, final string points to empty space   (92 strings)
		0x096F000, 20,		// string 1287-1289					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x09A9000, 21,		// string 1290-1395		// Scene ?? - ???    (106 strings) - Bayside Labs
		0x09AF000, 22,		// string 1396-1398					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x09E9000, 23,		// string 1399-1407		// Scene ?? - ???    (9 strings)
		0x09EF000, 24,		// string 1408-1410					// SAVE (game)/LOAD (game)/CONTINUE choices (LOAD from startup)  (3 strings)
		0x0A29000, 25,		// string 1411-1419		// TEST Functions    (9 strings)
		0x0A69000, 26,		// string 1420-1533		// Scene 17 - ???    (114 strings) - Hospital and helicopter attack
		0x0A6F000, 27,		// string 1534-1536					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0AA9000, 28,		// string 1537-1614		// Scene ?? - ???    (78 strings) - Cole and Gool meet (Bayside Labs ?)
		0x0AAF000, 29,		// string 1615-1617					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0AF1000, 30,		// string 1618-1729		// Scene 3 - Police Station Interior A   (112 strings)
		0x0AF7000, 31,		// string 1730-1854		// Scene 3 - Police Station Interior B   (125 strings)
		0x0B31002, 32,		// string 1855-1923		// Scene 3 - Police Station Interior C   (69 strings)
															// first pointer at 0x0B31000 is NOT valid !!  More than 3 strings in this block... had to re-extract
		0x0B37000, 33,		// string 1923-1925					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0B71000, 34,		// string 1926-2008		// Scene 8 - Back at hotel room          (83 strings) - Discussion between Cole and Sheila about Doc
		0x0B77000, 35,		// string 2009-2011					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0BB1000, 36,		// string 2012-2106		// Scene 13 - Cathy's Room              (95 strings) - Cathy's room
		0x0BB7000, 37,		// string 2107-2109					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0BF1000, 38,		// string 2110-2127		// Scene 10 - Hallway to Cathy's Room   (18 strings) - Hallway between rooms and conference room
		0x0BF7000, 39,		// string 2128-2130					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0C31000, 40,		// string 2131-2151		// Scene 9 - Next morning                (21 strings) - Cole awakens to find Sheila gone
		0x0C37000, 41,		// string 2152-2154					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0C71000, 42,		// string 2155-2178		// Scene 11 - Meeting Room               (24 strings) - on the way to the meeting room
		0x0C77000, 43,		// string 2179-2181					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0CB1000, 44,		// string 2182-2210		// Scene 12a - Talk to Gool              (29 strings) - Discussion with Gool
		0x0CB7000, 45,		// string 2211-2213					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0CF1000, 46,		// string 2214-2255		// Scene 12b - Talk to Kill              (42 strings) - Discussion with Kill (after Doc's death)
		0x0CF7000, 47,		// string 2256-2258					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0D31000, 48,		// string 2259-2302		// Scene 12c - Talk to Sally             (44 strings) - Discussion with Sally before seeing Cathy in her room
		0x0D37000, 49,		// string 2303-2305					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0D71000, 50,		// string 2306-2345		// Scene 12d - Talk to Ray               (40 strings) - Discussion with Ray
		0x0D77000, 51,		// string 2346-2348					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0DB1000, 52,		// string 2349-2384		// Scene 12e - Talk to Noze              (36 strings) - Discussion with Noze
		0x0DB7000, 53,		// string 2385-2387					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0DF1000, 54,		// string 2388-2483		// Scene ? - ???    (96 strings) - Endgame ?
		0x0DF7000, 55,		// string 2484-2486					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0E49800, 56,		// string 2487-2549		// Scene ? - ???    (63 strings) - Endgame part 2 + Credits ?
		0x0E4F800, 57,		// string 2550-2552					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0E89800, 58,		// string 2553-2595		// Scene ? - ???    (43 strings) - Endgame part 2 (alternate a)
		0x0E8F800, 59,		// string 2596-2598					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0EC9800, 60,		// string 2599-2623		// Scene ? - ???    (25 strings) - Endgame part 2 (alternate b)
		0x0ECF800, 61,		// string 2624-2626					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x1135000, 62,		// string 2627-2633		// Scene ? - ???    (7 strings) - Various end texts - often overrides other sections
		0x113B000, 63,		// string 2634-2634					// SAVE (game)/LOAD (game)/CONTINUE choices   (1 strings)
//		0x06D5800, 64,		// string 2635-2637		// Start game "LOAD1   LOAD2" choices - needs DotB2 print patch
		0x0000000, 0		// END
};
#else

int block[][2] = {			// second column is the fileId number (because we may not process all consecutively, or even at once)
		0x070F800, 1,		// string 1-80			// Scene 1A - Introduction A   (80 strings)
		0x0715800, 2,		// string 81-83						// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x075E000, 3,		// string 84-87			// Scene 1B - Introduction B   (4 strings)
		0x0764000, 4,		// string 88-90						// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x07A7000, 5,		// string 91-213		// Scene 2 - Cole's Apartment to police station exterior  (123 strings)
		0x07AD000, 6,		// string 214-216					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x07E7000, 7,		// string 217-340		// ? - Cain rescues Sheila   (124 strings)
		0x07ED000, 8,		// string 341-343					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0827000, 9,		// string 344-451		// Scene 4 - Police Station (return to first floor)   (108 strings)
		0x082D000, 10,		// string 452-525		// Scene 5 - Hotel A, entry   (74 strings)
		0x0867000, 11,		// string 526-641		// Scene 6 - Hotel B, room    (116 strings)
		0x086D000, 12,		// string 642-644					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x08A7000, 13,		// string 645-762		// ? - Cole trying key at Doc's (with Sheila)   (118 strings)
		0x08AD000, 14,		// string 763-810				// string #47 points to empty space   (48 strings)
		0x08E7000, 15,		// string 811-927		// ? - Cole trying key at Doc's (without Sheila)   (117 strings)
		0x08ED000, 16,		// string 928-975				// string @ 0x7037 contains a 00 byte; also problems in final string   (48 strings)
		0x0927000, 17,		// string 976-1098		// Scene 7 - Hotel C, second floor   (123 strings)  **** CURRENT WORK
		0x092D000, 18,		// string 1099-1194	**	// Scene ? - ???    (96 strings)
		0x0969000, 19,		// string 1195-1286				// Note that 4 strings are encoded without separators; also, final string points to empty space   (92 strings)
		0x096F000, 20,		// string 1287-1289					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x09A9000, 21,		// string 1290-1395		// Scene ? - ???    (106 strings)
		0x09AF000, 22,		// string 1396-1398					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x09E9000, 23,		// string 1399-1407		// Scene ? - ???    (9 strings)
		0x09EF000, 24,		// string 1408-1410					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0A29000, 25,		// string 1411-1419		// Scene ? - ???    (9 strings)
		0x0A69000, 26,		// string 1420-1533		// Scene ? - ???    (114 strings)
		0x0A6F000, 27,		// string 1534-1536					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0AA9000, 28,		// string 1537-1614		// Scene ? - ???    (78 strings)
		0x0AAF000, 29,		// string 1615-1617					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0AF1000, 30,		// string 1618-1729		// Scene 3 - Police Station Interior A   (112 strings)
		0x0AF7000, 31,		// string 1730-1854		// Scene 3 - Police Station Interior B   (125 strings)
		0x0B31002, 32,		// string 1855-1923		// Scene 3 - Police Station Interior C   (69 strings)
															// first pointer at 0x0B31000 is NOT valid !!  More than 3 strings in this block... had to re-extract
		0x0B37000, 33,		// string 1923-1925					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0B71000, 34,		// string 1926-2008		// Scene ? - ???    (83 strings)
		0x0B77000, 35,		// string 2009-2011					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0BB1000, 36,		// string 2012-2106		// Scene ? - ???    (95 strings)
		0x0BB7000, 37,		// string 2107-2109					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0BF1000, 38,		// string 2110-2127		// Scene ? - ???    (18 strings)
		0x0BF7000, 39,		// string 2128-2130					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0C31000, 40,		// string 2131-2151		// Scene ? - ???    (21 strings)
		0x0C37000, 41,		// string 2152-2154					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0C71000, 42,		// string 2155-2178		// Scene ? - ???    (24 strings)
		0x0C77000, 43,		// string 2179-2181					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0CB1000, 44,		// string 2182-2210		// Scene ? - ???    (29 strings)
		0x0CB7000, 45,		// string 2211-2213					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0CF1000, 46,		// string 2214-2255		// Scene ? - ???    (42 strings)
		0x0CF7000, 47,		// string 2256-2258					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0D31000, 48,		// string 2259-2302		// Scene ? - ???    (44 strings)
		0x0D37000, 49,		// string 2303-2305					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0D71000, 50,		// string 2306-2345		// Scene ? - ???    (40 strings)
		0x0D77000, 51,		// string 2346-2348					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0DB1000, 52,		// string 2349-2384		// Scene ? - ???    (36 strings)
		0x0DB7000, 53,		// string 2385-2387					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0DF1000, 54,		// string 2388-2483		// Scene ? - ???    (96 strings)
		0x0DF7000, 55,		// string 2484-2486					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0E49800, 56,		// string 2487-2549		// Scene ? - ???    (63 strings)
		0x0E4F800, 57,		// string 2550-2552					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0E89800, 58,		// string 2553-2595		// Scene ? - ???    (43 strings)
		0x0E8F800, 59,		// string 2596-2598					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x0EC9800, 60,		// string 2599-2623		// Scene ? - ???    (25 strings)
		0x0ECF800, 61,		// string 2624-2626					// SAVE (game)/LOAD (game)/CONTINUE choices   (3 strings)
		0x1135000, 62,		// string 2627-2633		// Scene ? - ???    (7 strings)
		0x113B000, 63,		// string 2634-2634					// SAVE (game)/LOAD (game)/CONTINUE choices   (1 strings)
//		0x06D5800, 64,		// string 2635-2637		// Start game "LOAD1   LOAD2" choicse - needs DotB2 print patch
		0x0000000, 0		// END
};
#endif
#endif


//
// Blocks for Dead of the Brain 2:
//

#ifdef DEAD2

int block[][2] = {
		0x04f800, 1,			// string -
		0x055800, 2,			// string -
		0x08F800, 3,			// string -
		0x095800, 4,			// string -
		0x0CF800, 5,			// string -
		0x0D5800, 6,			// string -
		0x10F800, 7,			// string -				// problem - SJIS 833c (no map)
		0x115800, 8,			// string -
		0x14F800, 9,			// string -
		0x155800, 10,		// string -
		0x18F800, 11,		// string -
		0x195800, 12,		// string -
		0x1CF800, 13,		// string -
		0x1D5800, 14,		// string -
		0x20F800, 15,		// string -
		0x215800, 16,		// string -
		0x24F800, 17,		// string -
		0x255800, 18,		// string -
		0x28F800, 19,		// string -
		0x295800, 20,		// string -
		0x2CF800, 21,		// string -
		0x2D5800, 22,		// string -
		0x30F800, 23,		// string -
		0x315800, 24,		// string -
		0x34F800, 25,		// string -
		0x355800, 26,		// string -
		0x38F800, 27,		// string -
		0x395800, 28,		// string -
		0x3CF800, 29,		// string -
		0x3D5800, 30,		// string -
		0x40F800, 31,		// string -
		0x415800, 32,		// string -
		0x44F800, 33,		// string -
		0x455800, 34,		// string -
		0x48F800, 35,		// string -
		0x495800, 36,		// string -
		0x4CF800, 37,		// string -
		0x4D5800, 38,		// string -
		0x50F800, 39,		// string -
		0x515800, 40,		// string -
		0x54F800, 41,		// string -
		0x555800, 42,		// string -
		0x58F800, 43,		// string -
		0x595800, 44,		// string -
		0x5CF800, 45,		// string - addr 35886 has 0xc2 0xb0 (No with suspended "o")
		0x5D5800, 46,		// string -
		0x60F800, 47,		// string -
		0x615800, 48,		// string -
		0x64F800, 49,		// string -
		0x655800, 50,		// string -
		0x68F800, 51,		// string -
		0x695800, 52,		// string -
		0x6CF800, 53,		// string -
		0x6D5800, 54,		// string -
		0x000000, 0		// END
};
#endif


void detokenize(translation_row *trans);
int hexconvert(char * string, int len, int * errflag);



int main(void) {
	int ret;
	int block_num;								// block iterator
	int i;												// iterator used in hexdump
	int j;
	long filesize;									// size of data file (loaded into array)

	int block_start;

//	int offsetPtr = 0x4000;					// resident memory location for pointers & strings

	int found;										// used to identify whether item found in list

	int stringnum;								// counter within string block
	int tmpcount;									// iterator within string

	int rc;												// database select command related variables
	int result_count;
	int msglen_fromdb;
	int result_code;

	int hex_err;									// used during hexadecimal conversions

	int curr_diskaddr;							// running counters for where the target message will reside
	int curr_memaddr;

// translation string array

// pointer-related variables
	char ptr_diskaddr_hex[200];
	int ptr_diskaddr;
	int ptr_fileid;
	int ptr_deref;
	int ptr_newref;
	char ptr_newref_todisk[2];			// stored in lo, hi order


	char filename_template_iso[1000];
	char filename_iso[1000];
	char filename_db[1000];
    char buffer[10000];
    int buf_read;
	sqlite3_stmt *stmt;

	int update_db = UPDATE_DB;
	int update_iso = UPDATE_ISO;

	printf("starting\n");

	currPath = getenv ("PWD");
	if (currPath != NULL)
	       printf("Current working dir: '%s'\n", currPath);

	filename_template_iso[0] = '\0';
	filename_iso[0] = '\0';
	filename_db[0] = '\0';

	// copy the template file to the working file
	ftemplate = fopen(template_iso_name, "rb");				// Open the template ISO

	if (ftemplate == NULL) {
		printf("could not open the template ISO file '%s'\n", template_iso_name);
		exit(1);
	}
	fextract = fopen(iso_name, "wb");				// Open the ISO

	if (fextract == NULL) {
		printf("could not open the target ISO file '%s'\n", iso_name);
		exit(1);
	}

	do {
		buf_read = fread(buffer, 1, 8192, ftemplate);
		if (buf_read == 0) break;
		fwrite(buffer, 1, buf_read, fextract);
	} while (buf_read == 8192);

	fclose(ftemplate);
    fclose(fextract);

    printf("Copied Successfully\n");

    fextract = NULL;


	/* build the filename for the SQLite3 database file */
	strcat(filename_db, currPath);
	strcat(filename_db, PATH_SEPARATOR);
	strcat(filename_db, db_fname);

	fextract = fopen(iso_name, "r+b");				// Open the ISO

	if (fextract == NULL) {
		printf("could not open the ISO file '%s'\n", iso_name);
		exit(1);
	}



	//
	// Open DB file
	//
	rc = sqlite3_open(filename_db, &db);

	if (db == NULL)
	{
		printf("Failed to open DB file '%s'\n", filename_db);
		return 1;
	}

	if (rc ) {
		printf("Can't open database %s\n", sqlite3_errmsg(db));
	    exit(1);
	}

	printf("Opened DB file '%s'\n", filename_db);

	//
	// Loop to go through the blocks of text strings
	//

	for (block_num = 0; block[block_num][0] != 0; block_num++)
	{

		//
		// STEP 1: read the strings in the block, and create the string output data
		//

		// 'Not_Message' holds:
		//		0 = good message
		//		1 = message stored in text area, but no pointers point at it (probably a binary edit)
		//		2 = bad initial extract; second extract didn't match --> IGNORE THESE for re-insert
		//
	    char *sql = "SELECT FileId, Address, NumBytes, DiskAddr_Hex, Address_Hex, "
	    		"Orig_Data, Not_Message, Use_Orig_Data, Human_Translation FROM tblTransData WHERE FileId = ? AND Not_Message < 2 "
	    		"ORDER BY Address";

	    rc = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);

	    if (rc == SQLITE_OK) {
	        sqlite3_bind_int(stmt, 1, block[block_num][1]);
	    } else {
	        printf("Read: Failed to execute statement: %s\n", sqlite3_errmsg(db));
	        exit(1);
	    }

		result_count = 0;
		while (sqlite3_step(stmt) != SQLITE_DONE) {


			trans_row[result_count].file_id = sqlite3_column_int(stmt, 0);	// FileId
			trans_row[result_count].address = sqlite3_column_int(stmt, 1);	// Address
			trans_row[result_count].numbytes = sqlite3_column_int(stmt, 2);	// NumBytes

			strcpy(trans_row[result_count].diskaddr_hex, (char *)sqlite3_column_text(stmt, 3));
			strcpy(trans_row[result_count].memaddr_hex, (char *)sqlite3_column_text(stmt, 4));

			memcpy(trans_row[result_count].orig_data, sqlite3_column_blob(stmt, 5), sqlite3_column_bytes(stmt, 5));	// Orig_Data
			trans_row[result_count].orig_data_size = sqlite3_column_bytes(stmt, 5);		// size of Orig_Data

			trans_row[result_count].not_message = sqlite3_column_int(stmt, 6);	// Not_Message
			trans_row[result_count].use_orig_data = sqlite3_column_int(stmt, 7);	// Use_Orig_Data

			strcpy(trans_row[result_count].human_translation, (char *)sqlite3_column_text(stmt, 8));	// Human_Translation
			trans_row[result_count].human_translation_size = sqlite3_column_bytes(stmt, 8);	// size of Human_Translation

			if (strcmp(trans_row[result_count].diskaddr_hex, "") == 0) {
				trans_row[result_count].orig_disk_addr = 0;
			}
			else {
				hex_err = 0;
				trans_row[result_count].orig_disk_addr = hexconvert(&trans_row[result_count].diskaddr_hex[0], 0, &hex_err);
				if (hex_err > 0)
					trans_row[result_count].orig_disk_addr = 0;
			}

			hex_err = 0;
			if (strcmp(trans_row[result_count].memaddr_hex, "") == 0) {
				trans_row[result_count].orig_mem_addr = 0;
			}
			else {
				hex_err = 0;
				trans_row[result_count].orig_mem_addr = hexconvert(&trans_row[result_count].memaddr_hex[0], 0, &hex_err);
				if (hex_err > 0)
					trans_row[result_count].orig_mem_addr = 0;
			}

			result_count++;
		}

		sqlite3_finalize(stmt);

		curr_diskaddr = trans_row[0].orig_disk_addr;
		curr_memaddr = trans_row[0].address;

		//
		// STEP 2 - de-tokenize human translation and calculate new addresses
		//
		for (i = 0; i < result_count; i++) {

			trans_row[i].final_coded_diskaddr = curr_diskaddr;
			trans_row[i].final_coded_memaddr = curr_memaddr;

			// This flag is set if the string was not extracted normally (i.e. pointers didn't point at it)
			// We copy it just in case, but may change this behaviour in future
			//
			if (trans_row[i].not_message == 1)		// NOTE: PROBABLY SHOULD SKIP REINSERTION FOR THIS MESSAGE !!!
			{
				memcpy(trans_row[i].final_coded_bytes , trans_row[i].orig_data , trans_row[i].orig_data_size);
				trans_row[i].final_coded_size = trans_row[i].numbytes;
			}
			else if (trans_row[i].use_orig_data == 1)
			{
				// this flag is set if the original text was the best option available (i.e. fixed-size choices etc.)
				//
				memcpy(trans_row[i].final_coded_bytes , trans_row[i].orig_data , trans_row[i].orig_data_size);
				trans_row[i].final_coded_size = trans_row[i].numbytes;
			}
			//
			// else, we will convert the human_coded bytes into a message
			// by de-tokenizing it and adjusting the coding of any UTF-8 latin characters
			//
			else {
				detokenize(&trans_row[i]);
			}

			curr_diskaddr += trans_row[i].final_coded_size;
			curr_memaddr += trans_row[i].final_coded_size;
		}

		//
		// STEP 3 - update the rows in the database with the final coding and size
		//
		// Do an UPDATE Statement for the final coded bytes and size
		// Also write the strings back to the to ISO file, if the flag indicates this is desired
		//
		for (i = 0; i < result_count; i++)
		{
			if (update_db)
			{
			    char *update_sql =	"UPDATE tblTransData "
			    									"SET Final_Coded_Bytes = ?, Final_Coded_Len = ? "
			    									"WHERE FileId = ? AND Address = ?";

			    rc = sqlite3_prepare_v2(db, update_sql, -1, &stmt, NULL);

			    if (rc == SQLITE_OK) {
					sqlite3_bind_blob(stmt, 1, trans_row[i].final_coded_bytes, trans_row[i].final_coded_size, NULL);
			        sqlite3_bind_int(stmt, 2, trans_row[i].final_coded_size);
			        sqlite3_bind_int(stmt, 3, block[block_num][1]);
			        sqlite3_bind_int(stmt, 4, trans_row[i].address);
			    } else {
			        printf("Update: Failed to execute statement: %s\n", sqlite3_errmsg(db));
			        exit(1);
			    }

				result_code = sqlite3_step(stmt);
				if (result_code != SQLITE_DONE) {
					printf("Error #%d: %s\n", result_code, sqlite3_errmsg(db));
					sqlite3_close(db);
					exit(1);
				}

				sqlite3_finalize(stmt);
			}
			//
			// Now, write to disk, if flag is set:
			//
			if (update_iso)
			{
				if (fseek(fextract, trans_row[i].final_coded_diskaddr, SEEK_SET) != 0) {
					printf("Error seeking to block %d, addr %d, diskaddr %8.8x, errno = %d\n",
							block[block_num][1],
							trans_row[i].address,
							trans_row[i].final_coded_diskaddr,
							errno);

					exit(1);
				}

				ret = fwrite(trans_row[i].final_coded_bytes, 1, trans_row[i].final_coded_size, fextract);
				if (ret != trans_row[i].final_coded_size) {
					printf("Block  %d, Address %d, Final coded disk address %8.8x, Problem writing %d bytes; ret = %d\n",
							block[block_num][1],
							trans_row[i].address,
							trans_row[i].final_coded_diskaddr,
							trans_row[i].final_coded_size, ret);

					exit(1);
				}
			}
		}


		//
		// STEP 4 - Read the pointer list and determine new addresses
		//
		// Find old pointer reference in the   trans_row[i].orig_mem_addr, and
		// cross-reference to corresponding trans_row[i].final_coded_memaddr
		// and finally, update disk image where the pointer lives


		char *pointer_sql = "SELECT DiskAddr_Hex, FileId, Ptr_Deref FROM tblPointers WHERE FileId = ? ORDER BY DiskAddr_Hex";

		rc = sqlite3_prepare_v2(db, pointer_sql, -1, &stmt, NULL);

		if (rc == SQLITE_OK) {
			sqlite3_bind_int(stmt, 1, block[block_num][1]);
		} else {
			printf("Read Ptr: Failed to execute statement: %s\n", sqlite3_errmsg(db));
			exit(1);
		}


		while (sqlite3_step(stmt) != SQLITE_DONE)
		{
			strcpy(ptr_diskaddr_hex, (char *)sqlite3_column_text(stmt, 0));		// DiskAddr_Hex
			ptr_fileid = sqlite3_column_int(stmt, 1);							// FileId
			ptr_deref = sqlite3_column_int(stmt, 2);							// Ptr_Deref

			ptr_diskaddr = hexconvert(ptr_diskaddr_hex, 0, &hex_err);
			if (hex_err != 0) {
				printf ("Failed hexconvert of pointer %s\n", ptr_diskaddr_hex);
				exit(1);
			}

			// search for existing ptr_deref
			found = 0;
			for (j = 0; j < result_count; j++) {
				if (ptr_deref == trans_row[j].address) {
					found = 1;
					ptr_newref = trans_row[j].final_coded_memaddr;
					ptr_newref_todisk[0] = ptr_newref & 0xff;
					ptr_newref_todisk[1] = (ptr_newref >> 8) & 0xff;
					break;
				}
			}
			if (found == 0) {
				printf("Pointer to %d not found in xref list\n", ptr_deref);
				exit(1);
			}

			// print xref of addresses
///			printf("pointer address on disk = %8.8x, old value = %4.4x, new value = %4.4x\n", ptr_diskaddr, ptr_deref, ptr_newref);


			if (update_iso)
			{
				if (fseek(fextract, ptr_diskaddr, SEEK_SET) != 0) {
					printf("error seeking to pointer diskaddr %8.8x, errno = %d\n", ptr_diskaddr, errno);
					exit(1);
				}

				ret = fwrite(&ptr_newref_todisk[0], 1, 1, fextract);
				if (ret != 1) {
					printf("Problem writing 1 byte (#1); ret = %d\n", ret);
					exit(1);
				}
				ret = fwrite(&ptr_newref_todisk[1], 1, 1, fextract);
				if (ret != 1) {
					printf("Problem writing 1 byte (#2); ret = %d\n", ret);
					exit(1);
				}

			}
		}

		sqlite3_finalize(stmt);

		printf("Done block %d; original end = 0x%4.4x, new end = 0x%4.4x  --  %s (%d characters)\n",
				block[block_num][1],
				trans_row[result_count-1].address + trans_row[result_count-1].numbytes,
				trans_row[result_count-1].final_coded_memaddr + trans_row[result_count-1].final_coded_size,
				(trans_row[result_count-1].address + trans_row[result_count-1].numbytes
						>= trans_row[result_count-1].final_coded_memaddr + trans_row[result_count-1].final_coded_size) ? "OK" : "Larger than original - check available space",
				((trans_row[result_count-1].address + trans_row[result_count-1].numbytes) -
						(trans_row[result_count-1].final_coded_memaddr + trans_row[result_count-1].final_coded_size)));

	}		// Next block (iterator 'block_num')


	fclose(fextract);
	sqlite3_close(db);


	return EXIT_SUCCESS;
}

void
detokenize(translation_row *trans)
{
	int pos_src = 0;
	int pos_dest = 0;
	int iter;
	int found_in_list;
	int token_len;
	char hexval1, hexval2;
	int hexval, hexval_err;

//	printf("%s\n", trans->human_translation);

	while (1)
	{
		if (trans->human_translation[pos_src] == '\0')
			break;

		// skip CR/LF used for edit formatting ("<CR>" token used for actual script)
		//
		if ((trans->human_translation[pos_src] == 0x0A) || (trans->human_translation[pos_src] == 0x0D)) {
			pos_src++;
			continue;
		}

		//
		// Next, check for UTF characters
		//
		if ((trans->human_translation[pos_src] < 0) || (trans->human_translation[pos_src] > 0x7F))
		{
			found_in_list = 0;
			for (iter = 0; iter < NUM_LATIN; iter++)
			{
				if (accented_list[iter].numbyte == 2)
				{
					if (   ((trans->human_translation[pos_src] & 0xff) == accented_list[iter].byte1) &&
							((trans->human_translation[pos_src+1] & 0xff) == accented_list[iter].byte2))
					{
						trans->final_coded_bytes[pos_dest] = accented_list[iter].new_charval;
						pos_src += 2;
						pos_dest++;
						found_in_list = 1;
						break;
					}
				}
				else if (accented_list[iter].numbyte == 3)
				{
					if (   ((trans->human_translation[pos_src] & 0xff) == accented_list[iter].byte1) &&
							((trans->human_translation[pos_src+1] & 0xff) == accented_list[iter].byte2) &&
							((trans->human_translation[pos_src+2] & 0xff) == accented_list[iter].byte3))
					{
						trans->final_coded_bytes[pos_dest] = accented_list[iter].new_charval;
						pos_src += 3;
						pos_dest++;
						found_in_list = 1;
						break;
					}
				}
			}
			if (found_in_list == 0) {
				printf("Could not find UTF character 0x%2.2x 0x%2.2x (0x%2.2x) in list from offset %d (0x%x), FileId=%d, Address=%d, string '%s'\n",
						(unsigned int) (trans->human_translation[pos_src] & 0xff),
						(unsigned int) (trans->human_translation[pos_src+1] & 0xff),
						(unsigned int) (trans->human_translation[pos_src+2] & 0xff),
						pos_src,
						pos_src,
						trans->file_id,
						trans->address,
						trans->human_translation);
				exit(1);
			}
			else
			{
				found_in_list = 0;
				continue;
			}
		}


		//
		// Next, check for tokens
		//
		if (trans->human_translation[pos_src] == '<')
		{
			found_in_list = 0;
			for (iter = 0; iter < NUM_TOKENS; iter++)
			{
				token_len = strlen(token_list[iter].tokenname);
				if (strncmp(&trans->human_translation[pos_src], token_list[iter].tokenname, token_len) == 0)
				{
					if (token_list[iter].len == 1) {
						trans->final_coded_bytes[pos_dest] = token_list[iter].byte_val;
						pos_src += token_len;
						pos_dest++;
						found_in_list = 1;
						break;
					}
					else 	// two-byte token
					{
						hexval_err = 0;
						hexval = hexconvert(&(trans->human_translation[pos_src+token_len]), 2, &hexval_err);

						if (	(hexval_err == 1) ||
								(trans->human_translation[pos_src+token_len+2] != '>'))
						{
							printf("Error at token translation %s at position %d in string %s\n", &trans->human_translation[pos_src], pos_src, trans->human_translation);
							exit(1);
						}

						trans->final_coded_bytes[pos_dest] = token_list[iter].byte_val;
						trans->final_coded_bytes[pos_dest + 1] = hexval;
						pos_src += (token_len + 3);
						pos_dest += 2;
						found_in_list = 1;
						break;
					}
				}

			}
			if (found_in_list == 1)		// but if not found, maybe it's just a '<' in the middle of the string...
			{
				found_in_list = 0;
				continue;
			}
		}

		// Else
		trans->final_coded_bytes[pos_dest++] = trans->human_translation[pos_src++];
	}
	trans->final_coded_size = pos_dest;
}

int
hexconvert(char * string, int len, int * errflag)
{
	int offset;
	int result;
	int hexval;
	int hexval_err;
	char character;

	hexval_err = 0;
	result = 0;
	offset = 0;

	// if string starts with '0x', ignore it
	if (strncmp(string, "0x", 2) == 0)
		string += 2;

	while (1)
	{
		if ((len != 0) && (offset >= len))
			break;

		character = *(string + offset);

		if (character == 0)
			break;

		hexval = 0;

		if ((character >= '0') && (character <= '9')) {
			hexval = (character - '0');
		}
		else if ((character >= 'A') && (character <= 'F')) {
			hexval = (character - 'A' + 10);
		}
		else if ((character >= 'a') && (character <= 'f')) {
			hexval = (character - 'a' + 10);
		}
		else
			hexval_err = 1;

		if (hexval_err == 1)
			break;

		result = (result << 4) | hexval;
		offset++;
	}

	*(errflag) = hexval_err;
	return(result);
}
