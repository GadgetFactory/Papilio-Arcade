@echo off

REM SHA1 sums of files required
REM 5422df979e82bcc73df49f50515fe76c126c037b *2d
REM a8ee9ddfadf5e9accedfaf81da757a88a2e55a0a *2e
REM 3eae2b3e4596505a8afb5c5cfb108e823c2c4319 *2f
REM 170f9e92f0a3bee04407be27210b4fa825367688 *2h
REM e426ef6a7444a39a34d59799973b07d11b89f372 *2j
REM 174df3f281068c767344f751daace646360e26d6 *2l
REM a2f3380982d93a022f46756f974fd16c4cd617de *2m
REM f3a9c4d1d91836476fcad87ea0d243dde7171e0a *2p
REM d64134089bebd995b3a1a089411e180c8c29f32d *5f
REM 81b44eb1ce43cebde87f0a41ade2e7eb291af78d *5h
REM a25083c3e36d28afdefe4af6e6d4f3155e303625 *c01s.6e
REM 8ed78487d76fd0a917ab7b258937a46e2cd9800c *ot1.5c
REM 8558b4eff5d7e63029b325edef9914feda5834c3 *ot2.5d
REM 1f976d8595706730e29f93027e7ab4620075c078 *ot3.5e

set rom_path_src=..\roms\stern_scramble
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\2d + %rom_path_src%\2e + %rom_path_src%\2f + %rom_path_src%\2h + %rom_path_src%\2j + %rom_path_src%\2l + %rom_path_src%\2m + %rom_path_src%\2p %rom_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\c01s.6e       ROM_LUT        5 l r e > %rom_path%\ROM_LUT.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\rom.bin           ROM_PGM   14 l r e > %rom_path%\ROM_PGM.vhd

%romgen_path%\romgen %rom_path_src%\5h            ROM_OBJ_0 11 l r e > %rom_path%\ROM_OBJ_0.vhd
%romgen_path%\romgen %rom_path_src%\5f            ROM_OBJ_1 11 l r e > %rom_path%\ROM_OBJ_1.vhd

%romgen_path%\romgen %rom_path_src%\ot1.5c        ROM_SND_0 11 l r e > %rom_path%\ROM_SND_0.vhd
%romgen_path%\romgen %rom_path_src%\ot2.5d        ROM_SND_1 11 l r e > %rom_path%\ROM_SND_1.vhd
%romgen_path%\romgen %rom_path_src%\ot3.5e        ROM_SND_2 11 l r e > %rom_path%\ROM_SND_2.vhd

echo done
echo REMEMBER to set I_HWSEL_FROGGER := false in the VHDL code!
pause
