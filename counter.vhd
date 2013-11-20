library  ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
  port (	Clock, Reset : in std_logic;
         Fim : out std_logic
		  );
end counter;

architecture counter_behav of counter is
signal count : std_logic_vector(4 downto 0);
	begin
	
		P1: process(clock)
			begin
				if Reset = '1' then
					count <= "00000";
				elsif (clock'event and clock = '1') then
					if count <= "11000" then
						count <= count + 1;
						Fim <= '0';
					else
						count <= "00000";
						Fim <= '1';
					end if;
				end if;
			end process;
			
end counter_behv;
	
	