library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity final_submission is 
	port(CLOCK_50_B5B:	in  std_logic ;
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity final_submission; 

architecture main of final_submission is
signal col_driver: std_logic_vector(0 to 7) := "01111111";
signal row_driver: std_logic_vector(0 to 7) := "10000000";

signal counter_10_hz: unsigned(21 downto 0);
signal clock_10_hz: std_logic := '1';

signal counter_8: unsigned(2 downto 0);
signal clock_8: std_logic := '1';

begin

counting_10: process (CLOCK_50_B5B)
begin	
	if rising_edge(CLOCK_50_B5B) then
		if counter_10_hz = to_unsigned(2499999, 22) then
			counter_10_hz <= to_unsigned(0, 22);
			clock_10_hz <= not clock_10_hz;
			counter_8 <= counter_8 + 1;
			
			if counter_8 = to_unsigned(7, 3) then
				clock_8 <= not clock_8;
			end if;
			
		else
			counter_10_hz <= counter_10_hz + 1;
	end if;
end if;
end process;

col_driver <= col_driver(7) & col_driver(0 to 6) when rising_edge(clock_10_hz);
row_driver <= row_driver(7) & row_driver(0 to 6) when rising_edge(clock_8);

GPIO( 0) <= row_driver(0);	GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
GPIO( 2) <= row_driver(1);	GPIO( 3) <= row_driver(1); 
GPIO( 4) <= row_driver(2);	GPIO( 5) <= row_driver(2); 
GPIO( 6) <= row_driver(3);	GPIO( 7) <= row_driver(3); 
GPIO( 8) <= row_driver(4);	GPIO( 9) <= row_driver(4); 
GPIO(10) <= row_driver(5);	GPIO(11) <= row_driver(5); 
GPIO(12) <= row_driver(6);	GPIO(13) <= row_driver(6); 
GPIO(14) <= row_driver(7);	GPIO(15) <= row_driver(7); 

GPIO(20) <= col_driver(0);	GPIO(21) <= col_driver(0); 
GPIO(22) <= col_driver(1);	GPIO(23) <= col_driver(1); 
GPIO(24) <= col_driver(2);	GPIO(25) <= col_driver(2); 
GPIO(26) <= col_driver(3);	GPIO(27) <= col_driver(3); 
GPIO(28) <= col_driver(4);	GPIO(29) <= col_driver(4); 
GPIO(30) <= col_driver(5);	GPIO(31) <= col_driver(5); 
GPIO(32) <= col_driver(6);	GPIO(33) <= col_driver(6); 
GPIO(34) <= col_driver(7);	GPIO(35) <= col_driver(7);

end architecture main; 
