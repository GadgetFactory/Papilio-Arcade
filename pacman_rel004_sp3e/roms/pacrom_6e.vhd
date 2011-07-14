-- generated with romgen v3.0 by MikeJ
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.Vcomponents.all;

entity PACROM_6E is
  port (
    CLK         : in    std_logic;
    ENA         : in    std_logic;
    ADDR        : in    std_logic_vector(11 downto 0);
    DATA        : out   std_logic_vector(7 downto 0)
    );
end;

architecture RTL of PACROM_6E is

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
    attribute INIT_00 of inst : label is "2FE0020E00000000000000000000000000000000000000000000000000000733";
    attribute INIT_01 of inst : label is "002FEC02AC12B500E9DB037F801081FC1A7C0AF0116328D0103C02D780EC0A00";
    attribute INIT_02 of inst : label is "06E76FDD820ED9206FD400E9DA0370E001041400E9DA037FE401041C22012002";
    attribute INIT_03 of inst : label is "1E0E23EC0970010C17EB6C0970010317EB6D221EDB28EDA28ED62D26FDD72268";
    attribute INIT_04 of inst : label is "7E1A8D1EDD2BEE013E1A8DAEDD2CEEC1BD1A8D1EDD2CEE01BF1B034670106012";
    attribute INIT_05 of inst : label is "1F1A8D3EDD2CEE41B01A8D5EDD2CEE81B21A8D4EDD22EE015E1A8D4EDD22EE01";
    attribute INIT_06 of inst : label is "0B6DC020E6DDD42D32FA6B46B164B26376326081A8D5EDD21EE01611BFDEC11E";
    attribute INIT_07 of inst : label is "D4200ADE2D4A9B002FEBED14D00A20520E76DF228646C0A01838000021E00200";
    attribute INIT_08 of inst : label is "9D0723ED2A80FBD4A0727D3A000000000009C220ED0FBD5A9002D5200ADF2D5A";
    attribute INIT_09 of inst : label is "DAADB2BE50BEDBADB25E585EDBA7C3E282EF6FFDD2F18CDDA60896DEA796D4A3";
    attribute INIT_0A of inst : label is "CA60806DFA706D5ADB20DBA70FBB8DB20DBA907BD4ADA2BE50BEDAADA25E585E";
    attribute INIT_0B of inst : label is "7D6A708E70D6A7D8ADA20DAA707BB8DA20DAA90FBD5A7C3E282EF6FFDC2F18CD";
    attribute INIT_0C of inst : label is "AE784DD508E70D7A7D9A3CD4CD85D1E40D3CA7D6A580E983CD4CD84D1E40D332";
    attribute INIT_0D of inst : label is "920D9A7D7A5CDF52FEF42778E0420E052DBAF32FEF22778E0228E032DAA4DD38";
    attribute INIT_0E of inst : label is "C60010E1D62D18C34A7D6A03ED42CD4A9F6277FEF7201A062D820D8A7D6A072D";
    attribute INIT_0F of inst : label is "303E3EA9D62C18D34A687D6A83E8D42F7D4A950906306306C60D150906306306";
    attribute INIT_10 of inst : label is "01E31A1092D369504E9870E50FE706CF69980E067F069480EF6FE001C60E10E2";
    attribute INIT_11 of inst : label is "7D1A91092D169502E9870E507E706CF69980E067F069480EF6FE001C60110123";
    attribute INIT_12 of inst : label is "305E36AA01E37A443305E38AA01E39AD220E28CD2A608D02DAA7D0A308D12DBA";
    attribute INIT_13 of inst : label is "D720F6FF970699D820D8A7D6200E7D6A9D920D9A7D7200E7D7A9D32C020E9443";
    attribute INIT_14 of inst : label is "8A943D0AE00E740F0D9A7DAA08E46D8A5EA7D6A950D57D52D59D9D6200E7D6A9";
    attribute INIT_15 of inst : label is "AE00E740F0D9A7DAA08ED8A55A7D6A930D43D51D0AE00E740F0D9A7DAA08E46D";
    attribute INIT_16 of inst : label is "0F0D9A7DBA00E26D8A52A7D6A930D43D51D0AE00E740F0D9A7DAA08ED8A943D0";
    attribute INIT_17 of inst : label is "A00E26D8A6BA7D6A943D0AE00E740F0D9A7DBA00E66D8A930D43D51D0AE00E74";
    attribute INIT_18 of inst : label is "66D0000943D0AE00E740F0D9A7DBA00E26D8A930D43D51D0AE00E740F0D9A7DB";
    attribute INIT_19 of inst : label is "8A38A732A093223AA31239A30238A8A38A730A9A038A39A731A97038A3AA732A";
    attribute INIT_1A of inst : label is "02FE93723623923820E932238A31237A30236A8A36A730A9A038A37A731A9703";
    attribute INIT_1B of inst : label is "A052FFFF067E68D333680ED5AEC1307BD62CD6AEC190520E600ED52D80ED5A90";
    attribute INIT_1C of inst : label is "20E600ED72D80ED7A9002FE052F6A042FFFF067E3032F6A022FFFF067E3012F6";
    attribute INIT_1D of inst : label is "2FFFF067E3082F6A072FFFF067E3062F6A0A2FFFF067E68D333680ED7AEC190A";
    attribute INIT_1E of inst : label is "FFF067E3012F6A052FFFF067E68D333680EFE6DDAEC180EDFA9002FE0A2F6A09";
    attribute INIT_1F of inst : label is "D9AEC190F20E600ED92D80ED9A00009002FE052F6A042FFFF067E3032F6A022F";
    attribute INIT_20 of inst : label is "E0F2F6A0E2FFFF067E30D2F6A0C2FFFF067E30B2F6A0F2FFFF067E68D333680E";
    attribute INIT_21 of inst : label is "F067E30B2F6A0F2FFFF067E68D333680EDAAEC190F20E600EDA2D80EDAA9002F";
    attribute INIT_22 of inst : label is "238A392C39A382A6F8AE338AFF679002FE0F2F6A0E2FFFF067E30D2F6A0C2FFF";
    attribute INIT_23 of inst : label is "36A372C37A362A6F8AE336AFF67939239A3A2C3AA392A6F8AE239A7FFFF06A38";
    attribute INIT_24 of inst : label is "9480E00180015599061FDDFE85937237A382C38A372A6F8AE237A7FFFF06A362";
    attribute INIT_25 of inst : label is "9188D9480E0018001559171906FFE9188D9480E001800155591D4906FFE9188D";
    attribute INIT_26 of inst : label is "D001591E96D001591796D301591796D301591796D001591796D001591E906FFE";
    attribute INIT_27 of inst : label is "591796D401591796D40159A99D92199D590B92D91E96D301591E96D301591E96";
    attribute INIT_28 of inst : label is "0DDA091E96D701591E96D701591E96D401591E96D401591796D701591796D701";
    attribute INIT_29 of inst : label is "FDFA7DEA9FDE7D0DDAFDFA7DEA80EDDADF29DE27F60CFEDDDAD420020000097D";
    attribute INIT_2A of inst : label is "CD2A9FDD1A7D2A9DDA7D2AD02680E9D228D12D4509D8DD2DDDA39FDD4A7D0DDA";
    attribute INIT_2B of inst : label is "DD0A3D22CD2AA9DD1A7D2A97DA7D2AD02680E9D228D12D4509168D02DD0A3D22";
    attribute INIT_2C of inst : label is "09168D02DD0A3D22CD2A9BDD1A7D2A99DA7D2AD02680E9D228D12D4509168D02";
    attribute INIT_2D of inst : label is "E0EF690019168D02DD0A3D22CD2A95DD1A7D2A93DA7D2AD02680E9D228D12D45";
    attribute INIT_2E of inst : label is "23E36FFFFF00A0A23E36FFFFF00A0B2C9DF600A0C2C9DF600A9D03E8200E9320";
    attribute INIT_2F of inst : label is "3D7C3D77C3DFFFFFE00AC3DFFFFFC3DFFFFC3DFFFC3DFFC3DFC3D7081FE00A09";
    attribute INIT_30 of inst : label is "0000000098E94E30FB92E307B9CE30FB95E307B9B87169C3DFFFFC3D77FE00AC";
    attribute INIT_31 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_32 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_33 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_34 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_35 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_36 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_37 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_38 of inst : label is "E900000000000DF3E5413211706E777000000000000009205217421800000000";
    attribute INIT_39 of inst : label is "000000000000000000000000DF3EC5497E7770000000000000920FD5407EF007";
    attribute INIT_3A of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0431476543213321000000000000";
    attribute INIT_3B of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3C of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3D of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3E of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3F of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
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
    attribute INIT_00 of inst : label is "3F350303000000000000000000000000000000000000000000000000000005CF";
    attribute INIT_01 of inst : label is "5C3F340374037F20F70F127A402010540354034E30EC02C00DC4133020F4135C";
    attribute INIT_02 of inst : label is "30F0E5E443834434C5EF20F70F12743402000F20F70F12703402000413503503";
    attribute INIT_03 of inst : label is "6345373F1170214522310F117021442231045303443734438344330E5E4430DF";
    attribute INIT_04 of inst : label is "11004C034030307211004C034031301211004C0340313002110F12034C240443";
    attribute INIT_05 of inst : label is "00004C034031305210004C034031303210004C034030307201004C0340303072";
    attribute INIT_06 of inst : label is "0F5E413330AC453453A03203203DC5324324342204C034031307210003C08203";
    attribute INIT_07 of inst : label is "403503443403CF5C3F308C0FC0553553030EC4F33F0E4130F1F100503035C300";
    attribute INIT_08 of inst : label is "FC05D0F453024C40305CB45300000000000C413033C6C403C5C3403543443403";
    attribute INIT_09 of inst : label is "44344323032F443443E303EF4434303030F3E00443A01344302A0E44340E4030";
    attribute INIT_0A of inst : label is "4302A6E44346E4034439443025C014438443024C40344323032F443443E303EF";
    attribute INIT_0B of inst : label is "B443131F4844344434439443027C014438443026C4034303030F3E00443A0134";
    attribute INIT_0C of inst : label is "EF010CC032F4844344430DC07C0EC030EC02FB44313FF110DC07C0AC030EC01F";
    attribute INIT_0D of inst : label is "438443444300C4F3034F30003563E35634434F3034F30003563235634430CC03";
    attribute INIT_0E of inst : label is "1044201144330130BFB443C0F4533453C4F300034F3003563443844344435634";
    attribute INIT_0F of inst : label is "027F4B3C44330130FF02B443D0F7453A4453CF114324324310452F1143243243";
    attribute INIT_10 of inst : label is "26F4A3D115E531027F01743027F77F30E713EFFE742C7220F0E4702110452453";
    attribute INIT_11 of inst : label is "4453CD115E431026F01743026F76F30E713EFFE742C7220F0E47021104424430";
    attribute INIT_12 of inst : label is "020F4E3020F4E30CC020F4F3020F4F34530301345302B453443445312B453443";
    attribute INIT_13 of inst : label is "443B0E0074FE7C443844344439034443C443844344439034443C45341363C0CC";
    attribute INIT_14 of inst : label is "43C0FCD0F903403494434443C2F0C44303FB443C0FC0AC06C01CC4439034443C";
    attribute INIT_15 of inst : label is "0F903403494434443C2F44308FB443C0AC0FC00CD0F903403494434443C2F0D4";
    attribute INIT_16 of inst : label is "3494434443CEF0C4430DFB443C0AC0FC00CD0F903403494434443C2F443C0FCD";
    attribute INIT_17 of inst : label is "3CEF0D44301FB443C0FCD0F903403494434443CEF0D443C0AC0FC00CD0F90340";
    attribute INIT_18 of inst : label is "07C0000C0FCD0F903403494434443CEF0D443C0AC0FC00CD0F90340349443444";
    attribute INIT_19 of inst : label is "2B4E354F30C4F34F34F34F34F34F3DB4F354F3C0302B4F354F3C1302B4F354F3";
    attribute INIT_1A of inst : label is "C3F3C4E34E34F34F303C4F34E34F34E34F34E3DB4E354F3C0302B4E354F3C130";
    attribute INIT_1B of inst : label is "75430000FE57F13222020F433092024C4333433092C55303020F4333C0F433C5";
    attribute INIT_1C of inst : label is "303020F4333C0F433C5C3F35530E75530000FE5725530E75530000FE5725530E";
    attribute INIT_1D of inst : label is "30000FE5725530E75530000FE5725530E75430000FE57F13222020F433092C55";
    attribute INIT_1E of inst : label is "000FE5725530E75430000FE57F13222020F00E423092C0F413C5C3F35530E755";
    attribute INIT_1F of inst : label is "433092C55303020F4333C0F4330000C5C3F35530E75530000FE5725530E75530";
    attribute INIT_20 of inst : label is "35530E75530000FE5725530E75530000FE5725530E75430000FE57F13222020F";
    attribute INIT_21 of inst : label is "0FE5725530E75430000FE57F13222020F433092C55303020F4333C0F433C5C3F";
    attribute INIT_22 of inst : label is "34F34F334F34F30D030F84F350E5C5C3F35530E75530000FE5725530E7553000";
    attribute INIT_23 of inst : label is "4E34E334E34E30D030F84E350E5C4F34F34F334F34F30D030F84F350000FE74F";
    attribute INIT_24 of inst : label is "0020F0207442CEC000F4331E7FC4E34E34E334E34E30D030F84E350000FE74E3";
    attribute INIT_25 of inst : label is "7CF130020F0207442CECE7F00041E7CF130020F0207442CFECE4400041E7CF13";
    attribute INIT_26 of inst : label is "C422ECE702C402ECE702C4E2ECE702C4C2ECE702C422ECE702C402ECE700041E";
    attribute INIT_27 of inst : label is "ECE702C422ECE702C402EC00DCC0F0DCFCDC03CCE702C4E2ECE702C4C2ECE702";
    attribute INIT_28 of inst : label is "84030CE702C4E2ECE702C4C2ECE702C422ECE702C402ECE702C4E2ECE702C4C2";
    attribute INIT_29 of inst : label is "4403440304C743840344034403C0F403403740341E83FE34034135C300000C43";
    attribute INIT_2A of inst : label is "34130FC413441309C14413413220F7413741355D0CC1403340320DC413438403";
    attribute INIT_2B of inst : label is "34131413341300C41344130AC14413413220F7413741355D0CDD141334131413";
    attribute INIT_2C of inst : label is "0CDD14133413141334130EC413441308C14413413220F7413741355D0CDD1413";
    attribute INIT_2D of inst : label is "30F1E7440CDD14133413141334130FC413441309C14413413220F7413741355D";
    attribute INIT_2E of inst : label is "30E0E000005034130E0E0000054341301C0E54341301C0E503CE24F7F2CF7002";
    attribute INIT_2F of inst : label is "1C001C0001C0000FE50301C0000001C000001C00001C0001C001C4412FE58341";
    attribute INIT_30 of inst : label is "00000000C53C43025CC53025CC43024CC53024CC2770EC01C000001C04FE5430";
    attribute INIT_31 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_32 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_33 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_34 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_35 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_36 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_37 of inst : label is "0000000000000000000000000000000000000000000000000000000000000000";
    attribute INIT_38 of inst : label is "4454444444444444244445444542555444444444444445444545454444444444";
    attribute INIT_39 of inst : label is "4444444444444444444444444442444452555444444444444454444444444544";
    attribute INIT_3A of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4544433333334533444444444444";
    attribute INIT_3B of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3C of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3D of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3E of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    attribute INIT_3F of inst : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
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
