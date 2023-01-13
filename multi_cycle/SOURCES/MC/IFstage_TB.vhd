--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:14:13 03/25/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/IFstage_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_Stage
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
 
ENTITY IFstage_TB IS
END IFstage_TB;
 
ARCHITECTURE behavior OF IFstage_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_Stage
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	
	COMPONENT RAM is
	Port (
		 clk : in std_logic;
		 inst_addr : in std_logic_vector(10 downto 0);
		 inst_dout : out std_logic_vector(31 downto 0);
		 data_we : in std_logic;
		 data_addr : in std_logic_vector(10 downto 0);
		 data_din : in std_logic_vector(31 downto 0);
		 data_dout : out std_logic_vector(31 downto 0));		
	 
	 END COMPONENT; 
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
	
	--RAM INPUTS 
 	
 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
	--RAM Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
	
   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_Stage PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RST => RST,
          CLK => CLK,
          PC => PC
        );
	uu: RAM PORT MAP (
         clk => CLK,
			inst_addr => PC(12 DOWNTO 2),
			inst_dout => inst_dout,
			data_we => '0',
			data_addr => (others => '0'),
			data_din => (others => '0')
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
      -- hold reset state for 200 ns.
      RST	<= '1';
		wait for 200 ns;	
		for i in 0 to 10 loop
			PC_Immed  <= X"00000000";
			PC_sel	<= '0';
			PC_LdEn	<= '1';
			RST	<= '0';
		wait for clk_period;
		end loop;
		
		
		PC_Immed  <= X"00000004";
		PC_sel	<= '1';
		PC_LdEn	<= '1';
		RST	<= '0';
		wait for CLK_period;

		PC_Immed  <= X"00000000";
		PC_sel	<= '0';
		PC_LdEn	<= '1';
		RST	<= '0';
		wait for CLK_period;

		PC_Immed  <= X"00000008";
		PC_sel	<= '1';
		PC_LdEn	<= '1';
		RST	<= '0';
		wait for CLK_period;

		PC_Immed  <= X"00000000";
		PC_sel	<= '0';
		PC_LdEn	<= '1';
		RST	<= '0';
		wait for CLK_period;

		PC_Immed  <= X"00000000";
		PC_sel	<= '1';
		PC_LdEn	<= '1';
		RST	<= '1';
		wait for CLK_period;
		PC_Immed  <= X"00000000";
		PC_sel	<= '0';
		PC_LdEn	<= '1';
		RST	<= '0';
		wait for CLK_period;

      -- insert stimulus here 

      wait;
   end process;

END;
