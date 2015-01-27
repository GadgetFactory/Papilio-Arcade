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
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\epr-1012.ic5+%rom_path_src%\epr-1013a.ic6+%rom_path_src%\epr-1014.ic7+%rom_path_src%\epr-1015.ic8 %rom_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\pr-91.6l      ROM_LUT        5 l r e > %rom_path%\ROM_LUT.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\rom.bin           ROM_PGM   14 l r e > %rom_path%\ROM_PGM.vhd

%romgen_path%\romgen %rom_path_src%\epr-606.ic102 ROM_OBJ_0 11 l r e > %rom_path%\ROM_OBJ_0.vhd
%romgen_path%\romgen %rom_path_src%\epr-607.ic101 ROM_OBJ_1 11 l r e > %rom_path%\ROM_OBJ_1.vhd

%romgen_path%\romgen %rom_path_src%\epr-608.ic32  ROM_SND_0 11 l r e > %rom_path%\ROM_SND_0.vhd
%romgen_path%\romgen %rom_path_src%\epr-609.ic33  ROM_SND_1 11 l r e > %rom_path%\ROM_SND_1.vhd
%romgen_path%\romgen %rom_path_src%\epr-610.ic34  ROM_SND_2 11 l r e > %rom_path%\ROM_SND_2.vhd

echo done
echo REMEMBER to set I_HWSEL_FROGGER := true in the VHDL code!
pause
