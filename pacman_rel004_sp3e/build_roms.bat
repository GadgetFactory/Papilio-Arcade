@echo off
set rom_path=roms\

romgen %rom_path%pacrom_5e.bin PACROM_5E 12 l r e > %rom_path%pacrom_5e.vhd
romgen %rom_path%pacrom_5f.bin PACROM_5F 12 l r e > %rom_path%pacrom_5f.vhd
romgen %rom_path%pacrom_6e.bin PACROM_6E 12 l r e > %rom_path%pacrom_6e.vhd
romgen %rom_path%pacrom_6f.bin PACROM_6F 12 l r e > %rom_path%pacrom_6f.vhd
romgen %rom_path%pacrom_6h.bin PACROM_6H 12 l r e > %rom_path%pacrom_6h.vhd
romgen %rom_path%pacrom_6j.bin PACROM_6J 12 l r e > %rom_path%pacrom_6j.vhd

romgen %rom_path%pacrom_1m.bin PACROM_1M 9 l r e > %rom_path%pacrom_1m.vhd
romgen %rom_path%pacrom_4a.bin PACROM_4A_DST 8 c > %rom_path%pacrom_4a_dst.vhd
romgen %rom_path%pacrom_7f.bin PACROM_7F_DST 4 c > %rom_path%pacrom_7f_dst.vhd

cd Papilio_build
xcopy /y ..\%rom_path%*.vhd

echo done
