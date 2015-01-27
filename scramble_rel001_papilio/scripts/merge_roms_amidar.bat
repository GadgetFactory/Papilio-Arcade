REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 3b432b42e79f8b0a7d65e197f373a04e3c92ff20 *2716.a5
REM c6014d9575e92adf09b0961c2158a779ebe940c4 *2716.a6
REM eca735c6a35561a9a6ba8a20dca1e1c78ed073fc *am2d
REM 5b2e49ff915295617671b13f15b566046a5dbc15 *am2e
REM 1d72e9ae3005029628c6f9beb6ca65afcb1f7893 *am2f
REM 7d0ee9a82f02163b4cc6a7097e88ae34e96ebf58 *am2h
REM c32fdc8e292d91159e6c80c7033abea6404a4f2c *am2j
REM 425ec2c2caf404fc8ab13ee38d6567413022e1a1 *am2l
REM e0d24475547bbe5a94b45be6abefb84ad84d2534 *am2m
REM 46d757180426b71c827d14a35824a248f2c787b6 *am2p
REM 1015e56f37c244a850a8f4bf0e36668f047fd46d *amidar.clr
REM 4f4c2915503b85abe141d717fd254ee10c9da99e *amidarus.5c
REM 84d953618c8bf510d23b42232a856ac55f1baff5 *amidarus.5d

set rom_path_src=..\roms\amidar
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=scramble_hardware_p1_500K

set output_bitfile=amidar_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\am2d + %rom_path_src%\am2e + %rom_path_src%\am2f + %rom_path_src%\am2h + %rom_path_src%\am2j + %rom_path_src%\am2l + %rom_path_src%\am2m + %rom_path_src%\am2p %temp_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\amidar.clr       ROM_LUT        5 m r e > %temp_path%\ROM_LUT.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\rom.bin           ROM_PGM   14 m r e > %temp_path%\ROM_PGM.mem

%romgen_path%\romgen %rom_path_src%\2716.a5            ROM_OBJ_0 11 m r e > %temp_path%\ROM_OBJ_0.mem
%romgen_path%\romgen %rom_path_src%\2716.a6            ROM_OBJ_1 11 m r e > %temp_path%\ROM_OBJ_1.mem

%romgen_path%\romgen %rom_path_src%\amidarus.5c        ROM_SND_0 11 m r e > %temp_path%\ROM_SND_0.mem
%romgen_path%\romgen %rom_path_src%\amidarus.5d        ROM_SND_1 11 m r e > %temp_path%\ROM_SND_1.mem
%romgen_path%\romgen %rom_path_src%\amidarus.5d        ROM_SND_2 11 m r e > %temp_path%\ROM_SND_2.mem


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