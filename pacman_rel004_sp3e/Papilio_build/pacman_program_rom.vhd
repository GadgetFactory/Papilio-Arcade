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
-- Revision list
--
-- version 003 Jan 2006 release, general tidy up
-- version 001 initial release
--
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

use work.pkg_pacman.all;

entity PACMAN_PROGRAM_ROM is
  port (
    I_ADDR            : in    std_logic_vector(13 downto 0);
    O_DATA            : out   std_logic_vector( 7 downto 0);
    ENA_6             : in    std_logic;
    CLK               : in    std_logic
    );
end;

architecture RTL of PACMAN_PROGRAM_ROM is
  signal rom_data_0 : std_logic_vector(7 downto 0);
  signal rom_data_1 : std_logic_vector(7 downto 0);
  signal rom_data_2 : std_logic_vector(7 downto 0);
  signal rom_data_3 : std_logic_vector(7 downto 0);
  signal rom_data   : std_logic_vector(7 downto 0);

begin

  u_6e : entity work.PACROM_6E
    port map (
      CLK         => CLK,
      ENA         => ENA_6,
      ADDR        => I_ADDR(11 downto 0),
      DATA        => rom_data_0
      );

  u_6f : entity work.PACROM_6F
    port map (
      CLK         => CLK,
      ENA         => ENA_6,
      ADDR        => I_ADDR(11 downto 0),
      DATA        => rom_data_1
      );

  u_6h : entity work.PACROM_6H
    port map (
      CLK         => CLK,
      ENA         => ENA_6,
      ADDR        => I_ADDR(11 downto 0),
      DATA        => rom_data_2
      );

  u_6j : entity work.PACROM_6J
    port map (
      CLK         => CLK,
      ENA         => ENA_6,
      ADDR        => I_ADDR(11 downto 0),
      DATA        => rom_data_3
      );

  p_rom_data : process(I_ADDR, rom_data_0, rom_data_1, rom_data_2, rom_data_3)
  begin
    O_DATA <= (others => '0');
    case I_ADDR(13 downto 12) is
      when "00" => O_DATA <= rom_data_0;
      when "01" => O_DATA <= rom_data_1;
      when "10" => O_DATA <= rom_data_2;
      when "11" => O_DATA <= rom_data_3;
      when others => null;
    end case;
  end process;

end RTL;
