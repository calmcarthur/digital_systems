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