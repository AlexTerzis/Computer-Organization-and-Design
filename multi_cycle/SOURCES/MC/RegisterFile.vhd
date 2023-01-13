----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:43:26 03/12/2022 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
			  RST : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end RegisterFile;

 architecture Behavioral of RegisterFile is
	
	signal dec_exit, and_exit: STD_LOGIC_VECTOR (31 downto 0);
	type array32 is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
	signal array_exit: array32;
	
	signal tmp: std_logic;
	
	component Regstr is
		Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC);
	end component;
	
	component Decoder5to32 is
		Port ( input : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	

begin
				--32inputs       			--sel
	Dout1 <= array_exit(to_integer(unsigned(Ard1))) after 10ns;  --mux 32-1 sel 5bit
	Dout2 <= array_exit(to_integer(unsigned(Ard2))) after 10ns; 
	
	dec_5to32: Decoder5to32 port map (
			 input => Awr,
          output => dec_exit
			);
			
	reg0: Regstr port map (
			 RST=>'1',
			 DataIn=> Din,
			 WE=> and_exit(0),
			 CLK=>CLK,
			 DataOut=> array_exit(0)			
			 );
	
			
	 registers:for i in 1 to 31 generate
	
		reg_i: Regstr port map (
			 RST=> RST ,
			 DataIn=> Din,
			 WE=> and_exit(i),
			 CLK=>CLK,
			 DataOut=> array_exit(i)			
			 );	
	   end generate;	
		
	and_gates:for i in 0 to 31 generate 
					and_exit(i) <= WrEn and  dec_exit(i) after 2 ns;
			end generate;

end Behavioral;

