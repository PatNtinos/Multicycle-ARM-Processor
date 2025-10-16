library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
generic(
    N: integer := 5;
    M : integer := 32
    );
    Port ( 
           CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Write : in STD_LOGIC_VECTOR (M-1 downto 0);
           Data_Read : out STD_LOGIC_VECTOR (M-1 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is
    type memory_array is array (2**N-1 downto 0) of std_logic_vector(M-1 downto 0);
    signal  RAM : memory_array ;
begin
    Data_Read<=RAM(TO_INTEGER(unsigned(ADDR)));                       -- Asychronous Reading
    process (CLK)
        begin 
            if rising_edge(CLK) then
                if WE='1' then
                    RAM(to_integer(unsigned(ADDR)))<= Data_Write;     -- Sychronous Writing
                end if;
            end if;              
    end process;
end Behavioral;
