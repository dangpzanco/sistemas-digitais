library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity C1_SOMA is
port (A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
      F: out std_logic_vector(7 downto 0)
     );
end C1_SOMA;

architecture c1_estr of C1_SOMA is
begin 
  F <= A + B;
end c1_estr;