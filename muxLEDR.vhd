library IEEE;
use IEEE.Std_Logic_1164.all;

entity muxLEDR is
port (w, x, y, z: in std_logic_vector(3 downto 0);
		s: in std_logic_vector(1 downto 0);
      m: out std_logic_vector(3 downto 0)
     );
end muxLEDR;

architecture mux_estr of muxLEDR is
begin 

	m <= 	w when s = "00" else
			x when s = "01" else
			y when s = "10" else
			z;
end mux_estr;