library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_3to1_tb is
end mux_3to1_tb;

architecture Behavioral of mux_3to1_tb is

constant N : integer := 32;

component mux3to1 is

    Port ( 
           SEL :  in STD_LOGIC_VECTOR (1 downto 0);        -- Selection Signal
           In_1 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 1         
           In_2 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 2         
           In_3 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 3          
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));  -- Output          
end component mux3to1;


    signal SEL_tb     : std_logic_vector(1 downto 0);
    signal In_1_tb    : std_logic_vector(N - 1 downto 0);
    signal In_2_tb    : std_logic_vector(N - 1 downto 0);
    signal In_3_tb    : std_logic_vector(N - 1 downto 0);
    signal Output_tb  : std_logic_vector(N - 1 downto 0);
    
    
begin

        uut: mux3to1
        port map (
            SEL => SEL_tb,
            In_1 => In_1_tb,
            In_2 => In_2_tb,
            In_3 => In_3_tb,           
            Output => Output_tb
        );
    process
        begin
        wait for 100 ns;
        
        SEL_tb <= "00";
        In_1_tb <= x"11111111";
        In_2_tb <= x"22222222";
        In_3_tb <= x"33333333";
        wait for 10 ns;
        assert (Output_tb = x"11111111")
            report "Test case 1 failed";


        SEL_tb <= "11";
        wait for 10 ns;
        assert( Output_tb = x"22222222")
            report "Test case 2 failed";
        
        SEL_tb <= "10";
        wait for 10 ns;
            assert( Output_tb = x"33333333")
            report "Test case 3 failed";
        
 
        wait;
    end process;
        
end Behavioral;
