
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity INC4 is
generic (N : integer := 32);
    Port ( 
           Input_1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Input_2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));
end INC4;

architecture Behavioral of INC4 is

-- Adds the 4 so to compute the address of the next instruction

begin
    Output <= STD_LOGIC_VECTOR(UNSIGNED(Input_1)+ unsigned(Input_2));
end Behavioral;
