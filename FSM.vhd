library ieee;
use ieee.std_logic_1164.all; 

entity FSM is 
	port ( 
			Clk, Rst, Enter : in std_logic; 
			Operacao: in std_logic_vector(1 downto 0); 
			Sel: out std_logic_vector(1 downto 0); 
			Enable_1, Enable_2: out std_logic 
			); 
end FSM; 

architecture FSM_beh of FSM is 
	type states is (S0, S1, S2, S3, S4, S5, S6, S7); 
	signal EA, PE: states; 
	signal clock: std_logic; 
	signal reset: std_logic; 
begin 
	clock <= Clk; 
	reset <= Rst;
	P1: process (clock, reset) 
		begin 
			if reset = '0' then 
				EA <= S0; 
			elsif clock'event and clock = '1' then 
				EA <= PE; 
			end if; 
	end process; 

	P2: process (EA, Enter) 
		begin 
			case EA is
			
				when S0 => -- Wait
					if Enter = '1' then 
						PE <= S0; 
					else 
						PE <= S1; 
					end if; 
					Enable_1 <= '0'; 
					Enable_2 <= '0';
					
				when S1 => --Botão pressionado
					Enable_1 <= '1'; 
					Enable_2 <= '0';
					if Enter = '1' then
						PE <= S2;
					else
						PE <= S1;
					end if;
					
				when S2 => --Escolha da operação
					Enable_1 <= '0'; 
					Enable_2 <= '0'; 
					if Operacao = "00" then 
						PE <= S3; -- Fazer SOMA 
					elsif Operacao = "01" then 
						PE <= S4; -- Fazer OR 
					elsif Operacao = "10" then
						PE <= S5; -- Fazer XOR
					else			 
						PE <= S6; -- Fazer NOT
					end if;
						
				when S3 => --SOMA
					Sel <= "00";
					if Enter = '1' then
						PE <= S3;
					else
						PE <= S7;
					end if;
					
				when S4 => --OR
					Sel <= "01";
					if Enter = '1' then
						PE <= S4;
					else
						PE <= S7;
					end if;
					
				when S5 => --XOR
					Sel <= "10";
					if Enter = '1' then
						PE <= S5;
					else
						PE <= S7;
					end if;
					
				when S6 => --NOT
					Sel <= "11";
					Enable_1 <= '0'; 
					Enable_2 <= '1'; 
					PE <= S0;
					
				when S7 => --RESULTADO
					Enable_1 <= '0';
					Enable_2 <= '1';
					PE <= S0;
					
			end case; 
	end process; 
end FSM_beh; -- fim da architecture 