REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 1216b963e73c1de63cc323e361875f6810d83a05 *gorkans1.rom
REM 847ba7ca033eaf49245bef49d6513619edec3472 *gorkans2.rom
REM c77de0e991c44c2ee8a4537e264ac8fbb1b4b7db *gorkans3.rom
REM 0f3608d630fba9d4734a3ef30199a5d1a067cdff *gorkans4.rom
REM 0803e1ec5e5ed742ea83ff156ae75a2d48530f71 *gorkans5.rom
REM ece44c3204cf182db23b594ebdc051b51340ba2b *gorkans6.rom
REM 58ac78fc5b3559ef771ca708a79089b7a00cf6b8 *gorkans7.rom
REM 8f657c1b2865987b60d95960c5297a82bb1cc6e0 *gorkans8.rom
REM 7e51ddcf496f3b80fe186acc8bc6a0e574340346 *gorkgfx1.rom
REM e78ac5afa1ce996c41005c619ba2d2aa718497fc *gorkgfx2.rom
REM 1d8b65cad0b834fb920135fc907432042bc83db2 *gorkgfx3.rom
REM 8d6882dad94b26da8f0737e7f7f99946fe273f1b *gorkgfx4.rom
REM 19097b5f60d1030f8b82d9f1d3a241f93e5c75d6 *gorkprom.1
REM 0c4d0bee858b97632411c440bea6948a74759746 *gorkprom.2
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *gorkprom.3
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *gorkprom.4

set rom_path_src=..\roms\gorkans
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=pacman_hardware_p1_500K

set output_bitfile=gorkans_on_%bit_file%.bit


REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\gorkgfx4.rom + %rom_path_src%\gorkgfx2.rom + %rom_path_src%\gorkgfx3.rom + %rom_path_src%\gorkgfx1.rom %temp_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\gorkans8.rom + %rom_path_src%\gorkans4.rom + %rom_path_src%\gorkans7.rom + %rom_path_src%\gorkans3.rom + %rom_path_src%\gorkans6.rom + %rom_path_src%\gorkans2.rom + %rom_path_src%\gorkans5.rom + %rom_path_src%\gorkans1.rom %temp_path%\main.bin > NUL

REM generate mem files for small PROMS
%romgen_path%\romgen %rom_path_src%\gorkprom.3    PROM1_DST  9 m r e    > %temp_path%\prom1_dst.mem
%romgen_path%\romgen %rom_path_src%\gorkprom.1    PROM4_DST  8 m r e    > %temp_path%\prom4_dst.mem
%romgen_path%\romgen %rom_path_src%\gorkprom.4    PROM7_DST  4 m r e    > %temp_path%\prom7_dst.mem

REM generate mem files for larger ROMS
%romgen_path%\romgen %temp_path%\gfx1.bin          GFX1      13 m r e > %temp_path%\gfx1.mem
%romgen_path%\romgen %temp_path%\main.bin          ROM_PGM_0 14 m r e > %temp_path%\rom0.mem

REM this is ROM area not used but required
%romgen_path%\romgen %temp_path%\gfx1.bin          ROM_PGM_1 13 m r e > %temp_path%\rom1.mem

%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %bit_file_path%\%bit_file%.bit -bd %temp_path%\prom1_dst.mem tag avrmap.rom_audio1m -o b %temp_path%\out1.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out1.bit -bd %temp_path%\prom4_dst.mem tag avrmap.rom_col4a -o b %temp_path%\out2.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out2.bit -bd %temp_path%\prom7_dst.mem tag avrmap.rom_col7f -o b %temp_path%\out3.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out3.bit -bd %temp_path%\gfx1.mem tag avrmap.rom_gfx1 -o b %temp_path%\out4.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out4.bit -bd %temp_path%\rom0.mem tag avrmap.rom_code -o b %bit_file_path%\%output_bitfile%

REM %data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out4.bit -bd %temp_path%\rom0.mem tag avrmap.rom_code -o b %temp_path%\out5.bit
REM %data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out5.bit -bd %temp_path%\rom1.mem tag avrmap.rom_wiz -o b %bit_file_path%\%output_bitfile%

REM Cleanup
del %temp_path%\out*.bit
del %temp_path%\*.mem
del %temp_path%\*.bin

echo Merged bit file is located at: %bit_file_path%\%output_bitfile%
pause
