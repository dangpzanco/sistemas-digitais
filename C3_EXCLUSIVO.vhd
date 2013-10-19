library IEEE;
use IEEE.Std_Logic_1164.all;

entity C3_EXCLUSIVO is
port (A: in std_logic_vector(7 downto 0);
      B: in std_logic_vector(7 downto 0);
      F: out std_logic_vector(7 downto 0)
     );
end C3_EXCLUSIVO;

architecture c3_estr of C3_EXCLUSIVO is
begin 
  F <= A xor B;
end c3_estr;