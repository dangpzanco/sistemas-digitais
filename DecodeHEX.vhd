library IEEE;
use IEEE.Std_Logic_1164.all;
entity DecodeHEX is
port (I: in std_logic_vector(3 downto 0);
      O: out std_logic_vector(0 to 6)
     );
end DecodeHEX;
architecture DEC_estr of DecodeHEX is
begin 
  O <=   "0000001" when I = "0000" else
			"1001111" when I = "0001" else
			"0010010" when I = "0010" else
			"0000110" when I = "0011" else
			"1001100" when I = "0100" else
			"0100100" when I = "0101" else
			"0100000" when I = "0110" else
			"0001111" when I = "0111" else
			"0000000" when I = "1000" else
			"0001100" when I = "1001" else
			"0001000" when I = "1010" else
			"1100000" when I = "1011" else
			"0110001" when I = "1100" else
			"1000010" when I = "1101" else
			"0110000" when I = "1110" else
			"0111000";
end DEC_estr;