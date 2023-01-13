----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:25:15 05/09/2022 
-- Design Name: 
-- Module Name:    PROCESSOR_MC - Behavioral 
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

entity PROCESSOR_MC is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end PROCESSOR_MC;

architecture Behavioral of PROCESSOR_MC is




	component RAM is
   Port ( clk : in std_logic;
			 inst_addr : in std_logic_vector(10 downto 0);
			 inst_dout : out std_logic_vector(31 downto 0);
			 data_we : in std_logic;
		 	 data_addr : in std_logic_vector(10 downto 0);
			 data_din : in std_logic_vector(31 downto 0);
			 data_dout : out std_logic_vector(31 downto 0));
	end component;
	
	component CONTROL_MC is
	Port ( 
			 CLK : in STD_LOGIC;
			 RST : in STD_LOGIC;
			 Instr_Reg_WE : out STD_LOGIC;
			 Dec_Regs_WE : out STD_LOGIC;	
			 ALU_Reg_WE : out STD_LOGIC;	
			 MEM_Reg_WE : out STD_LOGIC;
			 ALU_ZERO : in STD_LOGIC;
			 Instr : in STD_LOGIC_VECTOR(31 DOWNTO 0); 			 
			 PC_LdEn : out STD_LOGIC;
			 PC_Sel : out STD_LOGIC;			 
			 RF_WrEn	: out STD_LOGIC;
			 RF_WrData_sel : out STD_LOGIC;
			 RF_B_sel : out STD_LOGIC;
			 ImmExt : out STD_LOGIC_VECTOR(1 DOWNTO 0);			 
			 ALU_Bin_sel : out STD_LOGIC;
			 ALU_func : out STD_LOGIC_VECTOR(3 DOWNTO 0);			 
			 Mem_WrEn : out STD_LOGIC;
			 ByteOp : out STD_LOGIC); 	
	end component;
	
	component DATAPATH_MC is
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
			 Instr_Saved : out STD_LOGIC_VECTOR(31 DOWNTO 0); 		
			 ALU_ZERO : out STD_LOGIC;	 			 
          MM_WrEn : out  STD_LOGIC;
          MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
			 Instr_Reg_WE : in STD_LOGIC;
			 Dec_Regs_WE : in STD_LOGIC;	
			 ALU_Reg_WE : in STD_LOGIC;	
			 MEM_Reg_WE : in STD_LOGIC;
          MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0));			 
	end component;
	
	--Inputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_SEL : std_logic;
   signal ALU_Func : std_logic_vector(3 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal Instr, Instr_saved : std_logic_vector(31 downto 0);
   signal ImmExt : std_logic_vector(1 downto 0);
   signal Byteop : std_logic;
   signal Mem_WrEn: std_logic;

 	--Outputs
   signal MM_WrEn: std_logic;
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal ALU_ZERO : std_logic;
   signal ALU_Output : std_logic_vector(31 downto 0);
   signal PC : std_logic_vector(31 downto 0);
	signal ALU_Out, MM_RdData, MM_Wr_Data : std_logic_vector(31 downto 0);	
	
	signal  Dec_Regs_WE, ALU_Reg_WE ,  MEM_Reg_WE ,Instr_Reg_WE : STD_LOGIC;
			 
begin

	MC_DATAPATH: DATAPATH_MC PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WREn => RF_WrEn,
          RF_WRData_SEL => RF_WRData_SEL,
          RF_B_SEL => RF_B_SEL,
          Mem_WrEn => Mem_WrEn,
          ALU_Func => ALU_Func,
          ALU_Bin_SEL=> ALU_Bin_SEL,
          CLK => CLK,
          RST => RST,
          Instr => Instr,
			 ImmExt => ImmExt,
          Byteop => Byteop,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
			 MM_WrData => MM_WR_data,
          MM_RdData => MM_RdData,
          ALU_ZERO => ALU_ZERO,
			 Instr_saved => Instr_saved,
			 Instr_Reg_WE => Instr_Reg_WE,
			 Dec_Regs_WE => Dec_Regs_WE,	
			 ALU_Reg_WE =>	ALU_Reg_WE,
			 MEM_Reg_WE => MEM_Reg_WE ,
          PC => PC
        );
		  
  MC_CONTROL: CONTROL_MC PORT MAP (
          CLK => CLK,
			 RST => RST,
			 PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_SEL => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Func => ALU_Func,
          ALU_Bin_SEL => ALU_Bin_sel,
          ALU_zero => ALU_zero,
          Instr => Instr_Saved,
          ImmExt => ImmExt,
          ByteOp => ByteOp,
			 
			 Instr_Reg_WE => Instr_Reg_WE,
			 Dec_Regs_WE => Dec_Regs_WE,	
			 ALU_Reg_WE =>	ALU_Reg_WE,
			 MEM_Reg_WE => MEM_Reg_WE ,
          Mem_WrEn => Mem_WrEn
        );
		  
	MC_RAM: RAM PORT MAP (
          clk => CLK,
          inst_addr => PC(12 DOWNTO 2),
          inst_dout => Instr,
          data_we => MM_WrEn,
          data_addr => MM_Addr,
          data_din => MM_Wr_Data,
          data_dout => MM_RdData
        );

end Behavioral;

