library  ieee; 
use  ieee.std_logic_1164.all;

entity topocalc is
  port ( SW : IN STD_LOGIC_VECTOR(17 downto 0);
         HEX0, HEX1: out std_logic_vector(0 to 6);
         LEDR : OUT STD_LOGIC_VECTOR(7 downto 0);
			KEY : IN STD_LOGIC_VECTOR(1 downto 0);
			CLOCK_50 : IN STD_logic
  );
end topocalc;

architecture topo_estru of topocalc is
	signal EN: std_logic_vector (1 downto 0);
	signal S: std_logic_vector (1 downto 0);
	signal X: std_logic_vector (17 downto 0);

	component minitopo
	port ( CHAVE : IN STD_LOGIC_VECTOR(17 downto 0);
			HEXA0, HEXA1: out std_logic_vector(0 to 6);
         LEDRED : OUT STD_LOGIC_VECTOR(7 downto 0);
			BOTAO : IN STD_LOGIC_VECTOR(1 downto 0);
			CLOK : IN STD_logic
			);
	end component;

	component FSM
	port ( 
			Clk, Rst, Enter : in std_logic; 
			Operacao: in std_logic_vector(1 downto 0); 
			Sel: out std_logic_vector(1 downto 0); 
			Enable_1, Enable_2: out std_logic 
			);
	end component;

begin
	X <= S & "00000000" & SW(7 downto 0);
	
	L1: FSM port map 
	(CLOCK_50, KEY(0), KEY(1), SW(17 downto 16), S, EN(0), EN(1));
	
	L2: minitopo port map 
	(X, HEX0(0 to 6), HEX1(0 to 6), LEDR(7 downto 0), EN(1 downto 0), CLOCK_50);

end topo_estru;
