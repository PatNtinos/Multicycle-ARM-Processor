library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Instruction_Memory_tb is
end Instruction_Memory_tb;

architecture Behavioral of Instruction_Memory_tb is


constant N : integer := 6;  -- Address length
constant M : integer := 32;  -- Word length

component Instruction_Memory is
    
    Port ( 
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);              -- Input
           DATA_OUT : out STD_LOGIC_VECTOR (M-1 downto 0));        -- Output
end component Instruction_Memory;

SIGNAL ADDR_tb     : STD_LOGIC_VECTOR (N-1 downto 0); 
SIGNAL DATA_OUT_tb : STD_LOGIC_VECTOR (M-1 downto 0); 


begin

        uut: Instruction_Memory
        port map (
            ADDR => ADDR_tb,           
            DATA_OUT => DATA_OUT_tb
        );
        
    process
    begin
        
        ADDR_tb <= "000000";   
        wait for 10 ns;
        assert (DATA_OUT_tb = x"E3A00000")
            report "Test 1 failed";

        
        ADDR_tb <= "000001";  
        wait for 10 ns;
        assert (DATA_OUT_tb = x"E3A01005")
            report "Test 2 failed";

        
        ADDR_tb <= "011101";  
        wait for 10 ns;
        assert (DATA_OUT_tb = x"75801064")
            report "Test 3 failed";

        
        ADDR_tb <= "100000";   
        wait for 10 ns;
        assert (DATA_OUT_tb = x"00000000")
            report "Test 4 failed";

        
        ADDR_tb <= "111111";   
        wait for 10 ns;
        assert (DATA_OUT_tb = x"00000000")
            report "Test 5 failed";

        wait;
    end process;
        

end Behavioral;
