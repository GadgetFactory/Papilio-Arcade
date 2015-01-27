REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 5c144a613fc4960a1dfd7ead89e7fee258a63171 *2s140.4a
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *82S123.7F
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82S126.1M
REM 0c4d0bee858b97632411c440bea6948a74759746 *82S126.3M
REM 68ebb7d9f70af868d99ec42c26bc55a54ba1f22c *tp1
REM 66de8203c364fd90e8a2b5749c2e40665b2f5830 *tp2
REM f828a177f22db9093a00c31e39e16214ce0dc6de *tp3
REM ff58d2dfb016397daabe2996bc3a7b63d28a4cca *tp4
REM 8ca5cd82d099b55e20f785489158231a1d99a430 *tp5a
REM 84b5e64bdbc25afab9b6f53e1719640e21a6feba *tp6
REM 7c3d7eb07b9256130141f71eba722f7823fd4c32 *tp7
REM b3b9066d9a43796185c00ae12f7bb2bbf42e3a07 *tp8
REM 95b204af0345163f93811cc770ee0ca2851a39c1 *tpa
REM dce755511b6262b984a2bca329f454892e486a09 *tpb
REM c9256795c6d0929ade1f24b372dadc2a2b88d897 *tpc
REM 65dd7861e05651485626465dc97215fed58db551 *tpd

set rom_path_src=..\roms\crush2
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=pacman_hardware_p1_500K

set output_bitfile=crush_roller_on_%bit_file%.bit


REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\tpa + %rom_path_src%\tpc + %rom_path_src%\tpb + %rom_path_src%\tpd %temp_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\tp1 + %rom_path_src%\tp5a + %rom_path_src%\tp2 + %rom_path_src%\tp6 + %rom_path_src%\tp3 + %rom_path_src%\tp7 + %rom_path_src%\tp4 + %rom_path_src%\tp8 %temp_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST 9 m r e    > %temp_path%\prom1_dst.mem
%romgen_path%\romgen %rom_path_src%\2s140.4a      PROM4_DST 8 m r e    > %temp_path%\prom4_dst.mem
%romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST 4 m r e    > %temp_path%\prom7_dst.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\gfx1.bin          GFX1      13  m r e > %temp_path%\gfx1.mem
%romgen_path%\romgen %temp_path%\main.bin          ROM_PGM_0 14  m r e > %temp_path%\rom0.mem

REM this is ROM area not used but required
%romgen_path%\romgen %temp_path%\gfx1.bin          ROM_PGM_1 13  m r e > %temp_path%\rom1.mem

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

