
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Processor_tb is
end Processor_tb;

architecture Behavioral of Processor_tb is

constant N: integer := 32 ;
constant CLK_PERIOD: time :=10ns;

component Processor is
    
    
        Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (5 downto 0);
           instr : out STD_LOGIC_VECTOR (N-1 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (N-1 downto 0);
           WriteData : out STD_LOGIC_VECTOR (N-1 downto 0);
           Result : out STD_LOGIC_VECTOR (N-1 downto 0)
           );
end component Processor;

SIGNAL  CLK_tb : STD_LOGIC;                             
SIGNAL  RESET_tb :  STD_LOGIC;                           
SIGNAL  PC_tb :  STD_LOGIC_VECTOR (5 downto 0);         
SIGNAL  instr_tb :  STD_LOGIC_VECTOR (N-1 downto 0);    
SIGNAL  ALUResult_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
SIGNAL  WriteData_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
SIGNAL  Result_tb :  STD_LOGIC_VECTOR (N-1 downto 0);    


begin

    uut: Processor
    Port map(
    CLK        =>      CLK_tb,             
    RESET      =>      RESET_tb,    
    PC         =>      PC_tb,       
    instr      =>      instr_tb,    
    ALUResult  =>      ALUResult_tb,
    WriteData  =>      WriteData_tb,
    Result     =>      Result_tb   
    );


    process is
     begin
        CLK_tb<='1';
        wait for CLK_PERIOD/2;
        CLK_tb<='0';
        wait for CLK_PERIOD/2;
      end process;
      
      process
      begin
        RESET_tb <= '1';
        wait for 100 ns;
        RESET_tb <= '0';
        wait;
      end process ;
      
end Behavioral;
