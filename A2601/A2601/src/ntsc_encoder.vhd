library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- clk must be a 64Mhz clock
-- sync is the sync signal (0 for 0V, 1 for 0.3V)
-- line_visible is 1 for lines that are displayed (only sync when 0)
-- line_even should be toggled every line (unused)
-- color: 222 RGB (r1r0g1g0b1b0)
-- output: 6 bit linear output, "000000" is 0v, "111111" is 1.3V (step is 0.02V)
entity ntsc_encoder is
    Port ( clk				: in  STD_LOGIC;
           sync			: in  STD_LOGIC;
           line_visible	: in  STD_LOGIC;
           line_even		: in  STD_LOGIC;
           color			: in  STD_LOGIC_VECTOR (5 downto 0);
           output			: out STD_LOGIC_VECTOR (5 downto 0));
end ntsc_encoder;

architecture Behavioral of ntsc_encoder is
	
	type table is array(63 downto 0) of unsigned(5 downto 0);
	signal y_table : table := (
		0 => "000000",
		1 => "000001",
		2 => "000010",
		3 => "000011",
		4 => "000110",
		5 => "000111",
		6 => "001000",
		7 => "001001",
		8 => "001100",
		9 => "001101",
		10 => "001110",
		11 => "001111",
		12 => "010010",
		13 => "010011",
		14 => "010100",
		15 => "010101",
		16 => "000011",
		17 => "000100",
		18 => "000101",
		19 => "000110",
		20 => "001001",
		21 => "001010",
		22 => "001011",
		23 => "001100",
		24 => "001111",
		25 => "010000",
		26 => "010001",
		27 => "010010",
		28 => "010101",
		29 => "010110",
		30 => "010111",
		31 => "011000",
		32 => "000110",
		33 => "000111",
		34 => "001000",
		35 => "001001",
		36 => "001100",
		37 => "001101",
		38 => "001110",
		39 => "001111",
		40 => "010010",
		41 => "010011",
		42 => "010100",
		43 => "010101",
		44 => "011000",
		45 => "011001",
		46 => "011010",
		47 => "011011",
		48 => "001001",
		49 => "001010",
		50 => "001011",
		51 => "001100",
		52 => "001111",
		53 => "010000",
		54 => "010001",
		55 => "010010",
		56 => "010101",
		57 => "010110",
		58 => "010111",
		59 => "011000",
		60 => "011011",
		61 => "011100",
		62 => "011101",
		63 => "011110"
	);
	
	signal u_table : table := (
		0 => "000000",
		1 => "000100",
		2 => "001001",
		3 => "001101",
		4 => "111101",
		5 => "000001",
		6 => "000110",
		7 => "001010",
		8 => "111010",
		9 => "111111",
		10 => "000011",
		11 => "000111",
		12 => "110111",
		13 => "111100",
		14 => "000000",
		15 => "000100",
		16 => "111111",
		17 => "000011",
		18 => "000111",
		19 => "001100",
		20 => "111100",
		21 => "000000",
		22 => "000100",
		23 => "001001",
		24 => "111001",
		25 => "111101",
		26 => "000001",
		27 => "000110",
		28 => "110110",
		29 => "111010",
		30 => "111111",
		31 => "000011",
		32 => "111101",
		33 => "000001",
		34 => "000110",
		35 => "001010",
		36 => "111010",
		37 => "111111",
		38 => "000011",
		39 => "000111",
		40 => "110111",
		41 => "111100",
		42 => "000000",
		43 => "000100",
		44 => "110100",
		45 => "111001",
		46 => "111101",
		47 => "000001",
		48 => "111100",
		49 => "000000",
		50 => "000100",
		51 => "001001",
		52 => "111001",
		53 => "111101",
		54 => "000001",
		55 => "000110",
		56 => "110110",
		57 => "111010",
		58 => "111111",
		59 => "000011",
		60 => "110011",
		61 => "110111",
		62 => "111100",
		63 => "000000"
	);
	
	signal v_table : table := (
		0 => "000000",
		1 => "111111",
		2 => "111110",
		3 => "111101",
		4 => "111011",
		5 => "111010",
		6 => "111001",
		7 => "111000",
		8 => "110110",
		9 => "110101",
		10 => "110100",
		11 => "110011",
		12 => "110001",
		13 => "110000",
		14 => "101111",
		15 => "101110",
		16 => "000110",
		17 => "000101",
		18 => "000100",
		19 => "000011",
		20 => "000001",
		21 => "000000",
		22 => "111111",
		23 => "111110",
		24 => "111100",
		25 => "111011",
		26 => "111010",
		27 => "111001",
		28 => "110111",
		29 => "110110",
		30 => "110101",
		31 => "110100",
		32 => "001100",
		33 => "001011",
		34 => "001010",
		35 => "001001",
		36 => "000111",
		37 => "000110",
		38 => "000101",
		39 => "000100",
		40 => "000010",
		41 => "000001",
		42 => "000000",
		43 => "111111",
		44 => "111101",
		45 => "111100",
		46 => "111011",
		47 => "111010",
		48 => "010010",
		49 => "010001",
		50 => "010000",
		51 => "001111",
		52 => "001101",
		53 => "001100",
		54 => "001011",
		55 => "001010",
		56 => "001000",
		57 => "000111",
		58 => "000110",
		59 => "000101",
		60 => "000011",
		61 => "000010",
		62 => "000001",
		63 => "000000"
	);
	
	signal counter	: integer range 0 to 4096;
	signal phase	: unsigned (20 downto 0) := (others=>'0');

	signal y			: unsigned (5 downto 0);	
	signal u			: unsigned (5 downto 0);
	signal v			: unsigned (5 downto 0);
	
	signal uv		: unsigned (5 downto 0);
	
begin
	
	process (clk)
	begin
		if rising_edge(clk) then
			phase <= phase+117286;
		end if;
	end process;

	process (clk, sync, line_visible)
	begin
		if rising_edge(clk) then
			if sync='0' then
				counter <= 0;
			else
				if line_visible='1' then
					counter <= counter+1;
				end if;
			end if;
		end if;
	end process;
	
	process (clk,counter,color,y_table,u_table,v_table)
	begin
		if rising_edge(clk) then
			-- color burst
			if counter>=2*29 and counter<2*(29+72) then
				-- black
				y	<= "000000";
				-- reference phase
				u	<= "111000";
				v	<= "000000";
				
			-- visible pixels
			elsif counter>=2*(29+72+85) and counter<2*(29+72+85+1664) then
				y	<= y_table(to_integer(unsigned(color)));
				u	<= u_table(to_integer(unsigned(color)));
				v	<= v_table(to_integer(unsigned(color)));
				
			-- front porch, sync and back porch
			else
				y	<= (others=>'0');
				u	<= (others=>'0');
				v	<= (others=>'0');
			end if;
		end if;
	end process;

	process (phase, u, v)
	begin
		case phase(20 downto 19) is
		when "00"	=> uv <= u;
		when "01"	=> uv <= 0-v;
		when "10"	=> uv <= 0-u;
		when "11"	=> uv <= v;
		when others	=> uv <= (others=>'0');
		end case;
	end process;
	
	process (clk,sync,y,uv)
	begin
		if rising_edge(clk) then
			output <= std_logic_vector(("0"&sync&"0000")+y+uv);
		end if;
	end process;
	
end Behavioral;

