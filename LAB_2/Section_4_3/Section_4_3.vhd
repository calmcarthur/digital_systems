library ieee;
use ieee.std_logic_1164.all;

entity Section_4_3 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0);
			SW: 		in 	std_logic_vector(9 downto 0);  
			LEDR:		out 	std_logic_vector(9 downto 0); 
			LEDG:		out 	std_logic_vector(7 downto 0)
			); 
end entity Section_4_3; 

architecture main of Section_4_3 is 
signal a0, a1, b0, b1:				std_logic;	-- Naming inputs 
signal carry_1, carry_2:			std_logic;
signal second_half_adder:			std_logic;

begin 
a0 <= SW(0); 
a1 <= SW(1); 
b0 <= SW(2); 
b1 <= SW(3); 


-- first half adder logic
LEDR(0) <= (a0 xor b0);
carry_1 <= (a0 and b0);

-- second half adder logic
second_half_adder <= (a1 xor b1);
carry_2 <= (a1 and b1);

-- third half adder and final or logic
LEDR(1) <= (second_half_adder xor carry_1);
LEDR(2) <= (second_half_adder and carry_1) or carry_2;
end architecture main; 
			