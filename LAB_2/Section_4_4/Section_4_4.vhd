-- First VHDL code for SYDE-192 Lab 
-- It implements three primitive gates of AND, OR, and NOT (inverter) 

library ieee;					-- Declare that you want to use IEEE libraries 
use ieee.std_logic_1164.all;	-- Library for standard logic circuits 
-- use ieee.numeric_std.all; 	-- Another useful library for UNSIGNED numbers 

entity Section_4_4 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Section_4_4; 

architecture main of Section_4_4 is 
signal a1, a0, b1, b0:				std_logic;	-- Naming inputs 
signal carry_1:						std_logic;
signal carry_2:						std_logic;
signal second_half_adder:			std_logic;
signal c0, c1, c2:					std_logic;

begin 
a1 <= SW(0); 
a0 <= SW(1); 
b1 <= SW(2); 
b0 <= SW(3); 


-- first half adder logic
LEDR(0) <= (a1 xor a0);
carry_1 <= (a1 and a0);

-- second half adder logic
second_half_adder <= (b1 xor b0);
carry_2 <= (b1 and b0);

-- third half adder and final or logic
LEDR(1) <= (second_half_adder xor carry_1);
LEDR(2) <= (second_half_adder and carry_1) or carry_2;
end architecture main; 
			