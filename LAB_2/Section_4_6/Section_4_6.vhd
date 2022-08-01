-- First VHDL code for SYDE-192 Lab 
-- It implements three primitive gates of AND, OR, and NOT (inverter) 

library ieee;					-- Declare that you want to use IEEE libraries 
use ieee.std_logic_1164.all;	-- Library for standard logic circuits 
use ieee.numeric_std.all; 	-- Another useful library for UNSIGNED numbers 

entity Section_4_6 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Section_4_6; 

architecture main of Section_4_6 is  
signal a, b: unsigned (3 downto 0);
signal c: unsigned(4 downto 0);

begin  
a <= unsigned(SW(3 downto 0));
b <= unsigned(SW(9 downto 6));
c <= ('0' & a) + ('0' & b); -- addition syntax is here
LEDG(4 downto 0) <= std_logic_vector(c);
end architecture main; 
			