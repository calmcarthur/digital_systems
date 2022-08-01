library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scrolling_g is 
	port(CLOCK_50_B5B:	in  std_logic ;
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity scrolling_g; 

architecture main of scrolling_g is
signal col_driver: std_logic_vector(0 to 7) := "01111111";
signal row_driver: std_logic_vector(0 to 7) := "10000000";

signal counter: unsigned(2 downto 0); 

signal counter_1000_hz: unsigned(21 downto 0);
signal clock_1000_hz: std_logic := '1';

signal counter_10_hz: unsigned(21 downto 0);
signal clock_10_hz: std_logic := '1';

signal counter_8: unsigned(2 downto 0);
signal clock_8: std_logic := '1';

signal row_display: std_logic_vector(0 to 63) := "0111110010000010100010101000101001001110000000000000000000000000";

begin

counting_1000_hz: process (CLOCK_50_B5B)
begin	
	if rising_edge(CLOCK_50_B5B) then
		if counter_1000_hz = to_unsigned(24999, 22) then
			counter_1000_hz <= to_unsigned(0, 22);
			clock_1000_hz <= not clock_1000_hz;
		else
			counter_1000_hz <= counter_1000_hz + 1;
	end if;
end if;
end process;

counting_10: process (CLOCK_50_B5B)
begin	
	if rising_edge(CLOCK_50_B5B) then
		if counter_10_hz = to_unsigned(2499999, 22) then
			counter_10_hz <= to_unsigned(0, 22);
			clock_10_hz <= not clock_10_hz;
			
			if counter_8 = to_unsigned(3, 3) then
				clock_8 <= not clock_8;
				counter_8 <= to_unsigned(0, 3);
			else
				counter_8 <= counter_8 + 1;
			end if;
			
		else
			counter_10_hz <= counter_10_hz + 1;
	end if;
end if;
end process;

col_driver <= col_driver(7) & col_driver(0 to 6) when rising_edge(clock_1000_hz);
row_display <= row_display(8 to 63) & row_display(0 to 7) when rising_edge(clock_8);

stat_g_row: process(clock_1000_hz)
begin
if rising_edge(clock_1000_hz) then
case counter is
	when to_unsigned(0, 3) =>
		row_driver <= row_display(0 to 7);
	when to_unsigned(1, 3) => 
		row_driver <= row_display(8 to 15);
	when to_unsigned(2, 3) =>
		row_driver <= row_display(16 to 23);
	when to_unsigned(3, 3) =>
		row_driver <= row_display(24 to 31);
	when to_unsigned(4, 3) =>
		row_driver <= row_display(32 to 39);
	when to_unsigned(5, 3) =>
		row_driver <= row_display(40 to 47);
	when to_unsigned(6, 3) =>
		row_driver <= row_display(48 to 55);
	when to_unsigned(7, 3) =>
		row_driver <= row_display(56 to 63);
end case;
		counter <= counter + 1;
end if;
end process;

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
