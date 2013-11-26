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
	type states0 is (C0, C1, C2);
	type states1 is (B0, B1, B2);
	type states2 is (CMD1, CMD2, CMD3, ESOMA, EMULT, ESUB, RESULT_U1, RESULT_T1, OP2_T3, RESULT_H1, OP1_H2, OP1_T2, OP1_U2, OP2_H3, EDIV, NEG_OPR, NEG_OP2, NEG_OP1, OP2_U3, LIMPA, EIGUAL, Edois);
	signal CA: states0;
	signal BA, PB: states1;
	signal EA, PE: states2;
	signal delay: std_logic_vector(4 downto 0);
	signal NotSending: std_logic;

component counter
        port (
        Clock, Reset : in std_logic;
        Fim : out std_logic
                        );
end component;
        
begin 

	P0: process(Clock, RST, NotSending)
			begin
				if RST = '0' then
					CA <= C0;
					BA <= B2;
					EA <= S0;
				elsif NotSending = '1' then
					BA <= B2;
				elsif Clock'event and Clock = '1' then
					case CA is
						when C0 =>
							delay <= (others => '0');
							CA <= C1;
						when C1 =>
							delay <= delay + 1;
							CA <= C2;
						when C2 =>
							if delay <= "11110" then --59 cycles = 1180ns
								CA <= C1;
							else
								CA <= C0;
								BA <= PB;
							end if;
					end case;
				end if;
			end process;
	
	P1: process (RST, BA)
			begin
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
			end process;

	P2: process(EA, Sign, Operation, iniciado) 
		begin 
			case EA is
            
				when S0 => 
					NotSending = '1';
					if iniciado = '0' then
						PE <= CMD1;
					else
						PE <= LIMPA;
					end if;
				
				when CMD1 =>   -- 038H
					RS <= '0';
					Selection <= "01001";
					if iniciado = '0' then
						PE <= CMD2;
					else
						PE <= LIMPA;
					end if;
                                                                                
				when CMD2 =>        -- 0FH
					RS <= '0';
					Selection <= "01010";
					PE <= CMD3;
                                                                                
				when CMD3 =>        --06H
					RS <= '0';
 					iniciado <= '1';
					Selection <= "01011";
					PE <= LIMPA;
                                                                                        
				when LIMPA =>        --01H
					RS <= '0';
					Selection <= "10010";
					PE <= ESCOLHE;
                                
										  
				when ESCOLHE =>
					RS <= '1';
				if 
					Operation = "00" then
					selection <= "00011";
				elsif 
					Sign = '1' then
					PE <= Neg_OP1;
				else
					PE <= OP1_H2;
				end if;
				if 
					Operation = "01" then
					Selection <= "00011";
				elsif
					Sign = '1' then
					PE <= NEG_OP1;
				else
					PE <= OP1_H2;
				end if;
				if
					Operation = "10" then
					Selection <= "00110";
				elsif
					Sign = '1' then
					PE <= NEG_OP2;
				else
					PE <= OP2_H3;
				end if;
				if
					Operation = "11" then
					Selection <= "00110";
				elsif
					Sign = '1' then
					PE <= NEG_OP2;
				else
					PE <= OP2_H3;
				end if;
												
				when NEG_OP1 =>        --SINAL NEGATIVO OP1
					RS <= '1';
					Selection <= "01101";
					if Sign = '1' then
						PE <= OP1_H2;
					end if;
                                                                                
				when OP1_H2 =>        --H2
					RS <= '1';
					Selection <= "00011";
					PE <= OP1_T2;
                                         --OPERANDO 1
				when OP1_T2 =>        --T2
					RS <= '1';
					Selection <= "00100";
					PE <= OP1_U2;
                                                                                
				when OP1_U2 =>        --U2
					RS <= '1';
					Selection <= "00101";
					if Operation = "00" then
						PE <= ESOMA;
					elsif Operation = "01" then
						PE <= ESUB;
					end if;
                                                                                
				when ESOMA =>        -- MAIS
					RS <= '1';
					Selection <= "01100";
					if Sign = '1' then
						PE <= NEG_OP2;
					else
						PE <= OP2_H3;
					end if;
                                                                                
				when ESUB =>        -- MENOS
					RS <= '1';
					Selection <= "01101";
					if Sign = '1' then
						PE <= NEG_OP2;
					else
						PE <= OP2_H3;
					end if;
                                                                                
				when EDIV =>        --BARRA
					RS <= '1';
					Selection <= "01111";
					if Sign = '1' then
					PE <= NEG_OP2;
					else
						PE <= OP2_H3;
					end if;
                                                                                
				when EMULT =>        --VEZES
					RS <= '1';
					Selection <= "01110";
					if Sign = '1' then
						PE <= NEG_OP2;
					else
						PE <= OP2_H3;
					end if;
                                                                                
				when NEG_OP2 =>        --SINAL NEGATIVO OP2
					RS <= '1';
					Selection <= "01101";
					if Sign = '1' then
						PE <= OP2_H3;
					end if;
                                                                                
				when OP2_H3 =>        --H3
					RS <= '1';
					Selection <= "00110";
					PE <= OP2_T3;
                                                                                
				when OP2_T3 =>        --T3
					RS <= '1';                   --OPERANDO 2 E 1(/ e *)
					Selection <= "00111";
					PE <= OP2_U3;
                                                                                        
				when OP2_U3 =>        --U3
					RS <= '1';
					Selection <= "01000";
					if Operation = "00" then
						PE <= EIGUAL;
					elsif Operation = "01"then
						PE <= EIGUAL;
					elsif Operation = "10" then
						PE <= Edois;
					else
						PE <= Edois;
					end if;
                                                                                
				when Edois =>        --2
					RS <= '1';
					Selection <= "10001";
					PE <= EIGUAL;        
                                                                                
				when EIGUAL =>        --IGUAL
					RS <= '1';
					Selection <= "10000";
					if Sign = '1' then
						PE <= NEG_OPR;
					else
						PE <= RESULT_H1;
					end if;
                                                                                
				when NEG_OPR =>        --SINAL NEGATIVO RESULTADO
					RS <= '1';
					Selection <= "01101";
					if Sign = '1' then
						PE <= RESULT_H1;
					end if;
                                                                                
				when RESULT_H1 =>			--H1
					RS <= '1';
					Selection <= "00000";
                                                                                
				when RESULT_T1 =>			--T1       --RESULTADO
					RS <= '1';
					Selection <= "00001";
                                                                                
				when RESULT_U1 =>			--U1
					RS <= '1';
					Selection <= "00010";
                                                                                
				end case;
			end process;

end FSM_beh;

