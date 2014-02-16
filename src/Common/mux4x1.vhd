----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:54:29 02/15/2014 
-- Design Name: 
-- Module Name:    mux4x1 - RTL 
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

entity mux4x1 is
	port (a: in std_logic;
	      b: in std_logic;
			c: in std_logic;
			d: in std_logic;
			sel: in std_logic_vector(1 downto 0);
			x: out std_logic);
end mux4x1;

architecture RTL of mux4x1 is
begin

	process(a,b,c,d,sel)
	begin
		case sel is
			when "00" => x<=a;
			when "01" => x<=b;
			when "10" => x<=c;
			when others => x<=d;
		end case;
	end process;
end RTL;
