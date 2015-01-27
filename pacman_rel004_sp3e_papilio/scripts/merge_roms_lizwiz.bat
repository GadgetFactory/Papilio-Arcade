REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 3a09b29374031aaa3722932aff974a467b3bb201 *4a.cpu
REM c960cd5720bfa21db73e1000fe8be7d5baf2a3a1 *5e.cpu
REM 194c8f816e5ff7614b3db4f355223667105738fa *5f.cpu
REM 467c9d70e07f403b6b9118aebe4e6d0abb40a5c1 *6e.cpu
REM 12fce48008c4f9387df0c84f3b0d7c5a1b35d898 *6f.cpu
REM 8c2458f98320c6887580c71632b544da0a582ba2 *6h.cpu
REM f91447ec1f06bf95106e6872d80dcb82e1d42ffb *6j.cpu
REM 4f2c3e7d6c38f0b9a90317f91feb3f86c9a0d0a5 *7f.cpu
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82s126.1m
REM 0c4d0bee858b97632411c440bea6948a74759746 *82s126.3m
REM ec0b123fd2e6de6681ca14f35fda249b2c2ec44f *wiza
REM 3ea384a1064302709d97fc16b347d3c012e90ac7 *wizb

set rom_path_src=..\roms\lizwiz
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=pacman_hardware_p1_500K

set output_bitfile=lizard_wizard_on_%bit_file%.bit


REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\wiza + %rom_path_src%\wizb %temp_path%\wiz.bin > NUL
copy /b/y %rom_path_src%\5e.cpu + %rom_path_src%\5f.cpu %temp_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\6e.cpu + %rom_path_src%\6f.cpu + %rom_path_src%\6h.cpu + %rom_path_src%\6j.cpu %temp_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 m r e     > %temp_path%\prom1_dst.mem
%romgen_path%\romgen %rom_path_src%\4a.cpu        PROM4_DST  8 m r e     > %temp_path%\prom4_dst.mem
%romgen_path%\romgen %rom_path_src%\7f.cpu        PROM7_DST  4 m r e     > %temp_path%\prom7_dst.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\gfx1.bin          GFX1      13 m r e > %temp_path%\gfx1.mem
%romgen_path%\romgen %temp_path%\main.bin          ROM_PGM_0 14 m r e > %temp_path%\rom0.mem

REM this is ROM area is used and required
%romgen_path%\romgen %temp_path%\wiz.bin           ROM_PGM_1 13 m r e > %temp_path%\rom1.mem

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

