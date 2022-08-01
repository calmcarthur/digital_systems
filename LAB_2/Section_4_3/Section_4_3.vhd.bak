-- First VHDL code for SYDE-192 Lab 
-- It implements three primitive gates of AND, OR, and NOT (inverter) 

library ieee;					-- Declare that you want to use IEEE libraries 
use ieee.std_logic_1164.all;	-- Library for standard logic circuits 
-- use ieee.numeric_std.all; 	-- Another useful library for UNSIGNED numbers 

entity Section_4_2 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Section_4_2; 

architecture main of Section_4_2 is 
signal a1, a0, b1, b0:			std_logic;	-- Naming inputs 

begin 
a1 <= SW(0); 
a0 <= SW(1); 
b1 <= SW(2); 
b0 <= SW(3); 

-- SW(0), ie. P3
LEDR(0) <= (a1 and b1) and (a0 and b0);
-- SW(1), ie. P2 
LEDR(1) <= (a0 nand b0) and (a1 and b1);
-- SW(2), ie. P1
LEDR(2) <= ((a0 and b1) and (b0 nand a1)) or ((a0 nand b1) and (b0 and a1));
-- SW(3), ie. P0
LEDR(3) <= a0 and b0;
end architecture main; 
			