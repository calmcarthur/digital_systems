library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity section_4_3 is 
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			CLOCK_50_B5B: in std_logic			
			); 
end entity section_4_3;

architecture main of section_4_3 is 
signal counter:			unsigned(24 downto 0);
signal counter_2:			unsigned(31 downto 0);
signal clock_1_hz:  		std_logic;

begin
	
	counter_2 <= counter_2 + 1 when rising_edge(CLOCK_50_B5B);
	LEDR(0) <= std_logic(counter_2(25));

	counting: process (CLOCK_50_B5B)
	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = to_unsigned(24999999, 25) then 
				counter <= to_unsigned(0, 25);
				clock_1_hz <= not clock_1_hz;
				LEDG(5) <= clock_1_hz;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

end architecture main;