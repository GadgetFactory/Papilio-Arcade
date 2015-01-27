@echo off
REM The game plays but there is no sound and the player's missile is invisible

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
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\ic13_1t.bin + %rom_path_src%\ic14_2t.bin + %rom_path_src%\ic15_3t.bin + %rom_path_src%\ic16_4t.bin + %rom_path_src%\ic17_5t.bin + %rom_path_src%\ic18_6t.bin %rom_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\6331-1j.86    ROM_LUT        5 l r e > %rom_path%\ROM_LUT.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\rom.bin           ROM_PGM   14 l r e > %rom_path%\ROM_PGM.vhd

%romgen_path%\romgen %rom_path_src%\ic31_1c.bin   ROM_OBJ_0 11 l r e > %rom_path%\ROM_OBJ_0.vhd
%romgen_path%\romgen %rom_path_src%\ic30_2c.bin   ROM_OBJ_1 11 l r e > %rom_path%\ROM_OBJ_1.vhd

%romgen_path%\romgen %rom_path_src%\ic55_2.bin    ROM_SND_0 11 l r e > %rom_path%\ROM_SND_0.vhd
%romgen_path%\romgen %rom_path_src%\ic56_1.bin    ROM_SND_1 11 l r e > %rom_path%\ROM_SND_1.vhd
%romgen_path%\romgen %rom_path_src%\ic56_1.bin    ROM_SND_2 11 l r e > %rom_path%\ROM_SND_2.vhd

echo done
echo REMEMBER to set I_HWSEL_FROGGER := false in the VHDL code!
pause
