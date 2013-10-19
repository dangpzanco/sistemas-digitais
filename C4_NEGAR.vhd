library IEEE;
use IEEE.Std_Logic_1164.all;

entity C4_NEGAR is
port (A: in std_logic_vector(7 downto 0);
      F: out std_logic_vector(7 downto 0)
     );
end C4_NEGAR;

architecture c4_estr of C4_NEGAR is
begin 
  F <= not A;
end c4_estr;