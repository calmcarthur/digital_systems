library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity section_4_2 is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			CLOCK_50_B5B: in std_logic			
			); 
end entity section_4_2; 

architecture main of section_4_2 is 
signal counter:			unsigned(31 downto 0);

begin
	
	counter <= counter + 1 when rising_edge(CLOCK_50_B5B);
	
	LEDG(7 downto 0) <= std_logic_vector(counter(21 downto 14)); 
	LEDR(9 downto 0) <= std_logic_vector(counter(31 downto 22));

end architecture main;