library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux19x1 is
port (H1, T1, U1, H2, T2, U2, H3, T3, U3, CTRL1, CTRL2, CTRL3: in std_logic_vector(7 downto 0);
		mais, menos, vezes, barra, igual, dois, CTRLf: in std_logic_vector(7 downto 0);
		s: in std_logic_vector(4 downto 0);
      m: out std_logic_vector(7 downto 0)
     );
end mux19x1;

architecture mux_estr of mux19x1 is
begin

	m <= 	H1 	when s = "00000" else
			T1 	when s = "00001" else
			U1 	when s = "00010" else
			H2 	when s = "00011" else
			T2 	when s = "00100" else
			U2 	when s = "00101" else
			H3 	when s = "00110" else
			T3 	when s = "00111" else
			U3 	when s = "01000" else
			CTRL1 when s = "01001" else
			CTRL2 when s = "01010" else
			CTRL3 when s = "01011" else
			mais 	when s = "01100" else
			menos when s = "01101" else
			vezes when s = "01110" else
			barra when s = "01111" else
			igual when s = "10000" else
			dois  when s = "10001" else
			CTRLf;
			
end mux_estr;