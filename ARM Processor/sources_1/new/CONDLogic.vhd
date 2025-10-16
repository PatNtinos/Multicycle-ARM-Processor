library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONDLogic is
    Port ( cond : in STD_LOGIC_VECTOR (3 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0); --order: N,Z,C,V
           CondEx_in : out STD_LOGIC);
end CONDLogic;

architecture Behavioral of CONDLogic is

begin
    process(cond,flags)
    begin
        case cond is
            when "0000" =>                          -- Equal 
                CondEx_in<=flags(2);
            when "0001" =>                          -- Not equal
                CondEx_in<=not flags(2);
            when "0010" =>                          -- Carry set
                CondEx_in<=flags(1);
            when "0011" =>                          -- Carry clear
                CondEx_in<=not flags(1);
            when "0100" =>                          -- Negative
                CondEx_in<=flags(3);
            when "0101" =>                          -- Positive or zero
                CondEx_in<=not flags(3);
            when "0110" =>                          -- Overflow
                CondEx_in<=flags(0);    
            when "0111" =>                          -- No Overflow
                CondEx_in<=not flags(0);    
            when "1000" =>                          -- Unsigned higher
                CondEx_in<= (not flags(2)) and flags(1);
            when "1001" =>                          -- The same or unsigned lower
                CondEx_in<=flags(2) or (not flags(1));
            when "1010" =>                          -- Equal or signed greater
                CondEx_in<=not(flags(3) xor flags(0));
            when "1011" =>                          -- Signed less
                CondEx_in<=flags(3) xor flags(0);
            when "1100" =>                          -- Signed greater
                CondEx_in<=(not flags(2)) and (not (flags(3) xor flags(0)));
            when "1101" =>                          -- Equal or signed less
                CondEx_in<= flags(2) or (flags(3) xor flags(0));
            when "1110" =>                          -- Always or unconditional
                CondEx_in<='1'; 
            when "1111" =>                          -- Uncodintional instructions
                CondEx_in<='1';
            when others =>
                CondEx_in<='0';
            end case;
    end process;          
end Behavioral;
