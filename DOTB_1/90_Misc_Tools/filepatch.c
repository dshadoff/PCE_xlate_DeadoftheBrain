/*
 ============================================================================
 Name        : filepatch.c
 Author      : Dave Shadoff
 Version     :
 Copyright   : (C) 2021 Dave Shadoff
 Description : File patching utility, to copy from one file into another
 ============================================================================
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// unsigned char track_data[30000000];
FILE *fin, *fout;

int get_int(char * in_string)
{
	int a = 0;
	int base = 10;
	int offset = 0;
	int iter;
	int char_val;

	if (in_string[0] == '$') {
		base = 16;
		offset = 1;
	}
	else if ((in_string[0] == '0') && (in_string[1] == 'x')) {
		base = 16;
		offset = 2;
	}

	iter = offset;
	while (iter < strlen(in_string)) {
		char_val = 0;

		if ((in_string[iter] >= '0') && (in_string[iter] <= '9')) {
			char_val = (in_string[iter] - '0');
		}
		else if ( (base == 16) &&  ((in_string[iter] >= 'A') && (in_string[iter] <= 'F'))) {
			char_val = (in_string[iter] - 'A' + 10);
		}
		else if ( (base == 16) &&  ((in_string[iter] >= 'a') && (in_string[iter] <= 'f'))) {
			char_val = (in_string[iter] - 'a' + 10);
		}
		else {
			a = -1;		/* Invalid Character */
			break;
		}

		a = (a * base) + char_val;
		iter++;
	}

	return(a);
}


int main(int argc, char * argv[]) {
	int i;
	int stat;
	char patchbyte[1000];		/* we only use one byte, but just in case.... */

	int target_offset, patch_offset, patch_length;
	long int target_filesize, patch_filesize;

	if (argc != 6) {
		printf("%d arguments\n", argc);
		printf("Usage: filepatch <target_file> <target_offset> <patch_file> <patch_offset> <patch_numbytes>\n");
		exit(1);
	}


	target_offset = get_int(argv[2]);
	if (target_offset == -1) {
		printf("Invalid character in target_offset\n");
		exit(1);
	}

	patch_offset = get_int(argv[4]);
	if (patch_offset == -1) {
		printf("Invalid character in patch_offset\n");
		exit(1);
	}

	patch_length = get_int(argv[5]);
	if (target_offset == -1) {
		printf("Invalid character in patch_length\n");
		exit(1);
	}

//	printf("Target file = %s\n", argv[1]);
//	printf("Target offset = 0x%x, (%d)\n", target_offset, target_offset);
//	printf("Patch file = %s\n", argv[3]);
//	printf("Patch offset = 0x%x, (%d)\n", patch_offset, patch_offset);
//	printf("Patch length = 0x%x, (%d)\n", patch_length, patch_length);

	fout = fopen(argv[1], "r+b");

	if (fout == NULL) {
		printf("could not open the target file\n");
		exit(1);
	}
//	else {
//		printf("success opening target file\n");
//	}

	if (fseek(fout, 0, SEEK_END) != 0) {
		printf("Error finding end of target file, errno = %d\n", errno);
		exit(1);
	}

	target_filesize = ftell(fout);

	fin = fopen(argv[3], "rb");

	if (fin == NULL) {
		printf("could not open the patch file\n");
		exit(1);
	}
//	else {
//		printf("success opening patch file\n");
//	}

	if (fseek(fin, 0, SEEK_END) != 0) {
		printf("Error finding end of patch file, errno = %d\n", errno);
		exit(1);
	}

	patch_filesize = ftell(fin);

//	printf("\ntarget_filesize = %ld\npatch_filesize = %ld\n", target_filesize, patch_filesize);

	if ((target_offset + patch_length -1) > target_filesize) {
		printf("Patch would extend beyond end-of-file; filesize = %ld, offset+length = %d\n", target_filesize, (target_offset+patch_length));
		exit(1);
	}

	if ((patch_offset + patch_length -1) > patch_filesize) {
		printf("Patch file too short; filesize = %ld, offset+length = %d\n", patch_filesize, (patch_offset+patch_length));
		exit(1);
	}

	if (fseek(fin, patch_offset, SEEK_SET) != 0) {
		printf("error seeking to patch area within patch file, errno = %d\n", errno);
		exit(1);
	}

	if (fseek(fout, target_offset, SEEK_SET) != 0) {
		printf("error seeking to patch area within target file, errno = %d\n", errno);
		exit(1);
	}



	for (i = 0; i < patch_length; i++) {
		stat = fread(patchbyte, 1, 1, fin);
		if (stat < 1) {
			printf("Error reading\n");
			exit(1);
		}
		stat = fwrite(patchbyte, 1, 1, fout);
		if (stat < 1) {
			printf("Error writing\n");
			exit(1);
		}
	}


	return EXIT_SUCCESS;

}
