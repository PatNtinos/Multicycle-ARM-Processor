library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity INC4_tb is
end INC4_tb;

architecture Behavioral of INC4_tb is

constant N : integer := 32;

component INC4 is
    Port ( 
           Input_1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Input_2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));
end component INC4;


    
    SIGNAL Input_1_tb : STD_LOGIC_VECTOR (N-1 downto 0);
    SIGNAL Input_2_tb : STD_LOGIC_VECTOR (N-1 downto 0);
    SIGNAL Output_tb  : STD_LOGIC_VECTOR (N-1 downto 0);
    
    
    begin
    
    uut: INC4 
    PORT MAP( 
        Input_1  => Input_1_tb,
        Input_2  => Input_2_tb,
        Output => Output_tb
    );
    process
        begin
        wait for 100 ns;
        
        Input_1_tb <= x"00000000";
        Input_2_tb <= x"00000004";
        wait for 10 ns;
        assert(Output_tb = x"00000004")
            report "Test case 1 failed";
            
            
        Input_1_tb <= x"00000004";
        Input_2_tb <= x"00000004";
        wait for 10 ns;
        assert(Output_tb = x"00000008")
            report "Test case 2 failed";
        
        Input_1_tb <= x"FFFFFFFC";
        Input_2_tb <= x"00000004";
        wait for 10 ns;
        assert(Output_tb = x"00000000")
            report "Test case 3 failed";
            
            
        wait;
    end process;


end Behavioral;
