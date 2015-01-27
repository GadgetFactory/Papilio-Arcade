@echo off
REM Plays OK but no sound

REM SHA1 sums of files required
REM 3b432b42e79f8b0a7d65e197f373a04e3c92ff20 *2716.a5
REM c6014d9575e92adf09b0961c2158a779ebe940c4 *2716.a6
REM eca735c6a35561a9a6ba8a20dca1e1c78ed073fc *am2d
REM 5b2e49ff915295617671b13f15b566046a5dbc15 *am2e
REM 1d72e9ae3005029628c6f9beb6ca65afcb1f7893 *am2f
REM 7d0ee9a82f02163b4cc6a7097e88ae34e96ebf58 *am2h
REM c32fdc8e292d91159e6c80c7033abea6404a4f2c *am2j
REM 425ec2c2caf404fc8ab13ee38d6567413022e1a1 *am2l
REM e0d24475547bbe5a94b45be6abefb84ad84d2534 *am2m
REM 46d757180426b71c827d14a35824a248f2c787b6 *am2p
REM 1015e56f37c244a850a8f4bf0e36668f047fd46d *amidar.clr
REM 4f4c2915503b85abe141d717fd254ee10c9da99e *amidarus.5c
REM 84d953618c8bf510d23b42232a856ac55f1baff5 *amidarus.5d

set rom_path_src=..\roms\amidar
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b %rom_path_src%\am2d + %rom_path_src%\am2e + %rom_path_src%\am2f + %rom_path_src%\am2h + %rom_path_src%\am2j + %rom_path_src%\am2l + %rom_path_src%\am2m + %rom_path_src%\am2p %rom_path%\rom.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\amidar.clr    ROM_LUT        5 l r e > %rom_path%\ROM_LUT.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\rom.bin           ROM_PGM   14 l r e > %rom_path%\ROM_PGM.vhd

%romgen_path%\romgen %rom_path_src%\2716.a5       ROM_OBJ_0 11 l r e > %rom_path%\ROM_OBJ_0.vhd
%romgen_path%\romgen %rom_path_src%\2716.a6       ROM_OBJ_1 11 l r e > %rom_path%\ROM_OBJ_1.vhd

%romgen_path%\romgen %rom_path_src%\amidarus.5c   ROM_SND_0 11 l r e > %rom_path%\ROM_SND_0.vhd
%romgen_path%\romgen %rom_path_src%\amidarus.5d   ROM_SND_1 11 l r e > %rom_path%\ROM_SND_1.vhd
%romgen_path%\romgen %rom_path_src%\amidarus.5d   ROM_SND_2 11 l r e > %rom_path%\ROM_SND_2.vhd

echo done
echo REMEMBER to set I_HWSEL_FROGGER := false in the VHDL code!
pause
