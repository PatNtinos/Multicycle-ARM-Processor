library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
   generic( N : integer := 32 );
   
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
end Datapath;

architecture Structural of Datapath is

component Register_File is
    generic(
        N : integer := 4;                               -- Addr bits
        M : integer := 32                               -- Data bits
        );
    Port ( 
           CLK : in STD_LOGIC;
           Addr_1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Addr_2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Write_Enable : in STD_LOGIC;
           Input : in STD_LOGIC_VECTOR (M-1 downto 0);
           Write_Addr : in STD_LOGIC_VECTOR (N-1 downto 0);
           R15 : in STD_LOGIC_VECTOR (M-1 downto 0);
           Out_1 : out STD_LOGIC_VECTOR (M-1 downto 0);
           Out_2 : out STD_LOGIC_VECTOR (M-1 downto 0)
           );
end component Register_File;

component Program_Counter is
 generic (N : integer := 32);
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           WE : in STD_LOGIC;
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));
end component Program_Counter;


component Status_Register is
 generic (N : integer := 32);
    Port ( 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           WE : in STD_LOGIC;
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));
end component Status_Register;

component ALU is
    generic( N : integer := 32);
    Port ( 
           SrcA : in STD_LOGIC_VECTOR (N-1 downto 0);                 -- First Input     
           SrcB : in STD_LOGIC_VECTOR (N-1 downto 0);                 -- Second Input
           ALUControl : in STD_LOGIC_VECTOR (3 downto 0);             -- Control for ALU
           
           shift_type : in STD_LOGIC_VECTOR (1 downto 0);             -- shift type
           shift_amount : in STD_LOGIC_VECTOR (4 downto 0);           -- shift amount 5
           
           ALUResult : out STD_LOGIC_VECTOR (N-1 downto 0);           -- ALU result
                                                                      -- Flags
           V_flag : out STD_LOGIC;                                    -- Overflow flag
           C_flag : out STD_LOGIC;                                    -- Carry flag
           Z_flag : out STD_LOGIC;                                    -- Zero flag
           N_flag : out STD_LOGIC                                     -- Negative flag
           );
end component ALU;

component Data_Memory is
generic(
    N: integer := 5;
    M : integer := 32
    );
    Port ( 
           CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Write : in STD_LOGIC_VECTOR (M-1 downto 0);
           Data_Read : out STD_LOGIC_VECTOR (M-1 downto 0));
end component Data_Memory;

component Instruction_Memory is
    generic(
        N : integer := 6;  -- Address length
        M : integer := 32  -- Word length
            );
    Port ( 
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);              -- Input
           DATA_OUT : out STD_LOGIC_VECTOR (M-1 downto 0));        -- Output
end component Instruction_Memory;

component Extend is
generic (N : integer := 32);
    Port ( 
           ImmSrc : in STD_LOGIC;                             -- Select
           Input : in STD_LOGIC_VECTOR (23 downto 0);         -- Input
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));     -- Output
end component Extend;


component mux2to1 is
generic (N : integer := 32);
    Port ( 
           SEL     : in STD_LOGIC;                               -- Selection Signal 
           In_1    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 1
           In_2    : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Input 2
           Output  : out STD_LOGIC_VECTOR (N-1 downto 0));       -- Output
end component mux2to1;

component mux3to1 is
generic (N : integer := 32);
    Port ( 
           SEL :  in STD_LOGIC_VECTOR (1 downto 0);        -- Selection Signal
           In_1 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 1         
           In_2 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 2         
           In_3 : in STD_LOGIC_VECTOR (N-1 downto 0);      -- Input 3          
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));  -- Output          
end component mux3to1;

component INC4 is
generic (N : integer := 32);
    Port ( 
           Input_1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Input_2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           Output : out STD_LOGIC_VECTOR (N-1 downto 0));
end component INC4;


component Register_RESET is
generic( N : integer := 32);
    Port ( 
           CLK : in STD_LOGIC;                                   -- CLK signal
           RESET : in STD_LOGIC;                                 -- RESET signal
           Data_In : in STD_LOGIC_VECTOR (N-1 downto 0);         -- Data in
           Data_Out : out STD_LOGIC_VECTOR (N-1 downto 0));      -- Data out
end component Register_RESET;


                                                                 -- Signals
    signal PC_in : std_logic_vector(N-1 downto 0);
    signal PC_out: std_logic_vector(N-1 downto 0);
    signal Instr_M_out: std_logic_vector(N-1 downto 0);
    signal IR_out: std_logic_vector(N-1 downto 0);
    signal PCPlus_4_out: std_logic_vector(N-1 downto 0);
    signal PCP4_out: std_logic_vector(N-1 downto 0);
    signal A1:std_logic_vector(3 downto 0);
    signal A2:std_logic_vector(3 downto 0);
    signal A3:std_logic_vector(3 downto 0);
    signal R15: std_logic_vector(N-1 downto 0);
    signal WD3: std_logic_vector(N-1 downto 0);
    signal RD1: std_logic_vector(N-1 downto 0);
    signal RD2: std_logic_vector(N-1 downto 0);
    signal extender_out: std_logic_vector(N-1 downto 0);
    signal A_out:  std_logic_vector(N-1 downto 0);
    signal B_out:  std_logic_vector(N-1 downto 0);
    signal I_out: std_logic_vector(N-1 downto 0);
    signal ALUSrcB_out: std_logic_vector(N-1 downto 0);
    signal ALU_out: std_logic_vector(N-1 downto 0);
    signal ALU_flags: std_logic_vector(3 downto 0);
    signal SR_out: std_logic_vector(3 downto 0);
    signal MA_out: std_logic_vector(N-1 downto 0);
    signal WD_out:std_logic_vector(N-1 downto 0);
    signal DataM_out: std_logic_vector(N-1 downto 0);
    signal RD_out: std_logic_vector(N-1 downto 0);
    signal S_out: std_logic_vector(N-1 downto 0);
    signal mux_MEMTOREG_out: std_logic_vector(N-1 downto 0);


