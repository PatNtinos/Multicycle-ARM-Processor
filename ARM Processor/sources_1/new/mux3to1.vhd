

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux3to1 is
generic (N : integer := 32);
    Port ( 
           SEL :  in STD_LOGIC_VECTOR (1 downto 0);        -- Selection Signal
           In_1 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 1         
           In_2 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 2         
           In_3 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 3          
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));  -- Output          
end mux3to1;

architecture Behavioral of mux3to1 is

begin
    process(SEL,In_1,In_2,In_3)
    begin
        case SEL is                                                              
            when "00" => Output <= In_1;                       -- First case 
            when "11" => Output <= In_2;                       -- Second case
            when "10" => Output <= In_3;                       -- Third case
            when others => Output <= (others => 'X');          -- All others 
        end case;  
    end process;                                                              
end Behavioral;
