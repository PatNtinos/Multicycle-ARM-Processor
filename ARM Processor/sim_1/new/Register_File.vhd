library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is
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
end Register_File;

architecture Behavioral of Register_File is
    type register_array is array (0 to 2**N-2) of STD_LOGIC_VECTOR(M-1 downto 0);
    signal registers :register_array ;

begin
                                                            -- Asychronous Reading
    process(Addr_1, Addr_2,R15)
    begin
    
        if Addr_1="1111" then
            Out_1<=R15;
        else
            Out_1<=registers(TO_INTEGER(unsigned(Addr_1))); 
        end if;    
        
        if Addr_2="1111" then
            Out_2<=R15;
        else
            Out_2<=registers(TO_INTEGER(unsigned(Addr_2)));
        end if;
    end process;
    
                                                            -- Sychronous Writing  
    process(CLK)
    begin
        if rising_edge(CLK) then
            if Write_Enable = '1' and Write_Addr /= "1111" then   
                registers(to_integer(unsigned(Write_Addr))) <= Input;
            end if;
        end if;
    end process;

end Behavioral;
