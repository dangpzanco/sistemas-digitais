library  ieee; 
use  ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity complemento_2 is 
        port (entrada: in std_logic_vector(7 downto 0); 
                saida: out std_logic_vector(7 downto 0) 
						 ); 
end complemento_2; 

architecture com2 of complemento_2 is
	begin

	saida <= not(entrada) + "00000001" when entrada(7) = '1' else
	saida <= entrada;
      
end com2;
