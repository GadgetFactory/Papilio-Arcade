REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 5422df979e82bcc73df49f50515fe76c126c037b *2d
REM a8ee9ddfadf5e9accedfaf81da757a88a2e55a0a *2e
REM 3eae2b3e4596505a8afb5c5cfb108e823c2c4319 *2f
REM 170f9e92f0a3bee04407be27210b4fa825367688 *2h
REM e426ef6a7444a39a34d59799973b07d11b89f372 *2j
REM 174df3f281068c767344f751daace646360e26d6 *2l
REM a2f3380982d93a022f46756f974fd16c4cd617de *2m
REM f3a9c4d1d91836476fcad87ea0d243dde7171e0a *2p
REM d64134089bebd995b3a1a089411e180c8c29f32d *5f
REM 81b44eb1ce43cebde87f0a41ade2e7eb291af78d *5h
REM a25083c3e36d28afdefe4af6e6d4f3155e303625 *c01s.6e
REM 8ed78487d76fd0a917ab7b258937a46e2cd9800c *ot1.5c
REM 8558b4eff5d7e63029b325edef9914feda5834c3 *ot2.5d
REM 1f976d8595706730e29f93027e7ab4620075c078 *ot3.5e

set rom_path_src=..\roms\stern_scramble
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=scramble_hardware_p1_500K

set output_bitfile=scramble_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\2d + %rom_path_src%\2e + %rom_path_src%\2f + %rom_path_src%\2h + %rom_path_src%\2j + %rom_path_src%\2l + %rom_path_src%\2m + %rom_path_src%\2p %temp_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\c01s.6e       ROM_LUT        5 m r e > %temp_path%\ROM_LUT.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\rom.bin           ROM_PGM   14 m r e > %temp_path%\ROM_PGM.mem

%romgen_path%\romgen %rom_path_src%\5h            ROM_OBJ_0 11 m r e > %temp_path%\ROM_OBJ_0.mem
%romgen_path%\romgen %rom_path_src%\5f            ROM_OBJ_1 11 m r e > %temp_path%\ROM_OBJ_1.mem

%romgen_path%\romgen %rom_path_src%\ot1.5c        ROM_SND_0 11 m r e > %temp_path%\ROM_SND_0.mem
%romgen_path%\romgen %rom_path_src%\ot2.5d        ROM_SND_1 11 m r e > %temp_path%\ROM_SND_1.mem
%romgen_path%\romgen %rom_path_src%\ot3.5e        ROM_SND_2 11 m r e > %temp_path%\ROM_SND_2.mem


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