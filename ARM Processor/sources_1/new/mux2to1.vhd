

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
generic (N : integer := 32);
    Port ( 
           SEL     : in STD_LOGIC;                               -- Selection Signal 
           In_1    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 1
           In_2    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 2
           Output  : out STD_LOGIC_VECTOR (N-1 downto 0));       -- Output
end mux2to1;                                                     

architecture Behavioral of mux2to1 is

begin
    process(SEL,In_1,In_2)
    begin
        case SEL is
                when '0' => Output <= In_1;                        -- First case
                when '1' => Output <= In_2;                        -- Second case
                when others => Output <= (others => 'X');          -- All others
        end case;
    end process;

end Behavioral;
