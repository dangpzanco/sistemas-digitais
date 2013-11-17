library  ieee; 
use  ieee.std_logic_1164.all;

entity B2A is
  port (	D : in std_logic_vector(3 downto 0);
         A : out std_logic_vector(7 downto 0)
		  );
end B2A;

architecture b2a_stru of B2A is
	begin
		A <= "0011" & D;
end b2a_stru;
	
	