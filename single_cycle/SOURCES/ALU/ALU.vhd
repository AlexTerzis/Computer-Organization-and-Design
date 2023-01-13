----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:33:05 03/13/2022 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);

end ALU;

architecture Behavioral of ALU is

signal sig_Cout: STD_LOGIC_VECTOR (32 downto 0);
signal sig,sig_B: STD_LOGIC_VECTOR (31 downto 0); 
signal flag_ovf,sig_ovf: STD_LOGIC;

begin
	Outp <= sig after 10 ns;
	ovf <= sig_ovf;
					--prosimo apotelesma diaforetiko	--idio proshma	--an exo add  h sub
	sig_Ovf <= ((sig(31) xor A(31)) and (A(31) xnor sig_B(31)))and flag_ovf after 10ns;--
	
	Cout <= sig_Cout(32) after 10ns;
	
	Zero <= not sig_ovf after 10 ns when signed (sig)= 0 
					else '0' after 10ns;
	
	process (Op,A,B) begin
		
		flag_ovf <= '0'; --voithitiko shma,to kano 0 giati ovf yparxei mono otan kanoume add h sub
		
		sig_B <= B ;
		
		Case Op is
			when "0000" =>	sig <= A + B;
								flag_ovf <= '1';
								sig_Cout<= ('0' & A) + ('0' & B);
			when "0001" =>	sig <= A - B;
								sig_B <= -B;--elegxo opos sthn proti periptosi, giafto andistrefo to b								
								sig_Cout<= ('0' & A) + ('0' & sig_B);
								flag_ovf <= '1';
			when "0010" =>	sig<= A and B;
								sig_Cout<= (others=> '0');
								
			when "0011" =>	sig<= A or B;
								sig_Cout<= (others=> '0');
								
			when "0100" =>	sig<= not A ;
								sig_Cout<= (others=> '0');
								
			when "0101" =>	sig<= A nand B;
								sig_Cout<= (others=> '0');
			
			when "0110" => sig<= A nor B;
								sig_Cout<= (others=> '0');

			when "1000" =>	sig<= (A(31) & A(31 downto 1));
								sig_Cout<= (others=> '0');
								
			when "1001" =>	sig<= ('0' & A(31 downto 1));
								sig_Cout<= (others=> '0');
								
			when "1010" =>	sig<= (A(30 downto 0) & '0');
								sig_Cout<= (others=> '0');
								
			when "1100" =>	sig<= (A(30 downto 0)& A(31));
								sig_Cout<= (others=> '0');
								
			when "1101" =>	sig<= (A(0) & A(31 downto 1));
								sig_Cout<= (others=> '0');
			
			when others => sig<= (others=> '0');			
								sig_Cout<= (others=> '0');
		End Case;		
   End process;	
	
end Behavioral;


