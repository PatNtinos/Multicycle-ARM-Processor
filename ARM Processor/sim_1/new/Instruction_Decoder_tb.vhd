

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Instruction_Decoder_tb is
end Instruction_Decoder_tb;

architecture Behavioral of Instruction_Decoder_tb is


component InstrDec is
    Port ( 
           op : in STD_LOGIC_VECTOR (1 downto 0);                       -- op 
           funct : in STD_LOGIC_VECTOR (5 downto 0);                    -- funct 
           shift_type : in STD_LOGIC_VECTOR (1 downto 0);               -- the type of shift
           shift_amount : in STD_LOGIC_VECTOR (4 downto 0);             -- the shift amount, 5
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0);                  -- Select different Sources
           ALUSrc : out STD_LOGIC;                                      -- Zero or Sign Extension
           ImmSrc : out STD_LOGIC;                                      -- Select Register or Immediate value
           ALUControl : out STD_LOGIC_VECTOR (3 downto 0);              -- Select operation for ALU
           MemtoReg : out STD_LOGIC;                                    -- Select PC or Register File
           NoWrite_in : out STD_LOGIC                                   -- Seperatew CMP from DP instructions
          );
end component InstrDec;





   SIGNAL  op_tb :  STD_LOGIC_VECTOR (1 downto 0);             
   SIGNAL  funct_tb :  STD_LOGIC_VECTOR (5 downto 0);          
   SIGNAL  shift_type_tb :  STD_LOGIC_VECTOR (1 downto 0);     
   SIGNAL  shift_amount_tb :  STD_LOGIC_VECTOR (4 downto 0);   
   SIGNAL  RegSrc_tb :  STD_LOGIC_VECTOR (2 downto 0);        
   SIGNAL  ALUSrc_tb :  STD_LOGIC;                            
   SIGNAL  ImmSrc_tb :  STD_LOGIC;                            
   SIGNAL  ALUControl_tb :  STD_LOGIC_VECTOR (3 downto 0);    
   SIGNAL  MemtoReg_tb :  STD_LOGIC;                          
   SIGNAL  NoWrite_in_tb :  STD_LOGIC;                       
begin

    uut: InstrDec
    Port Map(
    op            =>   op_tb, 
    funct         =>   funct_tb, 
    shift_type    =>   shift_type_tb, 
    shift_amount  =>   shift_amount_tb,
    RegSrc        =>   RegSrc_tb, 
    ALUSrc        =>   ALUSrc_tb, 
    ImmSrc        =>   ImmSrc_tb, 
    ALUControl    =>   ALUControl_tb, 
    MemtoReg      =>   MemtoReg_tb,
    NoWrite_in    =>   NoWrite_in_tb
            );



    process
        begin
             wait for 100 ns;

        op_tb <= "00";
        funct_tb <= (others => '0');
        shift_amount_tb <= (others => '0');
        shift_type_tb <= (others => '0');
        wait for 100 ns;
        
        --add -im
        op_tb     <= "00";
        funct_tb  <= "101000";         
        wait for 10 ns;
            assert (RegSrc_tb = "0X0" and ALUSrc_tb = '1' and ALUControl_tb = "0000" and NoWrite_in_tb = '0')
                report "ADD (immediate) failed" severity error;
        
        --sub -reg
        op_tb     <= "00";
        funct_tb  <= "000100";         
        wait for 10 ns;
            assert (RegSrc_tb = "000" and ALUSrc_tb = '0' and ALUControl_tb = "0001" and NoWrite_in_tb = '0')
                report "SUB (register) failed" severity error;
        
        --and -reg
        op_tb     <= "00";
        funct_tb  <= "000001";         
        wait for 10 ns;
            assert (ALUControl_tb = "0010")
                report "AND failed" severity error;
        
        --or -imm
        op_tb     <= "00";
        funct_tb  <= "111001";         
        wait for 10 ns;
            assert (ALUControl_tb = "0011" and ALUSrc_tb = '1')
                report "OR failed" severity error;
        
        --xor -imm
        op_tb     <= "00";
        funct_tb  <= "100010";         
        wait for 10 ns;
        
        --cmp --reg
        op_tb     <= "00";
        funct_tb  <= "010101";         
        wait for 10 ns;
            assert (NoWrite_in_tb = '1' and ALUControl_tb = "0001")
                report "CMP failed" severity error;
        
        --mov -imm
        op_tb     <= "00";
        funct_tb  <= "111010";         
        wait for 10 ns;
            assert (ALUControl_tb = "0110")
                report "MOV failed" severity error;      
        
        --mvn --reg
        op_tb     <= "00";
        funct_tb  <= "011110";         
        wait for 10 ns;  
            assert (ALUControl_tb = "0111")
                report "MVN failed" severity error;
        
        --lsl 
        op_tb <= "00";
        funct_tb <= "011011";  
        shift_amount_tb <= "00001";
        shift_type_tb <= "00"; 
        wait for 10 ns;  
            assert (ALUControl_tb = "0101")
                report "LSL failed" severity error;
        --lsr
        op_tb <= "00";
        funct_tb <= "011010";  
        shift_amount_tb <= "00001";
        shift_type_tb <= "01"; 
        wait for 10 ns; 
        
        --ror
        op_tb <= "00";
        funct_tb <= "011011";  
        shift_amount_tb <= "00001";
        shift_type_tb <= "11"; 
        wait for 10 ns; 
        
        --ldr -imm+
        op_tb<="01";
        funct_tb<="011001";
        wait for 10ns;
        
        --str -imm-
        op_tb<="01";
        funct_tb<="010000";
        wait for 10ns;
        
        --b
        op_tb<="10";
        funct_tb<="101111";
        wait for 10ns;
        
        --bl
        op_tb<="10";
        funct_tb<="110000";
        wait for 10ns;
        wait;
    end process;
    
    
    
    
    
    
end Behavioral;
