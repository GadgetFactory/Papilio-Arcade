REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM d89575f3749c75dc963317fe451ffeffd9856e4d *6331-1j.86
REM b926801ab1cc1e2787a76ced6c7cffd6fce753d4 *ic13
REM bde9f3c6cf060dc6f5b7652287b94e04bed7bcf7 *ic14
REM 7556d3dc51d6a112b6357b8a36df05fd1a4d1cc9 *ic15
REM 3354eb328a32537f722fe8a0949ddcab6cf21eb8 *ic16
REM 855c6ddf29fbfea004c7143fe29064abf53801ad *ic17
REM d644968758a1b73d13e09b24d24bfec82276e8f4 *ic18
REM 92a384899d5acd2c689f637da16a0e2d11a9d9c6 *ic30
REM f3ad51dc88aa58fd39195ead978b039e0b0b585c *ic31
REM 27678fc3172cbca3ae1eae96e9d8a62561d5ce40 *ic55
REM bcccdacacfc9a3b5f1412dfba6bb0046d283bccc *ic56

set rom_path_src=..\roms\stern_the_end
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=scramble_hardware_p1_500K

set output_bitfile=stern_the_end_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\ic13 + %rom_path_src%\ic14 + %rom_path_src%\ic15 + %rom_path_src%\ic16 + %rom_path_src%\ic17 + %rom_path_src%\ic18 %temp_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\6331-1j.86       ROM_LUT        5 m r e > %temp_path%\ROM_LUT.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\rom.bin           ROM_PGM   14 m r e > %temp_path%\ROM_PGM.mem

%romgen_path%\romgen %rom_path_src%\ic31            ROM_OBJ_0 11 m r e > %temp_path%\ROM_OBJ_0.mem
%romgen_path%\romgen %rom_path_src%\ic30            ROM_OBJ_1 11 m r e > %temp_path%\ROM_OBJ_1.mem

%romgen_path%\romgen %rom_path_src%\ic55        ROM_SND_0 11 m r e > %temp_path%\ROM_SND_0.mem
%romgen_path%\romgen %rom_path_src%\ic56        ROM_SND_1 11 m r e > %temp_path%\ROM_SND_1.mem
%romgen_path%\romgen %rom_path_src%\ic56        ROM_SND_2 11 m r e > %temp_path%\ROM_SND_2.mem


%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %bit_file_path%\%bit_file%.bit -bd %temp_path%\ROM_LUT.mem tag avrmap.ROM_LUT -o b %temp_path%\out1.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out1.bit -bd %temp_path%\ROM_PGM.mem tag avrmap.ROM_PGM -o b %temp_path%\out2.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out2.bit -bd %temp_path%\ROM_OBJ_0.mem tag avrmap.ROM_OBJ_0 -o b %temp_path%\out3.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out3.bit -bd %temp_path%\ROM_OBJ_1.mem tag avrmap.ROM_OBJ_1 -o b %temp_path%\out4.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out4.bit -bd %temp_path%\ROM_SND_0.mem tag avrmap.ROM_SND_0 -o b %temp_path%\out5.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out5.bit -bd %temp_path%\ROM_SND_1.mem tag avrmap.ROM_SND_1 -o b %temp_path%\out6.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out6.bit -bd %temp_path%\ROM_SND_2.mem tag avrmap.ROM_SND_2 -o b %bit_file_path%\%output_bitfile%


REM Cleanup
del %temp_path%\out*.bit
del %temp_path%\*.mem
del %temp_path%\*.bin

echo Merged bit file is located at: %bit_file_path%\%output_bitfile%
pause