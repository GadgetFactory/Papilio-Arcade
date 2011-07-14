This is a simulation model of Pacman hardware.

The original source code was downloaded from:
http://www.fpgaarcade.com/pac_main.htm

An open source ROM of a Ping Pong demo, from www.widel.com, runs on the Pac-Man hardware. In order to run Pac-Man roms the end user must own a legal copy of the game and provide their own roms.

In order to synthesize in your own ROM place the ROM files in the roms directory. Run the "build_roms.bat" file, this will copy your roms into the Papilio_build directory. Make sure you have Xilinx ISE Webpack installed and double click on "Papilio_build\Pacman.xise". Synthesize the design to create your own bitfile with your own ROM file included.

In order to to run the Ping Pong demo on the Papilio One make sure you have the Papilio Loader installed and associated with *.bit files. Double click on the "ping_pong_game_on_pacman_hardware.bit" file.
