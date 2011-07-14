--
-- A simulation model of Scramble hardware
-- Copyright (c) MikeJ - Feb 2007
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
-- Email support@fpgaarcade.com
--
-- Revision list
--
-- version 001 initial release
--

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
use UNISIM.Vcomponents.all;

entity SCRAMBLE_CLOCKS is
  port (
    I_CLK_REF         : in    std_logic;
    I_RESET_L         : in    std_logic;
    --
    O_CLK_REF         : out   std_logic;
    --
    O_ENA_12          : out   std_logic;
    O_ENA_6           : out   std_logic;
    O_ENA_6B          : out   std_logic;
    O_ENA_1_79        : out   std_logic;
    O_CLK             : out   std_logic;
    O_RESET           : out   std_logic
    );
end;

architecture RTL of SCRAMBLE_CLOCKS is

  signal reset_dcm_h            : std_logic;
  signal clk_ref_ibuf           : std_logic;
  signal clk_dcm_op_0           : std_logic;
  signal clk_dcm_op_dv          : std_logic;
  signal clk_dcm_0_bufg         : std_logic;
  signal clk                    : std_logic;
  signal dcm_locked             : std_logic;
  signal delay_count            : std_logic_vector(3 downto 0) := (others => '0');
  signal div_cnt                : std_logic_vector(1 downto 0);
  signal div_cnt_14             : std_logic_vector(3 downto 0);
  --
  signal ena_12                 : std_logic;
  signal ena_6                  : std_logic;
  signal ena_6b                 : std_logic;
  signal ena_1_79               : std_logic;

  --
  attribute DLL_FREQUENCY_MODE    : string;
  attribute DUTY_CYCLE_CORRECTION : string;
  attribute CLKOUT_PHASE_SHIFT    : string;
  attribute PHASE_SHIFT           : integer;
  attribute CLKFX_MULTIPLY        : integer;
  attribute CLKFX_DIVIDE          : integer;
  attribute CLKDV_DIVIDE          : real;
  attribute STARTUP_WAIT          : string;
  attribute CLKIN_PERIOD          : real;

  -- The original uses a 6.144 MHz clock
  --
  -- Here we are taking in 50Hz clock, and using the div 2 output to get 25.0MHz
  -- We are then clock enabling the whole design at /4 and /2
  --
  -- This runs the game at 6.25 MHz which is ~1.7% fast. If you can choose your
  -- input clock more accurately, and perhaps use the clkfx output you can probably do better.
  -- a 24.576 MHz oscillator would be ideal, and could be used directly
  --
  -- (The scan doubler requires a x2 freq clock)
  function str2bool (str : string) return boolean is
  begin
    if (str = "TRUE") or (str = "true") then
      return TRUE;
    else
      return FALSE;
    end if;
  end str2bool;

begin

  reset_dcm_h <= not I_RESET_L;
  IBUFG0 : IBUFG port map (I=> I_CLK_REF, O => clk_ref_ibuf);

  dcma   : if true generate
    attribute DLL_FREQUENCY_MODE    of dcm_inst : label is "LOW";
    attribute DUTY_CYCLE_CORRECTION of dcm_inst : label is "TRUE";
    attribute CLKOUT_PHASE_SHIFT    of dcm_inst : label is "NONE";
    attribute PHASE_SHIFT           of dcm_inst : label is 0;
    attribute CLKFX_MULTIPLY        of dcm_inst : label is 2;
    attribute CLKFX_DIVIDE          of dcm_inst : label is 1;
    attribute CLKDV_DIVIDE          of dcm_inst : label is 2.0;
    attribute STARTUP_WAIT          of dcm_inst : label is "FALSE";
    attribute CLKIN_PERIOD          of dcm_inst : label is 20.0;
    --
    begin
    dcm_inst : DCM
    -- pragma translate_off
      generic map (
        DLL_FREQUENCY_MODE    => dcm_inst'DLL_FREQUENCY_MODE,
        DUTY_CYCLE_CORRECTION => str2bool(dcm_inst'DUTY_CYCLE_CORRECTION),
        CLKOUT_PHASE_SHIFT    => dcm_inst'CLKOUT_PHASE_SHIFT,
        PHASE_SHIFT           => dcm_inst'PHASE_SHIFT,
        CLKFX_MULTIPLY        => dcm_inst'CLKFX_MULTIPLY,
        CLKFX_DIVIDE          => dcm_inst'CLKFX_DIVIDE,
        CLKDV_DIVIDE          => dcm_inst'CLKDV_DIVIDE,
        STARTUP_WAIT          => str2bool(dcm_inst'STARTUP_WAIT),
        CLKIN_PERIOD          => dcm_inst'CLKIN_PERIOD
       )
    -- pragma translate_on
      port map (
        CLKIN    => clk_ref_ibuf,
        CLKFB    => clk_dcm_0_bufg,
        DSSEN    => '0',
        PSINCDEC => '0',
        PSEN     => '0',
        PSCLK    => '0',
        RST      => reset_dcm_h,
        CLK0     => clk_dcm_op_0,
        CLK90    => open,
        CLK180   => open,
        CLK270   => open,
        CLK2X    => open,
        CLK2X180 => open,
        CLKDV    => clk_dcm_op_dv,
        CLKFX    => open,
        CLKFX180 => open,
        LOCKED   => dcm_locked,
        PSDONE   => open
       );
  end generate;


  BUFG0 : BUFG port map (I=> clk_dcm_op_0,  O => clk_dcm_0_bufg);
  O_CLK_REF <= clk_dcm_0_bufg;
  BUFG1 : BUFG port map (I=> clk_dcm_op_dv, O => clk);
  O_CLK <= clk;

  p_delay : process(I_RESET_L, clk)
  begin
    if (I_RESET_L = '0') then
      delay_count <= x"0";
      O_RESET <= '1';
    elsif rising_edge(clk) then
      if (delay_count(3 downto 0) = (x"F")) then
        delay_count <= (x"F");
        O_RESET <= '0';
      else
        delay_count <= delay_count + "1";
        O_RESET <= '1';
      end if;
    end if;
  end process;

  p_clk_div : process(I_RESET_L, clk)
  begin
    if (I_RESET_L = '0') then
      div_cnt    <= (others => '0');
      div_cnt_14 <= (others => '0');

      ena_12   <= '0';
      ena_6    <= '0';
      ena_6b   <= '0';
      ena_1_79 <= '0';

    elsif rising_edge(clk) then
      div_cnt <= div_cnt + "1";

      ena_12   <= div_cnt(0);
      ena_6    <= div_cnt(0) and not div_cnt(1);
      ena_6b   <= div_cnt(0) and     div_cnt(1);

      ena_1_79 <= '0';
      div_cnt_14 <= div_cnt_14 - "1";
      if (div_cnt_14 = "0000") then
        div_cnt_14 <= "1101"; -- 14-1
        ena_1_79 <= '1';
      end if;

    end if;
  end process;
  -- match delta delay on clock
  O_ENA_12   <= ena_12;
  O_ENA_6    <= ena_6;
  O_ENA_6B   <= ena_6b;
  O_ENA_1_79 <= ena_1_79;

end RTL;
