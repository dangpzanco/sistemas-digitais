library IEEE;
use IEEE.Std_Logic_1164.all;

entity muxsign is
	port (w, x, y: in std_logic;
			selection: in std_logic_vector(4 downto 0);
			m: out std_logic
     );
end muxsign;

architecture mux_estr of muxsign is
	begin 
		m <= 	w when selection = "10011" else
				x when selection = "10100" else
				y when selection = "10101" else
			   '0';
			
end mux_estr;

--- w <= SD0
--- x <= SD1
--- y <= SD2
--- selection <= selection
--- sign <= m