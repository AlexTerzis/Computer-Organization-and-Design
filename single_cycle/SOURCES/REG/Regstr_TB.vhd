--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:08:12 03/12/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/Regstr_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Regstr
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
 
ENTITY Regstr_TB IS
END Regstr_TB;
 
ARCHITECTURE behavior OF Regstr_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Regstr
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DataIn : IN  std_logic_vector(31 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0);
         WE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Regstr PORT MAP (
          CLK => CLK,
          RST => RST,
          DataIn => DataIn,
          DataOut => DataOut,
          WE => WE
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for CLK_period*10;

      -- insert stimulus here 
		RST <= '1';
		DataIn <="00000000000000000000000000000000";--rst
      WE <='0';
		wait for CLK_period ;
		RST <= '1';
		DataIn <="00000000000000000000000000000001";--rst and we 1
      WE <='1';
		wait for CLK_period ;
		
		DataIn <="00000000000000000000000000000001";
      WE <='1';
		RST <= '0';
		wait for CLK_period ;
		DataIn <="00000000000000000000000000000011";
      WE <='1';
		RST <= '0';
		wait for 100 ns;
		DataIn <="00000000000000000000000000000011";
      WE <='1';
		RST <= '0';
		wait for 100 ns;
		DataIn <="00000000000000000000000000000000";
      WE <='1';
		RST <= '0';	
		wait for 100 ns;
      wait;
   end process;

END;
