library ieee;
use ieee.std_logic_1164.all;
-- somador completo (fulladder)
entity fulladder is
	port (a, b, c: in std_logic;
			soma, carry: out std_logic);
	end fulladder;
architecture fulladder_beh of fulladder is
begin
	soma <= (a xor b) xor c;
	carry <= b when ((a xor b) = '0') 
				else c;
end fulladder_beh;
