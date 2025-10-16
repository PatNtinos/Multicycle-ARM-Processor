library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register_RESET_tb is
end Register_RESET_tb;

architecture Behavioral of Register_RESET_tb is

constant N : integer := 32;

component Register_RESET is
    Port ( 
           CLK : in STD_LOGIC;                                   -- CLK signal
           RESET : in STD_LOGIC;                                 -- RESET signal
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Data in
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));      -- Data out
end component Register_RESET;

           SIGNAL CLK_tb      : STD_LOGIC;                            
           SIGNAL RESET_tb    : STD_LOGIC;                               
           SIGNAL Data_In_tb  : STD_LOGIC_VECTOR (N-1 downto 0);        
           SIGNAL Data_Out_tb : STD_LOGIC_VECTOR (N-1 downto 0); 
           
           
begin

        uut: Register_RESET
        port map (
            CLK => CLK_tb,
            RESET => RESET_tb,
            Data_In => Data_In_tb,           
            Data_Out => Data_Out_tb
        );

    process
        begin
        wait for 100 ns;
        
        RESET_tb <= '1';
        Data_In_tb <= x"13131313";  
        CLK_tb <= '0';
        wait for 5 ns;
        CLK_tb <= '1';
        wait for 20 ns;
        assert (Data_Out_tb = x"00000000")
            report "Test 1 failed";

        
        RESET_tb <= '0';
        Data_In_tb <= x"13131313";
        wait for 10 ns;
        CLK_tb <= '0';
        wait for 5 ns;
        CLK_tb <= '1';                  -- Rising edge
        wait for 5 ns;
        assert (Data_Out_tb = x"13131313")
            report "Test 2 failed";
            
        CLK_tb <= '0';
        wait for 5 ns;
        CLK_tb <= '1';                  -- Rising edge
        wait for 5 ns;
        assert (Data_Out_tb = x"13131313")
            report "Test 3 failed";
        
        RESET_tb <= '1';
        CLK_tb <= '0';
        wait for 5 ns;
        CLK_tb <= '1';
        wait for 5 ns;
        wait for 100 ns;
        assert (Data_Out_tb = x"00000000")
            report "Test 4 failed";


    wait;
    end process;
end Behavioral;
