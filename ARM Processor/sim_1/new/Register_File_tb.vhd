library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File_tb is
end Register_File_tb;

architecture Behavioral of Register_File_tb is

constant  N : integer := 4;              -- Addr bits
constant  M : integer := 32;             -- Data bits
constant clk_period : time := 10 ns;

component Register_File is

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

        SIGNAL CLK_tb :  STD_LOGIC;
        SIGNAL Addr_1_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
        SIGNAL Addr_2_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
        SIGNAL Write_Enable_tb :  STD_LOGIC;
        SIGNAL Input_tb :  STD_LOGIC_VECTOR (M-1 downto 0);
        SIGNAL Write_Addr_tb :  STD_LOGIC_VECTOR (N-1 downto 0);
        SIGNAL R15_tb :  STD_LOGIC_VECTOR (M-1 downto 0);
        SIGNAL Out_1_tb :  STD_LOGIC_VECTOR (M-1 downto 0);
        SIGNAL Out_2_tb :  STD_LOGIC_VECTOR (M-1 downto 0);

begin

        uut:Register_File
        Port Map( 
           CLK         =>  CLK_tb,        
           Addr_1      =>  Addr_1_tb,      
           Addr_2      =>  Addr_2_tb,     
           Write_Enable=>  Write_Enable_tb,
           Input       =>  Input_tb,       
           Write_Addr  =>  Write_Addr_tb,  
           R15         =>  R15_tb,         
           Out_1       =>  Out_1_tb,       
           Out_2       =>  Out_2_tb     
           );

    clk_process : process
    begin
            CLK_tb <= '0';
            wait for clk_period/2;
            CLK_tb <= '1';
            wait for clk_period/2;
    end process;

 process
    begin
        
        wait for 100 ns;
        
         --INITIALIZATION
        Write_Enable_tb <= '0';
        R15_tb <= X"DDDDDDDD"; 
        Input_tb <= (others => '0');
        Write_Addr_tb <= (others => '0');
        Addr_1_tb <= (others => '0');
        Addr_2_tb <= (others => '0');
        
        wait for 100 ns; 
        

        -- Test case 1
        Write_Enable_tb <= '1';
        Write_Addr_tb   <= "0010";
        Input_tb        <= x"13131313";
        wait for clk_period;                          
        assert(Input_tb = x"13131313");

        --Test case 2
        Write_Enable_tb <= '0';
        Addr_1_tb       <= "0010";
        wait for clk_period;
        assert (Out_1_tb = x"13131313");
 
         
         --Test case 3
         Addr_1_tb<="0001";
         wait for clk_period;   
         --Expecting UUUUUUUU
            
        --Test case 4
        Write_Enable_tb <= '1';
        Write_Addr_tb   <= "0101";
        Input_tb        <= x"08080808";
        wait for clk_period;
        assert(Input_tb = x"08080808");
        
        Write_Addr_tb   <= "0110";
        Input_tb        <= x"77777777";
        wait for clk_period;
        assert(Input_tb = x"77777777");
        
        
        --Test case 5
        Write_Enable_tb <= '0';
        Addr_1_tb       <= "0101";
        Addr_2_tb       <= "0110";
        wait for clk_period;
        assert(Out_1_tb = x"08080808");
        assert(Out_2_tb = x"77777777");
 
        --Test case 6
        Write_Enable_tb <= '0';
        Addr_2_tb       <= "0101";
        Input_tb        <= x"41414141";
        wait for clk_period;

        --Test case 7
        Addr_1_tb <= "1111";
        wait for clk_period;
        assert (Out_1_tb = x"DDDDDDDD");
            
         --Test case 8
         Write_Enable_tb <= '1';
         Write_Addr_tb <= "1111";
         Input_tb <= x"26262626";
         wait for clk_period;
         assert (Out_1_tb = x"DDDDDDDD");
         
         Addr_1_tb <="1111";
         wait for clk_period;

        wait;
    end process;



end Behavioral;
