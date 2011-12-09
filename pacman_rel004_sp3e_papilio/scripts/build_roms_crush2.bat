@echo off

REM SHA1 sums of files required
REM 5c144a613fc4960a1dfd7ead89e7fee258a63171 *2s140.4a
REM 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *82S123.7F
REM bbcec0570aeceb582ff8238a4bc8546a23430081 *82S126.1M
REM 0c4d0bee858b97632411c440bea6948a74759746 *82S126.3M
REM 68ebb7d9f70af868d99ec42c26bc55a54ba1f22c *tp1
REM 66de8203c364fd90e8a2b5749c2e40665b2f5830 *tp2
REM f828a177f22db9093a00c31e39e16214ce0dc6de *tp3
REM ff58d2dfb016397daabe2996bc3a7b63d28a4cca *tp4
REM 8ca5cd82d099b55e20f785489158231a1d99a430 *tp5a
REM 84b5e64bdbc25afab9b6f53e1719640e21a6feba *tp6
REM 7c3d7eb07b9256130141f71eba722f7823fd4c32 *tp7
REM b3b9066d9a43796185c00ae12f7bb2bbf42e3a07 *tp8
REM 95b204af0345163f93811cc770ee0ca2851a39c1 *tpa
REM dce755511b6262b984a2bca329f454892e486a09 *tpb
REM c9256795c6d0929ade1f24b372dadc2a2b88d897 *tpc
REM 65dd7861e05651485626465dc97215fed58db551 *tpd

set rom_path_src=..\roms\crush2
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\tpa + %rom_path_src%\tpc + %rom_path_src%\tpb + %rom_path_src%\tpd %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\tp1 + %rom_path_src%\tp5a + %rom_path_src%\tp2 + %rom_path_src%\tp6 + %rom_path_src%\tp3 + %rom_path_src%\tp7 + %rom_path_src%\tp4 + %rom_path_src%\tp8 %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\82s126.1m     PROM1_DST 9 c     > %rom_path%\prom1_dst.vhd
%romgen_path%\romgen %rom_path_src%\2s140.4a      PROM4_DST 8 c     > %rom_path%\prom4_dst.vhd
%romgen_path%\romgen %rom_path_src%\82s123.7f     PROM7_DST 4 c     > %rom_path%\prom7_dst.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin          GFX1      13 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin          ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

REM this is ROM area not used but required
%romgen_path%\romgen %rom_path%\gfx1.bin          ROM_PGM_1 13 l r e > %rom_path%\rom1.vhd

echo done
pause
