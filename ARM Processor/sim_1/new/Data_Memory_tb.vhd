

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory_tb is
end Data_Memory_tb;

architecture Behavioral of Data_Memory_tb is


 constant   N: integer := 5;
 constant   M : integer := 32;
 constant CLK_PERIOD : time := 10 ns;

component Data_Memory is

    Port ( 
           CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDR : in STD_LOGIC_VECTOR (N-1 downto 0);
           Data_Write : in STD_LOGIC_VECTOR (M-1 downto 0);
           Data_Read : out STD_LOGIC_VECTOR (M-1 downto 0));
end component Data_Memory;


 SIGNAL  CLK_tb :  STD_LOGIC;
 SIGNAL  WE_tb : STD_LOGIC;
 SIGNAL  ADDR_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
 SIGNAL  Data_Write_tb :  STD_LOGIC_VECTOR (M-1 downto 0);
 SIGNAL  Data_Read_tb :  STD_LOGIC_VECTOR (M-1 downto 0);


begin

    uut: Data_Memory
    Port Map(
    CLK        =>  CLK_tb,       
    WE         =>  WE_tb,        
    ADDR       =>  ADDR_tb,      
    Data_Write =>  Data_Write_tb,
    Data_Read  =>  Data_Read_tb
    );
    
    process
    begin
        while true loop
            CLK_tb <= '0';
            wait for CLK_PERIOD / 2;
            CLK_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;
    
    process
    begin
       
        wait for 20 ns;

        WE_tb <= '1';
        ADDR_tb <= std_logic_vector(to_unsigned(0, N));
        Data_Write_tb <= X"13131313";
        wait for CLK_PERIOD;

        ADDR_tb <= std_logic_vector(to_unsigned(1, N));
        Data_Write_tb <= X"08080808";
        wait for CLK_PERIOD;

        ADDR_tb <= std_logic_vector(to_unsigned(5, N));
        Data_Write_tb <= X"12345678";
        wait for CLK_PERIOD;


        WE_tb <= '0';

        ADDR_tb <= std_logic_vector(to_unsigned(0, N));
        wait for 10 ns;  -- Read is asynchronous
        assert Data_Read_tb = X"13131313"
            report "Test 1 FAILED:";
            

        ADDR_tb <= std_logic_vector(to_unsigned(1, N));
        wait for 10 ns;
        assert Data_Read_tb = X"08080808"
            report "Test 2 FAILED:";


        ADDR_tb <= std_logic_vector(to_unsigned(5, N));
        wait for 10 ns;
        assert Data_Read_tb = X"12345678"
            report "Test 3 FAILED:";

        wait;
    end process;
    
     
end Behavioral;
