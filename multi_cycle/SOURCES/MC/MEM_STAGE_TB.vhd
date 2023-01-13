--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:06:59 04/03/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/MEM_STAGE_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
USE ieee.numeric_std.ALL;
 
ENTITY MEM_STAGE_TB IS
END MEM_STAGE_TB;
 
ARCHITECTURE behavior OF MEM_STAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_ADDR : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(10 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT RAM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_ADDR : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
	
	signal CLK : std_logic := '0';
	
 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
	
	
	
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_ADDR => ALU_MEM_ADDR,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );
		  
	uu: ram PORT MAP (	 
			clk => CLK,
			inst_addr => (others => '0'),
			data_we => MM_WrEn,
			data_addr => MM_Addr,
			data_din => MM_WrData,
			data_dout => MM_RdData
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
		   
	for i in 0 to 16 loop
			ByteOp <= '0';
          Mem_WrEn <= '1';
          ALU_MEM_ADDR <= std_logic_vector(to_unsigned(i,32));
          MEM_DataIn <=std_logic_vector(to_unsigned(i*5,32)); 
			 
	wait for 100 ns;
	end loop;
	
	for i in 17 to 24 loop
			ByteOp <= '1';
          Mem_WrEn <= '1';
          ALU_MEM_ADDR <= std_logic_vector(to_unsigned(i,32));
          MEM_DataIn <=std_logic_vector(to_unsigned(i*5,32)); 
			 
	wait for 100 ns;
	end loop;
 
	for i in 0 to 12 loop
			 ByteOp <= '0';
          Mem_WrEn <= '0';
          ALU_MEM_ADDR <= std_logic_vector(to_unsigned(i,32));
          MEM_DataIn <=(others => '0'); 
	wait for 100 ns;
	end loop;
	
	for i in 13 to 24 loop
			 ByteOp <= '1';
          Mem_WrEn <= '0';
          ALU_MEM_ADDR <= std_logic_vector(to_unsigned(i,32));
          MEM_DataIn <=(others => '0'); 
	wait for 100 ns;
	end loop;

      -- insert stimulus here 
			
      wait;
   end process;
	

END;
