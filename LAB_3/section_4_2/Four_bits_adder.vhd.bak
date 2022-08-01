library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Two_bits_adder is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Two_bits_adder; 

architecture main of Two_bits_adder is 
signal s_1, cout_1: 			std_logic; 
signal s_2, cout_2: 			std_logic; 
signal a0, a1, b0, b1: 		std_logic;

component Full_adder is 
	port (a, b, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin
a0 <= SW(0); 
a1 <= SW(1); 
b0 <= SW(2); 
b1 <= SW(3); 


component_1: entity work.Full_adder(RTL) port map(a0, b0, '0', s_1, cout_1);
component_2: entity work.Full_adder(RTL) port map(a1, b1, cout_1, s_2, cout_2);

LEDR(0) <= s_1; 
LEDR(1) <= s_2;
LEDR(2) <= cout_2;
end architecture main; 