library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity FSM_LCD is 
        port ( 
	Clock, RST, Sign : in std_logic; 
	Operation : in std_logic_vector(1 downto 0); 
	Selection : out std_logic_vector(4 downto 0); 
	RS, EN : out std_logic
                        ); 
end FSM_LCD; 

architecture FSM_beh of FSM_LCD is 
        type states is (C0, C1, C2, CMD1, CMD1_EN0, CMD1_EN1, CMD2, CMD2_EN0, CMD3, CMD3_EN0, ESOMA, LIMPA, LIMPA_EN0); --EMULTI, ESUB, EDIV,
        signal CA, EA, PE: states;
        signal delay: std_logic_vector(4 downto 0);
		  signal cont, enable_in, enable_out, envio, iniciado: std_logic;

component counter
        port (
        Clock, Reset : in std_logic;
        Fim : out std_logic
                        );
end component;
        
begin 

	P0: process(Clock, RST)
			begin
				if RST = '0' then
					CA <= C0;
					EA <= CMD1;
				elsif Clock'event and Clock = '1' then
					case CA is
						when C0 =>
							delay <= (others => '0');
							CA <= C1;
							cont <= '0';
						when C1 =>
							delay <= delay + 1;
							CA <= C2;
						when C2 =>
							if delay <= "11110" then --59 cycles = 1180ns
								CA <= C1;
							else
								cont <= '1';
								CA <= C0;
								BA <= PB;
							end if;
					end case;
				end if;
			end process;
	
	P1: process (enviando, RST)
			begin
				if enviando = '0' then
					EN <= '0';
					BA <= B0;
				
				elsif RST = '0' then
					EN <= '0';
					BA <= B0;
					EA <= PE;

				else
					case BA is
						when B0 =>
							EN <= '0';
							PB <= B1;
						when B1 =>
							EN <= '1';
							PB <= B2;
						when B2 =>
							EN <= '0';
							PB <= B0;
							EA <= PE;
					end case;
				end if;
			end process;

	P2: process(Clock, RST, Sign, Operation) 
		begin 
			case EA is
					
					when CMD1 =>
						RS <= '0';
						EN <= '0';
						--if inciado = '0' then
							Selection <= "01001";
							PE <= CMD1_EN1;
						--else
							--PE <= LIMPA;
						--end if;
					
					when CMD1_EN1 =>
						RS <= '0';
						EN <= '1';
						Selection <= "01001";
						PE <= CMD1_EN0;

					when CMD1_EN0 =>
						RS <= '0';
						EN <= '0';
						Selection <= "01001";
						PE <= CMD2;
						
					when CMD2 =>
						RS <= '0';
						EN <= '1';
						Selection <= "01010";
						PE <= CMD2_EN0;
					
					when CMD2_EN0 =>
						RS <= '0';
						EN <= '0';
						Selection <= "01010";
						PE <= CMD3;
					
					when CMD3 =>
						RS <= '0';
						EN <= '1';
						Selection <= "01011";
						PE <= CMD3_EN0;
					
					when CMD3_EN0 =>
						RS <= '0';
						EN <= '0';
						Selection <= "01011";
						PE <= LIMPA;
						--iniciado <= '1';
					
					when LIMPA =>
						RS <= '0';
						EN <= '1';
						Selection <= "01100";
						PE <= LIMPA_EN0;
					
					when LIMPA_EN0 =>
						RS <= '0';
						EN <= '0';
						Selection <= "01100";
						--if Operation = "00" then
							PE <= ESOMA;
						--elsif Operation = "01" then
							--PE <= ESUB;
						--elsif Operation = "10" then
							--PE <= EDIV;
						--else 
							--PE <= EMULTI;
					
					when ESOMA =>
						RS <= '1';
						EN <= '0';
						Selection <= "01100";
						--if Sign = '1' then
							--PE <= NEG_OP1;
						--else
							--PE <= ESOMA_
				end case;
		end process;

end FSM_beh;

