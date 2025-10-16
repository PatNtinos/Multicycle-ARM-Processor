library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
    generic( N: integer := 32 );
    
        Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (5 downto 0);
           instr : out STD_LOGIC_VECTOR (N-1 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (N-1 downto 0);
           WriteData : out STD_LOGIC_VECTOR (N-1 downto 0);
           Result : out STD_LOGIC_VECTOR (N-1 downto 0)
           );
end Processor;
    
architecture Structural of Processor is
    component Datapath is
          generic ( N: INTEGER:= 32);
         
          Port(
               CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               RegSrc : in STD_LOGIC_VECTOR (2 downto 0);
               ALUSrc : in STD_LOGIC;
               MemtoReg : in STD_LOGIC;
               ALUControl : in STD_LOGIC_VECTOR (3 downto 0);
               ImmSrc : in STD_LOGIC;
               IRWrite : in STD_LOGIC;
               RegWrite : in STD_LOGIC;
               MAWrite : in STD_LOGIC;
               MemWrite : in STD_LOGIC;
               FlagsWrite : in STD_LOGIC;
               PCSrc : in STD_LOGIC_VECTOR (1 downto 0);
               PCWrite : in STD_LOGIC;
               
               PC : out STD_LOGIC_VECTOR (N-1 downto 0);
               instr : out STD_LOGIC_VECTOR (N-1 downto 0);
               ALUResult : out STD_LOGIC_VECTOR (N-1 downto 0);
               WriteData : out STD_LOGIC_VECTOR (N-1 downto 0);
               Output : out STD_LOGIC_VECTOR (N-1 downto 0);
               flags : out STD_LOGIC_VECTOR (3 downto 0)
               );
    end component;
    
    component Control_Unit is
        generic( N: integer := 32);
        
        Port(
               CLK         : in std_logic;
               RESET       : in std_logic;
               IR          : in std_logic_vector(N-1 downto 0);
               SR          : in std_logic_vector(3 downto 0);       
               
               RegSrc      : out STD_LOGIC_VECTOR (2 downto 0);
               ALUSrc      : out std_logic;
               MemtoReg    : out std_logic;
               ALUControl  : out std_logic_vector(3 downto 0);
               ImmSrc      : out std_logic;
               
               IRWrite     : out std_logic;
               RegWrite    : out std_logic;
               MAWrite     : out std_logic;
               MemWrite    : out std_logic;
               FlagsWrite  : out std_logic;
               PCSrc       : out std_logic_vector (1 downto 0);  
               PCWrite     : out std_logic
             );
    end component;
    
      signal RegSrc_CU_out :std_logic_vector(2 downto 0);
      signal ALUSrc_CU_out :std_logic;
      signal MemtoReg_CU_out :std_logic;
      signal ALUControl_CU_out: std_logic_vector(3 downto 0);
      signal ImmSrc_CU_out : std_logic;
      
      signal IRWrite_CU_out :std_logic;
      signal RegWrite_CU_out :std_logic;
      signal MAWrite_CU_out : std_logic;
      signal MemWrite_CU_out : std_logic;
      signal FlagsWrite_CU_out: std_logic;
      signal PCSrc_CU_out: std_logic_vector(1 downto 0);
      signal PCWrite_CU_out: std_logic;
      
      signal PC_DP_out : std_logic_vector (N-1 downto 0);
      signal instr_DP_out: std_logic_vector(N-1 downto 0);
      signal ALUResult_DP_out: std_logic_vector(N-1 downto 0);
      signal WriteData_DP_out: std_logic_vector(N-1 downto 0);
      signal Flags_DP_out: std_logic_vector(3 downto 0);
      signal Result_DP_DP_out: std_logic_vector(N-1 downto 0);
    
    
    
begin
        DP: Datapath
        generic map( N => N)
        
        port map(
            CLK=> CLK,
            RESET=>RESET,
            
            RegSrc=> RegSrc_cu_out,
            ALUSrc=> ALUSrc_cu_out,
            ALUControl=> ALUControl_cu_out,
            RegWrite => RegWrite_cu_out,
            MemtoReg=> MemtoReg_cu_out,
            MemWrite=> MemWrite_cu_out,
            MAWrite=> MAWrite_cu_out,
            PCSrc=> PCSrc_cu_out,
            PCWrite=> PCWrite_cu_out,
            ImmSrc=> ImmSrc_cu_out,
            IRWrite=> IRWrite_cu_out,
            FlagsWrite=> FlagsWrite_cu_out,
            
            PC=> PC_DP_out,
            instr=> instr_DP_out,
            WriteData=>WriteData_DP_out,
            Flags=> Flags_DP_out,
            ALUResult => ALUResult_DP_out,
            Output=> Result_DP_DP_out         
           );
        
        CU: Control_Unit
        generic map(N=>N)
        port map(
            CLK=>CLK,
            RESET=>RESET,
            
            IR=> instr_DP_out,
            SR=> Flags_DP_out,
            
            RegSrc=> RegSrc_CU_out,
            ALUSrc=> ALUSrc_CU_out,
            ALUControl=> ALUControl_CU_out,
            RegWrite => RegWrite_CU_out,
            MemtoReg=> MemtoReg_CU_out,
            MemWrite=> MemWrite_CU_out,
            MAWrite=> MAWrite_CU_out,
            PCSrc=> PCSrc_CU_out,
            PCWrite=> PCWrite_CU_out,
            ImmSrc=> ImmSrc_CU_out,
            IRWrite=> IRWrite_CU_out,
            FlagsWrite=> FlagsWrite_CU_out
        );
        
        
        PC<=PC_DP_out(5 downto 0);
        instr<=instr_DP_out;
        ALUResult<=ALUResult_DP_out;
        WriteData<=WriteData_DP_out;
        Result<=Result_DP_DP_out;

end Structural;
