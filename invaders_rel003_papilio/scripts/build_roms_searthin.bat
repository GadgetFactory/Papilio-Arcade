@echo off

REM SHA1 sums of files required
REM e7e8c080cb6baf342ec637532e05d38129ae73cf *earthinv.e
REM b8c1efb4251a1e690ff6936ec956d6f66136a085 *earthinv.f
REM 8d9ca92405fbaf1d5a7138d400986616378d061e *earthinv.g
REM 90bfa4ea06f38e67fe4286d37d151632439249d2 *earthinv.h

set rom_path_src=..\roms\searthin
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\earthinv.h +%rom_path_src%\earthinv.g +%rom_path_src%\earthinv.f + %rom_path_src%\earthinv.e %rom_path%\invaders_rom.bin > NUL

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\invaders_rom.bin INVADERS_ROM 13 l r e > %rom_path%\invaders_rom.vhd

echo done
pause
