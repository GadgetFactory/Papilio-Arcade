@echo off
set rom_path_src=roms\sega_frogger\
set rom_path=roms\

 romgen %rom_path_src%frogger.ic5 SCRAMBLE_PGM_01 12 l r e > %rom_path%SCRAMBLE_PGM_01.vhd
 romgen %rom_path_src%frogger.ic6 SCRAMBLE_PGM_23 12 l r e > %rom_path%SCRAMBLE_PGM_23.vhd
 romgen %rom_path_src%frogger.ic7 SCRAMBLE_PGM_45 12 l r e > %rom_path%SCRAMBLE_PGM_45.vhd
 romgen %rom_path_src%frogger.ic8 SCRAMBLE_PGM_67 12 l r e > %rom_path%SCRAMBLE_PGM_67.vhd

 romgen %rom_path_src%frogger.606 SCRAMBLE_OBJ_0 11 l r e > %rom_path%SCRAMBLE_OBJ_0.vhd
 romgen %rom_path_src%frogger.607 SCRAMBLE_OBJ_1 11 l r e > %rom_path%SCRAMBLE_OBJ_1.vhd

 romgen %rom_path_src%pr-91.6l SCRAMBLE_LUT 5 c > %rom_path%SCRAMBLE_LUT.vhd

 romgen %rom_path_src%frogger.608 SCRAMBLE_SND_0 11 l r e > %rom_path%SCRAMBLE_SND_0.vhd
 romgen %rom_path_src%frogger.609 SCRAMBLE_SND_1 11 l r e > %rom_path%SCRAMBLE_SND_1.vhd
 romgen %rom_path_src%frogger.610 SCRAMBLE_SND_2 11 l r e > %rom_path%SCRAMBLE_SND_2.vhd

echo done
pause

