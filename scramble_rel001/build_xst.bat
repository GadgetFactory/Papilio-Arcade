rem SYNTHESIS SCRIPT USING XST (WEBPACK)
@echo off
set name=scramble
set rom_path=roms\
echo use build_xst /xil to skip synthesis stage.

if not exist build mkdir build
if not exist build echo Could not create directory & goto :eof
pushd build

xcopy /y ..\source\*.vhd
xcopy /y ..\source\*.edf
xcopy /y ..\%rom_path%*.vhd
copy ..\%name%_xst.ucf %name%.ucf
copy ..\%name%.ut
copy ..\%name%.scr
copy ..\%name%.prj

if "%1"=="/xil" goto xilinx

xst -ifn %name%.scr -ofn %name%.srp

:xilinx
ngdbuild -nt on -uc %name%.ucf %name%.ngc %name%.ngd
map -pr b %name%.ngd -o %name%.ncd %name%.pcf
par -w -ol high %name%.ncd %name%.ncd %name%.pcf
trce -v 10 -o %name%.twr %name%.ncd %name%.pcf
bitgen %name%.ncd %name%.bit -w -f %name%.ut

popd
echo Done
