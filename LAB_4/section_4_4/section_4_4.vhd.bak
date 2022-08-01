library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prelab_q1 is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			CLOCK_50_B5B: in std_logic			
			); 
end entity prelab_q1; 

architecture main of prelab_q1 is 
signal counter:			unsigned(24 downto 0);
signal clock_1_hz:  		std_logic;

begin

	counting: process (CLOCK_50_B5B)
	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = to_unsigned(24999999, 25) then 
				counter <= to_unsigned(0, 25);
				clock_1_hz <= not clock_1_hz;
				LEDG(0) <= clock_1_hz;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

end architecture main;