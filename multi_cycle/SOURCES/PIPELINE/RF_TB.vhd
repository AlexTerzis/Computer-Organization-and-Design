--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:30:13 03/22/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/RF_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile
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
 
ENTITY RF_TB IS
END RF_TB;
 
ARCHITECTURE behavior OF RF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
			RST : IN std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal CLK : std_logic := '0';
	signal RST : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          CLK => CLK,
			 RST => RST
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
          -- hold RST state for 200 ns.
          RST <= '1';
			 wait for 200 ns;	
          -- insert stimulus here 
			 Ard1 <= "00001";		
          Ard2 <= "00001";		--Ard1 kai ard2 deixnoun ston reg1
          Awr <= "00001";		--eisago ston reg1 
          Din <= "00000000000000000000000000000001";--thn timh 1
          WrEn <= '1'; --active to write
			 RST <= '0';
			 wait for CLK_period;
		  	 
			 Ard1 <= "00010";   
          Ard2 <= "00010"; --Ard1 kai ard2 deixnoun ston reg2
          Awr <= "00010"; --eisago ston reg2 mia tyxaia timh
          Din <= "00000000000000000000000001111111";
          WrEn <= '1';
			 RST <= '0';
			 wait for CLK_period;
			 
			 Ard1 <= "00010"; --vgazo san exodo to reg2
          Ard2 <= "00001"; --vgazo san exodo to reg1
          Awr <= "00011";          
          Din <= "00011000000000000000001100001010";
          WrEn <= '0';	--dont write
			 wait for CLK_period;

			 Ard1 <= "00000"; --prospatho na allaxo thn timh reg1 alla dn ginetai wr en un active
          Ard2 <= "00100";
          Awr <= "00001";
          Din <= "00111110000000000000000000000000";
          WrEn <= '0'; --dont write
			 wait for CLK_period;

			 Ard1 <= "00000";--prospatho na allaxo thn timh reg1 ginetai wren active 
          Ard2 <= "00100";
          Awr <= "00010";
          
          Din <= "00000000000000000000111000001100";
          WrEn <= '1';
			 wait for CLK_period;

			 Ard1 <= "00001"; --emfanizo times reg 1 kai reg 2
          Ard2 <= "00010";
          Awr <= "00100";
          
          Din <= "00000000000000000000000000000000";
          WrEn <= '0';
			 wait for CLK_period;

			 wait;
   end process;

END;
