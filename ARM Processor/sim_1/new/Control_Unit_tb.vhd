library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Control_unit_TB is
end Control_unit_TB;

architecture Behavioral of Control_unit_TB is

constant  N: integer := 32;
constant CLK_period : time := 10 ns;

    component Control_Unit
       
        port(
            CLK         : in std_logic;
            RESET       : in std_logic;
            IR          : in std_logic_vector(N-1 downto 0);
            SR          : in std_logic_vector(3 downto 0);       
            RegSrc      : out STD_LOGIC_VECTOR (2 downto 0);
            ImmSrc      : out std_logic;
            ALUSrc      : out std_logic;
            ALUControl  : out std_logic_vector(3 downto 0);
            MemtoReg    : out std_logic;
            IRWrite     : out std_logic;
            RegWrite    : out std_logic;
            MAWrite     : out std_logic;
            MemWrite    : out std_logic;
            FlagsWrite  : out std_logic;
            PCSrc       : out std_logic_vector (1 downto 0);  
            PCWrite     : out std_logic  
        );
    end component;
    
    -- Signals
    signal CLK_tb         : std_logic := '0';
    signal RESET_tb       : std_logic := '0';
    signal IR_tb          : std_logic_vector(N-1 downto 0);
    signal SR_tb          : std_logic_vector(3 downto 0);
    signal RegSrc_tb      : std_logic_vector(2 downto 0);
    signal ImmSrc_tb      : std_logic;
    signal ALUSrc_tb      : std_logic;
    signal ALUControl_tb  : std_logic_vector(3 downto 0);
    signal MemtoReg_tb    : std_logic;
    signal IRWrite_tb     : std_logic;
    signal RegWrite_tb    : std_logic;
    signal MAWrite_tb     : std_logic;
    signal MemWrite_tb    : std_logic;
    signal FlagsWrite_tb  : std_logic;
    signal PCSrc_tb       : std_logic_vector(1 downto 0);
    signal PCWrite_tb     : std_logic;

    
    
begin
    uut: Control_Unit
        port map (
            CLK         => CLK_tb,
            RESET       => RESET_tb,
            IR          => IR_tb,
            SR          => SR_tb,
            RegSrc      => RegSrc_tb,
            ImmSrc      => ImmSrc_tb,
            ALUSrc      => ALUSrc_tb,
            ALUControl  => ALUControl_tb,
            MemtoReg    => MemtoReg_tb,
            IRWrite     => IRWrite_tb,
            RegWrite    => RegWrite_tb,
            MAWrite     => MAWrite_tb,
            MemWrite    => MemWrite_tb,
            FlagsWrite  => FlagsWrite_tb,
            PCSrc       => PCSrc_tb,
            PCWrite     => PCWrite_tb
        );
    --CLK
    process
        begin
            CLK_tb <= '1';
            wait for CLK_period/2;
            CLK_tb <= '0';
            wait for CLK_period/2;
    end process;
    
    process
    begin
        RESET_tb <= '1';
        wait for 100 ns;
        RESET_tb <= '0';
        
        SR_tb <= "0000";  
        
 
        IR_tb <= x"E3A01001"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E3A02002"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E3A03003"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E3A04004"; 
        WAIT FOR 20 ns;
        
       
        IR_tb <= x"E0815002"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E0416003"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E2017004"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E3818005"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E2219006"; 
        WAIT FOR 20 ns;
        
  
        IR_tb <= x"E1A0C101"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E1A0D1A2"; 
        WAIT FOR 20 ns;
        IR_tb <= x"E1A0E1C3"; 
        WAIT FOR 20 ns;
        

        IR_tb  <= x"E592A000"; 
        WAIT FOR 20 ns;
        IR_tb  <= x"E582B000"; 
        WAIT FOR 20 ns;
  
        IR_tb <= x"EA00000A"; 
        WAIT FOR 20 ns;
        IR_tb <= x"EB00000B"; 
        WAIT FOR 20 ns;
        
    end process;

end Behavioral;