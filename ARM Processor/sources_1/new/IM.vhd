
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Instruction_Memory is
    generic(
        N : integer := 6;  -- Address length
        M : integer := 32  -- Word length
            );
    Port ( 
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);              -- Input
           DATA_OUT : out STD_LOGIC_VECTOR (M-1 downto 0));        -- Output
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

    type ROM_array is array (0 to 2**N-1) of std_logic_vector (M-1 downto 0); 
    
        constant ROM : ROM_array := (                               -- 64 words
        X"E3A00005", X"E3A01002", X"E0802001", X"E2423004",
        X"E0024003", X"E3845008", X"E0256000", X"E1A07086",
        X"E1A08147", X"E1570008", X"E2889009", X"E1E0A009",
        X"EB000002", X"E580A00C", X"E590B00C", X"EAFFFFEF",
        X"E3A03008", X"E3A04002", X"E0837004", X"E1A0F00E",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000"  );
begin

    DATA_OUT <= ROM (to_integer(unsigned(ADDR)));                   -- array indexing
end Behavioral;
