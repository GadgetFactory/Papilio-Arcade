@echo off

REM SHA1 sums of files required
REM 4755609bd974976f04855d51e08ec0d62ab4bc07 *1h.bin
REM a9795d8b7388f404f3b0e2c6ce15d713a4c5bafa *1k.bin
REM f382ad5a34d282056c78a5ec00c30ec43772bae2 *6l.bpr
REM 8b44b0f74420871454e27894d0f004859f9e59a9 *7l
REM e65f74e35b1bfaccd407e168ea55678ae9b68edf *galmidw.u
REM 02fdcd95d8511e64c0d2b007b874112d53e41045 *galmidw.v
REM 0046b9ed697a34d088de1aead8bd7cbe526a2396 *galmidw.w
REM 18d8714e5ef52f63ba8888ecc5a25b17b3bf17d1 *galmidw.y

set rom_path_src=..\roms\galaxian
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy /b/y %rom_path_src%\1h.bin + %rom_path_src%\1k.bin %rom_path%\gfx1.bin > NUL
copy /b/y %rom_path_src%\galmidw.u + %rom_path_src%\galmidw.v + %rom_path_src%\galmidw.w + %rom_path_src%\galmidw.y + %rom_path_src%\7l %rom_path%\main.bin > NUL

REM generate RTL code for small PROMS
%romgen_path%\romgen %rom_path_src%\6l.bpr    GALAXIAN_6L  5 c     > %rom_path%\galaxian_6l.vhd

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\gfx1.bin        GFX1      12 l r e > %rom_path%\gfx1.vhd
%romgen_path%\romgen %rom_path%\main.bin        ROM_PGM_0 14 l r e > %rom_path%\rom0.vhd

%romgen_path%\romgen %rom_path_src%\1h.bin    GALAXIAN_1H 11 l r e > %rom_path%\galaxian_1h.vhd
%romgen_path%\romgen %rom_path_src%\1k.bin    GALAXIAN_1K 11 l r e > %rom_path%\galaxian_1k.vhd

REM %romgen_path%\romgen %rom_path_src%\mc_wav_2.bin GALAXIAN_WAV 18 l r e > %rom_path%\galaxian_wav.vhd

echo done
pause
