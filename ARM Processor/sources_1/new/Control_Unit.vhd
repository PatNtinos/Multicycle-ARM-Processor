library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Control_Unit is
    generic( N : integer := 32);
    
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           IR : in STD_LOGIC_VECTOR (N-1 downto 0);
           SR : in STD_LOGIC_VECTOR (3 downto 0);
           
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (3 downto 0);
           ImmSrc : out STD_LOGIC;
           IRWrite : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC_VECTOR (1 downto 0);
           PCWrite : out STD_LOGIC
           );
end Control_Unit;

architecture Structural of Control_Unit is

    component InstrDec is
        Port ( 
           op : in STD_LOGIC_VECTOR (1 downto 0);     
           funct : in STD_LOGIC_VECTOR (5 downto 0);
           shift_type : in STD_LOGIC_VECTOR (1 downto 0);     
           shift_amount : in STD_LOGIC_VECTOR (4 downto 0);    -- 5  
           
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
           ImmSrc: out std_logic;
           ALUSrc: out std_logic;
           ALUControl: out std_logic_vector(3 downto 0);
           MemtoReg: out std_logic;
           NoWrite_in :out std_logic
           );
     end component InstrDec;
     
     component CONDLogic is
       Port ( 
           cond : in STD_LOGIC_VECTOR (3 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0); 
           
           CondEx_in : out STD_LOGIC
           );
     end component CONDLogic;
     
     component FSM is
         port
        (
            CLK         : in std_logic;                         
            RESET       : in std_logic;                        
            op          : in std_logic_vector (1 downto 0);     
            S           : in std_logic;                         
            B_BL     : in std_logic;                         
            Rd          : in std_logic_vector (3 downto 0);    
            NoWrite_in  : in std_logic;                         
            CondEx_in   : in std_logic;                        
            
            IRWrite     : out std_logic;                       
            RegWrite    : out std_logic;                        
            MAWrite     : out std_logic;                        
            MemWrite    : out std_logic;                       
            FlagsWrite  : out std_logic;                        
            PCSrc       : out std_logic_vector (1 downto 0);    
            PCWrite     : out std_logic                        
        );
     end component FSM;
     
    signal NoWrite_in : std_logic;
    signal CondEx_in  : std_logic;
    
    
    begin
        Instruction_Decoder: InstrDec
        port map(
            op => IR(27 downto 26),
            funct=> IR(25 downto 20),
            shift_type => IR(6 downto 5),
            shift_amount=> IR(11 downto 7),
            RegSrc=> RegSrc,
            ImmSrc=>ImmSrc,
            ALUSrc=>ALUSrc,
            ALUControl=>ALUControl,
            MemtoReg=>MemtoReg,
            NoWrite_in=>NoWrite_in
        );
    
        Conditional_Logic: CONDLogic
        port map(
            cond=>IR(31 downto 28),
            flags=>SR,
            CondEx_in=> CondEx_in
        );
    
        Finite_State_Machine: FSM
        port map(
            CLK=>CLK,
            RESET=>RESET,
            op=>IR(27 downto 26),
            S=> IR(20),
            B_BL=> IR (24),
            Rd=> IR(15 downto 12),
            NoWrite_in=> NoWrite_in,
            CondEx_in=>CondEx_in,
            IRWrite    => IRWrite,
            RegWrite   => RegWrite,
            MAWrite    => MAWrite,
            MemWrite   => MemWrite,
            FlagsWrite => FlagsWrite,
            PCWrite    => PCWrite,
            PCSrc      => PCSrc          
        );
    

end Structural;
