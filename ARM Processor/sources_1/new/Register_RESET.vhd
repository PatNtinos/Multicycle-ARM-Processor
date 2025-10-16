
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_RESET is
generic( N : integer := 32);
    Port ( 
           CLK : in STD_LOGIC;                                   -- CLK signal
           RESET : in STD_LOGIC;                                 -- RESET signal
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Data in
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));      -- Data out
end Register_RESET;

architecture Behavioral of Register_RESET is

begin
    process(CLK)
    begin  
          if rising_edge (CLK) then
              if RESET = '1' then
                  Data_Out <= (others => '0');                    -- Reset to 0
              else 
                  Data_Out <= Data_In;                            -- Load data
              end if;
          end if;
      end process;
end Behavioral;
