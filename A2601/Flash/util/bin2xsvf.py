# Converts binary files to xsvf files for programming on-board Flash roms
# Copyright 2007, 2010 Retromaster
#
#  This file is part of A2601.
#
#  A2601 is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License,
#  or any later version.
#
#  A2601 is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with A2601.  If not, see <http://www.gnu.org/licenses/>.

import sys
import os.path
from array import *

XCOMPLETE = 0x00;
XTDOMASK  = 0x01;
XSIR      = 0x02;
XSDR      = 0x03;
XRUNTEST  = 0x04;
XREPEAT   = 0x07;
XSDRSIZE  = 0x08;
XSDRTDO   = 0x09;
XSTATE    = 0x12;

fin = open(sys.argv[2], 'rb')
fout = open(sys.argv[3], 'wb')

size = os.path.getsize(sys.argv[2]);

input = array('B');
input.fromfile(fin, size);

output = array('B');

program = (sys.argv[1] == "-p");
verify = (sys.argv[1] == "-v");
eraseProgramVerify = (sys.argv[1] == "-epv");


def erase():

	output.append(XRUNTEST);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER1 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x02);
	output.append(0xFF);

	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x04);
	output.append(XTDOMASK)
	output.append(0x00);
	output.append(XSDRTDO);
	# Load cmd_reset_adr
	output.append(0x03);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER2 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x03);
	output.append(0xFF);
	
	output.append(XRUNTEST);
	output.append(0x00);
	output.append(0x98);
	output.append(0x96);
	output.append(0x80);
	
	# Clock 
	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x10);
	output.append(XSDRTDO);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);	


def resetAddress():

	output.append(XRUNTEST);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER1 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x02);
	output.append(0xFF);

	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x04);
	output.append(XTDOMASK)
	output.append(0x00);
	output.append(XSDRTDO);
	# Load cmd_reset_adr
	output.append(0x04);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER2 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x03);
	output.append(0xFF);
	
	# Clock 
	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x04);
	output.append(XSDRTDO);
	output.append(0x00);
	output.append(0x00);	


def programOrVerify(program):

	output.append(XRUNTEST);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER1 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x02);
	output.append(0xFF);

	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x04);
	output.append(XTDOMASK)
	output.append(0x00);
	output.append(XSDRTDO);
	if (program):
		# Load cmd_write 
		output.append(0x01);
	else:
		# Load cmd_read 
		output.append(0x02);
	output.append(0x00);

	# Load cfg. flash with BYPASS instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x3F);
	output.append(0xFF);

	# Load FPGA with USER2 instruction
	output.append(XSIR);
	output.append(0x0E);
	output.append(0x03);
	output.append(0xFF);

	# Pre-clock 
	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	if (program):
		output.append(0x02);
	else:
		output.append(0x04);
	# TDOMASK
	output.append(XSDRTDO);
	output.append(0x00);
	output.append(0x00);

	if (program):
		# Setup flash programming wait time
		output.append(XRUNTEST);
		output.append(0x00);
		output.append(0x00);
		output.append(0x00);
		output.append(0x40);

	# Shift 10 bits per byte
	output.append(XSDRSIZE)
	output.append(0x00);
	output.append(0x00);
	output.append(0x00);
	output.append(0x0A);

	output.append(XTDOMASK)
	if (program):
		output.append(0x00);
		output.append(0x00);
	else:
		output.append(0x01);
		output.append(0xFE);

	if (program):
		# Shift in bits
		for d in input:
			output.append(XSDR);
			output.append(0x00);
			output.append(d);    
	else:
		# Shift out bits
		for d in input:
			output.append(XSDRTDO);
			output.append(0x00);
			output.append(0x00);    
			output.append(d >> 7);
			output.append((d << 1) & 0xFF);    

# Initialization
output.append(XREPEAT);
output.append(0x01);
output.append(XSTATE);
output.append(0x01);
output.append(XSTATE);
output.append(0x00);

if (program):
	programOrVerify(1);

if (verify):
	programOrVerify(0);

if (eraseProgramVerify):
	erase();
	programOrVerify(1);
	resetAddress();
	programOrVerify(0);

output.append(XCOMPLETE);    

output.tofile(fout);

fin.close()
fout.close()


