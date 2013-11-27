library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity SUBT is
port (A, B: in std_logic_vector(7 downto 0);
		F   : out std_logic_vector(7 downto 0);
		Flag: out std_logic_vector(3 downto 0)
     );
end SUBT;

architecture c1_estr of SUBT is
signal c, Bin, S: std_logic_vector(7 downto 0);

component fulladder
	port (a, b, c: in std_logic;
			soma, carry: out std_logic);
	end component;

begin 
	
	Bin(0) <= B(0) xor '1';
	Bin(1) <= B(1) xor '1';
	Bin(2) <= B(2) xor '1';
	Bin(3) <= B(3) xor '1';
	Bin(4) <= B(4) xor '1';
	Bin(5) <= B(5) xor '1';
	Bin(6) <= B(6) xor '1';
	Bin(7) <= B(7) xor '1';

	A0: fulladder port map (A(0), Bin(0), '1', S(0), c(0));
	
	A1: fulladder port map (A(1), Bin(1), c(0), S(1), c(1));
	
	A2: fulladder port map (A(2), Bin(2), c(1), S(2), c(2));
	
	A3: fulladder port map (A(3), Bin(3), c(2), S(3), c(3));
	
	A4: fulladder port map (A(4), Bin(4), c(3), S(4), c(4));
	
	A5: fulladder port map (A(5), Bin(5), c(4), S(5), c(5));
	
	A6: fulladder port map (A(6), Bin(6), c(5), S(6), c(6));
	
	A7: fulladder port map (A(7), Bin(7), c(6), S(7), c(7));
	
	Flag(3) <= not (S(7) or S(6) or S(5) or S(4) or S(3) or S(2) or S(1) or S(0));
	Flag(2) <= c(7) xor c(6);
	Flag(1) <= c(7);
	Flag(0) <= S(7);
	
	F <= S;
	
end c1_estr;
