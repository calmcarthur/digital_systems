-- half adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Half_adder is 
	port (x, y: 			in std_logic; 
			Sum, Carry: 	out std_logic); 
end entity; 

architecture RTL of Half_adder is 
begin 
Sum <= x xor y; 
Carry <= x and y; 
end architecture; 

-- full adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Full_adder is 
	port (x, y, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end entity; 

architecture RTL of Full_adder is 
signal s_1, cout_1: std_logic; 
signal s_2, cout_2: std_logic; 

component Half_adder is 
	port (a, b: 	in  std_logic; 
			S, C: 	out std_logic); 
end component; 

begin 
component_1: entity work.Half_adder(RTL) port map(x, y, s_1, cout_1); 
component_2: entity work.Half_adder(RTL) port map(s_1, cin, s_2, cout_2); 
s <= s_2; 
cout <= cout_1 or cout_2; 
end architecture; 

-- seven segment
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment is port(
			data_in:		in std_logic_vector(3 downto 0);	
			blanking:		in std_logic;						
			segments_out: 	out std_logic_vector(6 downto 0) );	
end entity seven_segment;

architecture behavioral of seven_segment is

begin
		with blanking & data_in select
		segments_out(6 downto 0) <=	"1000000" when "00000",		-- 0
												"1111001" when "00001",		-- 1
												"0100100" when "00010", 	-- 2
												"0110000" when "00011", 	-- 3
												"0011001" when "00100", 	-- 4
												"0010010" when "00101", 	-- 5
												"0000010" when "00110", 	-- 6
												"1111000" when "00111", 	-- 7
												"0000000" when "01000", 	-- 8
												"0010000" when "01001", 	-- 9
												"0001000" when "01010", 	-- A
												"0000011" when "01011", 	-- B
												"1000110" when "01100", 	-- C
												"0100001" when "01101", 	-- D
												"0000110" when "01110", 	-- E
												"0001110" when "01111", 	-- F
												"1111111" when others; 		-- Blanking

end architecture behavioral;

-- four bit adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bits_adder is 
	port (x3, x2, x1, x0: 					in std_logic;
			y3, y2, y1, y0: 					in std_logic;
			cout_4, s_3, s_2, s_1, s_0:	 out std_logic); 
end entity Four_bits_adder; 

architecture main of Four_bits_adder is 
signal cout_1, cout_2, cout_3: 			std_logic; 

component Full_adder is 
	port (a, b, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin 

component_1: entity work.Full_adder(RTL) port map(x0, y0, '0', s_0, cout_1);
component_2: entity work.Full_adder(RTL) port map(x1, y1, cout_1, s_1, cout_2);
component_3: entity work.Full_adder(RTL) port map(x2, y2, cout_2, s_2, cout_3);
component_4: entity work.Full_adder(RTL) port map(x3, y3, cout_3, s_3, cout_4);
end architecture main; 

-- four bit multiplier
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_multiplier is 
	port (a3, a2, a1, a0: 	in							std_logic;
			b3, b2, b1, b0: 	in							std_logic;
			d7, d6, d5, d4, d3, d2, d1, d0: out 	std_logic); 
end entity Four_bit_multiplier; 

architecture main of Four_bit_multiplier is 
signal mul1_0, mul1_1, mul1_2, mul1_3: std_logic;
signal mul2_0, mul2_1, mul2_2, mul2_3: std_logic;

component Four_bits_adder is 
	port (x3, x2, x1, x0: 					in std_logic;
			y3, y2, y1, y0: 					in std_logic;
			cout_4, s_3, s_2, s_1, s_0:	 out std_logic); 
end component; 

begin

d0 <= a0 and b0;
component_1: entity work.Four_bits_adder(main) port map('0', (a0 and b3), (a0 and b2), (a0 and b1), (a1 and b3), (a1 and b2), (a1 and b1), (a1 and b0), mul1_3, mul1_2, mul1_1, mul1_0, d1);
component_2: entity work.Four_bits_adder(main) port map(mul1_3, mul1_2, mul1_1, mul1_0, (a2 and b3), (a2 and b2), (a2 and b1), (a2 and b0), mul2_3, mul2_2, mul2_1, mul2_0, d2);
component_3: entity work.Four_bits_adder(main) port map(mul2_3, mul2_2, mul2_1, mul2_0, (b3 and a3), (a3 and b2), (a3 and b1), (a3 and b0), d7, d6, d5, d4, d3);
end architecture main; 

-- section_4_5

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity section_4_5 is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			HEX0,HEX1,HEX2,HEX3: out std_logic_vector(6 downto 0) -- HEX's
			); 
end entity section_4_5; 

architecture main of section_4_5 is 
signal o0, o1, o2, o3, o4, o5, o6, o7: std_logic;
signal u0, u1, u2, u3: 		std_logic;
signal v0, v1, v2, v3: 		std_logic;
signal is_sum:					std_logic;
signal pro7, pro6, pro5, pro4, pro3, pro2, pro1, pro0: std_logic;
signal sum4, sum3, sum2, sum1, sum0: std_logic;

component Four_bits_adder is 
	port (x3, x2, x1, x0: 					in std_logic;
			y3, y2, y1, y0: 					in std_logic;
			cout_4, s_3, s_2, s_1, s_0:	 out std_logic); 
end component; 

component Four_bit_multiplier is 
	port (a3, a2, a1, a0: 	in							std_logic;
			b3, b2, b1, b0: 	in							std_logic;
			d7, d6, d5, d4, d3, d2, d1, d0: out 	std_logic); 
end component;

component seven_segment is
	port (data_in:		in std_logic_vector(3 downto 0);
			blanking:		in std_logic;						
			segments_out: 	out std_logic_vector(6 downto 0) );
end component;

begin
u0 <= SW(0); 
u1 <= SW(1); 
u2 <= SW(2); 
u3 <= SW(3); 
v0 <= SW(4); 
v1 <= SW(5); 
v2 <= SW(6); 
v3 <= SW(7); 
is_sum <= SW(8);

component_1: entity work.Four_bits_adder(main) port map(u3, u2, u1, u0, v3, v2, v1, v0, sum4, sum3, sum2, sum1, sum0);
component_2: entity work.Four_bit_multiplier(main) port map(u3, u2, u1, u0, v3, v2, v1, v0, pro7, pro6, pro5, pro4, pro3, pro2, pro1, pro0);

process (is_sum)
	begin
		if (is_sum = '1') then
			o7 <= '0';
			o6 <= '0';
			o5 <= '0';
			o4 <= sum4;
			o3 <= sum3;
			o2 <= sum2;
			o1 <= sum1;
			o0 <= sum0;
		else
			o7 <= pro7;
			o6 <= pro6;
			o5 <= pro5;
			o4 <= pro4;
			o3 <= pro3;
			o2 <= pro2;
			o1 <= pro1;
			o0 <= pro0;
		end if;
	end process;

hex0_inst: entity work.seven_segment(behavioral) port map((o3 & o2 & o1 & o0), '0', HEX0);
hex1_inst: entity work.seven_segment(behavioral) port map((o7 & o6 & o5 & o4), '0', HEX1);
hex2_inst: entity work.seven_segment(behavioral) port map((u3 & u2 & u1 & u0), '0', HEX2);
hex3_inst: entity work.seven_segment(behavioral) port map((v3 & v2 & v1 & v0), '0', HEX3);
end architecture main; 