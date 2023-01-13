--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:36:48 03/29/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/DEC_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DEC_TB IS
END DEC_TB;
 
ARCHITECTURE behavior OF DEC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          CLK => CLK,
          RST => RST,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		rst <= '1';
      wait for 100 ns;
		
		Instr <= "11000000000001010000000000001000";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out<= x"00000044" ;
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		RST <= '0';
      wait for CLK_period*2;

		Instr <= "11000000000001010000000000001000";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out <= x"00000000" ;
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		RST <= '0';
      wait for CLK_period*2;

		Instr <= "11000000000001010000000000001000";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out <= x"00000000" ;
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		RST <= '0';
      wait for CLK_period*2;

		Instr <= "11001100000000111010101111001101";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out <= x"00000000" ;
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		RST <= '0';
      wait for CLK_period*2;

		Instr <= "11001100000000111010101111001101";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out <= x"00000000" ;
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		RST <= '0';
      wait for CLK_period*2;

		Instr <= "11001100000000111010101111001101";
		RF_WrEn <= '1';
		ALU_out<= x"00000008" ;
		MEM_out <= x"00000000" ;
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		RST <= '0';
      wait for CLK_period*2;
      wait;
   end process;

END;
