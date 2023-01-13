----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:17 03/12/2022 
-- Design Name: 
-- Module Name:    Regstr - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Regstr is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC);
end Regstr;

architecture Behavioral of Regstr is

signal tmp: STD_LOGIC_VECTOR (31 downto 0);

begin
	
	DataOut <= tmp after 10 ns;
	
	process (CLK) begin	
		
		if (rising_edge(CLK)) then	
			if (RST='1') then 
				tmp <= (others=>'0');
			elsif (WE='1') then
				tmp <= DataIn;
			else
				tmp <= tmp;
			end if;
		end if;
	end process;
end Behavioral;
	

