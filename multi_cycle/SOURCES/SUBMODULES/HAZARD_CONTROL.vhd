----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:33 05/12/2022 
-- Design Name: 
-- Module Name:    HAZARD_CONTROL - Behavioral 
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

entity HAZARD_CONTROL is
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
end HAZARD_CONTROL;

architecture Behavioral of HAZARD_CONTROL is
	
	signal RS_dependancy_A,RS_dependancy_B : STD_LOGIC;	
	signal RT_dependancy_A,RT_dependancy_B :STD_LOGIC;		
	signal RD_dependancy_A,RD_dependancy_B :STD_LOGIC;	

	signal RS_dependancy_A_stall : STD_LOGIC;	
	signal RT_dependancy_A_stall :STD_LOGIC;		
	signal RD_dependancy_A_stall :STD_LOGIC;	
	
	signal RS_forward_A,RS_forward_B : STD_LOGIC;	
	signal RT_forward_A,RT_forward_B : STD_LOGIC;
	signal RD_forward_A,RD_forward_B : STD_LOGIC;
	
	signal RS_Stall,RT_Stall,RD_Stall : STD_LOGIC;
	
begin
		---------FORWARDING---------------------
      --_______________________________________
		--an einai na ginei endolh me kapoion kataxorhth 
		--pou vrisketai sthn prohgoumenh h proprohgoumenh entolon
		RS_dependancy_A <= '1' when RS_EX=RD_MEM and RD_MEM/="00000" else '0';
		RS_dependancy_B <= '1' when RS_EX=RD_WrBack and RD_WrBack/="00000" else '0';
		
		RT_dependancy_A <= '1' when RT_EX=RD_MEM and RD_MEM/="00000" else '0';
		RT_dependancy_B <= '1' when RT_EX=RD_WrBack and RD_WrBack/="00000" else '0';
		
		RD_dependancy_A <= '1' when RD_EX=RD_MEM and RD_MEM/="00000" else '0';
		RD_dependancy_B <= '1' when RD_EX=RD_WrBack and RD_WrBack/="00000" else '0';
		
		RS_dependancy_A_stall <= '1' when RS_DEC=RD_EX and RD_EX/="00000" else '0';		
		RT_dependancy_A_stall <= '1' when RT_DEC=RD_EX and RD_EX/="00000" else '0';		
		RD_dependancy_A_stall <= '1' when RD_DEC=RD_EX and RD_EX/="00000" else '0';
		
		--exo provlima se load, opote koitazo to pedendancy kai kano load
		--RYTMIZEI TOUS POLYPLEKTES POY THA KANOYN PRAXH STOHN EX STAGE
		RS_forward_A <= RS_dependancy_A and RF_WrEn_MEM;		
		RS_forward_B <= RS_dependancy_B and RF_WrEn_WrB;
		
		RT_forward_A <= RT_dependancy_A and RF_WrEn_MEM;		
		RT_forward_B <= RT_dependancy_B and RF_WrEn_WrB;
		
		RD_forward_A <= RD_dependancy_A and RF_WrEn_MEM;		
		RD_forward_B <= RD_dependancy_B and RF_WrEn_WrB;
		
		--
		Forward_SelectA <= "00" when RS_forward_A ='0' and RS_forward_B='0' else
		                   "01" when RS_forward_A ='1' else 
								 "10" when (RS_forward_A ='0' and RS_forward_B ='1') and ( RF_WrData_Select_WrB = '0') else
		                   "11" ; 
								 
		Forward_SelectB <= "00" when RT_forward_A ='0' and RT_forward_B='0' else
		                   "01" when RT_forward_A ='1' else 
								 "10" when ((RT_forward_A ='0') and (RT_forward_B ='1')) and ( RF_WrData_Select_WrB='0') else
		                   "11" ;
		
		Forward_SelectSW <= "00" when RD_forward_A ='0' and RD_forward_B='0' else
		                   "01" when RD_forward_A ='1' else 
								 "10" when ((RD_forward_A ='0') and (RD_forward_B ='1')) and ( RF_WrData_Select_WrB='0') else
		                   "11" ;
				
		---------STALL---------------------
		-----------------------------------
		--OTAN EXO LOAD KAI EXARTHSH TYPOY A
		RS_STALL <= RS_dependancy_A_stall when ((Opcode_EX="000011") or (Opcode_EX="001111")) else '0'; 
		RT_STALL <= RT_dependancy_A_stall when ((Opcode_EX="000011") or (Opcode_EX="001111")) else '0';
		RD_STALL <= RD_dependancy_A_stall when ((Opcode_EX="000011") or (Opcode_EX="001111")) else '0';
 
		STALL <= RS_STALL OR RT_STALL OR RD_STALL;
		
end Behavioral;

