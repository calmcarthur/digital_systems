library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bits_adder_led is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Four_bits_adder_led; 

architecture main of Four_bits_adder_led is 
signal s_0, cout_1: 			std_logic; 
signal s_1, cout_2: 			std_logic; 
signal s_2, cout_3: 			std_logic; 
signal s_3, cout_4: 			std_logic; 
signal x0, x1, x2, x3: 		std_logic;
signal y0, y1, y2, y3: 		std_logic;

component Full_adder is 
	port (a, b, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin
x0 <= SW(0); 
x1 <= SW(1); 
x2 <= SW(2); 
x3 <= SW(3); 
y0 <= SW(4); 
y1 <= SW(5); 
y2 <= SW(6); 
y3 <= SW(7); 


component_1: entity work.Full_adder(RTL) port map(x0, y0, '0', s_0, cout_1);
component_2: entity work.Full_adder(RTL) port map(x1, y1, cout_1, s_1, cout_2);
component_3: entity work.Full_adder(RTL) port map(x2, y2, cout_2, s_2, cout_3);
component_4: entity work.Full_adder(RTL) port map(x3, y3, cout_3, s_3, cout_4);

LEDR(0) <= s_0; 
LEDR(1) <= s_1;
LEDR(2) <= s_2;
LEDR(3) <= s_3;
LEDR(4) <= cout_4;
end architecture main; 