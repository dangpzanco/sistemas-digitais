library IEEE;
use IEEE.Std_Logic_1164.all;

entity muxSIGN is
port (OP1, OP2, OP3: in std_logic;
		s: in std_logic_vector(4 downto 0);
      m: out std_logic
     );
end muxSIGN;

architecture mux_estr of muxSIGN is
begin

	m <= 	OP1	when s = "01100" else
			OP2	when s = "00001" else
			OP3;
			
end mux_estr;