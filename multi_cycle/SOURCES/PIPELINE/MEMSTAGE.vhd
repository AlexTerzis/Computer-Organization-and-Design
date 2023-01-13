----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:54:36 03/25/2022 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;


architecture Behavioral of MEMSTAGE is
component MUX2to1 is
	generic (N: integer := 32);
    Port ( inp_a : in  STD_LOGIC_VECTOR (N-1 downto 0);
           inp_b : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_mux : out  STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in  STD_LOGIC);
	end component;
begin

MM_WrEn <= MEM_WrEn; --to shma p erxetai apo to control gia write endoles

MM_Addr <= std_logic_vector(to_unsigned(1024,11) + unsigned( ALU_MEM_ADDR(12 downto 2)));-- prostheto 1024 sthn timh ths diefthinsis gia na pao sto data segment

MUX_mem: MUX2to1 port map (--otan exo lb/sb 
			inp_a => MEM_DataIn,
         inp_b(31 downto 8) => x"000000" ,--byte ta prota 0
			inp_b(7 downto 0) => MEM_DataIn(7 downto 0),--ektos apo teleftaia 8
         out_mux => MM_WrData,--afto pou paei pros ram
         sel => ByteOp
	);

MUX_rf: MUX2to1 port map (
			inp_a =>  MM_RdData,
			inp_b(31 downto 8) => x"000000" ,--gia byte vazo 0 sta prota
         inp_b(7 downto 0) => MM_RdData(7 downto 0),--ektos apo ta teleftaia 7
         out_mux => MEM_DataOut, --afto pou paei pros rf
         sel => ByteOp
	);
end Behavioral;

