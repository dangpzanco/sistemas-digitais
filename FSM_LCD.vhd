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

        P0: process (Clock, Reset)
				begin
					if reset = '0' then
						CA <= C0;
					elsif clock'event and clock = '1' then
						case CA is
							when C0 =>
								delay <= (others => '0');
								CA <= C1;
							when C1 =>
								delay <= delay + 1;
								CA <= C2;
							when C2 =>
								if delay <= "11110" then --30 cycles = 600ns
									EA <= PE;
									CA <= C0;
								else
									CA <= C1;
								end if;
								
								
					end if;
				end process;
					

        P1: process (Clock, RST, Sign, Operation, Delay) 
                begin 
                        -- não esquecer do end if;
                        if Reset = '0' then 
                                EA <= S0;
                        elsif Clock'event and Clock = '1' then                         
                                case EA is

end FSM_beh;

