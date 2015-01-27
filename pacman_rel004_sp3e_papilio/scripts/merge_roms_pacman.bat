REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *82s123.7f
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82s126.1m
REM 0c4d0bee858b97632411c440bea6948a74759746 *82s126.3m
REM 19097b5f60d1030f8b82d9f1d3a241f93e5c75d6 *82s126.4a
REM 87117ba5082cd7a615b4ec7c02dd819003fbd669 *namcopac.6e
REM 326dbbf94c6fa2e96613dedb53702f8832b47d59 *namcopac.6f
REM 7e1945f6eb51f2e51806d0439f975f7a2889b9b8 *namcopac.6h
REM 01b4c38108d9dc4e48da4f8d685248e1e6821377 *namcopac.6j
REM 06ef227747a440831c9a3a613b76693d52a2f0a9 *pacman.5e
REM 4a937ac02216ea8c96477d4a15522070507fb599 *pacman.5f

set rom_path_src=..\roms\pacman
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=pacman_hardware_p1_500K

set output_bitfile=pacman_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\pacman.5e + %rom_path_src%\pacman.5f %temp_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\namcopac.6e + %rom_path_src%\namcopac.6f + %rom_path_src%\namcopac.6h + %rom_path_src%\namcopac.6j %temp_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 m r e     > %temp_path%\prom1_dst.mem
%romgen_path%\romgen %rom_path_src%\82s126.4a     PROM4_DST  8 m r e   > %temp_path%\prom4_dst.mem
%romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST  4 m r e  > %temp_path%\prom7_dst.mem
REM %romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 c     > %temp_path%\prom1_dst.mem
REM %romgen_path%\romgen %rom_path_src%\82s126.4a     PROM4_DST  8 c     > %temp_path%\prom4_dst.mem
REM %romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST  4 c     > %temp_path%\prom7_dst.mem

REM generate RAMB structures for larger ROMS
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