

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CondLogic_tb is
end CondLogic_tb;

architecture Behavioral of CondLogic_tb is




component CONDLogic is
    Port ( cond : in STD_LOGIC_VECTOR (3 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0); --order: N,Z,C,V
           CondEx_in : out STD_LOGIC);
end component CONDLogic;


SIGNAL    cond_tb :  STD_LOGIC_VECTOR (3 downto 0);  
SIGNAL    flags_tb :  STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL    CondEx_in_tb :  STD_LOGIC;        

       
begin

    uut: CondLogic
    Port Map(
    cond      => cond_tb, 
    flags     => flags_tb, 
    CondEx_in => CondEx_in_tb
    );
    
    process
    begin       

        cond_tb <= "0000"; 
        flags_tb <= "0001"; 
        wait for 10 ns; 
        
        cond_tb <= "0000"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  

        cond_tb <= "0001"; 
        flags_tb <= "0001"; 
        wait for 10 ns;  
        
        cond_tb <= "0001"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        
        cond_tb <= "0010"; 
        flags_tb <= "0010"; 
        wait for 10 ns;  
        
        cond_tb <= "0010"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "0011"; 
        flags_tb <= "0010"; 
        wait for 10 ns;  
        
        cond_tb <= "0011"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "0100"; 
        flags_tb <= "1000"; 
        wait for 10 ns;  
        
        cond_tb <= "0100"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "0101"; 
        flags_tb <= "1000"; 
        wait for 10 ns;  
        
        cond_tb <= "0101"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "0110"; 
        flags_tb <= "0001"; 
        wait for 10 ns; 
        
        cond_tb <= "0110"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "0111"; 
        flags_tb <= "0001"; 
        wait for 10 ns;  
        
        cond_tb <= "0111"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  

        cond_tb <= "1000"; 
        flags_tb <= "0010"; 
        wait for 10 ns;  
        
        cond_tb <= "1000"; 
        flags_tb <= "0011"; 
        wait for 10 ns;  
        
 
        cond_tb <= "1010"; 
        flags_tb <= "1001"; 
        wait for 10 ns;  
        
        cond_tb <= "1010"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "1011"; 
        flags_tb <= "1000"; 
        wait for 10 ns;  
        
        cond_tb <= "1011"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        

        cond_tb <= "1110"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        
        cond_tb <= "1111"; 
        flags_tb <= "0000"; 
        wait for 10 ns;  
        
      
        wait;
    end process;
    

end Behavioral;
