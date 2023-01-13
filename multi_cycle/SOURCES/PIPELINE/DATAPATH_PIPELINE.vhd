----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:37 05/10/2022 
-- Design Name: 
-- Module Name:    DATAPATH_PIPELINE - Behavioral 
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

entity DATAPATH_PIPELINE is

Port (	 PC_LdEn : in STD_LOGIC;
			 PC_Sel : in STD_LOGIC;--ALAZEI
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
			 Branch_control : in STD_LOGIC_VECTOR(1 DOWNTO 0);	
			 
			 ALU_ZERO : out STD_LOGIC;	 
          MM_WrEn : out  STD_LOGIC;
          MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
			 			 
			 Instr_saved : out STD_LOGIC_VECTOR(31 DOWNTO 0);
          MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0));
			 
end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is
component IF_Stage_PIPELINE is
		 Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
				  PC_EX : in  STD_LOGIC_VECTOR (31 downto 0);
				  PC_sel : in  STD_LOGIC;
				  PC_LdEn : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  PC : out  STD_LOGIC_VECTOR (31 downto 0));
		end component;
		
		component DECSTAGE_PIPELINE is
		 Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
		        Instr_WB : in  STD_LOGIC_VECTOR (31 downto 0);
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
		
		component HAZARD_CONTROL is
		Port ( RD_MEM : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_WrBack : in  STD_LOGIC_VECTOR (4 downto 0);
           RS_EX : in  STD_LOGIC_VECTOR (4 downto 0);
           RT_EX : in  STD_LOGIC_VECTOR (4 downto 0);
			  RD_EX : in  STD_LOGIC_VECTOR (4 downto 0);
			  RS_DEC : in  STD_LOGIC_VECTOR (4 downto 0);
           RT_DEC : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_DEC : in  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn_MEM : in  STD_LOGIC;
           RF_WrEn_WrB : in  STD_LOGIC;
           Opcode_EX : in  STD_LOGIC_VECTOR (5 downto 0);
           RF_WrData_Select_WrB : in  STD_LOGIC;
			  Forward_SelectA : out  STD_LOGIC_VECTOR (1 downto 0);
           Forward_SelectB : out  STD_LOGIC_VECTOR (1 downto 0);
			  Forward_SelectSW : out  STD_LOGIC_VECTOR (1 downto 0);
           STALL : out  STD_LOGIC);
		end component;

		
		component Regstr is
		Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC);
		end component;
		
		SIGNAL Immed_Top_Lvl, RF_A_Top_Lvl, RF_B_Top_Lvl : STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL PC_IF, PC_DEC, PC_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL MEM_Out_Top_Lvl, ALU_Out_Top_Lvl : STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL ALU_Zero_flag : STD_LOGIC;
		SIGNAL Immed_Register,RF_A_Register,RF_B_Register,RF_B_STORE_Register,MEM_Register,ALU_Register,ALU_Register_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);  
		SIGNAL Instruction_Register,Instruction_Register_WB, Instruction_Register_MEM, Instruction_Register_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);  
		SIGNAL Control_Output,Control_Output_Flag,Control_Output_EX,Control_Output_MEM,Control_Output_WB : STD_LOGIC_VECTOR(31 DOWNTO 0); 
		SIGNAL Forward_SELECT_1,Forward_SELECT_2,Forward_SELECT_3 : STD_LOGIC_VECTOR(1 DOWNTO 0); 
		SIGNAL STALL_TOP_LVL,FLUSH_TOP_LVL : STD_LOGIC;
		SIGNAL FORWARDED_A,FORWARDED_B,FORWARDED_SW  : STD_LOGIC_VECTOR(31 DOWNTO 0);
		signal PC_sel_next,STALL_RST : STD_LOGIC;
