library IEEE;
use IEEE.Std_Logic_1164.all;

entity C2_OU is
port (A: in std_logic_vector(7 downto 0);
      B: in std_logic_vector(7 downto 0);
      F: out std_logic_vector(7 downto 0)
     );
end C2_OU;

architecture c2_estr of C2_OU is
begin 
  F <= A or B;
end c2_estr;