library  ieee; 
use  ieee.std_logic_1164.all;

--D = ENTRADA NUMERICA
--U = UNITS
--T = TENS
--H = HUNDREDS

entity bin2bcd is
  port (	CLK, RST: in std_logic;
			D       : in std_logic_vector(7 downto 0);
         U, T, H : out std_logic_vector(3 downto 0)
		  );
end bin2bcd;

architecture bin_estru of bin2bcd is
	signal S1, S2, S3, S4, S5, S6, S7: std_logic_vector(3 downto 0);
	signal X1, X2, X3, X4, X5, X6, X7: std_logic_vector(3 downto 0);

	component add3
	port (	Num : in std_logic_vector(3 downto 0);
				Sum : out std_logic_vector(3 downto 0)
		  );
	end component;

begin
	X1 <= '0' & D(7 downto 5);
	X2 <= S1(2 downto 0) & D(4);
	X3 <= S2(2 downto 0) & D(3);
	X4 <= S3(2 downto 0) & D(2);
	X5 <= S4(2 downto 0) & D(1);
	X6 <= '0' & S1(3) & S2(3) & S3(3);
	X7 <= S6(2 downto 0) & S4(3);
	
	C1: add3 port map (X1, S1);
	
	C2: add3 port map (X2, S2);
	
	C3: add3 port map (X3, S3);
	
	C4: add3 port map (X4, S4);
	
	C5: add3 port map (X5, S5);
	
	C6: add3 port map (X6, S6);
	
	C7: add3 port map (X7, S7);
	
	U <= S5(2 downto 0) & D(0);
	T <= S7(2 downto 0) & S5(3);
	H <= "00" & S6(3) & S7(3);
	
end bin_estru;