begin
                                                                -- Instatiation
    RF: Register_File
     generic map(M=>N, N=>4)
     port map(
        CLK=>CLK,
        Write_Enable=> RegWrite,
        Addr_1=>A1,
        Addr_2=>A2,
        Write_Addr=>A3,
        R15=>R15,
        Input=>WD3,
        Out_1=>RD1,
        Out_2=>RD2
        );
        
    PC_REG : Program_Counter
    generic map(N =>N)
    port map(
        CLK=>CLK,
        RESET=>RESET,
        WE=>PCWrite,
        Data_In=>PC_in,
        Data_Out=>PC_out
        );
        
        
    IM : Instruction_Memory
    generic map(M=>N, N=>6)
    port map(
        ADDR => PC_out(7 downto 2),
        DATA_OUT => Instr_M_out
        );
    
    PCPlus4: INC4
    generic map(N=>N)
    port map(
        Input_1=> PC_out,
        Input_2=> "00000000000000000000000000000100",
        Output=> PCPlus_4_out
        );
        
    
    IR_reg: Program_Counter
    generic map(N=>N)
    port map(
        CLK=>CLK,
        RESET=>RESET,
        WE=>IRWrite,
        Data_In=>Instr_M_out,
        Data_Out=>IR_out
        );
        
    PCP4: Register_RESET
    generic map(N=>N)
    port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=> PCPlus_4_out,
        Data_Out=> PCP4_out
        );
        
    PCPlus8: INC4
    generic map(N=>N)
    port map(
       Input_1=> "00000000000000000000000000000100",
       Input_2=> PCP4_out,
       Output=> R15
       );
        
     A1_mux: mux2to1
     generic map(N=>4)
     port map(
        SEL=>RegSrc(0),
        In_1=>IR_out(19 downto 16),
        In_2=>"1111",
        Output=>A1
        );
       
     A2_mux: mux2to1
     generic map(N=>4)
     port map(
        SEL=>RegSrc(1),
        In_1=>IR_out(3 downto 0),
        In_2=>IR_out(15 downto 12),
        Output=>A2
        ); 
     
     A3_mux: mux2to1
     generic map(N=>4)
     port map(
        SEL=>RegSrc(2),
        In_1=>IR_out(15 downto 12),
        In_2=>"1110",
        Output=>A3
        );
     
     WD3_mux: mux2to1
     generic map(N=>N)
     port map(
        SEL=>RegSrc(2),
        In_1=>mux_MEMTOREG_out,
        In_2=>PCP4_out,
        Output=>WD3
        );
     
     Extender: Extend
     port map(
        ImmSrc=> ImmSrc,
        Input=> IR_out(23 downto 0),
        Output=> extender_out
        );
        
     Register_A: Register_RESET 
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>RD1,
        Data_Out=> A_out
        );
        
     Register_B: Register_RESET 
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>RD2,
        Data_Out=> B_out
        );
     
     Register_I: Register_RESET 
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>extender_out,
        Data_Out=> I_out
        );
        
        
     ALUSrc_mux: mux2to1
     generic map( N=>N)
     port map(
        SEL=>ALUSrc,
        In_1=> B_out,
        In_2=>I_out,
        Output=>ALUSrcB_out
        );
        
     ALU_UNIT:ALU
     generic map(N=>N)
     port map(
        SrcA=>A_out,
        SrcB=>ALUSrcB_out,
        ALUResult=>ALU_out,
        ALUControl=>ALUControl,
        shift_amount=>IR_out(11 downto 7),
        shift_type=>IR_out(6 downto 5),
        N_flag=>ALU_flags(3),
        Z_flag=>ALU_flags(2),
        C_flag=>ALU_flags(1),
        V_flag=>ALU_flags(0)
        );
        
     SR: Status_Register
     generic map(N=>4)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        WE=>FlagsWrite,
        Data_In=>ALU_flags,
        Data_Out=>SR_out
        );
        
     MA_Reg: Program_Counter
     generic map(N=>32)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        WE=>MAWrite,
        Data_In=>ALU_out,
        Data_Out=>MA_out
        );
        
     WD_Reg: Register_RESET
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>B_out,
        Data_Out=> WD_out
        );   
      
      Data_Mem: Data_Memory
      generic map( M=>N,N=>5)
      port map(
        CLK=>CLK,
        WE=>MemWrite,
        ADDR=>MA_out(6 downto 2),
        Data_Write=>WD_out,
        Data_Read=>DataM_out
        );
        
     S_Reg: Register_RESET
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>ALU_out,
        Data_Out=> S_out
        );
     
     RD_Reg: Register_RESET
     generic map(N=>N)
     port map(
        CLK=>CLK,
        RESET=>RESET,
        Data_In=>DataM_out,
        Data_Out=> RD_out
        ); 
     
     Men_Reg_mux: mux2to1
     generic map(N=>N)
     port map(
        SEL=>MemtoReg,
        In_1=>S_out,
        In_2=>RD_out,
        Output=> mux_MEMTOREG_out
        );
     
     PC_mux: mux3to1
     generic map(N=>N)
     port map(
        SEL=>PCSrc,
        In_1=>PCP4_out,
        In_2=>ALU_out,
        In_3=>mux_MEMTOREG_out,
        Output=> PC_in
        );
        
     --OUTPUT
     Output<=mux_MEMTOREG_out;
     PC<=PC_out;
     instr <=Instr_M_out;
     WriteData<=B_out;
     Flags<=SR_out;
     ALUResult<=ALU_out;




end Structural;
