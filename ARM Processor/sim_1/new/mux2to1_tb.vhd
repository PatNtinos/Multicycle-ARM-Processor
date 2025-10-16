

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2to1_tb is
end mux2to1_tb;

architecture Behavioral of mux2to1_tb is

component mux2to1 is
    generic (N : integer := 32);
    Port ( 
           SEL     : in STD_LOGIC;                               -- Selection Signal 
           In_1    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 1
           In_2    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 2
           Output  : out STD_LOGIC_VECTOR (N-1 downto 0));       -- Output
end component mux2to1;  

    SIGNAL SEL_tb : std_logic;
    SIGNAL In_1_tb      : std_logic_vector(31 DOWNTO 0);
    SIGNAL In_2_tb      : std_logic_vector(31 DOWNTO 0);
    SIGNAL Output_tb    : std_logic_vector(31 DOWNTO 0);
begin

    uut: mux2to1
        PORT MAP (
        SEL => SEL_tb,
        In_1      => In_1_tb,
        In_2      => In_2_tb,
        Output    => Output_tb
    );
    process
    begin
        wait for 100ns;
        
        
        SEL_tb <= '0';
        In_1_tb <= x"00000001";
        In_2_tb <= x"00000000";
        wait for 10 ns;
        assert (Output_tb = x"00000001")
            report "Test case 1 failed";

        
        
        SEL_tb <= '1';
        wait for 10 ns;
        assert( Output_tb = x"00000000")
            report "Test case 2 failed";
        
        SEL_tb <= '0';
        In_1_tb <= x"13131313";
        In_2_tb <= x"08080808";
        wait for 10 ns;
            assert( Output_tb =x"13131313")
            report "Test case 3 failed";
        
        SEL_tb <= '1';
        wait for 10 ns;
            assert( Output_tb = x"08080808")
            report "Test case 4 failed";
            
        WAIT;    
    end process;
end Behavioral;
