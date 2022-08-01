library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity section_4_5 is
  port (KEY:    in   std_logic_vector(3 downto 0); -- Push buttons
        SW:     in   std_logic_vector(9 downto 0); -- Toggle switches
        LEDR:   out  std_logic_vector(9 downto 0); -- Red LEDs
        LEDG:   out  std_logic_vector(7 downto 0); -- Green LEDs
        HEX0,HEX3: out std_logic_vector(6 downto 0); -- HEX's 
        CLOCK_50_B5B: in std_logic
        );
end entity section_4_5;

architecture main of section_4_5 is
signal counter:	unsigned(4 downto 0);
signal counter_1: unsigned(2 downto 0);
signal counter_10:			unsigned(24 downto 0);
signal clock_1_hz, clock_10_hz:  		std_logic;
signal hex0_output, hex3_output:			unsigned(3 downto 0);

component seven_segment is
  port (data_in:   in std_logic_vector(3 downto 0);
        blanking:    in std_logic;
        segments_out: out std_logic_vector(6 downto 0)); 
end component;

begin

		-- 10hz from 50mhz
		counting_10_hz: process (CLOCK_50_B5B)
		 begin
			  if rising_edge(CLOCK_50_B5B) then
					if counter_10 = to_unsigned(2499999, 25) then
						 counter_10 <= to_unsigned(0, 25);
						 clock_10_hz <= not clock_10_hz;
					else
						 counter_10 <= counter_10 + 1;
					end if;
			  end if;    
		end process;
	
		-- 1hz from 10hz
		counting_1_hz: process (clock_10_hz)
		begin
			  if rising_edge(clock_10_hz) then
					if counter_1 = to_unsigned(5, 3) then
						 counter_1 <= to_unsigned(0, 3);
						 clock_1_hz <= not clock_1_hz;
					else
						 counter_1 <= counter_1 + 1;
					end if;
			  end if;   
		end process;
		
		-- seconds counter
		counting_seconds: process (clock_1_hz)
		begin
        if rising_edge(clock_1_HZ) then		  
				if counter = to_unsigned(21, 5) then
                counter <= to_unsigned(0, 5);
				else
                counter <= counter + 1;

				end if;
			end if;   
		end process;
		
		-- state machine
		state_machine: process (counter)
		begin
			case to_integer(counter) is
				when 0 to 1 => 
					-- NS
					LEDR(0) <= '0';
					LEDG(7) <= clock_10_hz;
					-- EW
					LEDR(4) <= '1';
					LEDG(4) <= '0';
					
					hex3_output <= "0000";
					hex0_output <= counter(3 downto 0) - 0;
					
				when 2 to 6 => 
					-- NS
					LEDR(0) <= '0';
					LEDG(7) <= '1';
					-- EW
					LEDR(4) <= '1';
					LEDG(4) <= '0';
					
					hex3_output <= "0001";
					hex0_output <= counter(3 downto 0) - 2;
					
				when 7 to 9 => 
					-- NS
					LEDR(0) <= clock_10_hz;
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= '1';
					LEDG(4) <= '0';
					
					hex3_output <= "0010";
					hex0_output <= counter(3 downto 0) - 7;		
					
				when 10 => 
					-- NS
					LEDR(0) <= '1';
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= '1';
					LEDG(4) <= '0';
					
					hex3_output <= "0011";
					hex0_output <= counter(3 downto 0) - 10;	
										
				when 11 to 12 => 
					-- NS
					LEDR(0) <= '1';
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= '0';
					LEDG(4) <= clock_10_hz;
					
					hex3_output <= "0100";
					hex0_output <= counter(3 downto 0) - 11;					
					
				when 13 to 17 => 
					-- NS
					LEDR(0) <= '1';
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= '0';
					LEDG(4) <= '1';
					
					hex3_output <= "0101";
					hex0_output <= counter(3 downto 0) - 13;			
					
				when 18 to 20 => 
					-- NS
					LEDR(0) <= '1';
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= clock_10_hz; 
					LEDG(4) <= '0';
					
					hex3_output <= "0110";
					hex0_output <= counter(3 downto 0) - 18;			
					
				when others => 
					-- NS
					LEDR(0) <= '1';
					LEDG(7) <= '0';
					-- EW
					LEDR(4) <= '1';
					LEDG(4) <= '0';
					
					hex3_output <= "0111";
					hex0_output <= counter(3 downto 0) - 21;	
						
			end case;
		end process;

hex3_inst: entity work.seven_segment(behavioral) port map(std_logic_vector(hex3_output), '0', HEX3);
hex0_inst: entity work.seven_segment(behavioral) port map(std_logic_vector(hex0_output), '0', HEX0);

end architecture main;