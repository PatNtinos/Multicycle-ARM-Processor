
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Extend_tb is
end Extend_tb;



architecture Behavioral of Extend_tb is

constant N : integer := 32;

component Extend is

    Port ( 
           ImmSrc : in STD_LOGIC;                             -- Select
           Input : in STD_LOGIC_VECTOR (23 downto 0);         -- Input
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));     -- Output
end component Extend;

SIGNAL  ImmSrc_tb : STD_LOGIC;                          
SIGNAL  Input_tb :  STD_LOGIC_VECTOR (23 downto 0);        
SIGNAL  Output_tb :  STD_LOGIC_VECTOR (N-1 downto 0); 


begin


    uut: Extend
    Port map(
    ImmSrc=>ImmSrc_tb,
    Input =>Input_tb, 
    Output=>Output_tb);


    process
        begin
        
        
        Input_tb <= "000000000000111111111111"; 
        ImmSrc_tb <= '0';
        wait for 10 ns;
        assert (Output_tb = "00000000000000000000111111111111")
            report "Test case 1 failed";
  

        
        Input_tb <= "000000000000111111111111";  
        ImmSrc_tb <= '1';
        wait for 10 ns;
        assert (Output_tb = std_logic_vector(resize(signed(Input_tb) * 4, N)))
            report "Test case 2 failed";
  
        
        
        wait;
    end process;
end Behavioral;
