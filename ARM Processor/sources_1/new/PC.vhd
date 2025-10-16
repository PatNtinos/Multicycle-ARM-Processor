library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Program_Counter is
 generic (N : integer := 32);
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           WE : in STD_LOGIC;
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));
end Program_Counter;

architecture Behavioral of Program_Counter is

begin
    process(CLK)
        begin
            if rising_edge(CLK)then
                if RESET = '1' then
                    Data_Out <= (others =>'0');
                elsif WE = '1' then
                    Data_Out <= Data_In;
                end if;
            end if;
    end process;
end Behavioral;
