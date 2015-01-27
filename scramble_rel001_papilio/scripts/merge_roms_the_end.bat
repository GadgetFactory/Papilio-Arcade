REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM d89575f3749c75dc963317fe451ffeffd9856e4d *6331-1j.86
REM f684927cecabfbd7544f7549a6152c0a6a436019 *ic13_1t.bin
REM caf369fde632652a0a5fb11d3605f0d2386d297a *ic14_2t.bin
REM 5f70518e5dbfca0ba12ba4dc4f357ce8e6b27bc8 *ic15_3t.bin
REM 14464aa5284aecc9c6046e464ab3d13da89d8dda *ic16_4t.bin
REM 3c8c099c7865997d475c096f1b1c93d88ab21543 *ic17_5t.bin
REM 3311361a1eb29715aa41d61fbb3563014bd9eeb1 *ic18_6t.bin
REM a8ea784a2660f855757ae0b30cb2a33ab6f2cd59 *ic30_2c.bin
REM f1abcbfc3146a18dc3ff865e3ba278377a42a875 *ic31_1c.bin
REM 3e080621f2e83909a6f304a2d960a080bccbbdc2 *ic55_2.bin
REM ca483943971c8fc7f5775a8a7cc6ddd331d48170 *ic56_1.bin

set rom_path_src=..\roms\the_end
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=scramble_hardware_p1_500K

set output_bitfile=the_end_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\ic13_1t.bin + %rom_path_src%\ic14_2t.bin + %rom_path_src%\ic15_3t.bin + %rom_path_src%\ic16_4t.bin + %rom_path_src%\ic17_5t.bin + %rom_path_src%\ic18_6t.bin %temp_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\6331-1j.86       ROM_LUT        5 m r e > %temp_path%\ROM_LUT.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\rom.bin           ROM_PGM   14 m r e > %temp_path%\ROM_PGM.mem

%romgen_path%\romgen %rom_path_src%\ic31_1c.bin            ROM_OBJ_0 11 m r e > %temp_path%\ROM_OBJ_0.mem
%romgen_path%\romgen %rom_path_src%\ic30_2c.bin            ROM_OBJ_1 11 m r e > %temp_path%\ROM_OBJ_1.mem

%romgen_path%\romgen %rom_path_src%\ic55_2.bin         ROM_SND_0 11 m r e > %temp_path%\ROM_SND_0.mem
%romgen_path%\romgen %rom_path_src%\ic56_1.bin        ROM_SND_1 11 m r e > %temp_path%\ROM_SND_1.mem
%romgen_path%\romgen %rom_path_src%\ic56_1.bin        ROM_SND_2 11 m r e > %temp_path%\ROM_SND_2.mem


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