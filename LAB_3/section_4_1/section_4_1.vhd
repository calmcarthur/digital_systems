library ieee; 
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all; 	-- Another useful library for UNSIGNED numbers 

entity section_4_1 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity section_4_1; 

architecture main of section_4_1 is 
signal A, B, X, Y:				std_logic;	-- Naming inputs 
signal ENABLE: 					std_logic; 
signal DIRECTION: 				std_logic;

begin 
A <= SW(3); 
B <= SW(2); 
X <= SW(1); 
Y <= SW(0); 

DIRECTION <= ((B or (not Y)) and ((not X) xor A)) nor (A and (not X));
LEDR(0) <= DIRECTION; 

ENABLE <= ((A nor B) or (X nor Y)) nor ((X xnor A) and (B xnor Y));
LEDG(0) <= ENABLE; 

end architecture main; 
			