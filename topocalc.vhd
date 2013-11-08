library  ieee; 
use  ieee.std_logic_1164.all;

entity topocalc is
  port ( SW : IN STD_LOGIC_VECTOR(17 downto 0);
			KEY : IN STD_LOGIC_VECTOR(1 downto 0);
			CLOCK_50 : IN STD_logic;
         HEX0, HEX1: out std_logic_vector(0 to 6);
         LEDR : OUT STD_LOGIC_VECTOR(7 downto 0)
			
  );
end topocalc;

architecture topo_estru of topocalc is
	signal EN, SEL: std_logic_vector (1 downto 0);
   signal F, F1, F2, F3, F4, G1, G2: std_logic_vector (7 downto 0);
	--signal G1 : std_logic_vector (7 downto 0);

   component C1_SOMA
      port (A: in std_logic_vector(7 downto 0);
            B: in std_logic_vector(7 downto 0);
            F: out std_logic_vector(7 downto 0)
      );
   end component;

   component C2_OU
      port (A: in std_logic_vector(7 downto 0);
            B: in std_logic_vector(7 downto 0);
            F: out std_logic_vector(7 downto 0)
      );
   end component;

   component desloca_esquerda
       port (
			CLK, RST, EN: in std_logic;
			sr_in: in std_logic_vector(7 downto 0);
			sr_out: out std_logic_vector(7 downto 0)
		);
   end component;
	
	component desloca_direita
       port (
			CLK, RST, EN: in std_logic;
			sr_in: in std_logic_vector(7 downto 0);
			sr_out: out std_logic_vector(7 downto 0)
		);
   end component;
	
   component mux4x1
      port (w, x, y, z: in std_logic_vector(7 downto 0);
		      s: in std_logic_vector(1 downto 0);
            m: out std_logic_vector(7 downto 0)
     );
   end component;
	
	component DecodeHEX
	port (I: in std_logic_vector(3 downto 0);
			O: out std_logic_vector(0 to 6)
     );
	end component;
	
	component flipf
	port (CLK, RST, EN: in std_logic;
			D: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
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

	component bin2bcd
	port (CLK, RST: in std_logic;
			D       : in std_logic_vector(7 downto 0);
         U, T, H : out std_logic_vector(3 downto 0)
		   );
	end component;

begin

	L0: FSM port map 
	(CLOCK_50, KEY(0), KEY(1), SW(17 downto 16), SEL, EN(0), EN(1));
	
	L1: C1_SOMA port map (SW(7 downto 0), G2(7 downto 0), F1);

	L2: C2_OU port map (SW(7 downto 0), G2(7 downto 0), F2);

	L3: desloca_esquerda port map (CLOCK_50, KEY(0), KEY(1), SW(7 downto 0), F3);

	L4: desloca_direita port map (CLOCK_50, KEY(0), KEY(1), SW(7 downto 0), F4);

	L5: mux4x1 port map (F1, F2, F3, F4, SEL, F);

	R0: flipf port map (CLOCK_50, KEY(0), EN(0), SW(7 downto 0), G2(7 downto 0));

	R1: flipf port map (CLOCK_50, KEY(0), EN(1), F, G1);

--a sugestão da aula 6 era usar 3 flipflops

	R3: flipf port map (CLOCK_50, KEY(0), EN(1), F(7 downto 0), LEDR(7 downto 0));

	L6: DecodeHEX port map (G1(3 downto 0), HEX0);

	L7: DecodeHEX port map (G1(7 downto 4), HEX1);

--LEDR(7 downto 0) <= F;
	
end topo_estru;
