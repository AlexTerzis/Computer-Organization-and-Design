--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:54:21 03/18/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/dec5to32_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder5to32
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
 
ENTITY dec5to32_TB IS
END dec5to32_TB;
 
ARCHITECTURE behavior OF dec5to32_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder5to32
    PORT(
         input : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder5to32 PORT MAP (
          input => input,
          output => output
        );
--
--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
---- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		input <= "00000";
      wait for 100 ns;	
		
		input <= "00001";
      wait for 100 ns;	
		input <= "00010";
      wait for 100 ns;	
		input <= "00011";
      wait for 100 ns;

		input <= "00100";
      wait for 100 ns;	
		
		input <= "10000";
      wait for 100 ns;	
		input <= "10001";
      wait for 100 ns;	
		input <= "01111";
      wait for 100 ns;	
		input <= "11111";
      wait for 100 ns;			


      wait;
   end process;

END;
