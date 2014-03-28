----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:22 03/24/2014 
-- Design Name: 
-- Module Name:    adder_subtractor_1b - RTL 
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

entity adder_subtractor_1b is
	port (c_in: in std_logic;
		  A: in std_logic;
          B: in std_logic;
		  S: out std_logic;
          c_out: out std_logic
          );
end adder_subtractor_1b;

architecture RTL of adder_subtractor_1b is

begin
            
    S <= A xor B xor c_in;
    c_out <= (A and B) or (c_in and (A xor B));

end RTL;

