@echo off
set rom_path_src=roms\stern_scramble\
set rom_path=roms\

 rem stern
 copy /b %rom_path_src%2d + %rom_path_src%2e %rom_path%SCRAMBLE_PGM_01.bin
 copy /b %rom_path_src%2f + %rom_path_src%2h %rom_path%SCRAMBLE_PGM_23.bin
 copy /b %rom_path_src%2j + %rom_path_src%2l %rom_path%SCRAMBLE_PGM_45.bin
 copy /b %rom_path_src%2m + %rom_path_src%2p %rom_path%SCRAMBLE_PGM_67.bin

 romgen %rom_path%SCRAMBLE_PGM_01.bin SCRAMBLE_PGM_01 12 l r e > %rom_path%SCRAMBLE_PGM_01.vhd
 romgen %rom_path%SCRAMBLE_PGM_23.bin SCRAMBLE_PGM_23 12 l r e > %rom_path%SCRAMBLE_PGM_23.vhd
 romgen %rom_path%SCRAMBLE_PGM_45.bin SCRAMBLE_PGM_45 12 l r e > %rom_path%SCRAMBLE_PGM_45.vhd
 romgen %rom_path%SCRAMBLE_PGM_67.bin SCRAMBLE_PGM_67 12 l r e > %rom_path%SCRAMBLE_PGM_67.vhd

 romgen %rom_path_src%5h SCRAMBLE_OBJ_0 11 l r e > %rom_path%SCRAMBLE_OBJ_0.vhd
 romgen %rom_path_src%5f SCRAMBLE_OBJ_1 11 l r e > %rom_path%SCRAMBLE_OBJ_1.vhd

 romgen %rom_path_src%82s123.6e SCRAMBLE_LUT 5 c > %rom_path%SCRAMBLE_LUT.vhd

 rem konami
 rem copy /b %rom_path_src%2d + %rom_path_src%2e %rom_path%SCRAMBLE_PGM_01.bin
 rem copy /b %rom_path_src%2f + %rom_path_src%2h %rom_path%SCRAMBLE_PGM_23.bin
 rem copy /b %rom_path_src%2j + %rom_path_src%2l %rom_path%SCRAMBLE_PGM_45.bin
 rem copy /b %rom_path_src%2m + %rom_path_src%2p %rom_path%SCRAMBLE_PGM_67.bin

 rem romgen %rom_path%SCRAMBLE_PGM_01.bin SCRAMBLE_PGM_01 12 l r e > %rom_path%SCRAMBLE_PGM_01.vhd
 rem romgen %rom_path%SCRAMBLE_PGM_23.bin SCRAMBLE_PGM_23 12 l r e > %rom_path%SCRAMBLE_PGM_23.vhd
 rem romgen %rom_path%SCRAMBLE_PGM_45.bin SCRAMBLE_PGM_45 12 l r e > %rom_path%SCRAMBLE_PGM_45.vhd
 rem romgen %rom_path%SCRAMBLE_PGM_67.bin SCRAMBLE_PGM_67 12 l r e > %rom_path%SCRAMBLE_PGM_67.vhd

 rem romgen %rom_path_src%5h.k SCRAMBLE_OBJ_0 11 l r e > %rom_path%SCRAMBLE_OBJ_0.vhd
 rem romgen %rom_path_src%5f.k SCRAMBLE_OBJ_1 11 l r e > %rom_path%SCRAMBLE_OBJ_1.vhd

 rem romgen %rom_path_src%82s123.6e SCRAMBLE_LUT 5 c > %rom_path%SCRAMBLE_LUT.vhd

 rem common
 romgen %rom_path_src%5c SCRAMBLE_SND_0 11 l r e > %rom_path%SCRAMBLE_SND_0.vhd
 romgen %rom_path_src%5d SCRAMBLE_SND_1 11 l r e > %rom_path%SCRAMBLE_SND_1.vhd
 romgen %rom_path_src%5e SCRAMBLE_SND_2 11 l r e > %rom_path%SCRAMBLE_SND_2.vhd

echo done

