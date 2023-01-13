----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:21 05/10/2022 
-- Design Name: 
-- Module Name:    CONTROL_PIPELINE - Behavioral 
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


entity CONTROL_PIPELINE  is
	Port ( ALU_ZERO : in STD_LOGIC;
			 Instr : in STD_LOGIC_VECTOR(31 DOWNTO 0); 
			 
			 PC_LdEn : out STD_LOGIC;
			 PC_Sel : out STD_LOGIC;
			 
			 RF_WrEn	: out STD_LOGIC;
			 RF_WrData_sel : out STD_LOGIC;
			 RF_B_sel : out STD_LOGIC;
			 ImmExt : out STD_LOGIC_VECTOR(1 DOWNTO 0);
			 
			 ALU_Bin_sel : out STD_LOGIC;
			 ALU_func : out STD_LOGIC_VECTOR(3 DOWNTO 0);
			 
			 Branch_cONTROL : out STD_LOGIC_VECTOR(1 DOWNTO 0);
			 
			 Mem_WrEn : out STD_LOGIC;
			 ByteOp : out STD_LOGIC);
end CONTROL_PIPELINE ;

architecture Behavioral of CONTROL_PIPELINE  is

begin


process (Instr,ALU_Zero)
	
	begin
			
			Branch_cONTROL <= "00";
	      
			PC_LdEn <='1';
			
			case Instr (31 DOWNTO 26) is
				
			when "100000" =>  PC_Sel <='0';
			--R-type 
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--rt
									ImmExt <="00";
			 
									ALU_Bin_sel <='0';--no immed
									ALU_func <= Instr(3 DOWNTO 0);--oxi 6bit gt ta 2 prota se ola einai 11
			 
									Mem_WrEn <='0';
									ByteOp <='0'; 
			
			when "111000" =>	PC_Sel <='0';
			--li		
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--immidiate
									ImmExt <="00";--sign ex
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0011";--or me ta prota 16 me immed
			 
									Mem_WrEn <='0';
									ByteOp <='0';						
			
			
			when "111001" =>	PC_Sel <='0';
			--lui		
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--immidiate
									ImmExt <="11";--16 zero fill
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0011";--or me ta prota 16 me immed
			 
									Mem_WrEn <='0';
									ByteOp <='0';
									
			when "110000" =>	PC_Sel <='0';
			--addi		
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--immidiate
									ImmExt <="00";--sign ex
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='0';
									ByteOp <='0';
									
			when "110010" =>	PC_Sel <='0';
			--nandi		
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--immidiate
									ImmExt <="10";--zero fill
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0101";--nand
			 
									Mem_WrEn <='0';
									ByteOp <='0';		 				
									
			when "110011" =>	PC_Sel <='0';
			--ori		
									RF_WrEn	<='1';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--immidiate
									ImmExt <="01";--zero fill
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='0';
									ByteOp <='0';	
										
			when "111111" =>	PC_Sel <='1';--exo branch
			--b		
									RF_WrEn	<='0';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='0';--dont care
									ImmExt <="10";--SignExtend(Imm) << 2
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Branch_CONTROL <="11";
									
									Mem_WrEn <='0';
									ByteOp <='0';	
												
			
			when "000000" =>	PC_Sel <=ALU_Zero;--exo branch an einai isa dld Zero=1
			--beq		
									RF_WrEn	<='0';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='1';--RF-B
									ImmExt <="10";--SignExtend(Imm) << 2
			 
									ALU_Bin_sel <='0';--rf B
									ALU_func<= "0001";--sub
			 
									Branch_CONTROL <="01";
									Mem_WrEn <='0';
									ByteOp <='0';	
			
			when "000001" =>	PC_Sel <= not ALU_Zero;--exo branch an den einai isa dld Zero=0
			--bne		
									RF_WrEn	<='0';
									RF_WrData_sel <='0';--apo alu
									RF_B_sel <='1';--imm
									ImmExt <="10";--SignExtend(Imm) << 2
			 
									ALU_Bin_sel <='0';--rf b
									ALU_func<= "0001";--sub
			 
									Branch_CONTROL <="10";
									Mem_WrEn <='0';
									ByteOp <='0';	
			
			when "000011" =>	PC_Sel <= '0';
			--lb		
									RF_WrEn	<='1';--
									RF_WrData_sel <='1';--apo mem
									RF_B_sel <='1';--imm
									ImmExt <="00";--SignExtend 
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='0';
									ByteOp <='1';	
			
			when "000111" =>	PC_Sel <= '0';--exo branch an den einai isa dld Zero=0
			--sb		
									RF_WrEn	<='0';--dn grafo sthn rf
									RF_WrData_sel <='1';--apo mem
									RF_B_sel <='1';--imm
									ImmExt <="00";--SignExtend 
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='1';
									ByteOp <='1';	
			
			when "001111" =>	PC_Sel <= '0';
			--lw		
									RF_WrEn	<='1'; --thelo na grapso rf
									RF_WrData_sel <='1';--apo mem
									RF_B_sel <='1';--imm
									ImmExt <="00";--SignExtend 
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='0';
									ByteOp <='0';	
			
			when "011111" =>	PC_Sel <= '0';--exo branch an den einai isa dld Zero=0
			--sw		
									RF_WrEn	<='0';--dn grafo sthn rf
									RF_WrData_sel <='1';--apo mem
									RF_B_sel <='1';--imm
									ImmExt <="00";--SignExtend 
			 
									ALU_Bin_sel <='1';--immidiate
									ALU_func<= "0000";--add
			 
									Mem_WrEn <='1';
									ByteOp <='0';	
			
			when others =>		PC_Sel <= '0';
									RF_WrEn	<='0';
									RF_WrData_sel <='0';
									RF_B_sel <='0';
									ImmExt <="00";
									ALU_Bin_sel <='0';
									ALU_func<= "0000";			 
									Mem_WrEn <='0';
									ByteOp <='0';
					
			end case;
		end process;																		
end Behavioral;

