@echo off

REM SHA1 sums of files required
REM XXXX *1h.bin
REM XXXX *1k.bin
REM XXXX *6l.bpr
REM XXXX *7l
REM XXXX *galmidw.u
REM XXXX *galmidw.v
REM XXXX *galmidw.w
REM XXXX *galmidw.y

set rom_path_src=..\roms\mrdonight
set bit_file_path=..\bit_files
set temp_path=..\scripts\tmp
set romgen_path=..\romgen_source
set data2mem=..\scripts\bin\data2mem

REM Bit file to merge the ROMs into. Uncomment the bit file for the Papilio Arcade board you are using.
REM This is for the papilio pro with arcade megawing chip
REM set bit_file=mrdonight_hardware_papilio_pro_lx9
REM this is for the Papilio One with 500K chip
set bit_file=mrdonight_hardware_p1_500K

set output_bitfile=mrdonight_on_%bit_file%.bit

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\1h.bin + %rom_path_src%\1k.bin %temp_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\galmidw.u + %rom_path_src%\galmidw.v + %rom_path_src%\galmidw.w + %rom_path_src%\galmidw.y + %rom_path_src%\7l %temp_path%\main.bin > NUL

REM generate RTL code for small PROMS
REM %romgen_path%\romgen %rom_path_src%\6l.bpr    GALAXIAN_6L  5 c     > %rom_path%\galaxian_6l.vhd
%romgen_path%\romgen %rom_path_src%\6l.bpr    GALAXIAN_6L  5 m r e     > %temp_path%\galaxian_6l.mem

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\gfx1.bin        GFX1      12 m r e > %temp_path%\gfx1.mem
%romgen_path%\romgen %temp_path%\main.bin        ROM_PGM_0 14 m r e > %temp_path%\rom0.mem

%romgen_path%\romgen %rom_path_src%\1h.bin    GALAXIAN_1H 11 m r e > %temp_path%\galaxian_1h.mem
%romgen_path%\romgen %rom_path_src%\1k.bin    GALAXIAN_1K 11 m r e > %temp_path%\galaxian_1k.mem

REM %romgen_path%\romgen %rom_path_src%\mc_wav_2.bin GALAXIAN_WAV 18 l r e > %rom_path%\galaxian_wav.vhd

%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %bit_file_path%\%bit_file%.bit -bd %temp_path%\galaxian_6l.mem tag avrmap.galaxian_6l -o b %temp_path%\out1.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out1.bit -bd %temp_path%\rom0.mem tag avrmap.rom_code -o b %temp_path%\out2.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out2.bit -bd %temp_path%\galaxian_1h.mem tag avrmap.rom_1h -o b %temp_path%\out3.bit
%data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out3.bit -bd %temp_path%\galaxian_1k.mem tag avrmap.rom_1k -o b %bit_file_path%\%output_bitfile%

REM %data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out4.bit -bd %temp_path%\rom0.mem tag avrmap.rom_code -o b %temp_path%\out5.bit
REM %data2mem% -bm %bit_file_path%\%bit_file%_bd.bmm -bt %temp_path%\out5.bit -bd %temp_path%\rom1.mem tag avrmap.rom_wiz -o b %bit_file_path%\%output_bitfile%

REM Cleanup
del %temp_path%\out*.bit
del %temp_path%\*.mem
del %temp_path%\*.bin

echo Merged bit file is located at: %bit_file_path%\%output_bitfile%
pause
