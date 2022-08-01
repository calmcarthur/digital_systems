library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scrolling_message is 
	port(CLOCK_50_B5B:	in  std_logic ;
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity scrolling_message; 

architecture main of scrolling_message is
signal col_driver: std_logic_vector(0 to 7) := "01111111";
signal row_driver: std_logic_vector(0 to 7) := "10000000";

signal counter: unsigned(2 downto 0); 

signal counter_1000_hz: unsigned(21 downto 0);
signal clock_1000_hz: std_logic := '1';

signal counter_10_hz: unsigned(21 downto 0);
signal clock_10_hz: std_logic := '1';

signal counter_8: unsigned(2 downto 0);
signal clock_8: std_logic := '1';

signal curr_letter: std_logic_vector(0 to 47);
signal letter_counter: unsigned(0 to 3) := "0101";
signal row_display: std_logic_vector(0 to 63);
signal row_bits: std_logic_vector(0 to 47);

constant message_length: integer := 23; -- This is the length of the string
constant message: string(1 to message_length) := "CAL AND DYLAN DOMINATE ";

signal one_char: character := ' ';
signal integer_one_char: integer;
signal ascii: std_logic_vector(6 downto 0); -- ASCII code
signal char_pntr: unsigned(5 downto 0) := "000001"; -- Pointing to first character

begin
one_char <= message(to_integer(char_pntr)); -- character type
integer_one_char <= character'pos(one_char); -- integer type
ascii <= std_logic_vector(to_unsigned(integer_one_char, 7)); -- std_logic_vector

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
			
			if counter_8 = to_unsigned(1, 3) then
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

col_driver <= col_driver(1 to 7) & col_driver(0) when rising_edge(clock_1000_hz);
row_display <= curr_letter(0 to 7) & row_display(0 to 55) when rising_edge(clock_8);

change_curr_letter: process(clock_8)
begin
if rising_edge(clock_8) then
	if letter_counter = to_unsigned(4, 4) then
		if to_integer(char_pntr) = message_length then
			char_pntr <= to_unsigned(1, 6);
		else
			char_pntr <= char_pntr + 1;
		end if;
	end if;

	if letter_counter = to_unsigned(5, 4) then
		letter_counter <= to_unsigned(0, 4);
		curr_letter <= row_bits;
	else
		letter_counter <= letter_counter + 1;
		curr_letter <= curr_letter(8 to 47) & curr_letter(0 to 7);
	end if;
end if;
end process;

stat_g_row: process(clock_1000_hz)
begin
if rising_edge(clock_1000_hz) then
case counter is
	when to_unsigned(7, 3) =>
		row_driver <= row_display(0 to 7);
	when to_unsigned(6, 3) => 
		row_driver <= row_display(8 to 15);
	when to_unsigned(5, 3) =>
		row_driver <= row_display(16 to 23);
	when to_unsigned(4, 3) =>
		row_driver <= row_display(24 to 31);
	when to_unsigned(3, 3) =>
		row_driver <= row_display(32 to 39);
	when to_unsigned(2, 3) =>
		row_driver <= row_display(40 to 47);
	when to_unsigned(1, 3) =>
		row_driver <= row_display(48 to 55);
	when to_unsigned(0, 3) =>
		row_driver <= row_display(56 to 63);
end case;
		counter <= counter + 1;
end if;
end process;

row_bits <= "011111101001000010010000100100000111111000000000" when ascii = "1000001" else -- A (0x41)
				"111111101001001010010010100100100110110000000000"	when ascii = "1000010" else -- B (0x42)
				"011111001000001010000010100000100100010000000000"	when ascii = "1000011" else -- C (0x43)
				"111111101000001010000010100000100111110000000000"	when ascii = "1000100" else -- D (0x44)
				"111111101001001010010010100100101000001000000000"	when ascii = "1000101" else -- E (0x45)
				"111111101001000010010000100100001000000000000000"	when ascii = "1000110" else -- F (0x46)
				"011111001000001010001010100010100100111000000000"	when ascii = "1000111" else -- G (0x47)
				"111111100001000000010000000100001111111000000000"	when ascii = "1001000" else -- H (0x48)
				"000000001000001011111110100000100000000000000000"	when ascii = "1001001" else -- I (0x49)
				"000001000000001000000010000000101111110000000000"	when ascii = "1001010" else -- J (0x4A)
				"111111100001000000101000010001001000001000000000"	when ascii = "1001011" else -- K (0x4B)
				"111111100000001000000010000000100000001000000000"	when ascii = "1001100" else -- L (0x4C)
				"111111100100000000110000010000001111111000000000"	when ascii = "1001101" else -- M (0x4D)
				"111111100010000000010000000010001111111000000000"	when ascii = "1001110" else -- N (0x4E)
				"011111001000001010000010100000100111110000000000"	when ascii = "1001111" else -- O (0x4F)
				"111111101000100010001000100010000111000000000000"	when ascii = "1010000" else -- P (0x50)
				"011111001000001010001010100001000111101000000000"	when ascii = "1010001" else -- Q (0x51)
				"111111101001000010011000100101000110001000000000"	when ascii = "1010010" else -- R (0x52)
				"011001001001001010010010100100100100110000000000"	when ascii = "1010011" else -- S (0x53)
				"100000001000000011111110100000001000000000000000"	when ascii = "1010100" else -- T (0x54)
				"111111000000001000000010000000101111110000000000"	when ascii = "1010101" else -- U (0x55)
				"111110000000010000000010000001001111100000000000"	when ascii = "1010110" else -- V (0x56)
				"111111100000010000011000000001001111111000000000"	when ascii = "1010111" else -- W (0x57)
				"110001100010100000010000001010001100011000000000"	when ascii = "1011000" else -- X (0x58)
				"110000000010000000011110001000001100000000000000"	when ascii = "1011001" else -- Y (0x59)
				"100001101000101010010010101000101100001000000000"	when ascii = "1011010" else -- Z (0x5A)
				"011111001000101010010010101000100111110000000000"	when ascii = "0110000" else -- 0 (0x30)
				"000000000100001011111110000000100000000000000000"	when ascii = "0110001" else -- 1 (0x31)
				"010001101000101010010010100100100110000000000000"	when ascii = "0110010" else -- 2 (0x32)
				"010001001000001010010010100100100110110000000000"	when ascii = "0110011" else -- 3 (0x33)
				"000110000010100001001000111111100000100000000000"	when ascii = "0110100" else -- 4 (0x34)
				"111001001010001010100010101000101001110000000000"	when ascii = "0110101" else -- 5 (0x35)
				"001111000101001010010010100100101000110000000000"	when ascii = "0110110" else -- 6 (0x36)
				"100000001000111010010000101000001100000000000000"	when ascii = "0110111" else -- 7 (0x37)
				"011011001001001010010010100100100110110000000000"	when ascii = "0111000" else -- 8 (0x38)
				"011001001001001010010010100100100111110000000000"	when ascii = "0111001" else -- 9 (0x39)
				"000000000000000000000000000000000000000000000000"	when ascii = "0100000" else -- Blank (0x20)
				"000100000001000000010000000100000001000000000000"	when ascii = "0101101" else -- Dash (0x2D)
				"100100101001001010010010100100101001001000000000"; 							-- Error 

GPIO( 0) <= row_driver(7);	GPIO( 1) <= row_driver(7); 	-- Pin connections between GPIO port and the PCB 
GPIO( 2) <= row_driver(6);	GPIO( 3) <= row_driver(6); 
GPIO( 4) <= row_driver(5);	GPIO( 5) <= row_driver(5); 
GPIO( 6) <= row_driver(4);	GPIO( 7) <= row_driver(4); 
GPIO( 8) <= row_driver(3);	GPIO( 9) <= row_driver(3); 
GPIO(10) <= row_driver(2);	GPIO(11) <= row_driver(2); 
GPIO(12) <= row_driver(1);	GPIO(13) <= row_driver(1); 
GPIO(14) <= row_driver(0);	GPIO(15) <= row_driver(0); 

GPIO(20) <= col_driver(0);	GPIO(21) <= col_driver(0); 
GPIO(22) <= col_driver(1);	GPIO(23) <= col_driver(1); 
GPIO(24) <= col_driver(2);	GPIO(25) <= col_driver(2); 
GPIO(26) <= col_driver(3);	GPIO(27) <= col_driver(3); 
GPIO(28) <= col_driver(4);	GPIO(29) <= col_driver(4); 
GPIO(30) <= col_driver(5);	GPIO(31) <= col_driver(5); 
GPIO(32) <= col_driver(6);	GPIO(33) <= col_driver(6); 
GPIO(34) <= col_driver(7);	GPIO(35) <= col_driver(7);
end architecture main; 
