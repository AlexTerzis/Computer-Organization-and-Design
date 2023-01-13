----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:34 03/23/2022 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is
	component ALU is
	Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
	end component;
	
	component MUX2to1 is
	generic (N: integer := 32);
    Port ( inp_a : in  STD_LOGIC_VECTOR (N-1 downto 0);
           inp_b : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_mux : out  STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in  STD_LOGIC);
	end component;
	
	signal mux_alu: STD_LOGIC_VECTOR (31 downto 0);
begin
	MUXx_ALU: MUX2to1 port map (
			inp_a => RF_B,
         inp_b =>  Immed,
         out_mux => mux_alu, 
         sel => ALU_Bin_sel
	);
	ALU_IF: ALU port map (
		A => RF_A,
		B => mux_alu,
		Op => ALU_func,
		Outp => ALU_out,
		Zero => ALU_zero,
		Cout => open,
		Ovf => open
	);

end Behavioral;

