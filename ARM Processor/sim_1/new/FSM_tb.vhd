library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FSM_tb is
end FSM_tb;

architecture Behavioral of FSM_tb is

constant CLK_PERIOD : time := 10 ns;

component FSM is
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           S : in STD_LOGIC;
           B_BL : in STD_LOGIC;
           Rd : in STD_LOGIC_VECTOR (3 downto 0);
           NoWrite_in : in STD_LOGIC;
           Condex_in : in STD_LOGIC;
           PCWrite : out STD_LOGIC;
           IRWrite : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC;
           MEMWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC_VECTOR (1 downto 0)
           );
end component FSM;

SIGNAL  CLK_tb :  STD_LOGIC;
SIGNAL  RESET_tb : STD_LOGIC;
SIGNAL  op_tb : STD_LOGIC_VECTOR (1 downto 0);
SIGNAL  S_tb : STD_LOGIC;
SIGNAL  B_BL_tb :  STD_LOGIC;
SIGNAL  Rd_tb :  STD_LOGIC_VECTOR (3 downto 0);
SIGNAL  NoWrite_in_tb :  STD_LOGIC;
SIGNAL  Condex_in_tb : STD_LOGIC;
SIGNAL  PCWrite_tb :  STD_LOGIC;
SIGNAL  IRWrite_tb :  STD_LOGIC;
SIGNAL  RegWrite_tb :  STD_LOGIC;
SIGNAL  FlagsWrite_tb :  STD_LOGIC;
SIGNAL  MAWrite_tb :  STD_LOGIC;
SIGNAL  MEMWrite_tb :  STD_LOGIC;
SIGNAL  PCSrc_tb :  STD_LOGIC_VECTOR (1 downto 0);

begin

    uut: FSM
    Port map(
            
           CLK        => CLK_tb,       
           RESET      => RESET_tb,     
           op         => op_tb,        
           S          => S_tb,         
           B_BL       => B_BL_tb,      
           Rd         => Rd_tb,        
           NoWrite_in => NoWrite_in_tb,
           Condex_in  => Condex_in_tb, 
           PCWrite    => PCWrite_tb,   
           IRWrite    => IRWrite_tb,   
           RegWrite   => RegWrite_tb,  
           FlagsWrite => FlagsWrite_tb,
           MAWrite    => MAWrite_tb,   
           MEMWrite   => MEMWrite_tb,  
           PCSrc      => PCSrc_tb                
            );


    process
    begin
        while true loop
            CLK_tb <= '0';
            wait for CLK_PERIOD / 2;
            CLK_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    process
    begin
        wait for 100 ns;
        -- RESET phase
        RESET_tb <= '1';
        wait for 2 * CLK_PERIOD;
        RESET_tb <= '0';
        wait for CLK_PERIOD;


        op_tb <= "00"; 
        NoWrite_in_tb <= '0';
        CondEx_in_tb <= '1'; 
        S_tb <= '0'; 
        Rd_tb <= "0001";
        wait for 5 * CLK_PERIOD;  

        NoWrite_in_tb <= '1';
        wait for 5 * CLK_PERIOD;
      
        op_tb <= "01"; 
        S_tb <= '1';
        wait for 5 * CLK_PERIOD;
      
        S_tb <= '0';
        wait for 5 * CLK_PERIOD;
   
        op_tb <= "10"; 
        B_BL_tb <= '0';
        wait for 5 * CLK_PERIOD;
       
        B_BL_tb <= '1';
        wait for 5 * CLK_PERIOD;
        
        wait;
    end process;
end Behavioral;
