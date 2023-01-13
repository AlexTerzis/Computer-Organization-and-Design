----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:48:39 03/22/2022 
-- Design Name: 
-- Module Name:    MUX32to1 - Behavioral 
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

entity MUX32to1 is
    Port (
			  inp0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp2 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp4 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp6 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp8 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp10 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp12 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp14 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp16 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp17 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp18 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp19 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp20 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp21 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp23 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp24 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp25 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp26 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp27 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp28 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp29 : in  STD_LOGIC_VECTOR (31 downto 0);
           inp30 : in  STD_LOGIC_VECTOR (31 downto 0);
			  inp31 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32to1;

architecture Behavioral of MUX32to1 is

begin
--	dout <= inp0 when (sel = '00') else 
--			  inp1 when (sel = '01') else
--			  inp2 when (sel = '02') else 
--			  inp3 when (sel = '03') else
--			  inp4 when (sel = '04') else 
--			  inp5 when (sel = '05') else
--			  inp6 when (sel = x'06') else 
--			  inp7 when (sel = x'07') else
--			  inp8 when (sel = x'08') else 
--			  inp9 when (sel = x'09') else
--			  inp10 when (sel = x'0a') else 
--			  inp11 when (sel = x'0b') else
--			  inp12 when (sel = x'0c') else 
--			  inp13 when (sel = x'0d') else
--			  inp14 when (sel = x'0e') else 
--			  inp15 when (sel = x'0f') else
--			  inp16 when (sel = x'10') else 
--			  inp17 when (sel = x'11') else
--			  inp18 when (sel = x'12') else 
--			  inp19 when (sel = x'13') else
--			  inp20 when (sel = x'14') else 
--			  inp21 when (sel = x'15') else
--			  inp22 when (sel = x'16') else 
--			  inp23 when (sel = x'17') else
--			  inp24 when (sel = x'18') else 
--			  inp25 when (sel = x'19') else
--			  inp26 when (sel = x'1a') else 
--			  inp27 when (sel = x'1b') else
--			  inp28 when (sel = x'1c') else 
--			  inp29 when (sel = x'1d') else
--			  inp30 when (sel = x'1e') else 
--			  inp31;

end Behavioral;

