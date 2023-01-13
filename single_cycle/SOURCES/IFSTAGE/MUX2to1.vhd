----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:54:52 03/18/2022 
-- Design Name: 
-- Module Name:    MUX2to1 - Behavioral 
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

entity MUX2to1 is
	generic (N: integer := 32);
    Port ( inp_a : in  STD_LOGIC_VECTOR (N-1 downto 0);
           inp_b : in  STD_LOGIC_VECTOR (N-1 downto 0);
           out_mux : out  STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in  STD_LOGIC);
end MUX2to1;



architecture Behavioral of MUX2to1 is

begin				
	out_mux <= inp_a when (sel = '0')else
				  inp_b;

end Behavioral;


