----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:00 03/23/2022 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is
	component MUX2to1 is
	generic (N: integer := 32);
    Port ( inp_a : in  STD_LOGIC_VECTOR (N-1 downto 0);
           inp_b : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_mux : out  STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in  STD_LOGIC);
end component;

component RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
			  RST : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end component;

signal mux_adress: STD_LOGIC_VECTOR (4 downto 0);
signal mux_write: STD_LOGIC_VECTOR (31 downto 0);

begin
	
	REGISTER_FILE: RegisterFile port map (
			  Ard1 => Instr (25 downto 21), 
           Ard2 => mux_adress,
           Awr => Instr (20 downto 16),
           Dout1 => RF_A,
           Dout2 => RF_B,
           Din => mux_write,
           WrEn => RF_WrEn,
			  RST => RST,
           CLK => CLK
	);
	
	Muxx_write: MUX2to1 port map (
			inp_a => ALU_Out,
         inp_b =>  MEM_Out,
         out_mux => mux_write, 
         sel => RF_WrData_sel
	);
	
	Muxx_adress: MUX2to1 generic map (N=>5)
	port map (
			
			inp_a => Instr(15 downto 11),--rt
         inp_b => Instr(20 downto 16),--rd
         out_mux => mux_adress, 
         sel => RF_B_sel
	);
	--IMMED CLOUD
	Immed <= (31 downto 16 => instr(15)) & Instr(15 downto 0) when ImmExt = "00" else--sign extension
				(31 DOWNTO 16=> '0')  & Instr(15 downto 0) when ImmExt = "01" else	--zero fill
				(31 downto 18 => instr(15)) & Instr(15 downto 0)&"00" when ImmExt = "10" else--SignExtend(Imm) << 2
				Instr(15 downto 0) & (15 downto 0 => '0'); --16 zero fill
end Behavioral;

