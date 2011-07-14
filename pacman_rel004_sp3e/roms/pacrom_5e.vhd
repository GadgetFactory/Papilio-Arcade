-- generated with romgen v3.0 by MikeJ
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.Vcomponents.all;

entity PACROM_5E is
  port (
    CLK         : in    std_logic;
    ENA         : in    std_logic;
    ADDR        : in    std_logic_vector(11 downto 0);
    DATA        : out   std_logic_vector(7 downto 0)
    );
end;

architecture RTL of PACROM_5E is

  function romgen_str2bv (str : string) return bit_vector is
    variable result : bit_vector (str'length*4-1 downto 0);
  begin
    for i in 0 to str'length-1 loop
      case str(str'high-i) is
        when '0'       => result(i*4+3 downto i*4) := x"0";
        when '1'       => result(i*4+3 downto i*4) := x"1";
        when '2'       => result(i*4+3 downto i*4) := x"2";
        when '3'       => result(i*4+3 downto i*4) := x"3";
        when '4'       => result(i*4+3 downto i*4) := x"4";
        when '5'       => result(i*4+3 downto i*4) := x"5";
        when '6'       => result(i*4+3 downto i*4) := x"6";
        when '7'       => result(i*4+3 downto i*4) := x"7";
        when '8'       => result(i*4+3 downto i*4) := x"8";
        when '9'       => result(i*4+3 downto i*4) := x"9";
        when 'A'       => result(i*4+3 downto i*4) := x"A";
        when 'B'       => result(i*4+3 downto i*4) := x"B";
        when 'C'       => result(i*4+3 downto i*4) := x"C";
        when 'D'       => result(i*4+3 downto i*4) := x"D";
        when 'E'       => result(i*4+3 downto i*4) := x"E";
        when 'F'       => result(i*4+3 downto i*4) := x"F";
        when others    => null;
      end case;
    end loop;
    return result;
  end romgen_str2bv;

  attribute INIT_00 : string;
  attribute INIT_01 : string;
  attribute INIT_02 : string;
  attribute INIT_03 : string;
  attribute INIT_04 : string;
  attribute INIT_05 : string;
  attribute INIT_06 : string;
  attribute INIT_07 : string;
  attribute INIT_08 : string;
  attribute INIT_09 : string;
  attribute INIT_0A : string;
  attribute INIT_0B : string;
  attribute INIT_0C : string;
  attribute INIT_0D : string;
  attribute INIT_0E : string;
  attribute INIT_0F : string;
  attribute INIT_10 : string;
  attribute INIT_11 : string;
  attribute INIT_12 : string;
  attribute INIT_13 : string;
  attribute INIT_14 : string;
  attribute INIT_15 : string;
  attribute INIT_16 : string;
  attribute INIT_17 : string;
  attribute INIT_18 : string;
  attribute INIT_19 : string;
  attribute INIT_1A : string;
  attribute INIT_1B : string;
  attribute INIT_1C : string;
  attribute INIT_1D : string;
  attribute INIT_1E : string;
  attribute INIT_1F : string;
  attribute INIT_20 : string;
  attribute INIT_21 : string;
  attribute INIT_22 : string;
  attribute INIT_23 : string;
  attribute INIT_24 : string;
  attribute INIT_25 : string;
  attribute INIT_26 : string;
  attribute INIT_27 : string;
  attribute INIT_28 : string;
  attribute INIT_29 : string;
  attribute INIT_2A : string;
  attribute INIT_2B : string;
  attribute INIT_2C : string;
  attribute INIT_2D : string;
  attribute INIT_2E : string;
  attribute INIT_2F : string;
  attribute INIT_30 : string;
  attribute INIT_31 : string;
  attribute INIT_32 : string;
  attribute INIT_33 : string;
  attribute INIT_34 : string;
  attribute INIT_35 : string;
  attribute INIT_36 : string;
  attribute INIT_37 : string;
  attribute INIT_38 : string;
  attribute INIT_39 : string;
  attribute INIT_3A : string;
  attribute INIT_3B : string;
  attribute INIT_3C : string;
  attribute INIT_3D : string;
  attribute INIT_3E : string;
  attribute INIT_3F : string;

  component RAMB16_S4
    --pragma translate_off
    generic (
      INIT_00 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39 : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F : bit_vector (255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000"
      );
    --pragma translate_on
    port (
      DO    : out std_logic_vector (3 downto 0);
      ADDR  : in  std_logic_vector (11 downto 0);
      CLK   : in  std_logic;
      DI    : in  std_logic_vector (3 downto 0);
      EN    : in  std_logic;
      SSR   : in  std_logic;
      WE    : in  std_logic 
      );
  end component;

  signal rom_addr : std_logic_vector(11 downto 0);

begin

  p_addr : process(ADDR)
  begin
     rom_addr <= (others => '0');
     rom_addr(11 downto 0) <= ADDR;
  end process;

  rom0 : if true generate
    attribute INIT_00 of inst : label is "008899FF002222EE009999FF00EE2222000000FF000000EE00FF88FF00EE22EE";
    attribute INIT_01 of inst : label is "008888FF000000EE00FF999900EE22EE00FF9999002222EE00FF11FF000000EE";
    attribute INIT_02 of inst : label is "00FF99EE00EE22EE00FF99FF00EE00EE00FF99FF002222EE00FF99FF00EE22EE";
    attribute INIT_03 of inst : label is "00FF998800EE000000FF998800EE222200FF887700EE22CC00FF888800EE2222";
    attribute INIT_04 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_05 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_06 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_07 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_08 of inst : label is "FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000";
    attribute INIT_09 of inst : label is "33333333CCCCCCCC000000000000000033333333CCCCCCCC0000000000000000";
    attribute INIT_0A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_0B of inst : label is "0000012402248000000000000006600000000000008880000000000000067000";
    attribute INIT_0C of inst : label is "000489960422222C000489A40026A22200024F000022E200012488870C22226C";
    attribute INIT_0D of inst : label is "0008889E00224800012599940CA2222C000F99980422222C0000124F00088AC0";
    attribute INIT_0E of inst : label is "0000000000000000000016C0002800000006999604222248001799960C22222C";
    attribute INIT_0F of inst : label is "CE7310000008CE73000137EC37EC8000000137EC37EC8000CE7310000008CE73";
    attribute INIT_10 of inst : label is "012488840C222224001F999602E2226C0003487002C888C20000000000000000";
    attribute INIT_11 of inst : label is "012488840C22AAAC001F998802C00000001F998802E22220001F888702E2226C";
    attribute INIT_12 of inst : label is "001E124802C842200000088F0C2222C000009E880022E200001F111F02C002C0";
    attribute INIT_13 of inst : label is "012488870C22226C001F421F02C002C000F4324F02C002C0001F800002E22222";
    attribute INIT_14 of inst : label is "0004A984042222A4001F999602C08422012488870C22AA4A001F999602C00000";
    attribute INIT_15 of inst : label is "001F010F00C26A6C0870016800C24800001F000F00C2226C00089E880000E000";
    attribute INIT_16 of inst : label is "000000000000000000089AC8026A2220000C212C00024800000C212C022480C2";
    attribute INIT_17 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_18 of inst : label is "00009E880022E20000F4324F02C002C000000000000000000000000000000000";
    attribute INIT_19 of inst : label is "00000000000000000000088F0C2222C0001F998802E22220001E124802C84220";
    attribute INIT_1A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1C of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1D of inst : label is "00009E880022E2000870016800C248000003487002C888C2001F888702E2226C";
    attribute INIT_1E of inst : label is "00009E880022E200001F010F00C26A6C0000000000000000001F888702E2226C";
    attribute INIT_1F of inst : label is "0000000000000000001F800002E22222001F998802E22220001F888702E2226C";
    attribute INIT_20 of inst : label is "009E880022E20002F4324F00C002C00000000000000000020000000000000000";
    attribute INIT_21 of inst : label is "000000000000000000088F002222C0001F998800E222200C1E124800C8422002";
    attribute INIT_22 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_23 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_24 of inst : label is "0000000000000002000000000000000000000000000000000000000000000000";
    attribute INIT_25 of inst : label is "009E880022E2000270016800C248000003487008C888C2001F888700E2226C02";
    attribute INIT_26 of inst : label is "009E880022E200021F010F00C26A6C0000000000000000001F888700E2226C00";
    attribute INIT_27 of inst : label is "00000000000000001F800000E22222001F998800E22220021F888700E2226C02";
    attribute INIT_28 of inst : label is "9E88001EE20002C8324F000002C00022000000F4000002C00000000000000000";
    attribute INIT_29 of inst : label is "0000000000000000088F000022C000009988000022200C221248001F422002E2";
    attribute INIT_2A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_2B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_2C of inst : label is "0000001F000002E2000000000000000000000000000000000000000000000000";
    attribute INIT_2D of inst : label is "9E88001FE20002E201680000480000224870087088C200C288870003226C02C8";
    attribute INIT_2E of inst : label is "9E88001FE20002E2010F00006A6C00220000001F000000C288870000226C0000";
    attribute INIT_2F of inst : label is "000000000000000080000000222200009988001F222002E28887001F226C02E2";
    attribute INIT_30 of inst : label is "88001E120002C8424F00009EC00022E20000F4320002C0020000000000000000";
    attribute INIT_31 of inst : label is "00000000000000008F000000C000000088000008000C222248001F992002E222";
    attribute INIT_32 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_33 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_34 of inst : label is "00001F880002E222000000000000000000000000000000000000000000000000";
    attribute INIT_35 of inst : label is "88001F880002E2226800009E000022E2F0087001C200C248870003486C02C888";
    attribute INIT_36 of inst : label is "88001F880002E2220F00009E6C0022E200001F010000C26A870000006C000000";
    attribute INIT_37 of inst : label is "0000000000000000000000002200000088001F802002E22287001F996C02E222";
    attribute INIT_38 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_39 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3C of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3D of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3E of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3F of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
  begin
  inst : RAMB16_S4
      --pragma translate_off
      generic map (
        INIT_00 => romgen_str2bv(inst'INIT_00),
        INIT_01 => romgen_str2bv(inst'INIT_01),
        INIT_02 => romgen_str2bv(inst'INIT_02),
        INIT_03 => romgen_str2bv(inst'INIT_03),
        INIT_04 => romgen_str2bv(inst'INIT_04),
        INIT_05 => romgen_str2bv(inst'INIT_05),
        INIT_06 => romgen_str2bv(inst'INIT_06),
        INIT_07 => romgen_str2bv(inst'INIT_07),
        INIT_08 => romgen_str2bv(inst'INIT_08),
        INIT_09 => romgen_str2bv(inst'INIT_09),
        INIT_0A => romgen_str2bv(inst'INIT_0A),
        INIT_0B => romgen_str2bv(inst'INIT_0B),
        INIT_0C => romgen_str2bv(inst'INIT_0C),
        INIT_0D => romgen_str2bv(inst'INIT_0D),
        INIT_0E => romgen_str2bv(inst'INIT_0E),
        INIT_0F => romgen_str2bv(inst'INIT_0F),
        INIT_10 => romgen_str2bv(inst'INIT_10),
        INIT_11 => romgen_str2bv(inst'INIT_11),
        INIT_12 => romgen_str2bv(inst'INIT_12),
        INIT_13 => romgen_str2bv(inst'INIT_13),
        INIT_14 => romgen_str2bv(inst'INIT_14),
        INIT_15 => romgen_str2bv(inst'INIT_15),
        INIT_16 => romgen_str2bv(inst'INIT_16),
        INIT_17 => romgen_str2bv(inst'INIT_17),
        INIT_18 => romgen_str2bv(inst'INIT_18),
        INIT_19 => romgen_str2bv(inst'INIT_19),
        INIT_1A => romgen_str2bv(inst'INIT_1A),
        INIT_1B => romgen_str2bv(inst'INIT_1B),
        INIT_1C => romgen_str2bv(inst'INIT_1C),
        INIT_1D => romgen_str2bv(inst'INIT_1D),
        INIT_1E => romgen_str2bv(inst'INIT_1E),
        INIT_1F => romgen_str2bv(inst'INIT_1F),
        INIT_20 => romgen_str2bv(inst'INIT_20),
        INIT_21 => romgen_str2bv(inst'INIT_21),
        INIT_22 => romgen_str2bv(inst'INIT_22),
        INIT_23 => romgen_str2bv(inst'INIT_23),
        INIT_24 => romgen_str2bv(inst'INIT_24),
        INIT_25 => romgen_str2bv(inst'INIT_25),
        INIT_26 => romgen_str2bv(inst'INIT_26),
        INIT_27 => romgen_str2bv(inst'INIT_27),
        INIT_28 => romgen_str2bv(inst'INIT_28),
        INIT_29 => romgen_str2bv(inst'INIT_29),
        INIT_2A => romgen_str2bv(inst'INIT_2A),
        INIT_2B => romgen_str2bv(inst'INIT_2B),
        INIT_2C => romgen_str2bv(inst'INIT_2C),
        INIT_2D => romgen_str2bv(inst'INIT_2D),
        INIT_2E => romgen_str2bv(inst'INIT_2E),
        INIT_2F => romgen_str2bv(inst'INIT_2F),
        INIT_30 => romgen_str2bv(inst'INIT_30),
        INIT_31 => romgen_str2bv(inst'INIT_31),
        INIT_32 => romgen_str2bv(inst'INIT_32),
        INIT_33 => romgen_str2bv(inst'INIT_33),
        INIT_34 => romgen_str2bv(inst'INIT_34),
        INIT_35 => romgen_str2bv(inst'INIT_35),
        INIT_36 => romgen_str2bv(inst'INIT_36),
        INIT_37 => romgen_str2bv(inst'INIT_37),
        INIT_38 => romgen_str2bv(inst'INIT_38),
        INIT_39 => romgen_str2bv(inst'INIT_39),
        INIT_3A => romgen_str2bv(inst'INIT_3A),
        INIT_3B => romgen_str2bv(inst'INIT_3B),
        INIT_3C => romgen_str2bv(inst'INIT_3C),
        INIT_3D => romgen_str2bv(inst'INIT_3D),
        INIT_3E => romgen_str2bv(inst'INIT_3E),
        INIT_3F => romgen_str2bv(inst'INIT_3F)
        )
      --pragma translate_on
      port map (
        DO   => DATA(3 downto 0),
        ADDR => rom_addr,
        CLK  => CLK,
        DI   => "0000",
        EN   => ENA,
        SSR  => '0',
        WE   => '0'
        );
  end generate;
  rom1 : if true generate
    attribute INIT_00 of inst : label is "008899FF002222EE009999FF00EE2222000000FF000000EE00FF88FF00EE22EE";
    attribute INIT_01 of inst : label is "008888FF000000EE00FF999900EE22EE00FF9999002222EE00FF11FF000000EE";
    attribute INIT_02 of inst : label is "00FF99EE00EE22EE00FF99FF00EE00EE00FF99FF002222EE00FF99FF00EE22EE";
    attribute INIT_03 of inst : label is "00FF998800EE000000FF998800EE222200FF887700EE22CC00FF888800EE2222";
    attribute INIT_04 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_05 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_06 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_07 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_08 of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000";
    attribute INIT_09 of inst : label is "33333333CCCCCCCC33333333CCCCCCCC00000000000000000000000000000000";
    attribute INIT_0A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_0B of inst : label is "0000012402248000000000000006600000000000008880000000000000067000";
    attribute INIT_0C of inst : label is "000489960422222C000489A40026A22200024F000022E200012488870C22226C";
    attribute INIT_0D of inst : label is "0008889E00224800012599940CA2222C000F99980422222C0000124F00088AC0";
    attribute INIT_0E of inst : label is "0000000000000000000016C0002800000006999604222248001799960C22222C";
    attribute INIT_0F of inst : label is "CE7310000008CE73000137EC37EC8000000137EC37EC8000CE7310000008CE73";
    attribute INIT_10 of inst : label is "012488840C222224001F999602E2226C0003487002C888C20000000000000000";
    attribute INIT_11 of inst : label is "012488840C22AAAC001F998802C00000001F998802E22220001F888702E2226C";
    attribute INIT_12 of inst : label is "001E124802C842200000088F0C2222C000009E880022E200001F111F02C002C0";
    attribute INIT_13 of inst : label is "012488870C22226C001F421F02C002C000F4324F02C002C0001F800002E22222";
    attribute INIT_14 of inst : label is "0004A984042222A4001F999602C08422012488870C22AA4A001F999602C00000";
    attribute INIT_15 of inst : label is "001F010F00C26A6C0870016800C24800001F000F00C2226C00089E880000E000";
    attribute INIT_16 of inst : label is "000000000000000000089AC8026A2220000C212C00024800000C212C022480C2";
    attribute INIT_17 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_18 of inst : label is "00009E880022E20000F4324F02C002C000000000000000000000000000000000";
    attribute INIT_19 of inst : label is "00000000000000000000088F0C2222C0001F998802E22220001E124802C84220";
    attribute INIT_1A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1C of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_1D of inst : label is "00009E880022E2000870016800C248000003487002C888C2001F888702E2226C";
    attribute INIT_1E of inst : label is "00009E880022E200001F010F00C26A6C0000000000000000001F888702E2226C";
    attribute INIT_1F of inst : label is "0000000000000000001F800002E22222001F998802E22220001F888702E2226C";
    attribute INIT_20 of inst : label is "009E880022E20002F4324F00C002C00000000000000000020000000000000000";
    attribute INIT_21 of inst : label is "000000000000000000088F002222C0001F998800E222200C1E124800C8422002";
    attribute INIT_22 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_23 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_24 of inst : label is "0000000000000002000000000000000000000000000000000000000000000000";
    attribute INIT_25 of inst : label is "009E880022E2000270016800C248000003487008C888C2001F888700E2226C02";
    attribute INIT_26 of inst : label is "009E880022E200021F010F00C26A6C0000000000000000001F888700E2226C00";
    attribute INIT_27 of inst : label is "00000000000000001F800000E22222001F998800E22220021F888700E2226C02";
    attribute INIT_28 of inst : label is "9E88001EE20002C8324F000002C00022000000F4000002C00000000000000000";
    attribute INIT_29 of inst : label is "0000000000000000088F000022C000009988000022200C221248001F422002E2";
    attribute INIT_2A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_2B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_2C of inst : label is "0000001F000002E2000000000000000000000000000000000000000000000000";
    attribute INIT_2D of inst : label is "9E88001FE20002E201680000480000224870087088C200C288870003226C02C8";
    attribute INIT_2E of inst : label is "9E88001FE20002E2010F00006A6C00220000001F000000C288870000226C0000";
    attribute INIT_2F of inst : label is "000000000000000080000000222200009988001F222002E28887001F226C02E2";
    attribute INIT_30 of inst : label is "88001E120002C8424F00009EC00022E20000F4320002C0020000000000000000";
    attribute INIT_31 of inst : label is "00000000000000008F000000C000000088000008000C222248001F992002E222";
    attribute INIT_32 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_33 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_34 of inst : label is "00001F880002E222000000000000000000000000000000000000000000000000";
    attribute INIT_35 of inst : label is "88001F880002E2226800009E000022E2F0087001C200C248870003486C02C888";
    attribute INIT_36 of inst : label is "88001F880002E2220F00009E6C0022E200001F010000C26A870000006C000000";
    attribute INIT_37 of inst : label is "0000000000000000000000002200000088001F802002E22287001F996C02E222";
    attribute INIT_38 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_39 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3A of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3B of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3C of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3D of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3E of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_3F of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
  begin
  inst : RAMB16_S4
      --pragma translate_off
      generic map (
        INIT_00 => romgen_str2bv(inst'INIT_00),
        INIT_01 => romgen_str2bv(inst'INIT_01),
        INIT_02 => romgen_str2bv(inst'INIT_02),
        INIT_03 => romgen_str2bv(inst'INIT_03),
        INIT_04 => romgen_str2bv(inst'INIT_04),
        INIT_05 => romgen_str2bv(inst'INIT_05),
        INIT_06 => romgen_str2bv(inst'INIT_06),
        INIT_07 => romgen_str2bv(inst'INIT_07),
        INIT_08 => romgen_str2bv(inst'INIT_08),
        INIT_09 => romgen_str2bv(inst'INIT_09),
        INIT_0A => romgen_str2bv(inst'INIT_0A),
        INIT_0B => romgen_str2bv(inst'INIT_0B),
        INIT_0C => romgen_str2bv(inst'INIT_0C),
        INIT_0D => romgen_str2bv(inst'INIT_0D),
        INIT_0E => romgen_str2bv(inst'INIT_0E),
        INIT_0F => romgen_str2bv(inst'INIT_0F),
        INIT_10 => romgen_str2bv(inst'INIT_10),
        INIT_11 => romgen_str2bv(inst'INIT_11),
        INIT_12 => romgen_str2bv(inst'INIT_12),
        INIT_13 => romgen_str2bv(inst'INIT_13),
        INIT_14 => romgen_str2bv(inst'INIT_14),
        INIT_15 => romgen_str2bv(inst'INIT_15),
        INIT_16 => romgen_str2bv(inst'INIT_16),
        INIT_17 => romgen_str2bv(inst'INIT_17),
        INIT_18 => romgen_str2bv(inst'INIT_18),
        INIT_19 => romgen_str2bv(inst'INIT_19),
        INIT_1A => romgen_str2bv(inst'INIT_1A),
        INIT_1B => romgen_str2bv(inst'INIT_1B),
        INIT_1C => romgen_str2bv(inst'INIT_1C),
        INIT_1D => romgen_str2bv(inst'INIT_1D),
        INIT_1E => romgen_str2bv(inst'INIT_1E),
        INIT_1F => romgen_str2bv(inst'INIT_1F),
        INIT_20 => romgen_str2bv(inst'INIT_20),
        INIT_21 => romgen_str2bv(inst'INIT_21),
        INIT_22 => romgen_str2bv(inst'INIT_22),
        INIT_23 => romgen_str2bv(inst'INIT_23),
        INIT_24 => romgen_str2bv(inst'INIT_24),
        INIT_25 => romgen_str2bv(inst'INIT_25),
        INIT_26 => romgen_str2bv(inst'INIT_26),
        INIT_27 => romgen_str2bv(inst'INIT_27),
        INIT_28 => romgen_str2bv(inst'INIT_28),
        INIT_29 => romgen_str2bv(inst'INIT_29),
        INIT_2A => romgen_str2bv(inst'INIT_2A),
        INIT_2B => romgen_str2bv(inst'INIT_2B),
        INIT_2C => romgen_str2bv(inst'INIT_2C),
        INIT_2D => romgen_str2bv(inst'INIT_2D),
        INIT_2E => romgen_str2bv(inst'INIT_2E),
        INIT_2F => romgen_str2bv(inst'INIT_2F),
        INIT_30 => romgen_str2bv(inst'INIT_30),
        INIT_31 => romgen_str2bv(inst'INIT_31),
        INIT_32 => romgen_str2bv(inst'INIT_32),
        INIT_33 => romgen_str2bv(inst'INIT_33),
        INIT_34 => romgen_str2bv(inst'INIT_34),
        INIT_35 => romgen_str2bv(inst'INIT_35),
        INIT_36 => romgen_str2bv(inst'INIT_36),
        INIT_37 => romgen_str2bv(inst'INIT_37),
        INIT_38 => romgen_str2bv(inst'INIT_38),
        INIT_39 => romgen_str2bv(inst'INIT_39),
        INIT_3A => romgen_str2bv(inst'INIT_3A),
        INIT_3B => romgen_str2bv(inst'INIT_3B),
        INIT_3C => romgen_str2bv(inst'INIT_3C),
        INIT_3D => romgen_str2bv(inst'INIT_3D),
        INIT_3E => romgen_str2bv(inst'INIT_3E),
        INIT_3F => romgen_str2bv(inst'INIT_3F)
        )
      --pragma translate_on
      port map (
        DO   => DATA(7 downto 4),
        ADDR => rom_addr,
        CLK  => CLK,
        DI   => "0000",
        EN   => ENA,
        SSR  => '0',
        WE   => '0'
        );
  end generate;
end RTL;
