# Print Patch

DotBNewFont-8x12.bmp is the template font used (BMP format).  Note the accented characters for French support.  This is converted to NewFont8x12.bin by using FEIDAN

To recreate the patch:
- DotB1_patch_2018.asm should be assembled by using PCEAS (part of HuC).  Any version should be usable.
  - pceas -l -raw DotB_patch_2018.asm

- The bash script 'patch_dotb' will use the 'filepatch' utility (see Tools folder) to apply the key portions to the track02.iso file (in the folder above this one).


