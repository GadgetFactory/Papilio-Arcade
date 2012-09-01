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
			audio: out std_logic;
         O_VSYNC: out std_logic;
         O_HSYNC: out std_logic;
			O_VIDEO_R: out std_logic_vector(3 downto 0);
			O_VIDEO_G: out std_logic_vector(3 downto 0);
			O_VIDEO_B: out std_logic_vector(3 downto 0);			
--         au: out std_logic_vector(4 downto 0);
         res: in std_logic;
         p_l: in std_logic;
         p_r: in std_logic;
         p_a: in std_logic;
         p_u: in std_logic;
         p_d: in std_logic;
         p_s: in std_logic;
         p_bs: out std_logic;			
			--LED: out std_logic_vector(2 downto 0);
			I_SW :in std_logic_vector(2 downto 0);
         JOYSTICK_GND: out std_logic			
			);
end A2601NoFlash;

architecture arch of A2601NoFlash is

	COMPONENT a2601_dcm
	PORT(
		CLKIN_IN : IN std_logic; 
		RST_IN : IN std_logic; 		
		CLKFX_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		CLK2X_OUT : OUT std_logic
		);
	END COMPONENT;

    component A2601 is
    port(vid_clk: in std_logic;
         rst: in std_logic;
         d: inout std_logic_vector(7 downto 0);
         a: out std_logic_vector(12 downto 0);
			r: out std_logic;
         pa: inout std_logic_vector(7 downto 0);
         pb: inout std_logic_vector(7 downto 0);
         inpt4: in std_logic;
         inpt5: in std_logic;
         colu: out std_logic_vector(6 downto 0);
         csyn: out std_logic;
         vsyn: out std_logic;
         hsyn: out std_logic;
			rgbx2: out std_logic_vector(23 downto 0);
         cv: out std_logic_vector(7 downto 0);
         au0: out std_logic;
         au1: out std_logic;
         av0: out std_logic_vector(3 downto 0);
         av1: out std_logic_vector(3 downto 0);
         ph0_out: out std_logic;
         ph1_out: out std_logic);
    end component;

	COMPONENT cart_rom
	PORT(
		clk : IN std_logic;
		addr : IN std_logic_vector(13 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT VGA_SCANDBL
	PORT(
		I_R : IN std_logic_vector(2 downto 0);
		I_G : IN std_logic_vector(2 downto 0);
		I_B : IN std_logic_vector(1 downto 0);
		I_HSYNC : IN std_logic;
		I_VSYNC : IN std_logic;
		CLK : IN std_logic;
		CLK_X2 : IN std_logic;          
		O_R : OUT std_logic_vector(2 downto 0);
		O_G : OUT std_logic_vector(2 downto 0);
		O_B : OUT std_logic_vector(1 downto 0);
		O_HSYNC : OUT std_logic;
		O_VSYNC : OUT std_logic
		);
	END COMPONENT;	
	
	 component dac is
	 port(DACout: 	out std_logic;
			DACin:	in std_logic_vector(4 downto 0);
			Clk:		in std_logic;
			Reset:	in std_logic);
	 end component;	
	 
   component ram128x8 is
        port(clk: in std_logic;
             r: in std_logic;
             d_in: in std_logic_vector(7 downto 0);
             d_out: out std_logic_vector(7 downto 0);
             a: in std_logic_vector(6 downto 0));
    end component;

    component CartTable is
        port(clk: in std_logic;
             d: out std_logic_vector(10 downto 0);
             c: out std_logic_vector(6 downto 0);
             a: in std_logic_vector(6 downto 0));
    end component;
    
	 signal vid_clk, vid_clkx2: std_logic;
    signal d: std_logic_vector(7 downto 0);
    --signal cpu_d: std_logic_vector(7 downto 0);
    signal a: std_logic_vector(13 downto 0);
    signal pa: std_logic_vector(7 downto 0);
    signal pb: std_logic_vector(7 downto 0);
    signal inpt4: std_logic;
    signal inpt5: std_logic;
    signal colu: std_logic_vector(6 downto 0);
    signal csyn: std_logic;
    signal au0: std_logic;
    signal au1: std_logic;
    signal av0: std_logic_vector(3 downto 0);
    signal av1: std_logic_vector(3 downto 0);

    signal auv0: unsigned(4 downto 0);
    signal auv1: unsigned(4 downto 0);

    signal rst: std_logic := '1';
    signal sys_clk_dvdr: unsigned(4 downto 0) := "00000";

    signal ph0: std_logic;
    signal ph1: std_logic;
	 
    signal rgbx2: std_logic_vector(23 downto 0);
    signal hsyn: std_logic;
    signal vsyn: std_logic;
	 
	 signal ctrl_cntr: unsigned(3 downto 0);
	 signal gsel: std_logic;
    signal p_fn: std_logic;

		signal rst_cntr: unsigned(12 downto 0) := "0000000000000";
		   signal sc_clk: std_logic;
    signal sc_r: std_logic;
    signal sc_d_in: std_logic_vector(7 downto 0);
    signal sc_d_out: std_logic_vector(7 downto 0);
    signal sc_a: std_logic_vector(6 downto 0);

    subtype bss_type is std_logic_vector(2 downto 0);


    signal bank: std_logic_vector(3 downto 0) := "0000";
    signal tf_bank: std_logic_vector(1 downto 0);
    signal e0_bank: std_logic_vector(2 downto 0);
    signal e0_bank0: std_logic_vector(2 downto 0) := "000";
    signal e0_bank1: std_logic_vector(2 downto 0) := "000";
    signal e0_bank2: std_logic_vector(2 downto 0) := "000";

    signal cpu_a: std_logic_vector(12 downto 0);
    signal cpu_d: std_logic_vector(7 downto 0);
    signal cpu_r: std_logic;

    signal cart_info: std_logic_vector(10 downto 0) := "00000000000";
    signal cart_cntr: unsigned(6 downto 0) := "0000000";
    signal cart_max: std_logic_vector(6 downto 0);
    signal cart_vect: std_logic_vector(6 downto 0) := "0000000";

    signal cart_next: std_logic;
    signal cart_prev: std_logic;
    signal cart_swch: std_logic := '0';
    signal cart_next_l: std_logic;
    signal cart_prev_l: std_logic;
	 signal sel: std_logic;
--	 signal ctrl_cntr: unsigned(3 downto 0);
	--tmp
	signal cv:  std_logic_vector(7 downto 0);
	signal au:  std_logic_vector(4 downto 0);

    constant BANK00: bss_type := "000";
    constant BANKF8: bss_type := "001";
    constant BANKF6: bss_type := "010";
    constant BANKFE: bss_type := "011";
    constant BANKE0: bss_type := "100";
    constant BANK3F: bss_type := "101";

    signal bss: bss_type := BANK00; 	--bank switching method
    signal sc: std_logic := '0';		--superchip enabled or not
	 
begin
	  
--	Inst_a2601_dcm: a2601_dcm PORT MAP(
--		CLKIN_IN => clk,
--		RST_IN => '0',		
--		CLKFX_OUT => vid_clk,
--		CLKIN_IBUFG_OUT => open,
--		CLK0_OUT => open,
--		CLK2X_OUT => vid_clkx2
--	);		

  u_clocks : entity work.PACMAN_CLOCKS
    port map (
      I_CLK_REF  => clk,
      I_RESET_L  => '1',
      --
      O_CLK_REF  => open,
      --
      O_ENA_12   => open,
      O_ENA_6    => open,
      O_CLK      => vid_clk,
      O_RESET    => open
      );	  

    ms_A2601: A2601
        port map(vid_clk, rst, cpu_d, cpu_a, cpu_r,pa, pb, inpt4, inpt5, colu, csyn, vsyn, hsyn, rgbx2, cv, au0, au1, av0, av1, ph0, ph1);
  
	Inst_cart_rom: cart_rom PORT MAP(
		clk => vid_clk,
		data => d,
		addr => a
	);		 
	--brd_CartTable: CartTable
   --     port map(ph0, cart_info, cart_max, std_logic_vector(cart_cntr));
	
	dac_inst: dac 
		port map(audio, au, vid_clk, '0');	

	
      O_VIDEO_R(3 downto 1) <= rgbx2(23 downto 21);
      O_VIDEO_G(3 downto 1) <= rgbx2(15 downto 13);
      O_VIDEO_B(3 downto 2) <= rgbx2(7 downto 6);	
      O_HSYNC   <= hsyn;
      O_VSYNC   <= vsyn;	

--    cpu_d <= d when a(12) = '1' else "ZZZZZZZZ";
 process(ph0)
    begin
        if (ph0'event and ph0 = '1') then
			if res = '1' then
			rst <= '1';
			else
			rst <= '0';
			end if;
		end if;
            
    end process;

    -- Controller inputs sampling
    p_bs <= ctrl_cntr(3);

    -- Only one controller port supported.
    pa(3 downto 0) <= "1111";

    process(ph0)
    begin
        if (ph0'event and ph0 = '1') then
            ctrl_cntr <= ctrl_cntr + 1;
            if (ctrl_cntr = "1111") then    -- p_bs
                p_fn <=  p_a;
                pb(0) <= not p_s;
            elsif (ctrl_cntr = "0111") then
                pa(7 downto 4) <= p_r & p_l & p_d & p_u;
                inpt4 <= p_a;
                gsel <= not p_s;
            end if;

            pb(7) <= pa(7) or p_fn;
            pb(6) <= pa(6) or p_fn;
            pb(1) <= pa(4) or p_fn;
            pb(3) <= pa(5) or p_fn;
        end if;
    end process;

    pb(5) <= '1';
    pb(4) <= '1';
    pb(2) <= '1';
    inpt5 <= '1';
	 JOYSTICK_GND <= '0';

    auv0 <= ("0" & unsigned(av0)) when (au0 = '1') else "00000";
    auv1 <= ("0" & unsigned(av1)) when (au1 = '1') else "00000";

    au <= std_logic_vector(auv0 + auv1);

    --process(vid_clk, sys_clk_dvdr)
    --begin
     --   if (vid_clk'event and vid_clk = '1') then
     --       sys_clk_dvdr <= sys_clk_dvdr + 1;
     --       if (sys_clk_dvdr = "11101") then
     --           rst <= '0';
     --       end if;
     --   end if;
    --end process;

    sc_ram128x8: ram128x8
        port map(sc_clk, sc_r, sc_d_in, sc_d_out, sc_a);

    -- This clock is phase shifted so that we can use Xilinx synchronous block RAM.
    sc_clk <= not ph1;
    sc_r <= '0' when cpu_a(12 downto 7) = "100000" else '1';
    sc_d_in <= cpu_d;
    sc_a <= cpu_a(6 downto 0);

    -- ROM and SC output
    process(cpu_a, d, sc_d_out, sc)
    begin
        if (cpu_a(12 downto 7) = "100001" and sc = '1') then
            cpu_d <= sc_d_out;
        elsif (cpu_a(12 downto 7) = "100000" and sc = '1') then
            cpu_d <= "ZZZZZZZZ";
        elsif (cpu_a(12) = '1') then
            cpu_d <= d;
        else
            cpu_d <= "ZZZZZZZZ";
        end if;
    end process;

    with cpu_a(11 downto 10) select e0_bank <=
        e0_bank0 when "00",
        e0_bank1 when "01",
        e0_bank2 when "10",
        "111" when "11",
        "---" when others;

    tf_bank <= bank(1 downto 0) when (cpu_a(11) = '0') else "11";

    with bss select a <=
        --cart_vect & 
		  "00" & cpu_a(11 downto 0) when BANK00,
        --cart_vect(6 downto 1) & 
		  '0' & bank(0) & cpu_a(11 downto 0) when BANKF8,
        --cart_vect(6 downto 2) & 
		  bank(1 downto 0) & cpu_a(11 downto 0) when BANKF6,
        --cart_vect(6 downto 1) & 
		  '0' & bank(0) & cpu_a(11 downto 0) when BANKFE,
        --cart_vect(6 downto 1) & 
		  "0" & e0_bank & cpu_a(9 downto 0) when BANKE0,
        --cart_vect(6 downto 1) & 
		  '0' & tf_bank & cpu_a(10 downto 0) when BANK3F,
        --"-------------------" when others;
		  "--------------" when others;

    bankswch: process(ph0)
    begin
        if (ph0'event and ph0 = '1') then
            if (rst = '1') then
                bank <= "0000";
                e0_bank0 <= "000";
                e0_bank1 <= "000";
                e0_bank2 <= "000";
            else
                case bss is
                    when BANKF8 =>
                        if (cpu_a = "1" & X"FF8") then
                            bank <= "0000";
                        elsif (cpu_a = "1" & X"FF9") then
                            bank <= "0001";
                        end if;
                    when BANKF6 =>
                        if (cpu_a = "1" & X"FF6") then
                            bank <= "0000";
                        elsif (cpu_a = "1" & X"FF7") then
                            bank <= "0001";
                        elsif (cpu_a = "1" & X"FF8") then
                            bank <= "0010";
                        elsif (cpu_a = "1" & X"FF9") then
                            bank <= "0011";
                        end if;
                    when BANKFE =>
                        if (cpu_a = "0" & X"1FE") then
                            bank <= "0000";
                        elsif (cpu_a = "1" & X"1FE") then
                            bank <= "0001";
                        end if;
                    when BANKE0 =>
                        if (cpu_a(12 downto 4) = "1" & X"FE" and cpu_a(3) = '0') then
                            e0_bank0 <= cpu_a(2 downto 0);
                        elsif (cpu_a(12 downto 4) = "1" & X"FE" and cpu_a(3) = '1') then
                            e0_bank1 <= cpu_a(2 downto 0);
                        elsif (cpu_a(12 downto 4) = "1" & X"FF" and cpu_a(3) = '0') then
                            e0_bank2 <= cpu_a(2 downto 0);
                        end if;
                    when BANK3F =>
                        --if (cpu_a(12 downto 6) = "0000000") then
                        if (cpu_a = "0" & X"03F") then
                            bank(1 downto 0) <= cpu_d(1 downto 0);
                        end if;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

    --bss <= cart_info(3 downto 1);
    --sc <= cart_info(0);
    --cart_vect <= cart_info(10 downto 4);
	--LED <= bss;
    --cart_next <= (not pa(7)) and (not gsel);
    --cart_prev <= (not pa(6)) and (not gsel);
end arch;



