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