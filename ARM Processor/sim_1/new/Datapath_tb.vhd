library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Datapath_tb is
end Datapath_tb;

architecture Behavioral of Datapath_tb is

   constant N : integer := 32 ;
   constant clk_period : time := 10 ns;
   
component Datapath is
   
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PCWrite : in STD_LOGIC;
           PCSrc : in STD_LOGIC_VECTOR (1 downto 0);
           IRWrite : in STD_LOGIC;
           RegSrc : in STD_LOGIC_VECTOR (2 downto 0);
           RegWrite : in STD_LOGIC;
           ImmSrc : in STD_LOGIC;
           ALUControl : in STD_LOGIC_VECTOR (3 downto 0);
           ALUSrc : in STD_LOGIC;
           MemtoReg : in STD_LOGIC;
           FlagsWrite : in STD_LOGIC;
           MAWrite : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           
           PC : out STD_LOGIC_VECTOR (N-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (N-1 downto 0);
           WriteData : out STD_LOGIC_VECTOR (N-1 downto 0);
           Flags : out STD_LOGIC_VECTOR (3 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (N-1 downto 0);
           Output : out STD_LOGIC_VECTOR (N-1 downto 0)
           );
end component Datapath;




 SIGNAL  CLK_tb : STD_LOGIC;
 SIGNAL  RESET_tb :  STD_LOGIC;
 SIGNAL  PCWrite_tb :  STD_LOGIC;
 SIGNAL  PCSrc_tb :  STD_LOGIC_VECTOR (1 downto 0);
 SIGNAL  IRWrite_tb :  STD_LOGIC;
 SIGNAL  RegSrc_tb :  STD_LOGIC_VECTOR (2 downto 0);
 SIGNAL  RegWrite_tb :  STD_LOGIC;
 SIGNAL  ImmSrc_tb :  STD_LOGIC;
 SIGNAL  ALUControl_tb :  STD_LOGIC_VECTOR (3 downto 0);
 SIGNAL  ALUSrc_tb :  STD_LOGIC;
 SIGNAL  MemtoReg_tb :  STD_LOGIC;
 SIGNAL  FlagsWrite_tb :  STD_LOGIC;
 SIGNAL  MAWrite_tb :  STD_LOGIC;
 SIGNAL  MemWrite_tb :  STD_LOGIC;  
 SIGNAL  PC_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
 SIGNAL  Instr_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
 SIGNAL  WriteData_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
 SIGNAL  Flags_tb :  STD_LOGIC_VECTOR (3 downto 0);
 SIGNAL  ALUResult_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
 SIGNAL  Output_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
           
           
           
      
     
      
begin


    uut: Datapath
    Port map(
    CLK           =>      CLK_tb,         
    RESET         =>      RESET_tb,       
    PCWrite       =>      PCWrite_tb,     
    PCSrc         =>      PCSrc_tb,       
    IRWrite       =>      IRWrite_tb,     
    RegSrc        =>      RegSrc_tb,      
    RegWrite      =>      RegWrite_tb,    
    ImmSrc        =>      ImmSrc_tb,      
    ALUControl    =>      ALUControl_tb,  
    ALUSrc        =>      ALUSrc_tb,      
    MemtoReg      =>      MemtoReg_tb,    
    FlagsWrite    =>      FlagsWrite_tb,  
    MAWrite       =>      MAWrite_tb,     
    MemWrite      =>      MemWrite_tb,    
    PC            =>      PC_tb,          
    Instr         =>      Instr_tb,       
    WriteData     =>      WriteData_tb,   
    Flags         =>      Flags_tb,       
    ALUResult     =>      ALUResult_tb,   
    Output        =>      Output_tb      
    );
    
    
    
    
    
    clk_process : process
    begin
        while true loop
            CLK_tb <= '0';
            wait for clk_period/2;
            CLK_tb <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    process
    begiN
        RegSrc_tb <= (others => '0');
        RegWrite_tb <= '0';
        ALUCoNtrol_tb <= (others => '0');
        ALUSrc_tb <= '0';
        MemtoReg_tb <= '0';
        MemWrite_tb <= '0';
        MAWrite_tb <= '0';
        PCSrc_tb <= "00";
        PCWrite_tb <= '0';
        ImmSrc_tb <= '0';
        IRWrite_tb <= '0';
        FlagsWrite_tb <= '0';


        RESET_tb <= '1';
        wait for 100 Ns;
        RESET_tb <= '0';
        wait for 100 Ns;

        
        RegWrite_tb <= '1';
        ALUCoNtrol_tb <= "0010"; -- ADD
        ALUSrc_tb <= '0';
        wait for clk_period;
    

 
        ALUCoNtrol_tb <= "0110"; -- SUB
        wait for clk_period;

        MemtoReg_tb <= '1';
        MemWrite_tb <= '0';
        ALUSrc_tb <= '1';
        wait for clk_period;
        assert (Output_tb = ALUResult_tb)
        report "Test 3 (LW) failed: Output not from memory"
        severity error;


        MemWrite_tb <= '1';
        MemtoReg_tb <= '0';
        wait for clk_period;

        wait;
    end process;

end Behavioral;
