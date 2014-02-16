----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:16:23 02/15/2014 
-- Design Name: 
-- Module Name:    f_block - RTL 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity f_block is
	port(f_op: in std_logic_vector (3 downto 0);
		  f_r1, f_r2: in std_logic_vector (7 downto 0);
		  f: out std_logic_vector (7 downto 0));
end f_block;

architecture RTL of f_block is

begin

	generate_mux4x8: for i in 0 to 7 generate
		mux4x1_i : entity work.mux4x1 port map (
			a => f_op(0),
			b => f_op(1),
			c => f_op(2),
			d => f_op(3),
			sel => f_r1(i) & f_r2(i),
			x => f(i));
	end generate;

end RTL;

