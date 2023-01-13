----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:11:33 04/03/2022 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
	Port ( PC_LdEn : in STD_LOGIC;
			 PC_Sel : in STD_LOGIC;
			 CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
			 PC : out STD_LOGIC_VECTOR(31 DOWNTO 0);			 
			 RF_WrEn	: in STD_LOGIC;
			 RF_WrData_sel : in STD_LOGIC;
			 RF_B_sel : in STD_LOGIC;
			 ImmExt : in STD_LOGIC_VECTOR(1 DOWNTO 0);			 
			 ALU_Bin_sel : in STD_LOGIC;
			 ALU_func : in STD_LOGIC_VECTOR(3 DOWNTO 0);			 
			 Mem_WrEn : in STD_LOGIC;
			 ByteOp : in STD_LOGIC;			 
          MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0);		 
			 Instr : in STD_LOGIC_VECTOR(31 DOWNTO 0); 		  
			 ALU_ZERO : out STD_LOGIC;	 
          MM_WrEn : out  STD_LOGIC;
          MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
          MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0));
			 
end DATAPATH;

architecture Behavioral of DATAPATH is 
	
	component IF_Stage is
	 Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component DECSTAGE is
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
	end component;

	component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC);
	end component;

	component MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));	
	end component;

--endiamesa shmata ta dilono oste na boro na kano this syndeseis esoterika
SIGNAL Immed_Top_Lvl, RF_A_Top_Lvl, RF_B_Top_Lvl : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEM_Out_Top_Lvl, ALU_Out_Top_Lvl : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin
	
IF_STG: IF_Stage 
port map ( PC_Immed =>Immed_Top_Lvl,
           PC_sel =>PC_sel, 
           PC_LdEn =>PC_LdEn, 
           RST =>RST, 
           CLK =>CLK, 
           PC =>PC 
			  );

DEC_STG: DECSTAGE
port map (Instr =>Instr,
			 RF_WrEn =>RF_WrEn,
			 ALU_out =>ALU_Out_Top_LvL,
			 MEM_out =>MEM_Out_Top_LvL,
			 RF_WrData_sel =>RF_WrData_Sel,
			 RF_B_sel =>RF_B_sel,
			 ImmExt =>ImmExt,
			 Clk => CLK,
			 RST => RST,
			 Immed => Immed_Top_Lvl,
			 RF_A => RF_A_Top_Lvl,
			 RF_B => RF_B_Top_Lvl
          );	
			 
EX_STG: EXSTAGE
port map( RF_A =>RF_A_Top_Lvl,
			 RF_B =>RF_B_Top_Lvl,
			 Immed =>Immed_Top_Lvl,
			 ALU_Bin_sel =>ALU_Bin_sel,
			 ALU_func =>ALU_Func,
			 ALU_out =>ALU_Out_Top_Lvl,
			 ALU_zero => ALU_ZERO
			 );			 --

MEM_STG: MEMSTAGE
port map( ByteOp =>ByteOp,
	       Mem_WrEn =>Mem_WrEn,
			 ALU_MEM_Addr =>ALU_Out_Top_Lvl,
			 MEM_DataIn =>RF_B_Top_Lvl,
			 MEM_DataOut =>MEM_Out_Top_Lvl,
			 MM_WrEn =>MM_WrEn,
			 MM_Addr =>MM_Addr,
			 MM_WrData =>MM_WrData, 
			 MM_RdData=>MM_RdData 
          );	
	
end Behavioral;

