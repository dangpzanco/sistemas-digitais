library  ieee; 
use  ieee.std_logic_1164.all;

entity minitopo is
  port ( CHAVE : IN STD_LOGIC_VECTOR(17 downto 0);
         HEXA0, HEXA1: out std_logic_vector(0 to 6);
         LEDRED : OUT STD_LOGIC_VECTOR(7 downto 0);
			BOTAO : IN STD_LOGIC_VECTOR(1 downto 0);
			CLOK : IN STD_logic
  );
end minitopo;

architecture topo_estru of minitopo is
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

begin

L1: C1_SOMA port map (CHAVE(7 downto 0), G2(7 downto 0), F1);

L2: C2_OU port map (CHAVE(7 downto 0), G2(7 downto 0), F2);

L3: desloca_esquerda port map (CLOK, BOTAO(0), BOTAO(1), CHAVE(7 downto 0), F3);

L4: desloca_direita port map (CLOK, BOTAO(0), BOTAO(1), CHAVE(7 downto 0), F4);

L5: mux4x1 port map (F1, F2, F3, F4, CHAVE(17 downto 16), F);

R0: flipf port map (CLOK, BOTAO(0), BOTAO(1), CHAVE(7 downto 0), G2(7 downto 0));

R1: flipf port map (CLOK, BOTAO(0), BOTAO(1), F, G1);

 --a sugestão da aula 6 era usar 3 flipflops

R3: flipf port map (CLOK, BOTAO(0), BOTAO(1), F(7 downto 0), LEDRED(7 downto 0));

L6: DecodeHEX port map (G1(3 downto 0), HEXA0);

L7: DecodeHEX port map (G1(7 downto 4), HEXA1);

--LEDRED(7 downto 0) <= F;

end topo_estru;
