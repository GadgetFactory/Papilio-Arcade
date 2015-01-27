@echo off

REM SHA1 sums of files required
REM 1216b963e73c1de63cc323e361875f6810d83a05 *gorkans1.rom
REM 847ba7ca033eaf49245bef49d6513619edec3472 *gorkans2.rom
REM c77de0e991c44c2ee8a4537e264ac8fbb1b4b7db *gorkans3.rom
REM 0f3608d630fba9d4734a3ef30199a5d1a067cdff *gorkans4.rom
REM 0803e1ec5e5ed742ea83ff156ae75a2d48530f71 *gorkans5.rom
REM ece44c3204cf182db23b594ebdc051b51340ba2b *gorkans6.rom
REM 58ac78fc5b3559ef771ca708a79089b7a00cf6b8 *gorkans7.rom
REM 8f657c1b2865987b60d95960c5297a82bb1cc6e0 *gorkans8.rom
REM 7e51ddcf496f3b80fe186acc8bc6a0e574340346 *gorkgfx1.rom
REM e78ac5afa1ce996c41005c619ba2d2aa718497fc *gorkgfx2.rom
REM 1d8b65cad0b834fb920135fc907432042bc83db2 *gorkgfx3.rom
REM 8d6882dad94b26da8f0737e7f7f99946fe273f1b *gorkgfx4.rom
REM 19097b5f60d1030f8b82d9f1d3a241f93e5c75d6 *gorkprom.1
REM 0c4d0bee858b97632411c440bea6948a74759746 *gorkprom.2
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *gorkprom.3
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *gorkprom.4

set rom_path_src=..\roms\gorkans
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\gorkgfx4.rom + %rom_path_src%\gorkgfx2.rom + %rom_path_src%\gorkgfx3.rom + %rom_path_src%\gorkgfx1.rom %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\gorkans8.rom + %rom_path_src%\gorkans4.rom + %rom_path_src%\gorkans7.rom + %rom_path_src%\gorkans3.rom + %rom_path_src%\gorkans6.rom + %rom_path_src%\gorkans2.rom + %rom_path_src%\gorkans5.rom + %rom_path_src%\gorkans1.rom %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\gorkprom.3    PROM1_DST  9 c     > %rom_path%\prom1_dst.vhd
%romgen_path%\romgen %rom_path_src%\gorkprom.1    PROM4_DST  8 c     > %rom_path%\prom4_dst.vhd
%romgen_path%\romgen %rom_path_src%\gorkprom.4    PROM7_DST  4 c     > %rom_path%\prom7_dst.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin          GFX1      13 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin          ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

REM this is ROM area not used but required
%romgen_path%\romgen %rom_path%\gfx1.bin          ROM_PGM_1 13 l r e > %rom_path%\rom1.vhd

echo done
pause
