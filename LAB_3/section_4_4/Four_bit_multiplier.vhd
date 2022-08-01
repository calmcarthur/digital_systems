library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_multiplier is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			HEX0,HEX1,HEX2,HEX3: out std_logic_vector(6 downto 0) -- HEX's
			); 
end entity Four_bit_multiplier; 

architecture main of Four_bit_multiplier is 
signal d0, d1, d2, d3, d4, d5, d6, d7: std_logic;
signal mul1_0, mul1_1, mul1_2, mul1_3: std_logic;
signal mul2_0, mul2_1, mul2_2, mul2_3: std_logic;
signal a0, a1, a2, a3: 		std_logic;
signal b0, b1, b2, b3: 		std_logic;

component Four_bits_adder is 
	port (x3, x2, x1, x0: 					in std_logic;
			y3, y2, y1, y0: 					in std_logic;
			cout_4, s_3, s_2, s_1, s_0:	 out std_logic); 
end component; 

component seven_segment is
	port (data_in:		in std_logic_vector(3 downto 0);
			blanking:		in std_logic;						
			segments_out: 	out std_logic_vector(6 downto 0) );
end component;

begin
a0 <= SW(0); 
a1 <= SW(1); 
a2 <= SW(2); 
a3 <= SW(3); 
b0 <= SW(4); 
b1 <= SW(5); 
b2 <= SW(6); 
b3 <= SW(7); 

d0 <= a0 and b0;
component_1: entity work.Four_bits_adder(main) port map('0', (a0 and b3), (a0 and b2), (a0 and b1), (a1 and b3), (a1 and b2), (a1 and b1), (a1 and b0), mul1_3, mul1_2, mul1_1, mul1_0, d1);
component_2: entity work.Four_bits_adder(main) port map(mul1_3, mul1_2, mul1_1, mul1_0, (a2 and b3), (a2 and b2), (a2 and b1), (a2 and b0), mul2_3, mul2_2, mul2_1, mul2_0, d2);
component_3: entity work.Four_bits_adder(main) port map(mul2_3, mul2_2, mul2_1, mul2_0, (b3 and a3), (a3 and b2), (a3 and b1), (a3 and b0), d7, d6, d5, d4, d3);

hex0_inst: entity work.seven_segment(behavioral) port map((d3 & d2 & d1 & d0), '0', HEX0);
hex1_inst: entity work.seven_segment(behavioral) port map((d7 & d6 & d5 & d4), '0', HEX1);
hex2_inst: entity work.seven_segment(behavioral) port map((a3 & a2 & a1 & a0), '0', HEX2);
hex3_inst: entity work.seven_segment(behavioral) port map((b3 & b2 & b1 & b0), '0', HEX3);
end architecture main; 