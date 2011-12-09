@echo off

set rom_path_src=..\roms\pong_homebrew
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\pacman.5e + %rom_path_src%\pacman.5f %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\pacman.6e + %rom_path_src%\pacman.6f + %rom_path_src%\pacman.6h + %rom_path_src%\pacman.6j %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\pacman.1m     PROM1_DST  9 l r e     > %rom_path%\prom1_dst.vhd
%romgen_path%\romgen %rom_path_src%\pacman.4a     PROM4_DST  8 l r e     > %rom_path%\prom4_dst.vhd
%romgen_path%\romgen %rom_path_src%\pacman.7f     PROM7_DST  4 l r e     > %rom_path%\prom7_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\pacman.1m     PROM1_DST  9 c     > %rom_path%\prom1_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\pacman.4a     PROM4_DST  8 c     > %rom_path%\prom4_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\pacman.7f     PROM7_DST  4 c     > %rom_path%\prom7_dst.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin          GFX1      13 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin          ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

REM this is ROM area not used but required
%romgen_path%\romgen %rom_path%\gfx1.bin          ROM_PGM_1 13 l r e > %rom_path%\rom1.vhd

echo done
pause
 