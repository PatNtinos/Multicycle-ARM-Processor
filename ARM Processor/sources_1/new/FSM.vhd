library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is

    type FSM_states is
         (S0,S1,S2a,S2b,S3,S4a,S4b,S4c,S4d,S4e,S4f,S4g,S4h,S4i);
    
    signal current_state, next_state : FSM_states;
   
begin
    process(CLK)
      begin
         if rising_edge(CLK) then
               if RESET = '1' then
                   current_state <= S0;
               else
                   current_state <= next_state;
               end if;
         end if;
    end process;

NEXT_STATE_LOGIC :process(current_state, op, S,B_BL, Rd, NoWrite_in, CondEx_in) 
   begin
        IRWrite    <= '0';
        RegWrite   <= '0';
        MAWrite    <= '0';
        MemWrite   <= '0';
        FlagsWrite <= '0';
        PCSrc      <= "00";
        PCWrite    <= '0';     
        next_state <= S0;  
        
        case current_state is
            when S0 =>
                IRWrite<='1'; 
                next_state<=S1;
            when S1 =>
                if CondEX_in ='0' then 
                    next_state<=S4c;                                -- end    
                elsif CondEX_in ='1' and op="01" then               -- LDR/STR
                    next_state <= S2a;
                elsif CondEX_in ='1' and op="00" then    
                    if NoWrite_in = '0' then  
                        next_state <= S2b;                          -- Data Processing
                    else  
                        next_state <= S4g;                          -- CMP
                    end if;
                elsif CondEX_in ='1' and op="10" then 
                    if B_BL='0' then                                -- B_BL
                        next_state<= S4h;
                    else
                        next_state<= S4i;   
                   end if;
                end if;
            when S2a =>                                             -- Memory Instructions
                MAWrite<='1';
                if S='1' then 
                    next_state<=S3;                                 -- LDR
                elsif S='0' then 
                    next_state<=S4d;                                -- STR
                else
                    next_state<=current_state;
                end if;
                
            when S2b =>
                if S = '0' then
                    if unsigned(Rd) /= "1111" then  
                        next_state <= S4a;
                    else  
                        next_state <= S4b;
                    end if;
                elsif S='1' then  
                    if unsigned(Rd) /= "1111" then  
                        next_state <= S4e;
                    else  
                        next_state <= S4f;
                    end if;
                else
                    next_state<=current_state;
                end if; 
                                
            when S3 => 
                if unsigned(Rd) /= "1111" then  
                    next_state <= S4a;
                elsif unsigned(Rd)= "1111" then
                    next_state <= S4b;
                else 
                    next_state<=current_state;   
                end if; 
                
            when S4a =>
                RegWrite <= '1';
                PCWrite  <= '1';
                next_state <= S0;     
                
            when S4b =>
                PCSrc   <= "10";
                PCWrite <= '1';
                next_state <= S0;
                
            when S4c =>
                PCWrite  <= '1';
                next_state <= S0;
                
            when S4d =>
                MemWrite <= '1';
                PCWrite  <= '1';
                next_state <= S0;  
                
            when S4e =>
                RegWrite   <= '1';
                FlagsWrite <= '1';
                PCWrite    <= '1';
                next_state <= S0;
                
            when S4f =>
                FlagsWrite <= '1';
                PCSrc      <= "10";
                PCWrite    <= '1';
                next_state <= S0;
                
            when S4g =>
                FlagsWrite <= '1';
                PCWrite    <= '1';
                next_state <= S0;
                
            when S4h =>
                PCSrc   <= "11";
                PCWrite <= '1';
                next_state <= S0;
                
            when S4i =>
                RegWrite <= '1';
                PCSrc    <= "11";
                PCWrite  <= '1';
                next_state <= S0;
                
            when others =>
                next_state<=S0;
        end case;
   
   end process NEXT_STATE_LOGIC;


end Behavioral;
