REM Written for Gadget Factories Papilio Arcade
REM Copyright 2001 Gadget Factory, LLC
REM http://www.gadgetfactory.net
REM License Creative Commons Attribution

@echo off

REM SHA1 sums of files required
REM 68c99b6cdcb9396bb473739a62ffc009b4bf57d5 *epr-1012.ic5
REM cdf560adbd7f2813e86e378da7781cccf7928a44 *epr-1013a.ic6
REM 4612e1fe1ab7182a277140b1a1976cc17e0746a5 *epr-1014.ic7
REM be94e9f5caa74c3de6fd95bd20928f4a9c514227 *epr-1015.ic8
REM f090afcfacf5f13cdfa0dfda8e3feb868c6ce8bc *epr-608.ic32
REM 75582a94b696062cbdb66a4c5cf0bc0bb94f81ee *epr-609.ic33
REM 2e1d34ae4da385fd7cac94707d25eeddf4604e1a *epr-610.ic34
REM 78831fd287da18928651a8adb7e578d291493eff *epr-607.ic101
REM dd768967add61467baa08d5929001f157d6cd911 *epr-606.ic102
REM 66648b2b28d3dcbda5bdb2605d1977428939dd3c *pr-91.6l

set rom_path_src=..\roms\sega_frogger
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio Logic with LX9 chip
REM set bit_file=pacman_hardware_papilio_logic_lx9
REM this is for the Papilio One with 500K chip
set bit_file=frogger_hardware_p1_500K

set output_bitfile=frogger_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\epr-1012.ic5+%rom_path_src%\epr-1013a.ic6+%rom_path_src%\epr-1014.ic7+%rom_path_src%\epr-1015.ic8 %temp_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\pr-91.6l       ROM_LUT        5 m r e > %temp_path%\ROM_LUT.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\rom.bin           ROM_PGM   14 m r e > %temp_path%\ROM_PGM.mem

%romgen_path%\romgen %rom_path_src%\epr-606.ic102            ROM_OBJ_0 11 m r e > %temp_path%\ROM_OBJ_0.mem
%romgen_path%\romgen %rom_path_src%\epr-607.ic101            ROM_OBJ_1 11 m r e > %temp_path%\ROM_OBJ_1.mem

%romgen_path%\romgen %rom_path_src%\epr-608.ic32        ROM_SND_0 11 m r e > %temp_path%\ROM_SND_0.mem
%romgen_path%\romgen %rom_path_src%\epr-609.ic33        ROM_SND_1 11 m r e > %temp_path%\ROM_SND_1.mem
%romgen_path%\romgen %rom_path_src%\epr-610.ic34        ROM_SND_2 11 m r e > %temp_path%\ROM_SND_2.mem


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