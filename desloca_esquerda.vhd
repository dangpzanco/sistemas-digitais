library ieee;
use ieee.std_logic_1164.all;
entity desloca_esquerda is port (
      CLK, RST, EN: in std_logic;
		sr_in: in std_logic_vector(7 downto 0);
		sr_out: out std_logic_vector(7 downto 0)
		);
end desloca_esquerda;
architecture behv of desloca_esquerda is
	signal sr: std_logic_vector(7 downto 0);
begin
	process(CLK, EN, sr_in) 
	begin 
		if RST = '0' then
			sr <= (others => '0');
		elsif (CLK'event and CLK = '1') then 
			if EN = '1' then
				sr(7 downto 1) <= sr_in(6 downto 0);
				sr(0) <= '0';
			end if;
		end if;
	end process;
	sr_out <= sr;
end behv;