--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:41 03/27/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/EX_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE
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
 
ENTITY EX_TB IS
END EX_TB;
 
ARCHITECTURE behavior OF EX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
	--add rfA and rfB
			 RF_A <= "00000000000000000000000000000011";
          RF_B <= "00000000000000000000000000000110";
          Immed <="00000000000000000000000000100111";
          ALU_Bin_sel <='0';
          ALU_func <="0000";
		wait for 100 ns;
			--add rfaA and immed
			 RF_A <= "00000000000000000000000000000101";
          RF_B <= "00000000000000000000000000000010";
          Immed <="00000000000000000000000000000111";
          ALU_Bin_sel <='1';
          ALU_func <="0000";
		wait for 100 ns;
		   --sub rfA and rfB
			 RF_A <= "00000000000000000000000000000101";
          RF_B <= "00000000000000000000000000110010";
          Immed <="00000000000000000000000000000000";
          ALU_Bin_sel <='0';
          ALU_func <="0001";
		wait for 100 ns;
			--sub rfA immed --case alu-zero=1
			 RF_A <= "00000000000000000000000000000111";
          RF_B <= "00000000000000000000000000000010";
          Immed <="00000000000000000000000000000111";
          ALU_Bin_sel <='1';
          ALU_func <="0001";
		wait for 100 ns;
			 RF_A <= "00000000000000000000000000010001";
          RF_B <= "00000000000000000000000001000010";
          Immed <="00000000000000000000000010000111";
          ALU_Bin_sel <='0';
          ALU_func <="0011";
		wait for 100 ns;
			 RF_A <= "00000000000000000000000100000001";
          RF_B <= "00000000000000000000000000000010";
          Immed <="00000000000000000000000100000111";
          ALU_Bin_sel <='1';
          ALU_func <="0011";
		wait for 100 ns;

      wait;
   end process;

END;
