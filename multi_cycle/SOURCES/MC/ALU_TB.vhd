--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:27:14 03/13/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/ALU_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Outp : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Outp : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Outp => Outp,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		
		--add
				 
		A <= "01000000000000000000000000000000";--ovf case
      B <= "01000000000000000000000000000111";
		wait for 100 ns;
		
		A <= "00000000000000000000000000000111";--no ovf no zero no cout
      B <= "00000000000000000000000000000111";
		wait for 100 ns;
		
		A <= "00000000000000000000000000000001";--zero case
      B <= x"ffffffff";
		wait for 100 ns;
		
		
		
		--sub		
		A <= "01000000000000000000000000000000";--ovf case
      B <= "01000000000000000000000000000111";
		Op <= "0001";
		wait for 100 ns;
		A <= "00000000000000000000000000000001";--no ovf no zero no cout
      B <= x"ffffffff";
		wait for 100 ns;		
		A <= "10000000000000000000000000000000";--ovf case
      B <= "00000000000000000000000000000001";
		
      wait for 100 ns;
		a <= x"ffffffff";--zero case
      b <= x"ffffffff";
		wait for 100 ns;
		
		
		--and		 
		A <= "00000000000000000000000000000010";
      B <= "00000000000000000000000000000111";
		Op <= "0010";
      wait for 100 ns;
		
		--or		 
		A <= "00000000000000000000000000001010";
      B <= "00000000000000000000000000000101";
		Op <= "0011";
      wait for 100 ns;
				
		--not a		 
		A <= "00000000000000000000000000000111";
		Op <= "0100";
      wait for 100 ns;
		
		--nand		 
		A <= "00000000000000000000000000001010";
      B <= "00000000000000000000000000001001";
		Op <= "0110";
      wait for 100 ns;
		
		--Αριθμητική ολίσθηση δεξιά κατά μια θέση. MSB ? [παλιό MSB	 
		A <= "10000000000000000000000000000010";
		Op <= "1000";
      wait for 100 ns;
		A <= "01000000000000000000000000000011";
		Op <= "1000";
      wait for 100 ns;
		
		--	Λογική oλίσθηση δεξιά κατά μια θέση. MSB ? ‘0’
		A <= "11000000000000000000000000000010";
		Op <= "1001";
      wait for 100 ns;
		
		--	Λογική ολίσθηση αριστερά κατά μια θέση. LSB ? ‘0’		A <= "11000000000000000000000000000010";
		Op <= "1010";
      wait for 100 ns;
		
		--	Κυκλική ολίσθηση (rotate) αριστερά το Α κατά μια θέση 		A <= "11000000000000000000000000000010";
		Op <= "1100";
      wait for 100 ns;
		
		--	Κυκλική ολίσθηση (rotate) δεξιά το Α κατά μια θέση		A <= "11000000000000000000000000000010";
		Op <= "1101";
      wait for 100 ns;

      wait;
   end process;

END;
