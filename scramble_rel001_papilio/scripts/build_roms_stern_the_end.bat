@echo off
REM The game plays but there is no sound and the player's missile is invisible

REM SHA1 sums of files required
REM d89575f3749c75dc963317fe451ffeffd9856e4d *6331-1j.86
REM b926801ab1cc1e2787a76ced6c7cffd6fce753d4 *ic13
REM bde9f3c6cf060dc6f5b7652287b94e04bed7bcf7 *ic14
REM 7556d3dc51d6a112b6357b8a36df05fd1a4d1cc9 *ic15
REM 3354eb328a32537f722fe8a0949ddcab6cf21eb8 *ic16
REM 855c6ddf29fbfea004c7143fe29064abf53801ad *ic17
REM d644968758a1b73d13e09b24d24bfec82276e8f4 *ic18
REM 92a384899d5acd2c689f637da16a0e2d11a9d9c6 *ic30
REM f3ad51dc88aa58fd39195ead978b039e0b0b585c *ic31
REM 27678fc3172cbca3ae1eae96e9d8a62561d5ce40 *ic55
REM bcccdacacfc9a3b5f1412dfba6bb0046d283bccc *ic56

set rom_path_src=..\roms\stern_the_end
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\ic13 + %rom_path_src%\ic14 + %rom_path_src%\ic15 + %rom_path_src%\ic16 + %rom_path_src%\ic17 + %rom_path_src%\ic18 %rom_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\6331-1j.86    ROM_LUT        5 l r e > %rom_path%\ROM_LUT.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\rom.bin           ROM_PGM   14 l r e > %rom_path%\ROM_PGM.vhd

%romgen_path%\romgen %rom_path_src%\ic31          ROM_OBJ_0 11 l r e > %rom_path%\ROM_OBJ_0.vhd
%romgen_path%\romgen %rom_path_src%\ic30          ROM_OBJ_1 11 l r e > %rom_path%\ROM_OBJ_1.vhd

%romgen_path%\romgen %rom_path_src%\ic55          ROM_SND_0 11 l r e > %rom_path%\ROM_SND_0.vhd
%romgen_path%\romgen %rom_path_src%\ic56          ROM_SND_1 11 l r e > %rom_path%\ROM_SND_1.vhd
%romgen_path%\romgen %rom_path_src%\ic56          ROM_SND_2 11 l r e > %rom_path%\ROM_SND_2.vhd

echo done
echo REMEMBER to set I_HWSEL_FROGGER := false in the VHDL code!
pause
