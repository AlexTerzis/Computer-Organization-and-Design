--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:45:39 04/11/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/CONTROL_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         ALU_ZERO : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         PC_LdEn : OUT  std_logic;
         PC_Sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_WrEn : OUT  std_logic;
         ByteOp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ALU_ZERO : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_LdEn : std_logic;
   signal PC_Sel : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_WrEn : std_logic;
   signal ByteOp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          ALU_ZERO => ALU_ZERO,
          Instr => Instr,
          PC_LdEn => PC_LdEn,
          PC_Sel => PC_Sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          ByteOp => ByteOp
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		Instr <= "11000000000001010000000000001000";
		wait for 100 ns;	
		Instr <= "11001100000000111010101111001101";
		wait for 100 ns;	
		Instr <= "01111100000000110000000000000100";
		wait for 100 ns;	
		Instr <= "00111100101010101111111111111100";
		wait for 100 ns;	
		Instr <= "00001100000100000000000000000100";
		wait for 100 ns;	
		Instr <= "10000001010001001000000000110101";
		wait for 100 ns;	
		Instr <= "00000000000000000000000000000000";
		wait for 100 ns;	

		Instr <= "00000100101001010000000000001000";
		ALU_ZERO<= '1';
		wait for 100 ns;	
		Instr <= "11111100000000001111111111111110";
		wait for 100 ns;	
		
      wait;
   end process;

END;
