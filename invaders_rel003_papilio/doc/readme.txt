**** Rel003 release
Fit to Spartan-3E and addition of audio and scan converter by MikeJ.
Audio based on work by Paul Walsh.

you will need the roms :

INVADERS.E
INVADERS.F
INVADERS.G
INVADERS.H

in the \roms directory.

Run :

build_invaders_roms.bat

Run :

build_invaders_xst.bat


you will end up with a bitfile (invaders_top.bit) in the \build directory that 
can be downloaded to the Spartan3E starter kit board. Connect a standard VGA
monitor and PS2 keyboard.

The push button on the knob is reset.

Keys (on the PS2 keyboard) :

C - Coin
1 - Player 1
2 - Player 2
Left and Right cursor keys - Move
Space - Fire.

 The audio DAC requires an external RC low-pass filter:


   dac_o 0---XXXXX---+---0 analog audio
              3k3    |
                    === 4n7
                     |
                    GND

  connected to J4 (Pins F8 and/or E8) - I wired two up for stereo.


  J4
  O nc
  O nc
  O to Left Audio Filter
  O to Right Audio Filter
  O GND
  O VCC

Have fun,
/MikeJ

****

VHDL model of Midway 8080 system and game boards

Curently implemented game boards:

Space Invaders
Dog Patch
Sea Wolf

The VHDL source code has been tested on a BurchED board
with 32k SRAM and the zxgate I/O board described at:
http://zxgate.sourceforge.net

The top levels include a PS/2 keyboard interface

Synthesis and simulation procedure:

*** 1. Get tools and files ***

There are no ROMs in this distribution.
For the script to work the ROMs must be named
rom/invaders.bin, rom/dogpatch.bin and rom/seawolf.bin
If the ROM is in separate files merge them:
copy /b INVADERS.H + INVADERS.G + INVADERS.F + INVADERS.E rom/invaders.bin

You will need Xilinx Webpack to synthesize the files.
If you want to use the compile scripts you also need
to set the xilinx environment variables. There is a
check box that can be checked during installation that
does this. This can also be done after installation,
check WebPACK_setup.bat in the Webpack directory to
see how it should be done.

You also need the hex2rom and xrom utilities to
generate VHDL ROMs from the binary ROM file.
If you are using windows these can be downloaded from:
http://www.e.kth.se/~e93_daw/vhdl/download/hex2rom_0244_Win32.zip
If you are using Linux or Cygwin they can be compiled from the
source code in http://www.opencores.org/cvsweb.shtml/t80/sw/

*** 2. Run the scripts ***

Using XST:

You must first synthesize the 8080 core. Run:
syn/xilinx/run/spinv.bat

Then you can run the game scripts:

syn/xilinx/run/invaders.bat
syn/xilinx/run/dogpatch.bat
syn/xilinx/run/seawolf.bat

Using Leonardo Spectrum:

Run the scripts:

syn/xilinx/run/invaders_leo.bat
syn/xilinx/run/dogpatch_leo.bat
syn/xilinx/run/seawolf_leo.bat

The default target for the above scripts is xc2s200-pq208-5.
Since this device only has 7k Block RAM the ROMs are split
between Select and Block RAM.
If your target device has 8k or more Block RAM you can change
the parameters for hex2rom and xrom to only use Block RAM.

If you want to change the target FPGA you must modify the
batch and also *.scr and *.tcl in /syn/xilinx/bin/

If you want to change the pin placement you need to modify
invaders.pin and invaders_leo.pin /syn/xilinx/bin/

Modelsim synthesis:

vhdl/gen_roms.bat
generates a VHDL ROMs for simulation.
This is needed by
sim/rtl_sim/msim/compile.do
which is the modelsim compile script.

*** 3. Configure the FPGA ***

Run Xilinx Impact from the command line or from the start menu.
1. Select Configure Devices
2. Select Slave Serial Mode
3. Select the .bit file in /syn/xilinx/out that you just compiled
4. Run Operations->Program...

Enjoy!
