library ieee;
use ieee.std_logic_1164.all;
entity desloca_direita is port (
      CLK, RST, EN: in std_logic;
		sr_in: in std_logic_vector(7 downto 0);
		sr_out: out std_logic_vector(7 downto 0);
		FlagD: out std_logic_vector(3 downto 0)
		);
end desloca_direita;
architecture behv of desloca_direita is
	signal sr: std_logic_vector(7 downto 0);
begin
	process(CLK, EN, sr_in) 
	begin 
		if RST = '0' then
			sr <= (others => '0');
		elsif (CLK'event and CLK = '1') then 
			if EN = '1' then
				sr(6 downto 0) <= sr_in(7 downto 1);
				sr(7) <= '0';
			end if;
		end if;
	end process;
	FlagD(3) <= not (sr(7) or sr(6) or sr(5) or sr(4) or sr(3) or sr(2) or sr(1) or sr(0));
	FlagD(2) <= '0';
	FlagD(1) <= '0';
	FlagD(0) <= sr(7);
	sr_out <= sr;
end behv;