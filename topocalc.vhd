library  ieee; 
use  ieee.std_logic_1164.all;

entity topocalc is
  port ( SW : IN STD_LOGIC_VECTOR(17 downto 0);
                        KEY : IN STD_LOGIC_VECTOR(1 downto 0);
                        CLOCK_50 : IN STD_logic;
         HEX0, HEX1: out std_logic_vector(0 to 6);
         LEDR : OUT STD_LOGIC_VECTOR(3 downto 0);
                        LEDG : OUT STD_LOGIC_VECTOR(7 downto 0);
                        LCD_DATA: OUT SDT_LOGIC_VEECTOR(7 downto 0)
  );
end topocalc;

architecture topo_estru of topocalc is
        signal EN, SEL: std_logic_vector (1 downto 0);  --signal G1 : std_logic_vector (7 downto 0);
   signal F, F1, F2, F3, F4, G1, G2,SD0, SD1, SD2: std_logic_vector (7 downto 0); -- SD0, SD1, SD0 são os fios que irão para os Bin2BCD
        signal sub, sum: std_LOGIC_VECTOR (3 downto 0);
	signal A0, A3, A2, B0, B1, B2, C0, C2, C3: std_logic_vector (3 downto 0); --- fios que vão de B2BCD para os B2A
        signal h1,h2,h3,t1,t2,t3,u1,u2,u3: std_logic_vector (7 downto 0); --- fios dos Ascii para o mux

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
                ); -- a saída Q, vai para o LEDG e também para o bin2bcd. Fazer o que com os fios?
        end component;

   component FSM
        port ( 
                        Clk, Rst, Enter : in std_logic; 
                        Operacao: in std_logic_vector(1 downto 0); 
                        Sel: out std_logic_vector(1 downto 0); 
                        Enable_1, Enable_2: out std_logic 
                        );
        end component;

   component SOMA_SUB
      port (A, B: in std_logic_vector(7 downto 0);
                Sel : in std_logic;
                F   : out std_logic_vector(7 downto 0);
                Zero, Over, Car, Neg: out std_logic
     );
        end component;

   component complemento_2  
        port (entrada: in std_logic_vector(7 downto 0); 
                saida: out std_logic_vector(7 downto 0)
						 );	
		end component; 

   component bin2bcd
        port (CLK, RST: in std_logic;
                        D       : in std_logic_vector(7 downto 0);
         U, T, H : out std_logic_vector(3 downto 0)
                   );
        end component;

   component B2A 
		port (        D : in std_logic_vector(3 downto 0);
					  A : out std_logic_vector(7 downto 0)
                  );
end component;

component mux19x1 
port (H1, T1, U1, H2, T2, U2, H3, T3, U3, CTRL1, CTRL2, CTRL3: in std_logic_vector(7 downto 0);
                mais, menos, vezes, barra, igual, dois, CTRLf: in std_logic_vector(7 downto 0);
															s: in std_logic_vector(4 downto 0);
															m: out std_logic_vector(7 downto 0)
     );
end component;

begin
  
   LEDR <= sub when SW(17 downto 16) = "01" else
           sum when SW(17 downto 16) = "00";
        
		
M0: mux19x1 port map (h1,t1,u1,h2,t2,u2,h3,t3,u3,"00111000","00001110","00000110","00101011","00101100","00101010","00101111","00111101","00110010","00000001", selection , LCD_DATA(7 downto 0)); --Lcd fio de saída para o LCD
		--- selet é a entrada para a seleção do mux, que vem da FSM 2/ deixei o 0EH!!
		
ASCII0: B2A port map (A0,h1); -- vem do BCD 0 vai para o mux19x1          				
		
ASCII1: B2A port map (B0,t1);
		
ASCII2: B2A port map (C0,u1);
		
ASCII3: B2A port map (A1,h2); -- vem do BCD 1 vai para o mux19x1
		
ASCII4: B2A port map (B1,t2);
		
ASCII5: B2A port map (C1,u2);
		
ASCII6: B2A port map (A2,h3); -- vem do BCD 2 vai para o mux19x1
		
ASCII7: B2A port map (B2,t3);
		
ASCII8: B2A port map (C2,u3);
		

Bcd0: bin2bcd port map (CLOCK_50, KEY(0),SD0,A0,B0,C0); -- A, B, C tem 4 bits são saídas para b2A
	
Bcd1: bin2bcd port map (CLOCK_50, KEY(0),SD1,A1,B1,C1);	

Bcd2: bin2bcd port map (CLOCK_50, KEY(0),SD2,A2,B2,C2);
	
		
C0: complemento_2 port map (P,SD0); -- registrador R3 que vai pro ledG
		
C1: complemento_2 port map (G2,SD1); -- registrador R0 que vai para as operações
		
C2: complemento_2 port map (SW(7 downto 0),SD2); -- entrada nas chaves
        
		
L0: FSM port map (CLOCK_50, KEY(0), KEY(1), SW(17 downto 16), SEL, EN(0), EN(1));
        
        
L1: SOMA_SUB port map (SW(7 downto 0), G2(7 downto 0), '0', F1, sum(3), sum(2), sum(1), sum(0));

L2: SOMA_SUB port map (SW(7 downto 0), G2(7 downto 0), '1', F2, sub(3), sub(2), sub(1), sub(0));

L3: desloca_esquerda port map (CLOCK_50, KEY(0), KEY(1), SW(7 downto 0), F3);

L4: desloca_direita port map (CLOCK_50, KEY(0), KEY(1), SW(7 downto 0), F4);

L5: mux4x1 port map (F1, F2, F3, F4, SEL, F);


R0: flipf port map (CLOCK_50, KEY(0), EN(0), SW(7 downto 0), G2(7 downto 0));

R1: flipf port map (CLOCK_50, KEY(0), EN(1), F, G1);

--a sugestão da aula 6 era usar 3 flipflops, utilizamos um de 8bit no lugar de 2 de 4bit

R3: flipf port map (CLOCK_50, KEY(0), EN(1), F(7 downto 0),P(7 downto 0)); -- P = saída do registrador pro bin2bcd

        
L6: DecodeHEX port map (G1(3 downto 0), HEX0);

L7: DecodeHEX port map (G1(7 downto 4), HEX1);

        
LEDG(7 downto 0) <= F; -- tirei o LEDG como sinal de saída no R3, e coloquei P, pois preciso do sinal de saída para o bin2BCD
        
end topo_estru;
