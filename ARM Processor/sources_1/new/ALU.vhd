library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
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
end ALU;

architecture Behavioral of ALU is
begin
    process(SrcA,SrcB,ALUControl,shift_type,shift_amount)
            
            variable temp_1 : signed( N+1 downto 0 );
            variable temp_2 : signed( N+1 downto 0 );
            variable temp_res : signed( N+1 downto 0 );
            variable temp_logic :std_logic_vector ( N-1 downto 0);
        
        begin
        
            temp_1 := (others => '0');                                 -- Initialization
            temp_2 := (others => '0');
            temp_res := (others => '0');
            temp_logic := (others => '0');    
            ALUResult <= (others => '0');
            N_flag <= '0';
            Z_flag <= '0'; 
            C_flag <= '0';
            V_flag <= '0';
            
            
            case ALUControl is                                         -- ALU cases
            
                when "0000" =>                                         --ADD
                    temp_1 := signed('0' & SrcA(N-1) & SrcA); 
                    temp_2 := signed('0' & SrcB(N-1) & SrcB); 
                    temp_res := temp_1 + temp_2;
                    ALUResult <= std_logic_vector( temp_res(N-1 downto 0)); 
                                                                                -- Flags
                    C_flag <= std_logic (temp_res(N+1));
                    V_flag <= std_logic( temp_res(N) xor temp_res(N-1));
                    
                    if (temp_res(N-1)= '1') then
                        N_flag <= '1';
                    else 
                        N_flag <= '0';
                    end if;
                    
                    if (temp_res(N-1 downto 0)= 0) then
                        Z_flag <= '1';
                    else 
                        Z_flag <= '0';
                    end if;
                    
                when "0001" =>                                             --SUB
                    temp_1 := signed('0' & SrcA(N-1) & SrcA); 
                    temp_2 := signed('0' & not SrcB(N-1) & not SrcB)+1; 
                    temp_res := temp_1 + temp_2;
                    ALUResult <= std_logic_vector( temp_res(N-1 downto 0)); 
                                                                            -- Flags
                    C_flag <= std_logic (temp_res(N+1));
                    V_flag <= std_logic( temp_res(N) xor temp_res(N-1));
                    
                    if (temp_res(N-1)= '1') then
                        N_flag <= '1';
                    else 
                        N_flag <= '0';
                    end if;
                    
                    if (temp_res(N-1 downto 0)= 0) then
                        Z_flag <= '1';
                    else 
                        Z_flag <= '0';
                    end if;
                    
                when "0010" =>                                          --AND
                    temp_logic := SrcA and SrcB;
                    ALUResult <= std_logic_vector(temp_logic);
                                                                        -- Flags
                    C_flag <= '0';
                    V_flag <= '0';
                    
                    if (temp_logic(N-1)= '1') then
                        N_flag <= '1';
                    else 
                        N_flag <= '0';
                    end if;
                    
                    if (signed(temp_logic)= 0) then
                        Z_flag <= '1';
                    else 
                        Z_flag <= '0';
                    end if;
                    
                when "0011" =>                                              --OR
                    temp_logic := SrcA or SrcB;
                    ALUResult <= std_logic_vector(temp_logic);
                                                                            -- Flags
                    C_flag <= '0';
                    V_flag <= '0';
                    
                    if (temp_logic(N-1)= '1') then
                        N_flag <= '1';
                    else 
                        N_flag <= '0';
                    end if;
                    
                    if (signed(temp_logic)= 0) then
                        Z_flag <= '1';
                    else 
                        Z_flag <= '0';
                    end if;
                    
                when "0100" =>                                              -- XOR
                    temp_logic := SrcA xor SrcB;
                    ALUResult <= std_logic_vector(temp_logic);
                                                                            -- Flags
                    C_flag <= '0';
                    V_flag <= '0';
                    
                    if (temp_logic(N-1)= '1') then
                        N_flag <= '1';
                    else 
                        N_flag <= '0';
                    end if;
                    
                    if (signed(temp_logic)= 0) then
                        Z_flag <= '1';
                    else 
                        Z_flag <= '0';
                    end if;
                
                when "0110" =>                                              -- MOV
                    ALUResult <= SrcB;
                    
                when "0111" =>                                              -- MVN
                    ALUResult <=not SrcB;
                
                when "0101" =>                                              -- Shift
                    case shift_type is
                        when "00" =>            -- LSL
                            ALUResult <= std_logic_vector (shift_left(unsigned(SrcB), to_integer(unsigned(shift_amount))));
                        when "01" =>            -- LSR
                            ALUResult <= std_logic_vector (shift_right(unsigned(SrcB), to_integer(unsigned(shift_amount))));
                        when "10" =>            --ASR
                            ALUResult <= std_logic_vector (shift_right(signed(SrcB), to_integer(unsigned(shift_amount))));
                        when "11" =>            -- ROR
                            ALUResult <= std_logic_vector (rotate_right(unsigned(SrcB), to_integer(unsigned(shift_amount))));
                        when others =>
                            ALUResult <= (others => '0');
                     end case;
                
                when others =>
                    ALUResult <= (others => '0');
                    
             end case;
        end process;
end Behavioral;
















