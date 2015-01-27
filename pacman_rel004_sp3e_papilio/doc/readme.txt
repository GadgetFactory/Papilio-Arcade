--
-- A simulation model of Pacman hardware
-- Copyright (c) MikeJ - January 2006
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- You are responsible for any legal issues arising from your use of this code.
--
-- The latest version of this file can be found at: www.fpgaarcade.com
--
-- Email pacman@fpgaarcade.com
--

 Revision list

 version 004 Release for Spartan3e starter kit.
********************************************************************************
     Note :

     Switch3 is coin1   (Switch up and then down)
     Switch2 is Start2   "
     Switch1 is Start1   "
     Switch0 is used to switch between NTSC and VGA (31K). Up (on) is VGA
     and LED0 will come on.

     The push button on the rotary control is used for reset.

     Push buttons left,right up and down are wired to Player1 and Player2 
     controls.

********************************************************************************

 version 003 General tidyup and refit for xilinx devices with ramb16s.
	       All roms are now internal.
	       Only XST supported now for ease of support.

 version 002 Release with romgen (VHDL rom generator), vga scan doubler and
	       integrated audio volume multiplier

 version 001 Initial release


 The design is a bit Xilinx specific at the moment, this will be fixed shortly.

 The following scripts will create a directory called 'build', copy the source
 files, run the sythesizer and Xilinx place and route tools.

 Assuming the Xilinx tools are installed and working, expand the distribution
 zip file (maintaining directory structure).

 Fire up a command prompt and navigate to the directory.

 run :

 Build_roms.bat - this will convert the files in the Roms directory to VHDL
		  files (also in the Roms directory). These may then be used
		  if you wish to simulate the design. Note, the rom binaries
		  provided are for a demo Pong game by David Widel as it is
		  not possible to distribute the original files. If you wish
		  to run up the game you can replace the 9 roms images with
		  binaries from the arcade game.

		  (Rom 3M is not required - its function has been simulated
		   by the code in audio.vhd)


 then :

 Build_xst.bat - Xilinx build script using Xilinx WebPak
		 (uses pacman_xst.ucf constraints file)

 if you add a /xil switch, the script will not run the synthesizer, just the
 place and route tools. You will be left with a .bit file in the Build directory
 you can use to program a chip. Remember to modify the .ucf file for your
 pinout.


 Additional Notes :

   Button shorts input to ground when pressed
   external pull ups of 1k are recommended.

Audio out :

   This DAC requires an external RC low-pass filter:

   audio_o 0---XXXXX---+---0 analog audio
		3k3    |
		      === 4n7
		       |
		      GND


 Video Out :

   Video out DAC's. Values here give 0.7 Volt peek video output.

   Use the following resistors for Video DACs :

   video_out(3) 510
   video_out(2) 1k
   video_out(1) 2k2
   video_out(0) 3k9

  See the WWW.FPGAARCADE.COM website for details on how to modify the Spartan3e starter kit board.

 Cheers,

 MikeJ
