--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:48:50 04/11/2022
-- Design Name:   
-- Module Name:   C:/Lab_User_Temp/HRY203/lab1/DATAPATH_TB.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_LdEn : IN  std_logic;
         PC_Sel : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         Mem_WrEn : IN  std_logic;
         ByteOp : IN  std_logic;
         MM_RdData : IN  std_logic_vector(31 downto 0);
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_ZERO : OUT  std_logic;
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(10 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_LdEn : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_WrEn : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
   signal ALU_ZERO : std_logic;
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_LdEn => PC_LdEn,
          PC_Sel => PC_Sel,
          CLK => CLK,
          RST => RST,
          PC => PC,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          ByteOp => ByteOp,
          MM_RdData => MM_RdData,
          Instr => Instr,
          ALU_ZERO => ALU_ZERO,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData
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
		wait for clk_period*1;
		
		PC_sel <='0'; 
		
		PC_LdEn <='1'; 
		rst <= '0';
		wait for clk_period*1;
		--wait for 10 ns ;
		rst <= '0';
	

		  -- addi r5,r0,8
		Instr <= "11000000000001010000000000001000";
		PC_sel <='0'; 
		PC_LdEn<='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out 
		RF_B_sel  <='0';
		ImmExt<="00";  -- SIGN EXT
		ALU_Bin_sel <='1';  --Immed
		ALU_func <="0000"; --add			
		Mem_WrEn  <='0';

		wait for clk_period*1;
		
		-- ori r3,r0,ABCD]
		
		Instr <= "11001100000000111010101111001101";
		PC_sel <='0'; 			
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out 
		RF_B_sel  <='0';
		ImmExt<="01"; --zero fill
		ALU_Bin_sel <='1';  --Immed
		ALU_func <="0011"; --OR			
		Mem_WrEn  <='0';
		wait for clk_period*1;
		
		-- sw r3 4(r0)
		Instr <= "01111100000000110000000000000100";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='0';
		RF_WrData_sel <='1'; --Mem out dont care
		RF_B_sel  <='1';
		ImmExt<="00";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000";	--add	
		Mem_WrEn  <='1'; 
		wait for clk_period*1;

		-- lw r10,-4(r5)
		Instr <= "00111100101010101111111111111100"; 
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='0';
		ImmExt<="00";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000";--add		
		Mem_WrEn  <='0'; 
		MM_RdData <= x"0000abcd";		
		wait for clk_period*1;
		
		-- lb r16 4(r0)
		Instr <= "00001100000100000000000000000100";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		ByteOp <='1';
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='1';
		ImmExt<="00";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000"; --add		
		Mem_WrEn  <='0';

		wait for clk_period*1;
		
		-- nand r4,r0,r16
		Instr <= "10000001010001001000000000110101";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --alu 
		RF_B_sel  <='0'; --rt
		ImmExt<="01"; -- dont care
		ALU_Bin_sel <='0';  --RF_B
		ALU_func  <="0101"; --nand		
		Mem_WrEn  <='0';  
		wait for clk_period*1;
    -- NO OPERATION
		Instr <= (OTHERS => '0');
		PC_sel <='0'; 
		PC_LdEn <='0'; 
		RF_WrEn <='0';
		RF_WrData_sel <='0'; 
		RF_B_sel  <='0'; 
		ImmExt<="00"; -- 
		ALU_Bin_sel <='0';  
		ALU_func  <="0000"; 	
		Mem_WrEn  <='0';  
		wait for clk_period*1;
    
      wait;
   end process;

END;