begin          
					
					ALU_ZERO <= ALU_ZERO_flag;
					-----------------31--------30downto27-----26--------25-----------24-------23--------------22--------21----20downto 19
					Control_Output<= (ALU_Bin_Sel & ALU_Func & ByteOp & MEM_WrEn & RF_WrEn & RF_WrData_sel & PC_LdEn & PC_Sel & Branch_control & Control_Output_flag(18 downto 0));
					
					
					--pairnei ston sosto xrono pote prepei na kanei branch
					--EPISIS ME AFTO TO SHMA XERO POTE EXO BRANCH KAI OXI NO OPERATION (nop)
					PC_sel_next <= '0' when Control_Output_EX (0) = '0' else
										'0' when Control_Output_EX (20 downto 19) = "00" else--no branch
										'1' when Control_Output_EX (20 downto 19) = "11" else--b
										 ALU_Zero_flag when Control_Output_EX (20 downto 19) = "01" else--beq
									not ALU_Zero_flag ; --bne
					
					FLUSH_TOP_LVL <= pc_sEL_NEXT or RST ;
					
					STALL_RST<= STALL_TOP_LVL OR RST OR PC_Sel_Next;
					PC <= PC_IF;
					
					IF_STGE: IF_Stage_PIPELINE 
					port map ( PC_Immed =>Immed_Register,
								  PC_EX => PC_EX,
								  PC_sel =>PC_sel_next , 
								  PC_LdEn =>NOT STALL_top_lvl, 
								  RST =>RST, 
								  CLK =>CLK, 
								  PC =>PC_IF 
								  );

					DEC_STGE: DECSTAGE_PIPELINE
					port map (Instr =>Instruction_Register,
					          Instr_WB =>Instruction_Register_WB,
								 RF_WrEn =>Control_Output_WB(24),
								 ALU_out =>ALU_Register_WB,
								 MEM_out =>MEM_Register,
								 RF_WrData_sel =>Control_Output_WB(23),
								 RF_B_sel =>RF_B_sel,
								 ImmExt =>ImmExt,
								 Clk => CLK,
								 RST => RST,
								 Immed => Immed_Top_Lvl,
								 RF_A => RF_A_Top_Lvl,
								 RF_B => RF_B_Top_Lvl
								 );	
					

					FORWARDED_A <= RF_A_Register when Forward_SELECT_1 = "00" else
										ALU_Register when Forward_SELECT_1 = "01" else
										ALU_Register_WB when Forward_SELECT_1 = "10" else
										MEM_Register ;	
										
					FORWARDED_B <= RF_B_Register when Forward_SELECT_2 = "00" else
										ALU_Register when Forward_SELECT_2 = "01" else
										ALU_Register_WB when Forward_SELECT_2 = "10" else
										MEM_Register ;	
										
					FORWARDED_SW <= RF_B_Register when Forward_SELECT_3 = "00" else
										ALU_Register when Forward_SELECT_3 = "01" else
										ALU_Register_WB when Forward_SELECT_3 = "10" else
										MEM_Register ;	
										
					EX_STGE: EXSTAGE
					port map( RF_A =>FORWARDED_A,
								 RF_B =>FORWARDED_B,
								 Immed =>Immed_Register,
								 ALU_Bin_sel =>Control_Output_EX(31),
								 ALU_func =>Control_Output_EX(30 DOWNTO 27),
								 ALU_out =>ALU_Out_Top_Lvl,
								 ALU_zero => ALU_ZERO_flag
								 );			 --

					MEM_STGE: MEMSTAGE
					port map( ByteOp =>Control_Output_MEM(26),
								 Mem_WrEn =>Control_Output_MEM(25),
								 ALU_MEM_Addr =>ALU_Register,
								 MEM_DataIn =>RF_B_STORE_Register,
								 MEM_DataOut =>MEM_Out_Top_Lvl,
								 MM_WrEn =>MM_WrEn,
								 MM_Addr =>MM_Addr,
								 MM_WrData =>MM_WrData, 
								 MM_RdData=>MM_RdData 
								 );
								 
					HAZARD_CTRL: HAZARD_CONTROL
						port map(RD_MEM => Instruction_Register_MEM(20 DOWNTO 16),
								   RD_WrBack => Instruction_Register_WB(20 downto 16),
								   RS_EX => Instruction_Register_EX(25 downto 21),
								   RT_EX => Instruction_Register_EX(15 DOWNTO 11),
									RD_EX => Instruction_Register_EX(20 DOWNTO 16),
									RS_DEC => Instruction_Register(25 downto 21),
								   RT_DEC => Instruction_Register(15 DOWNTO 11),
									RD_DEC => Instruction_Register(20 DOWNTO 16),
								   RF_WrEn_MEM => Control_Output_MEM(24),
								   RF_WrEn_WrB => Control_Output_WB(24),
								   Opcode_EX => Instruction_Register_EX(31 DOWNTO 26), 
									RF_WrData_Select_WrB => Control_Output_WB(23),
								   Forward_SelectA => Forward_Select_1,
								   Forward_SelectB => Forward_Select_2,
									Forward_SelectSW => Forward_Select_3,
								   STALL => STALL_TOP_LVL
						);
								 
				------------------------------	
	           Instruct_Register_DEC: Regstr 
				  port map (
								 RST=>FLUSH_TOP_LVL,
								 DataIn=> Instr,
								 WE=> NOT STALL_TOP_LVL,
								 CLK=>CLK,
								 DataOut=> Instruction_Register			
								 );
				 --to shma p paei st control
				 Instr_saved <= Instruction_Register;
				 
	           
	           Instruct_Register_EX: Regstr 
				  port map (
								 RST=>FLUSH_TOP_LVL,
								 DataIn=> Instruction_Register,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Instruction_Register_EX			
								 );
				 
	           Instruct_Register_MEM: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> Instruction_Register_EX,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Instruction_Register_MEM			
								 );
				  Instruct_Register_WB: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> Instruction_Register_MEM	,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Instruction_Register_WB			
								 );
				 					
				  RF_A_Regster: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> RF_A_Top_Lvl ,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> RF_A_Register			
								 );
				  RF_B_Regster: Regstr
				  port map (
								 RST=>RST,
								 DataIn=> RF_B_Top_Lvl ,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> RF_B_Register			
								 );
				 RF_B_STORE_Regster: Regstr
				  port map (
								 RST=>RST,
								 DataIn=> FORWARDED_SW ,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> RF_B_STORE_Register			
								 );				 
				  Immed_Regster: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> Immed_Top_Lvl ,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Immed_Register			
								 );
									 
				  MEM_Regster: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> MEM_Out_Top_Lvl ,
								 WE=> '1' ,
								 CLK=>CLK,
								 DataOut=> MEM_Register			
								 );
								 
				  ALU_Regster: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> ALU_Out_Top_Lvl ,
								 WE=> '1' ,
								 CLK=>CLK,
								 DataOut=> ALU_Register			
								 );
								 
				 	ALU_Regster_WB: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> ALU_Register	 ,
								 WE=> '1' ,
								 CLK=>CLK,
								 DataOut=> ALU_Register_WB			
								 );
								 
				PC_Register_DEC: Regstr 
				  port map (
								 RST=>FLUSH_TOP_LVL,
								 DataIn=> PC_IF,
								 WE=> NOT STALL_TOP_LVL,
								 CLK=>CLK,
								 DataOut=> PC_DEC			
								 );
				 	 
				PC_Register_EX: Regstr 
				  port map (
								 RST=>STALL_RST,
								 DataIn=> PC_DEC,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> PC_EX			
								 );
								 
				Control_Register_DEC: Regstr 
				  port map (
								 RST=>FLUSH_TOP_LVL,
								 DataIn=> (others => '1'),
								 WE=> NOT STALL_TOP_LVL,
								 CLK=>CLK,
								 DataOut=> Control_Output_Flag			
								 );
				 	 
					Control_Register_EX: Regstr 
				  port map (
								 RST=>STALL_RST,
								 DataIn=> Control_Output,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Control_Output_EX			
								 );
				 
	           Control_Register_MEM: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> Control_Output_EX,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Control_Output_MEM			
								 );
				  Control_Register_WB: Regstr 
				  port map (
								 RST=>RST,
								 DataIn=> Control_Output_MEM	,
								 WE=> '1',
								 CLK=>CLK,
								 DataOut=> Control_Output_WB			
								 );			 
								 
								 				
end Behavioral;

