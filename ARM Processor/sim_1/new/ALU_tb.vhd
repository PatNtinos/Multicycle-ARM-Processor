library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    constant N : integer := 32;
    
component ALU is

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
           
 SIGNAL   SrcA_tb :  STD_LOGIC_VECTOR (N-1 downto 0);              
 SIGNAL   SrcB_tb :  STD_LOGIC_VECTOR (N-1 downto 0);              
 SIGNAL   ALUControl_tb :  STD_LOGIC_VECTOR (3 downto 0);                                                         
 SIGNAL   shift_type_tb :  STD_LOGIC_VECTOR (1 downto 0);          
 SIGNAL   shift_amount_tb :  STD_LOGIC_VECTOR (4 downto 0);                                                      
 SIGNAL   ALUResult_tb :  STD_LOGIC_VECTOR (N-1 downto 0);                    
 SIGNAL   V_flag_tb :  STD_LOGIC;                                 
 SIGNAL   C_flag_tb :  STD_LOGIC;                                 
 SIGNAL   Z_flag_tb :  STD_LOGIC;                                 
 SIGNAL   N_flag_tb :  STD_LOGIC;                                  
           
              
begin

    uut: ALU
    Port map(
    SrcA          =>  SrcA_tb,
    SrcB          =>  SrcB_tb,
    ALUControl    =>  ALUControl_tb, 
    shift_type    =>  shift_type_tb, 
    shift_amount  =>  shift_amount_tb,
    ALUResult     =>  ALUResult_tb, 
    V_flag        =>  V_flag_tb, 
    C_flag        =>  C_flag_tb, 
    Z_flag        =>  Z_flag_tb, 
    N_flag        =>  N_flag_tb
    );
    
    
    process
     begin
        wait for 100ns;
        
        --INITIALIZATION
        SrcA_tb<= (others=>'0');
        SrcB_tb<= (others=>'0');
        shift_amount_tb<= (others=>'0');
        shift_type_tb<= (others=>'0');
        ALUControl_tb<= (others=>'0');
        wait for 100ns;
        
        --ADD (POSITIVE)
        SrcA_tb <= X"00000009";  
        SrcB_tb <= X"00000004";  
        ALUControl_tb <= "0000";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"0000000D") 
        report "ADD test failed";

        assert (Z_flag_tb = '0' and N_flag_tb = '0' and V_flag_tb = '0')
        report "ADD test failed: wrong flags";
        

        --ADD (OVERFLOW-NEGATIVE)
        SrcA_tb <= X"7FFFFFFF";  -- 2147483647 (MAX)
        SrcB_tb <= X"00000001";  -- 1
        ALUControl_tb <= "0000"; 
        wait for 10 ns;
        
        
        assert (ALUResult_tb = X"80000000")
        report "ADD overflow test failed";

        assert (V_flag_tb = '1' and N_flag_tb = '1')
        report "ADD overflow test failed";
        
        --SUB (NEGATIVE)
        SrcA_tb <= X"00000004"; 
        SrcB_tb <= X"00000009";  
        ALUControl_tb <= "0001"; 
        wait for 10 ns;
        
        assert (ALUResult_tb = X"FFFFFFFB")  
        report "SUB negative test failed";

        assert (N_flag_tb = '1')
        report "SUB negative test failed";
  
        --SUB (POSITIVE)
        SrcA_tb <= X"00000009";   
        SrcB_tb <= X"00000004";    
        ALUControl_tb <= "0001";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"00000005")  
        report "SUB positive test failed";
    
    
        assert (N_flag_tb = '0' and Z_flag_tb = '0')
        report "SUB positive test failed: wrong flags";
 
        --AND 
        SrcA_tb <= X"F0F0F0F0";   
        SrcB_tb <= X"CCCCCCCC";   
        ALUControl_tb <= "0010";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"C0C0C0C0")
        report "AND test failed";
   
        
        --OR
        SrcA_tb <= X"12345678";  
        SrcB_tb <= X"87654321";  
        ALUControl_tb <= "0011";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"97755779")
        report "OR test failed";
        
        --XOR
        SrcA_tb <= X"0F0F0F0F";  
        SrcB_tb <= X"33333333";  
        ALUControl_tb <= "0100";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"3C3C3C3C")
        report "XOR test failed";
        
        --LSL
        SrcB_tb <= X"00000009";    
        shift_amount_tb <= "00010";
        shift_type_tb <= "00";
        ALUControl_tb <= "0101";    
        wait for 10 ns;
        
        assert (ALUResult_tb = X"00000024")
        report "LSL test failed";
       
        
        --LSR
        SrcB_tb <= X"80000090";   
        shift_amount_tb <= "00010";
        shift_type_tb <= "01";
        wait for 10 ns;
        
        
        assert (ALUResult_tb = X"20000024") 
        report "LSR test failed";
        
        
        --ASR
        SrcB_tb <=  X"FFFFFF90";
        shift_amount_tb <= "00010";
        shift_type_tb <= "10";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"FFFFFFE4")
        report "ASR test failed";

        
        
        --ROR
        SrcB_tb <= X"80000009";    
        shift_amount_tb <= "00010";
        shift_type_tb <= "11";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"60000002")
        report "ROR test failed";

        --MOV
        SrcB_tb <= X"12345678";   
        ALUControl_tb <= "0110";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"12345678")
        report "MOV test failed";
  
        
        --MVN
        SrcB_tb <= X"A5A5A5A5";   
        ALUControl_tb <= "0111";
        wait for 10 ns;
        
        assert (ALUResult_tb = X"5A5A5A5A")  
        report "MVN test failed";

        
        wait;
        
    end process;
    
    
end Behavioral;
