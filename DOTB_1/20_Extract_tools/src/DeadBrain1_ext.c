/*
 ============================================================================
 Name        : DeadBrain1_ext.c
 Author      : Dave Shadoff
 Version     :
 Copyright   : (C) 2018 Dave Shadoff
 Description : Extractor for text of Dead of the Brain 1 (and 2)
 ============================================================================
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sqlite3.h>


#define DEAD1			// extract for dead of the brain 1
//#define DEAD2		// extract for dead of the brain 2


// ****************************
// modify these two as needed:
//
#define UPDATE				0					// 0 = test pass (do not update database); 1 = update database
//#define UPDATE				1					// 0 = test pass (do not update database); 1 = update database
#define START_STRING	1					// in case we only run partial script extracts
//#define START_STRING	2635					// in case we only run partial script extracts



//		Dead of the Brain 1 (and 2) - extract program re-implementation
//


int compare_ignoring_CR(char * str1, char * str2);
int Unicode_to_SJIS(int uni);
int SJIS_to_Unicode(int sjis);
int SJIS_to_UTF8(int sjis, unsigned char *buf);
void read_Unicode_map(void);

int cvt_to_tokens(unsigned char *out, unsigned char *in, int len);
int cvt_to_unicode(unsigned char *out, unsigned char *in, int len);


int SJIS_to_Unicode_array[65536];
int Unicode_to_SJIS_array[65536];
int SJIS_map_read_flag = 0;
unsigned char Unicode_buf[5];

char * currPath;

#define	PATH_SEPARATOR	"/"

char * map_fname = "unicode.txt";

#ifdef DEAD1
char * db_fname = "DotB1_text-a.db";
#endif
#ifdef DEAD2
char * db_fname = "DotB2_text.db";
#endif

char * iso_name = "/mnt/hgfs/Documents/media/games/Dead of the Brain I & II (J)/Dead of the Brain I & II (J)-02.iso";


typedef struct token {
	unsigned char byte_val;
	int len;
	char  * tokenname;
} token;


#define		ENDMSG_0			0
#define		ENDMSG_1			1
#define		WAITKEY				2		// 2-byte
#define		CR						3
#define		CODE04				4		// 2-byte
#define		TEXTSPEED			5		// 2-byte
#define		CODE06				6		// 2-byte
#define		PRINTFLAGS		7		// 2-byte
#define		CLEAR					8
#define		CODE09				9		// 2-byte
#define		TOPLEFT				10
#define		WAIT					11	// 2-byte
#define		FASTTEXTKEY		12	// 2-byte

#define	NUM_TOKENS	13

token token_list[NUM_TOKENS] = {
		{0, 1, "<ENDMSG_0>" },
		{1, 1, "<ENDMSG_1>" },
		{2, 2, "<WAITKEY=" },
		{3, 1,  "<CR>\n" },
		{4, 2, "<CODE04=" },
		{5, 2, "<TEXTSPEED=" },
		{6, 2, "<CODE06=" },
		{7, 2, "<PRINTFLAGS=" },
		{8, 1, "<CLEAR>" },
		{9, 2, "<CODE09=" },
		{10, 1, "<TOPLEFT>\n" },
		{11, 2, "<WAIT=" },
		{12, 2, "<FASTTEXTKEY="}
};

//
// data read from ISO track - keep it global in scope for now
//
unsigned char array[30000000];

//
// file input/output - keep them global in scope for the time being
//
FILE *fextract, *fout_sjis, *fout_utf, *fout_err;
sqlite3 *db;

//
// Blocks for Dead of the Brain 1:
//
#ifdef DEAD1

#define	GAMENUM	1

int block[][2] = {			// second column is the fileId number (because we may not process all consecutively, or even at once)
//		0x070F800, 1,		// string 1-80
//		0x0715800, 2,		// string 81-83				// SAVE (game)/LOAD (game)/CONTINUE choices
//		0x075E000, 3,		// string 84-87
//		0x0764000, 4,		// string 88-90				// SAVE (game)/LOAD (game)/CONTINUE choices
//		0x07A7000, 5,		// string 91-213
//		0x07AD000, 6,		// string 214-216
//		0x07E7000, 7,		// string 217-340
//		0x07ED000, 8,		// string 341-343
//		0x0827000, 9,		// string 344-451
//		0x082D000, 10,		// string 452-524
//		0x0867000, 11,		// string 525-640
//		0x086D000, 12,		// string 641-643
//		0x08A7000, 13,		// string 644-761
//		0x08AD000, 14,		// string 762-809			// string #47 points to empty space
//		0x08E7000, 15,		// string 810-926
//		0x08ED000, 16,		// string 927-974			// string @ 0x7037 contains a 00 byte; also problems in final string
//		0x0927000, 17,		// string 975-1097
//		0x092D000, 18,		// string 1098-1193
//		0x0969000, 19,		// string 1194-1285		// Note that 4 strings are encoded without separators; also, final string points to empty space
//		0x096F000, 20,		// string 1286-1288
//		0x09A9000, 21,		// string 1289-1394
//		0x09AF000, 22,		// string 1395-1397
//		0x09E9000, 23,		// string 1398-1406
//		0x09EF000, 24,		// string 1407-1409
//		0x0A29000, 25,		// string 1410-1418
//		0x0A69000, 26,		// string 1419-1532
//		0x0A6F000, 27,		// string 1533-1535
//		0x0AA9000, 28,		// string 1536-1613
//		0x0AAF000, 29,		// string 1614-1616
//		0x0AF1000, 30,		// string 1617-1728
//		0x0AF7000, 31,		// string 1729-1853
//		0x0B31002, 32,		// string 1854-1921		// first pointer at 0x0B31000 is NOT valid !!  More than 3 strings in this block... had to re-extract
//		0x0B37000, 33,		// string 1922-1924
//		0x0B71000, 34,		// string 1925-2007
//		0x0B77000, 35,		// string 2008-2010
//		0x0BB1000, 36,		// string 2011-2105
//		0x0BB7000, 37,		// string 2106-2108
//		0x0BF1000, 38,		// string 2109-2126
//		0x0BF7000, 39,		// string 2127-2129
//		0x0C31000, 40,		// string 2130-2150
//		0x0C37000, 41,		// string 2151-2153
//		0x0C71000, 42,		// string 2154-2177
//		0x0C77000, 43,		// string 2178-2180
//		0x0CB1000, 44,		// string 2181-2209
//		0x0CB7000, 45,		// string 2210-2212
//		0x0CF1000, 46,		// string 2213-2254
//		0x0CF7000, 47,		// string 2255-2257
//		0x0D31000, 48,		// string 2258-2301
//		0x0D37000, 49,		// string 2302-2304
//		0x0D71000, 50,		// string 2305-2344
//		0x0D77000, 51,		// string 2345-2347
//		0x0DB1000, 52,		// string 2348-2383
//		0x0DB7000, 53,		// string 2384-2386
//		0x0DF1000, 54,		// string 2387-2482
//		0x0DF7000, 55,		// string 2483-2485
//		0x0E49800, 56,		// string 2486-2548
//		0x0E4F800, 57,		// string 2549-2551
//		0x0E89800, 58,		// string 2552-2594
//		0x0E8F800, 59,		// string 2595-2597
//		0x0EC9800, 60,		// string 2598-2622
//		0x0ECF800, 61,		// string 2623-2625
//		0x1135000, 62,		// string 2626-2632
//		0x113B000, 63,		// string 2633-2633
		0x06D5800, 64,		// string 2635-2637
		0x0000000, 0		// END
};
#endif
// Blocks for Dead of the Brain 2:
//

#ifdef DEAD2

#define	GAMENUM	2

int block[][2] = {			// second column is the fileId number (because we may not process all consecutively, or even at once)
//		0x04f800, 1,			// string 1-77
//		0x055800, 2,			// string 78-108
//		0x08F800, 3,			// string 109-176
//		0x095800, 4,			// string 177-179
//		0x0CF800, 5,			// string 180-258
//		0x0D5800, 6,			// string 259-261
//		0x10F800, 7,			// string 262-283
//		0x115800, 8,			// string 284-286
//		0x14F800, 9,			// string 287-347
//		0x155800, 10,		// string 348-415
//		0x18F800, 11,		// string 416-480
//		0x195800, 12,		// string 481-574
//		0x1CF800, 13,		// string 575-618
//		0x1D5800, 14,		// string 619-712
//		0x20F800, 15,		// string 713-840
//		0x215800, 16,		// string 841-931
//		0x24F800, 17,		// string 932-1025
//		0x255800, 18,		// string 1026-1028
//		0x28F800, 19,		// string 1029-1157
//		0x295800, 20,		// string 1158-1193
//		0x2CF800, 21,		// string 1194-1322
//		0x2D5800, 22,		// string 1323-1358
//		0x30F800, 23,		// string 1359-1444
//		0x315800, 24,		// string 1445-1447
//		0x34F800, 25,		// string 1448-1516
//		0x355800, 26,		// string 1517-1519
//		0x38F800, 27,		// string 1520-1608
//		0x395800, 28,		// string 1609-1611
//		0x3CF800, 29,		// string 1612-1698
//		0x3D5800, 30,		// string 1699-1701
//		0x40F800, 31,		// string 1702-1788
//		0x415800, 32,		// string 1789-1791
//		0x44F800, 33,		// string 1792-1882
//		0x455800, 34,		// string 1883-1885
//		0x48F800, 35,		// string 1886-1890
//		0x495800, 36,		// string 1891-1893
//		0x4CF800, 37,		// string 1894-1914
//		0x4D5800, 38,		// string 1915-1917
//		0x50F800, 39,		// string 1918-1989
//		0x515800, 40,		// string 1990-1992
//		0x54F800, 41,		// string 1993-2017
//		0x555800, 42,		// string 2018-2020
//		0x58F800, 43,		// string 2021-2096
//		0x595800, 44,		// string 2097-2099
//		0x5CF800, 45,		// string 2100-2206
//		0x5D5800, 46,		// string 2207-2222
//		0x60F800, 47,		// string 2223-2346
//		0x615800, 48,		// string 2347-2349
//		0x64F800, 49,		// string 2350-2394
//		0x655800, 50,		// string 2395-2397
//		0x68F800, 51,		// string 2398-2416
//		0x695800, 52,		// string 2417-2419
//		0x6CF800, 53,		// string 2420-2428
//		0x6D5800, 54,		// string 2429-2431
		0x000000, 0		// END
};
#endif

int main(void) {
	int ret;
	int block_num;								// block iterator
	int i;												// iterator used in hexdump
	int j;
	int ptr_iter;
	int k;												// iterator within pointer list
	long filesize;									// size of data file (loaded into array)

	int block_start;
	int pointer_pointer;						// temporary address calculations (offset from start of track)

	int offsetPtr = 0x4000;					// resident memory location for pointers & strings
	int minptr, maxptr;						// used for finding list of pointers to data
	unsigned char msbyte, lsbyte;	// used for identifying pointer values
	int currptr;

	int ptrindex = 0;							// iterator within block of pointers
	int numUniqPtrs = 0;					// used for a unique list of pointers
	int ptrList[65536];

	int num_of_pointers;						// full word 'pointer' is used for complete list (includes duplicates, etc.)
	int pointer_diskaddr[65536];
	int pointer_deref[65536];

	int found;										// used for identifying duplicates
	int tmpPtr;										// used during sort of pointer list
	int in_ptr_list;							// used to determine whether a test message is actually pointed to by a pointer
	int not_message;							// (if not, it is treated as an immovable block of memory)

	int stringnum;								// counter within string block
	int currloc;										// iterator through string block
	int lastloc;										// marker of start of last string in string block
	int tmpcount;									// iterator within string
	int srcpos;										// adjusted start of string (offset ,rather than memory resident location)
	unsigned char tmpbyte;

	int rc;												// database select command related variables
	int result_count;
	int insert_0_update_1;					// flag set depending on whether extracted message already exists
	int msglen_fromdb;
	int result_code;
	char utfextract_fromdb[30000];
	char diskaddr_hex[100];
	char addr_hex[100];
	char numbyte_hex[100];
	char endaddr_hex[100];


	unsigned char raw_string[30000];
	unsigned char tokenized_string[30000];
	int tokenized_strlen;
	unsigned char unicode_string[30000];
	int unicode_strlen;
	unsigned char ffstring[100];

	char filename_sjis[1000];
	char filename_utf[1000];
	char filename_err[1000];
	char filename_iso[1000];
	char filename_db[1000];

	sqlite3_stmt *stmt;

	int update = UPDATE;

	printf("starting\n");

	currPath = getenv ("PWD");
	if (currPath != NULL)
	       printf("Current working dir: '%s'\n", currPath);

	filename_iso[0] = '\0';
	filename_db[0] = '\0';

	for (i = 0; i < 16; i++) {
		ffstring[i] = 0xff;
	}


	/* build the filename for the SQLite3 database file */
	strcat(filename_db, currPath);
	strcat(filename_db, PATH_SEPARATOR);
	strcat(filename_db, db_fname);

	fextract = fopen(iso_name, "rb");				// Open the ISO

	if (fextract == NULL) {
		printf("could not open the ISO file '%s'\n", iso_name);
		exit(1);
	}

	if (fseek(fextract, 0, SEEK_END) != 0) {
		printf("error seeking to end of file, errno = %d\n", errno);
		exit(1);
	}

	filesize = ftell(fextract);
	printf("filesize = %ld\n", filesize);

	if (fseek(fextract, 0, SEEK_SET) != 0) {
		printf("error seeking to start of file, errno = %d\n", errno);
		exit(1);
	}

	ret = fread(array, 1, filesize, fextract);
	if (ret != filesize) {
		printf("Problem reading %ld bytes; ret = %d\n", filesize, ret);
		exit(1);
	}

	printf("file read completed; searching...\n");

	sqlite3_open(filename_db, &db);

	if (db == NULL)
	{
		printf("Failed to open DB file '%s'\n", filename_db);
		return 1;
	}

	for (block_num = 0; block[block_num][0] != 0; block_num++)
	{
		// Create a unique list of pointers to strings
		ptrindex = 0;						// iterator within pointer block
		numUniqPtrs = 0;				// counter for unique pointers found

		num_of_pointers = 0;		// counter for list of all pointers

		block_start = block[block_num][0];
		offsetPtr = 0x4000 + (block_start & 0xFF);			// adjustment for block 32, where first pointer needs to be  ignored

		minptr = 65535;
		maxptr = 0;

		sprintf(filename_sjis, "%s%sDead%1.1d_block%2.2d_sjis.txt", currPath, PATH_SEPARATOR, GAMENUM, block[block_num][1]);
		fout_sjis = fopen(filename_sjis, "wb");
		if (fout_sjis == NULL) {
			printf("could not open the SJIS output file '%s'\n", filename_sjis);
			exit(1);
		}

		sprintf(filename_utf, "%s%sDead%1.1d_block%2.2d_utf.txt", currPath, PATH_SEPARATOR, GAMENUM, block[block_num][1]);
		fout_utf = fopen(filename_utf, "wb");
		if (fout_utf == NULL) {
			printf("could not open the UTF8 output file '%s'\n", filename_utf);
			exit(1);
		}

		sprintf(filename_err, "%s%sDead%1.1d_block%2.2d_err.txt", currPath, PATH_SEPARATOR, GAMENUM, block[block_num][1]);
		fout_err = fopen(filename_err, "wb");
		if (fout_err == NULL) {
			printf("could not open the error output file '%s'\n", filename_err);
			exit(1);
		}

		// pointer list is located at the beginning of the block;
		// we know that the pointers point to resident memory (i.e. near offsetPtr)
		// NOTE:  the pointer list can't run past the start of the actual text to which it points
		// ALSO: bounds-checks say that pointers should be in the range from 0x4000 - 0x9FFF
		//
		while ((ptrindex * 2) < minptr - offsetPtr) {

			pointer_pointer = block_start + (ptrindex *2);
//			printf("pointer_pointer %8.8x : ", pointer_pointer);

			lsbyte = array[pointer_pointer + 0];
			msbyte = array[pointer_pointer + 1];
			currptr = (int)(msbyte * 256) + lsbyte;

			// bounds check - if pointers are pointing out of bounds, stop accumulating...
			if ((currptr > 0x9FFF) || (currptr < 0x4000))
				break;

// update non-abbreviated list of pointers:
			pointer_diskaddr[num_of_pointers] = pointer_pointer;
			pointer_deref[num_of_pointers] = currptr;
			num_of_pointers++;


			if (currptr < minptr)
				minptr = currptr;

			if (currptr > maxptr)
				maxptr = currptr;

//			printf ("Found pointer %x\n", currptr);

			// if this is the first pointer, it is unique by definition; otherwise search for duplication
			if (numUniqPtrs == 0) {
				ptrList[numUniqPtrs] = currptr;
				numUniqPtrs++;
			}
			else {

				found = 0;
				for (k = 0; k < numUniqPtrs; k++) {
					if (ptrList[k] == currptr) {
						found = 1;
					}
				}
				if (found == 0) {
					ptrList[numUniqPtrs] = currptr;
					numUniqPtrs++;
				}
			}

			ptrindex++;
		}

		printf ("unique pointer list size = %d\n", numUniqPtrs);

		//	Now, we have a list of unique pointers; we should sort it now
		// sort the list (not-very-smart sort):

		for (j= 0; j < numUniqPtrs; j++) {
			for (k = 0; k < (numUniqPtrs - 1); k++) {
				if (ptrList[(k+1)] < ptrList[k]) {
					tmpPtr = ptrList[k];
					ptrList[k] = ptrList[(k+1)];
					ptrList[(k+1)] = tmpPtr;
				}
			}
		}
//
		for ( j = 0; j < numUniqPtrs; j++) {
			printf ("string # %d:   file %d, %d  (%4.4x)\n", (j+1), block[block_num][1], ptrList[j], ptrList[j]);
		}
//
		ptrindex = 0;
		stringnum = START_STRING;
		currloc = ptrList[0];
		lastloc = ptrList[numUniqPtrs-1];

		while (currloc <= lastloc) {

			srcpos = currloc - offsetPtr;					// currloc is resident location; srcpos is offset from block start

			in_ptr_list = 0;
			for (ptr_iter=0; ptr_iter < numUniqPtrs; ptr_iter++) {
				if (currloc == ptrList[ptr_iter]) {
					in_ptr_list = 1;
					printf("Found currloc %4.4x at pointer #%d\n", currloc, ptr_iter+1);

					break;
				}
			}
			if (in_ptr_list == 0) {
				printf("Currloc %4.4x not found in pointer list\n", currloc);
				fprintf(fout_err, "Currloc %4.4x not found in pointer list\n", currloc);
			}

			if (memcmp(&ffstring[0], &array[block_start + srcpos], 16) == 0) {
				// then this is a blank space - either pointers point to nowhere,
				// or to be used a s a buffer for dynamically forming a text message (not likely)
				memcpy(&raw_string[0], &ffstring[0], 16);

				memset(&tokenized_string[0], '\0',  9999);
				strcpy(tokenized_string, "[FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF]");
				tokenized_strlen = strlen(tokenized_string);

				memset(&unicode_string[0], '\0',  9999);
				strcpy(unicode_string, "[FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF][FF]");
				unicode_strlen = strlen(unicode_string);

				tmpcount = 16;
			}
			else
			{
				// normal string - traverse until end is found, making sure to skip over
				// tokens' second-byte values (which could otherwise appear as message_end tokens)
				//
				tmpcount = 0;
				while (srcpos + tmpcount <= 65536) {

					tmpbyte = array[block_start + srcpos + tmpcount];

					// if this is a 2-byte token, then don't mistake the second byte as a token itself (i.e. don't end prematurely)
					//
					if ( (tmpbyte < NUM_TOKENS) && token_list[tmpbyte].len > 1)
					{
						tmpcount += (token_list[tmpbyte].len - 1);
					}
					else if ((tmpbyte == ENDMSG_0) || (tmpbyte == ENDMSG_1)) {
						break;
					}
					tmpcount++;
				}
				tmpcount++;

				// grab the string (starting at  srcpos, for a length of tmpcount)
				memcpy(&raw_string[0], &array[block_start + srcpos], tmpcount);

				memset(&tokenized_string[0], '\0',  9999);
				tokenized_strlen = cvt_to_tokens(&tokenized_string[0], &raw_string[0], tmpcount);

				memset(&unicode_string[0], '\0',  9999);
				unicode_strlen = cvt_to_unicode(&unicode_string[0], &tokenized_string[0], tokenized_strlen);
			}

			// verify whether string has a pointer pointing to it
			// verify whether pointer points into the middle of it

			printf("----- ----- -----\n");
			printf("stringnum = %5.5d, location = %4.4x, orig len = %4.4x, end_location = %4.4x; pointer #%d\n\n",
					stringnum, currloc, tmpcount, (currloc+tmpcount-1), (in_ptr_list ? (ptr_iter+1) : 0));

			fprintf(fout_sjis, "----- ----- -----\n");
			fprintf(fout_sjis, "stringnum = %5.5d, location = %4.4x, orig len = %4.4x, end_location = %4.4x, len (including token expansion) = %4.4x, pointed to by pointer #%d\n\n",
					stringnum, currloc, tmpcount, (currloc+tmpcount-1), tokenized_strlen, (in_ptr_list ? (ptr_iter+1) : 0));

			fprintf(fout_utf, "----- ----- -----\n");
			fprintf(fout_utf, "stringnum = %5.5d, location = %4.4x, orig len = %4.4x, end_location = %4.4x, len (including token and UTF expansion) = %4.4x, pointed to by pointer #%d\n\n",
					stringnum, currloc, tmpcount, (currloc+tmpcount-1), unicode_strlen, (in_ptr_list ? (ptr_iter+1) : 0));

			// fetch database entry from table tblTransData and:
			// - verify existence
			// - verify length
			// - verify UTF string

		    char *sql = "SELECT NumBytes, Jap_Text_Dump FROM tblTransData WHERE FileId = ? AND Address = ?";

		    rc = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);

		    if (rc == SQLITE_OK) {
		        sqlite3_bind_int(stmt, 1, block[block_num][1]);
		        sqlite3_bind_int(stmt, 2, currloc);
		    } else {
		        printf("Failed to execute statement: %s\n", sqlite3_errmsg(db));
		        exit(1);
		    }

			result_count = 0;
			while (sqlite3_step(stmt) != SQLITE_DONE) {
				result_count++;
				if (result_count > 1) {
					printf("result # %d  ", result_count);
				}
				msglen_fromdb = sqlite3_column_int(stmt, 0);
				strcpy(utfextract_fromdb, sqlite3_column_text(stmt, 1));
				printf("extract length = %d, database says: %d\n", tmpcount, msglen_fromdb);
				fprintf(fout_err, "file = %d, address = %d, extract length = %d, database says: %d\n", block[block_num][1], currloc, tmpcount, msglen_fromdb);

				if (compare_ignoring_CR(unicode_string, utfextract_fromdb) == 1) {
					fprintf(fout_err, "Strings don't match\n");
					fprintf(fout_err, "Extracted Unicode_string:\n%s\n\nString from Database:\n%s\n\n", unicode_string, utfextract_fromdb);
					in_ptr_list = 2;
				}
				else
				{
					fprintf(fout_err, "strings match\n");
				}
				if (result_count > 1) {
					exit(1);
				}
			}

			if (result_count == 0) {
				fprintf(fout_err, "file = %d, address = %d, string didn't have a database match\n", block[block_num][1], currloc);
				printf("file = %d, address = %d, string didn't have a database match\n", block[block_num][1], currloc);
				insert_0_update_1 = 0;
				// exit(1);
			}
			else {
				insert_0_update_1 = 1;
			}

			sqlite3_finalize(stmt);

			//
			//

			if (update == 1)
			{

				sprintf(diskaddr_hex, "0x%7.7X", (block_start + srcpos));
				sprintf(addr_hex, "0x%4.4X", currloc);
				sprintf(numbyte_hex, "0x%4.4X", tmpcount);
				sprintf(endaddr_hex, "0x%4.4X", (currloc+tmpcount-1));

				if (in_ptr_list == 1) {			// found,, so it's a normal message
					not_message = 0;
				}
				else if (in_ptr_list == 2) {	// string doesn't match database, so special case
					not_message = 2;
				}
				else {
					not_message = 1;			// strings match, but no pointers point at it
				}

				if (insert_0_update_1 == 0)
				{
					char *insert_sql =
							"INSERT INTO tblTransData "
								"(Stringnum, FileId, Address, NumBytes, DiskAddr_Hex, Address_Hex, Numbytes_Hex, End_Addr_Hex, Orig_Data, Not_Message, Use_Orig_Data, "
								" Jap_Text_Dump, Modified_Date, Final_Coded_Uptodate, Comment, Translation_Complete, Insertion_Complete, Validated) "
								"VALUES "
								"( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, "
								" ?, datetime('now'), 0, 'Inserted by second extract', 0, 0, 0);";
					rc = sqlite3_prepare_v2(db, insert_sql, -1, &stmt, NULL);

					if (rc == SQLITE_OK) {
						sqlite3_bind_int(stmt, 1, stringnum);
						sqlite3_bind_int(stmt, 2, block[block_num][1]);
						sqlite3_bind_int(stmt, 3, currloc);
						sqlite3_bind_int(stmt, 4, tmpcount);
						sqlite3_bind_text(stmt, 5, diskaddr_hex, -1, NULL);
						sqlite3_bind_text(stmt, 6, addr_hex, -1, NULL);
						sqlite3_bind_text(stmt, 7, numbyte_hex, -1, NULL);
						sqlite3_bind_text(stmt, 8, endaddr_hex, -1, NULL);
						sqlite3_bind_blob(stmt, 9, raw_string, tmpcount, NULL);
						sqlite3_bind_int(stmt, 10, not_message);
						sqlite3_bind_text(stmt, 11, unicode_string, -1, NULL);
					} else {
						printf("Failed to execute statement: %s\n", sqlite3_errmsg(db));
						exit(1);
					}
				}

				else			// else it's an update
				{

					char *update_sql =
							"UPDATE tblTransData "
								"SET Stringnum = ?, DiskAddr_Hex = ?, Address_Hex = ?, NumBytes_Hex = ?, End_Addr_Hex = ?, Orig_Data = ?, Not_Message = ?  "
								"WHERE FileId = ? AND Address = ?";
					rc = sqlite3_prepare_v2(db, update_sql, -1, &stmt, NULL);

					if (rc == SQLITE_OK) {
						sqlite3_bind_int(stmt, 1, stringnum);
						sqlite3_bind_text(stmt, 2, diskaddr_hex, -1, NULL);
						sqlite3_bind_text(stmt, 3, addr_hex, -1, NULL);
						sqlite3_bind_text(stmt, 4, numbyte_hex, -1, NULL);
						sqlite3_bind_text(stmt, 5, endaddr_hex, -1, NULL);
						sqlite3_bind_blob(stmt, 6, raw_string, tmpcount, NULL);
						sqlite3_bind_int(stmt, 7, not_message);
						sqlite3_bind_int(stmt, 8, block[block_num][1]);
						sqlite3_bind_int(stmt, 9, currloc);
					} else {
						printf("Failed to execute statement: %s\n", sqlite3_errmsg(db));
						exit(1);
					}
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
// End of block controlled by 'update' flag


			// simple hex dump
			pointer_pointer = block_start + srcpos;
			for (i = 0; i < ((tmpcount/16) + 1); i++) {
//				printf ("%8.8x: ", pointer_pointer + (i*16));
				for (k = 0; k < 16; k++) {
					lsbyte = raw_string[((i*16) + k)];
//					printf ("%2.2x ", lsbyte);
					if (((i*16) + k + 2) > tmpcount) {
						break;
					}
				}
//				printf ("\n");
				if (((i*16) + 16) > tmpcount) {
					break;
				}
			}

//			printf("Tokenized:\n%s\n", tokenized_string);
			printf("Unicode:\n%s\n", unicode_string);
//			printf("Unicode_strlen = %d\n", unicode_strlen);

			fprintf(fout_sjis, "%s\n", tokenized_string);
			fprintf(fout_utf, "%s\n", unicode_string);


			// NEXT:
			// check whether the string is referenced by pointer
			// check whether a pointer points to middle of string

			currloc = currloc + tmpcount;
			stringnum++;

		}

//
//	Now, upsert into the tblPointers table
//

		if (update == 1)
		{
			for (i = 0; i < num_of_pointers; i++)
			{
				char *upsert_sql =
						"INSERT INTO tblPointers(DiskAddr_Hex, FileId, Ptr_Deref, Ptr_Deref_Hex) "
							"VALUES (?, ?, ?, ?) "
							"ON CONFLICT (DiskAddr_Hex) "
							"DO UPDATE SET DiskAddr_Hex=excluded.DiskAddr_Hex, FileId=excluded.FileId, Ptr_Deref=excluded.Ptr_Deref, Ptr_Deref_Hex=excluded.Ptr_Deref_Hex;";

				rc = sqlite3_prepare_v2(db, upsert_sql, -1, &stmt, NULL);

				sprintf(diskaddr_hex, "0x%7.7X", pointer_diskaddr[i]);
				sprintf(addr_hex, "0x%4.4X", pointer_deref[i]);

				if (in_ptr_list == 1)
					not_message = 0;
				else
					not_message = 1;

				if (rc == SQLITE_OK) {
					sqlite3_bind_text(stmt, 1, diskaddr_hex, -1, NULL);
					sqlite3_bind_int(stmt, 2, block[block_num][1]);
					sqlite3_bind_int(stmt, 3, pointer_deref[i]);
					sqlite3_bind_text(stmt, 4, addr_hex, -1, NULL);
				} else {
					printf("Failed to execute statement: %s\n", sqlite3_errmsg(db));
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
		}

		fclose(fout_sjis);
		fclose(fout_utf);

		printf("Done block %d\n", block[block_num][1]);

	}		// Next block (iterator 'block_num')


	fclose(fextract);
	sqlite3_close(db);


	return EXIT_SUCCESS;
}

int
compare_ignoring_CR(char * str1, char * str2)
{
	int	pos1, pos2;
	int	equal = 0;

	pos1 = 0;
	pos2 = 0;


	while (1)
	{
		if ((str1[pos1] == 0x00) && (str2[pos2] == 0x00))
		{
			break;
		}
		if ((str1[pos1] == 0x0a) || (str1[pos1] == 0x0d)) {
			pos1++;
			continue;
		}
		if ((str2[pos2] == 0x0a) || (str2[pos2] == 0x0d)) {
			pos2++;
			continue;
		}
		if (str1[pos1] == str2[pos2]) {
			pos1++;
			pos2++;
			continue;
		}
		equal = 1;
		break;
	}
	if (equal ==1)
		printf("Failed comparison at str1_pos = %d (%c), str2_pos = %d (%c)\n", pos1, str1[pos1], pos2, str2[pos2]);

	return(equal);
}

int
cvt_to_tokens(unsigned char *out, unsigned char *in, int len)
{
	int in_offset = 0;
	int out_offset = 0;
	unsigned char tmp_byte, tmp_byte1;

	while (in_offset < len) {
		tmp_byte = *(in+in_offset);
		tmp_byte1 = *(in+in_offset+1);

		// tokens are the first few possible ASCII characters and contiguous
		// if found, print name
		//
		if (tmp_byte < NUM_TOKENS)
		{
			memcpy((out+out_offset), token_list[tmp_byte].tokenname, strlen(token_list[tmp_byte].tokenname));
			out_offset += strlen(token_list[tmp_byte].tokenname);

			// if it's a 2-byte token, then it needs to have the second byte in the token (and closing brace)
			if (token_list[tmp_byte].len == 2)
			{
				sprintf((char *)(out + out_offset), "%2.2X>", tmp_byte1);
				out_offset += 3;
			}

			in_offset += token_list[tmp_byte].len;
		}
		else
		{
			// else, it's just a normal character (or partial charater for 2-byte codes)
			//
			*(out+out_offset) = *(in + in_offset);
			out_offset++;
			in_offset++;
		}
	}
	*(out+out_offset) = '\0';
	return out_offset;
}

// Note: we will use UTF-8 as 'Unicode' here
int
cvt_to_unicode(unsigned char *out, unsigned char *in, int len)
{
	int in_offset = 0;
	int out_offset = 0;
	unsigned char tmp_byte, tmp_byte1;
	int tmp_int, utf_len;
	int i;

	while (in_offset < len) {
		tmp_byte = *(in+in_offset);
		tmp_byte1 = *(in+in_offset+1);

		// SJIS is 2-byte from 0x81 to 0x9F, and 0xE0 onward.
		// 1-byte up to 0x80, and from 0xA0 to 0xDF
		if (((tmp_byte > 0x80) && (tmp_byte < 0xA0)) || (tmp_byte > 0xDF))
		{
			tmp_int = (int)(tmp_byte * 256) + tmp_byte1;

			utf_len = SJIS_to_UTF8(tmp_int, Unicode_buf);

			for (i = 0; i < utf_len; i++)
			{
				*(out+out_offset) = *(Unicode_buf+i);
				out_offset++;
			}
			in_offset +=2;
		}
		else		// 1-byte
		{
			*(out+out_offset) = *(in + in_offset);
			out_offset++;
			in_offset++;
		}

	}

	*(out+out_offset) = '\0';

	return(out_offset);
}

int
SJIS_to_UTF8(int sjis, unsigned char *buf) {
// instead of returning a 2-byte character, this can return up to three bytes; length is the return value
	int unicode_val;
	int len;

	unicode_val = SJIS_to_Unicode(sjis);

	if (unicode_val == 0) {
		printf("no unicode translation for %4.4x\n", sjis);
	}
	if (unicode_val < 0x80)
	{
		*(buf) = (unsigned char)unicode_val;
		len = 1;
	}
	else if (unicode_val < 0x800)
	{
		*(buf) = 0xC0 | (unsigned char)(unicode_val >> 6);
		*(buf+1) = 0x80 | (unsigned char)(unicode_val & 0x3f);
		len = 2;
	}
	else
	{
		*(buf) = 0xE0 | (unsigned char)(unicode_val >> 12);
		*(buf+1) = 0x80 | (unsigned char)((unicode_val & 0xfff) >> 6);
		*(buf+2) = 0x80 | (unsigned char)(unicode_val & 0x3f);
		len = 3;
	}

	return(len);
}


int
SJIS_to_Unicode(int sjis) {

	if (SJIS_map_read_flag == 0)
		read_Unicode_map();

	return(SJIS_to_Unicode_array[sjis]);
}

int
Unicode_to_SJIS(int uni) {

	if (SJIS_map_read_flag == 0)
		read_Unicode_map();

	return(Unicode_to_SJIS_array[uni]);
}

void
read_Unicode_map(void) {

	FILE *uni_file;
	int SJIS_index, Unicode_index;
	int temp;
	int c;
	int line;
	char filename_unimap[1000];

	/* build the filename for the Unicode map file */
	filename_unimap[0] = '\0';

	strcat(filename_unimap, currPath);
	strcat(filename_unimap, PATH_SEPARATOR);
	strcat(filename_unimap, map_fname);

	uni_file = fopen(filename_unimap, "rb");
	if (uni_file == NULL) {
		printf("could not open unicode mapping file '%s'\n", filename_unimap);
		exit(1);
	}

	line = 1;
	c = fgetc(uni_file);

	while (!feof(uni_file)) {														// get a line

		while (((c == 0x0d) || (c == 0x0a) || (c == 0x20)) && (!feof(uni_file))) {  // leading spaces

			if (c == 0x0a) {
				line++;
			}

			c = fgetc(uni_file);
		}

		SJIS_index = 0;
		Unicode_index = 0;

		if (c == '0') {																// starts out with 0x

			c = fgetc(uni_file);

			if ((c == 'x') && (!feof(uni_file))) {

				c = fgetc(uni_file);

				while ((c != 0x20) && (c != 0x09)) {
					temp = 0;
					if ((c >= '0') && (c <= '9')) {
						temp = (c - '0');
					}
					else if ((c >= 'A') && (c <= 'F')) {
						temp = (c - 'A') + 10;
					}
					else if ((c >= 'a') && (c <= 'f')) {
						temp = (c - 'a') + 10;
					}
					else
						printf("Parsing error, line #%d -> SJIS index character = %c, code = %d\n", line, c, c);

					SJIS_index = (SJIS_index * 16) + temp;

					c = fgetc(uni_file);
				}
			}
		}

		while (((c == 0x20) || (c == 0x09)) && (!feof(uni_file))) {					// intermediate spaces
			c = fgetc(uni_file);
		}

		if ((c == 'U') && (!feof(uni_file))) {										// starts out with U+

			c = fgetc(uni_file);

			if (c == '+') {

				c = fgetc(uni_file);

				while  ((c != 0x20) && (c != 0x09) && (c != '#') &&
						(c != 0x0d) && (c != 0x0a)  && (!feof(uni_file))) {

					temp = 0;
					if ((c >= '0') && (c <= '9')) {
						temp = (c - '0');
					}
					else if ((c >= 'A') && (c <= 'F')) {
						temp = (c - 'A') + 10;
					}
					else if ((c >= 'a') && (c <= 'f')) {
						temp = (c - 'a') + 10;
					}
					else
						printf("Parsing error, line #%d -> Unicode index character = %c, code = %d\n", line, c, c);

					Unicode_index = (Unicode_index * 16) + temp;

					c = fgetc(uni_file);
				}
			}
		}

		SJIS_to_Unicode_array[SJIS_index] = Unicode_index;
		Unicode_to_SJIS_array[Unicode_index] = SJIS_index;

		while (((c != 0x0d) && (c != 0x0a)) && (!feof(uni_file))) {					// trailing part of line
			if (c == 0x0a) {
				line++;
			}
			c = fgetc(uni_file);
		}
	}

	SJIS_map_read_flag = 1;
	return;
}
