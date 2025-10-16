library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Extend is
generic (N : integer := 32);
    Port ( 
           ImmSrc : in STD_LOGIC;                             -- Select
           Input : in STD_LOGIC_VECTOR (23 downto 0);         -- Input
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));     -- Output
end Extend;

architecture Behavioral of Extend is
begin
    process(ImmSrc,Input)
    begin
        case ImmSrc is 
        when '0' => Output <= std_logic_vector(resize(unsigned(Input(11 downto 0)),N));  --IMMSrc=0, Extend with zeros from 12-bit to 32-bit
        when '1' => Output <= std_logic_vector(resize(signed(Input) * 4,N));             --IMMSrc=1, Extend signed from 26-bit to 32-bit
        when others => Output <= (others => 'X');                                        -- Others case
        end case;
    end process;
end Behavioral;
