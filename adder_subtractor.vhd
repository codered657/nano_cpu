----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:08:31 02/16/2014 
-- Design Name: 
-- Module Name:    adder_subtractor - RTL 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_subtractor is
	port(op: in std_logic_vector (7 downto 0);	
		  r1, r2: in std_logic_vector(7 downto 0);
		  sum_diff: out std_logic_vector(7 downto 0));
end adder_subtractor;

architecture RTL of adder_subtractor is

begin
	sum_diff <= std_logic_vector(unsigned(r1) + unsigned(r2));

end RTL;

