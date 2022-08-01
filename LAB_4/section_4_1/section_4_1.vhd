library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment is port(
			data_in:		in std_logic_vector(3 downto 0);	
			blanking:		in std_logic;					
			segments_out: 	out std_logic_vector(6 downto 0) );
end entity seven_segment;

architecture behavioral of seven_segment is
begin
		with blanking & data_in select 

		segments_out(6 downto 0) <=	"1000000" when "00000",		-- 0
												"1111001" when "00001",		-- 1
												"0100100" when "00010", 	-- 2
												"0110000" when "00011", 	-- 3
												"0011001" when "00100", 	-- 4
												"0010010" when "00101", 	-- 5
												"0000010" when "00110", 	-- 6
												"1111000" when "00111", 	-- 7
												"0000000" when "01000", 	-- 8
												"0010000" when "01001", 	-- 9
												"0001000" when "01010", 	-- A
												"0000011" when "01011", 	-- B
												"1000110" when "01100", 	-- C
												"0100001" when "01101", 	-- D
												"0000110" when "01110", 	-- E
												"0001110" when "01111", 	-- F
												"1111111" when others; 		-- Blanking

end architecture behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity section_4_1 is
	port (KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			HEX0,HEX1: out std_logic_vector(6 downto 0); -- HEX's
			ClOCK_50_B5B:	in std_logic
			); 
end entity section_4_1; 

architecture main of section_4_1 is 
signal a:		unsigned(4 downto 0);
signal blanking: 	std_logic := '1';
signal num1, num2:		std_logic_vector(3 downto 0);

component seven_segment is
	port (data_in:		in std_logic_vector(3 downto 0);
			blanking:		in std_logic;						
			segments_out: 	out std_logic_vector(6 downto 0) );
end component;

begin
a <= a + 1 when rising_edge(KEY(0));

LEDG(0) <= std_logic(a(0));
LEDG(1) <= std_logic(a(1));
LEDG(2) <= std_logic(a(2));
LEDG(3) <= std_logic(a(3));
LEDG(4) <= std_logic(a(4));

blanking <= not(std_logic(a(4)));
num1 <= std_logic_vector(a(3 downto 0));
num2 <= "000" & std_logic(a(4));

hex0_inst: entity work.seven_segment(behavioral) port map(num1, '0', HEX0);
hex1_inst: entity work.seven_segment(behavioral) port map(num2, blanking, HEX1);

end architecture main; 