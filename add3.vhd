library  ieee; 
use  ieee.std_logic_1164.all;

entity add3 is
	port (	Num : in std_logic_vector(3 downto 0);
				Sum : out std_logic_vector(3 downto 0)
		  );  
end add3;

architecture sum_estru of add3 is
begin
	
	Sum <=	Num when Num = "0000" else
				Num when Num = "0001" else
				Num when Num = "0010" else
				Num when Num = "0011" else
				Num when Num = "0100" else
			"1000" when Num = "0101" else
			"1001" when Num = "0110" else
			"1010" when Num = "0111" else
			"1011" when Num = "1000" else
			"1100";
	
end sum_estru;