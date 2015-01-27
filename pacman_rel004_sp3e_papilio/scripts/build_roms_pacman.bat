@echo off

REM SHA1 sums of files required
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *82s123.7f
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82s126.1m
REM 0c4d0bee858b97632411c440bea6948a74759746 *82s126.3m
REM 19097b5f60d1030f8b82d9f1d3a241f93e5c75d6 *82s126.4a
REM 87117ba5082cd7a615b4ec7c02dd819003fbd669 *namcopac.6e
REM 326dbbf94c6fa2e96613dedb53702f8832b47d59 *namcopac.6f
REM 7e1945f6eb51f2e51806d0439f975f7a2889b9b8 *namcopac.6h
REM 01b4c38108d9dc4e48da4f8d685248e1e6821377 *namcopac.6j
REM 06ef227747a440831c9a3a613b76693d52a2f0a9 *pacman.5e
REM 4a937ac02216ea8c96477d4a15522070507fb599 *pacman.5f

set rom_path_src=..\roms\pacman
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\pacman.5e + %rom_path_src%\pacman.5f %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\namcopac.6e + %rom_path_src%\namcopac.6f + %rom_path_src%\namcopac.6h + %rom_path_src%\namcopac.6j %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 l r e     > %rom_path%\prom1_dst.vhd
%romgen_path%\romgen %rom_path_src%\82s126.4a     PROM4_DST  8 l r e     > %rom_path%\prom4_dst.vhd
%romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST  4 l r e     > %rom_path%\prom7_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 c     > %rom_path%\prom1_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\82s126.4a     PROM4_DST  8 c     > %rom_path%\prom4_dst.vhd
REM %romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST  4 c     > %rom_path%\prom7_dst.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin          GFX1      13 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin          ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

REM this is ROM area not used but required
%romgen_path%\romgen %rom_path%\gfx1.bin          ROM_PGM_1 13 l r e > %rom_path%\rom1.vhd

echo done
pause
