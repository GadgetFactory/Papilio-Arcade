-- A2601 Top Level Entity (ROM stored in on-chip RAM)
-- Copyright 2006, 2010 Retromaster
--
--  This file is part of A2601.
--
--  A2601 is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License,
--  or any later version.
--
--  A2601 is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with A2601.  If not, see <http://www.gnu.org/licenses/>.
--

-- This top level entity supports a single cartridge ROM stored in FPGA built-in
-- memory (such as Xilinx Spartan BlockRAM). To generate the required cart_rom
-- entity, use bin2vhdl.py found in the util directory.
--
-- For more information, see the A2601 Rev B Board Schematics and project
-- website at <http://retromaster.wordpress.org/a2601>.

library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity A2601NoFlash is
   port (clk: in std_logic;
         cv: out std_logic_vector(7 downto 0);
         O_VSYNC: out std_logic;
         O_HSYNC: out std_logic;
--         au: out std_logic_vector(4 downto 0);
			audio: out std_logic;
			O_VIDEO_R: out std_logic_vector(3 downto 0);
			O_VIDEO_G: out std_logic_vector(3 downto 0);
			O_VIDEO_B: out std_logic_vector(3 downto 0);
			
         res: in std_logic);
end A2601NoFlash;

architecture arch of A2601NoFlash is

    component a2601_dcm is
        port(clkin_in: in std_logic;
             rst_in: in std_logic;
             clkfx_out: out std_logic;
				 clk_osc_ref     : out   std_logic; 
             clkin_ibufg_out: out std_logic);
    end component;
		 
	 component dac is
	 port(DACout: 	out std_logic;
			DACin:	in std_logic_vector(4 downto 0);
			Clk:		in std_logic;
			Reset:	in std_logic);
	 end component;
	 
	COMPONENT double_clock
	PORT(
		CLKIN_IN : IN std_logic;          
		CLK0_OUT : OUT std_logic;
		CLK2X_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;	 

    component A2601 is
    port(vid_clk: in std_logic;
         rst: in std_logic;
         d: inout std_logic_vector(7 downto 0);
         a: out std_logic_vector(12 downto 0);
         pa: inout std_logic_vector(7 downto 0);
         pb: inout std_logic_vector(7 downto 0);
         inpt4: in std_logic;
         inpt5: in std_logic;
         colu: out std_logic_vector(6 downto 0);
         csyn: out std_logic;
         vsyn: out std_logic;
         hsyn: out std_logic;
         cv: out std_logic_vector(7 downto 0);
         au0: out std_logic;
         au1: out std_logic;
         av0: out std_logic_vector(3 downto 0);
         av1: out std_logic_vector(3 downto 0);
         ph0_out: out std_logic;
         ph1_out: out std_logic);
    end component;

    component cart_rom is
    port(clk: in std_logic;
         d: out std_logic_vector(7 downto 0);
         a: in std_logic_vector(12 downto 0));
    end component;

    signal vid_clk: std_logic;
    signal vid_clkX2: std_logic;
    signal d: std_logic_vector(7 downto 0);
    signal cpu_d: std_logic_vector(7 downto 0);
    signal a: std_logic_vector(12 downto 0);
    signal pa: std_logic_vector(7 downto 0);
    signal pb: std_logic_vector(7 downto 0);
    signal inpt4: std_logic;
    signal inpt5: std_logic;
    signal colu: std_logic_vector(6 downto 0);
    signal csyn: std_logic;
    signal hsyn: std_logic;
    signal vsyn: std_logic;
    signal hsync_x2: std_logic;
    signal vsync_x2: std_logic;
    signal au0: std_logic;
    signal au1: std_logic;
    signal av0: std_logic_vector(3 downto 0);
    signal av1: std_logic_vector(3 downto 0);
    signal video_r_x2: std_logic_vector(2 downto 0);
    signal video_g_x2: std_logic_vector(2 downto 0);
    signal video_b_x2: std_logic_vector(1 downto 0);
	 signal au: std_logic_vector(4 downto 0);

    signal auv0: unsigned(4 downto 0);
    signal auv1: unsigned(4 downto 0);

    signal rst: std_logic := '1';
    signal sys_clk_dvdr: unsigned(4 downto 0) := "00000";

    signal ph0: std_logic;
    signal ph1: std_logic;

    signal ena_6: std_logic;
    signal ena_12: std_logic;
    signal clk_osc_ref: std_logic;

begin

--	Inst_double_clock: double_clock PORT MAP(
--		CLKIN_IN => vid_clk,
--		CLK0_OUT => open,
--		CLK2X_OUT => vid_clkX2,
--		LOCKED_OUT => open
--	);


	
  u_dblscan : entity work.VGA_SCANDBL
    port map (
      I_R          => colu(6 downto 4),
      I_G          => colu(3 downto 1),
      I_B          => colu(1 downto 0),
      I_HSYNC      => hsyn,
      I_VSYNC      => vsyn,

      O_R          => video_r_x2,
      O_G          => video_g_x2,
      O_B          => video_b_x2,
      O_HSYNC      => hsync_x2,
      O_VSYNC      => vsync_x2,
      --
      CLK          => ena_6,
      CLK_X2       => ena_12
    );	
	 
      O_VIDEO_R(3 downto 1) <= video_r_x2;
      O_VIDEO_G(3 downto 1) <= video_g_x2;
      O_VIDEO_B(3 downto 2) <= video_b_x2;
      O_HSYNC   <= hSync_X2;
      O_VSYNC   <= vSync_X2;	 
		
  u_clocks : entity work.PACMAN_CLOCKS
    port map (
      I_CLK_REF  => clk,
      I_RESET_L  => rst,
      --
      O_CLK_REF  => clk_osc_ref,
      --
      O_ENA_12   => ena_12,
      O_ENA_6    => ena_6,
      O_CLK      => vid_clk,
      O_RESET    => open
      );		

	dac_inst: dac 
		port map(audio, au, vid_clk, '0');

--    ms_A2601_dcm: a2601_dcm
--        port map(clk_osc_ref, '0', vid_clk, open, open);

    ms_A2601: A2601
        port map(vid_clk, rst, cpu_d, a, pa, pb, inpt4, inpt5, colu, csyn, vsyn, hsyn, cv, au0, au1, av0, av1, ph0, ph1);

    ms_cart_rom: cart_rom
        port map(ph1, d, a(12 downto 0));

    cpu_d <= d when a(12) = '1' else "ZZZZZZZZ";

    pa <= "11111111";
    pb(7 downto 1) <= "1111111";
    pb(0) <= '1';

    inpt4 <= '1';
    inpt5 <= '1';

    auv0 <= ("0" & unsigned(av0)) when (au0 = '1') else "00000";
    auv1 <= ("0" & unsigned(av1)) when (au1 = '1') else "00000";

    au <= std_logic_vector(auv0 + auv1);

    process(vid_clk, sys_clk_dvdr)
    begin
        if (vid_clk'event and vid_clk = '1') then
            sys_clk_dvdr <= sys_clk_dvdr + 1;
            if (sys_clk_dvdr = "11101") then
                rst <= '0';
            end if;
        end if;
    end process;

end arch;



