library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is
 constant CLK_period: time :=10ns;
 constant N : integer := 32;
 
component Program_Counter is

    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           WE : in STD_LOGIC;
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));
end component Program_Counter;


SIGNAL      CLK_tb : STD_LOGIC;                             
SIGNAL      RESET_tb : STD_LOGIC;                           
SIGNAL      WE_tb : STD_LOGIC;                              
SIGNAL      Data_In_tb : STD_LOGIC_VECTOR (N-1 downto 0);   
SIGNAL      Data_Out_tb : STD_LOGIC_VECTOR (N-1 downto 0);

begin


        uut: Program_Counter
        port map (
            CLK => CLK_tb,
            RESET => RESET_tb,
            WE => WE_tb,
            Data_In => Data_In_tb,           
            Data_Out => Data_Out_tb
        );
        
        process is
        begin
            CLK_tb<='0';
            wait for CLK_period/2;
            CLK_tb<='1';
            wait for CLK_period/2;
            
        end process;
        
        
        process
            begin
            wait for 100ns;
            
            RESET_tb <= '1';
            wait for clk_period;
                assert(Data_Out_tb = x"00000000")
                report"Test 1 failed";
            
            RESET_tb <= '0';
            WE_tb <= '1';
            Data_In_tb <= x"13131313"; 
            wait for clk_period;
                assert(Data_Out_tb = x"13131313")
                report"Test 2 failed";
           
   

            WE_tb <= '0';
            wait for clk_period;
                assert(Data_Out_tb = x"13131313")
                report"Test 3 failed";
            
            WE_tb <= '1';
            Data_In_tb <= x"08080808";
            wait for clk_period;
                assert(Data_Out_tb = x"08080808")
                report"Test 4 failed";
            wait;
            
            
            
            wait;
        end process;
        
        
end Behavioral;
