@echo off

REM SHA1 sums of files required
REM 8adcb7cd4492fa6649d9ee81172d8dff56621d64 *1e.bin
REM 7e02651692113db31fd469868ae5ffdb0f941ecf *1f.bin
REM b693667656e5d8f44eeb2ea730f4d4db436da579 *1g.bin
REM eec34b3d5585bae03c7b80585daaa05ddfcc2164 *1h.bin

set rom_path_src=..\roms\alieninv
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\1h.bin + %rom_path_src%\1g.bin + %rom_path_src%\1f.bin + %rom_path_src%\1e.bin %rom_path%\invaders_rom.bin > NUL

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\invaders_rom.bin INVADERS_ROM 13 l r e > %rom_path%\invaders_rom.vhd

echo done
pause
