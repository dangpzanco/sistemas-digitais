library ieee;
use ieee.std_logic_1164.all; 

entity FSM_LCD is 
	port ( 
			Clock, RST, Sign: in std_logic; 
			Operation: in std_logic_vector(4 downto 0); 
			Selection: out std_logic_vector(1 downto 0); 
			RS, EN: out std_logic 
			); 
end FSM_LCD; 

architecture FSM_beh of FSM_LCD is 
	type states is (S0, S1, S2, S3, S4, S5, S6, S7); 
	signal EA: states;
	signal count_reset: std_logic;

component counter
	port (
	Clock, Reset : in std_logic;
	Fim : out std_logic
			);
end component;
	
begin 

	L1: port map counter(Clock, count_reset, Delay)

	P1: process (Clock, RST, Sign, Operation, Delay) 
		begin 
			-- não esquecer do end if;
			if Reset = '0' then 
				EA <= S0; 
			elsif Clock'event and Clock = '1' then 			
				case EA is

end FSM_beh;
