----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:10 03/23/2022 
-- Design Name: 
-- Module Name:    IF_Stage - Behavioral 
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

entity IF_Stage is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_Stage;

architecture Behavioral of IF_Stage is

	signal mux_sel,PC_Out,add_4,add_1: STD_LOGIC_VECTOR (31 downto 0);
	
	component MUX2to1 is
	generic (N: integer := 32);
    Port ( inp_a : in  STD_LOGIC_VECTOR (N-1 downto 0);
           inp_b : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_mux : out  STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in  STD_LOGIC);
	end component;
	
	component Regstr is
		Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC);
	end component;
	
begin
	PC_Register: Regstr port map (
			 RST=>RST,
			 DataIn=> mux_sel,
			 WE=> PC_LdEn,
			 CLK=>CLK,
			 DataOut=> PC_Out			
			 );
	MUX_Select: MUX2to1 port map (
			inp_a => add_4,
         inp_b =>  add_1,
         out_mux => mux_sel, 
         sel => PC_sel
	);
	
	add_1 <= std_logic_vector(signed(PC_Immed) + signed(add_4));
	add_4 <= std_logic_vector(signed(PC_Out) + 4);
	
	PC <= PC_Out ;
	
end Behavioral;

