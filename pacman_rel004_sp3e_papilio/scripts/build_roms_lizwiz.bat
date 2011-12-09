@echo off

REM SHA1 sums of files required
REM 3a09b29374031aaa3722932aff974a467b3bb201 *4a.cpu
REM c960cd5720bfa21db73e1000fe8be7d5baf2a3a1 *5e.cpu
REM 194c8f816e5ff7614b3db4f355223667105738fa *5f.cpu
REM 467c9d70e07f403b6b9118aebe4e6d0abb40a5c1 *6e.cpu
REM 12fce48008c4f9387df0c84f3b0d7c5a1b35d898 *6f.cpu
REM 8c2458f98320c6887580c71632b544da0a582ba2 *6h.cpu
REM f91447ec1f06bf95106e6872d80dcb82e1d42ffb *6j.cpu
REM 4f2c3e7d6c38f0b9a90317f91feb3f86c9a0d0a5 *7f.cpu
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82s126.1m
REM 0c4d0bee858b97632411c440bea6948a74759746 *82s126.3m
REM ec0b123fd2e6de6681ca14f35fda249b2c2ec44f *wiza
REM 3ea384a1064302709d97fc16b347d3c012e90ac7 *wizb

set rom_path_src=..\roms\lizwiz
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\wiza + %rom_path_src%\wizb %rom_path%\wiz.bin > NUL
copy /b/y %rom_path_src%\5e.cpu + %rom_path_src%\5f.cpu %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\6e.cpu + %rom_path_src%\6f.cpu + %rom_path_src%\6h.cpu + %rom_path_src%\6j.cpu %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST  9 c     > %rom_path%\prom1_dst.vhd
%romgen_path%\romgen %rom_path_src%\4a.cpu        PROM4_DST  8 c     > %rom_path%\prom4_dst.vhd
%romgen_path%\romgen %rom_path_src%\7f.cpu        PROM7_DST  4 c     > %rom_path%\prom7_dst.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin          GFX1      13 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin          ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

REM this is ROM area is used and required
%romgen_path%\romgen %rom_path%\wiz.bin           ROM_PGM_1 13 l r e > %rom_path%\rom1.vhd

echo done
pause
