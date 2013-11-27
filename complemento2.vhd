library  ieee; 
use  ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

		entity complemento2 is 
				port (entrada: in std_logic_vector(7 downto 0); 
                  saida: out std_logic_vector(7 downto 0) 
						 ); 
		end complemento2; 


architecture com2 of complemento2 is
	signal A, B, F: std_logic_vector (7 downto 0);
	signal Flag: std_logic_vector(3 downto 0);
		
		component SUBT  is
port (A, B: in std_logic_vector(7 downto 0);
		F   : out std_logic_vector(7 downto 0);
		Flag: out std_logic_vector(3 downto 0)
     );
end component;

begin
	
	
	
	A <= "00000000";
	B <= entrada;
	
  
	
	H0: SUBT port map (A, B, F, Flag);
 
	saida <= F when entrada(7) = '1' 
	else
	entrada;
	
	 
      
end com2;
