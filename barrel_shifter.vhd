----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:53 03/16/2014 
-- Design Name: 
-- Module Name:    barrel_shifter - RTL 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity barrel_shifter is

	port(op: in std_logic_vector (3 downto 0);
		  r1: in std_logic_vector (7 downto 0);
		  res: out std_logic_vector (7 downto 0));

end barrel_shifter;



architecture RTL of barrel_shifter is

	signal dir: std_logic; -- 1: left, 0: right
	signal num_shift_rotate: std_logic_vector (2 downto 0); -- number of shifts
	signal arith_logical: std_logic; -- 1: arithmetic 0:logical
	signal shift_rot: std_logic; -- 1: shift 0:rotate
	
	constant LEFT   : std_logic := '1';
	constant RIGHT  : std_logic := '0';
	constant SHIFT  : std_logic := '1';
	constant ROTATE : std_logic := '0';
	constant ARITH  : std_logic := '1';
	constant LOGICAL: std_logic := '0';

begin

	process(op,r1,dir,num_shift_rotate,shift_rot,arith_logical)
	
	begin
		
		if (shift_rot = SHIFT) then
		
			if (dir = LEFT) then
				case num_shift_rotate is
					when std_logic_vector(to_unsigned(1,3)) => 	res <= r1(6 downto 0) & "0";
					when std_logic_vector(to_unsigned(2,3)) => 	res <= r1(5 downto 0) & "00";
					when std_logic_vector(to_unsigned(3,3)) => 	res <= r1(4 downto 0) & "000";
					when std_logic_vector(to_unsigned(4,3)) => 	res <= r1(3 downto 0) & "0000";
					when std_logic_vector(to_unsigned(5,3)) => 	res <= r1(2 downto 0) & "00000";
					when std_logic_vector(to_unsigned(6,3)) => 	res <= r1(1 downto 0) & "000000";
					when std_logic_vector(to_unsigned(7,3)) => 	res <= r1(0 downto 0) & "0000000";
					when others => res <= "00000000";
				end case;						
			end if;
			
			if (dir = RIGHT) then
				if (arith_logical = LOGICAL) then
					case num_shift_rotate is
						when std_logic_vector(to_unsigned(1,3)) => 	res <= "0" & r1(7 downto 1);
						when std_logic_vector(to_unsigned(2,3)) => 	res <= "00" & r1(7 downto 2);
						when std_logic_vector(to_unsigned(3,3)) => 	res <= "000" & r1(7 downto 3);
						when std_logic_vector(to_unsigned(4,3)) => 	res <= "0000" & r1(7 downto 4);
						when std_logic_vector(to_unsigned(5,3)) => 	res <= "00000" & r1(7 downto 5);
						when std_logic_vector(to_unsigned(6,3)) => 	res <= "000000" & r1(7 downto 6);
						when std_logic_vector(to_unsigned(7,3)) => 	res <= "0000000" & r1(7 downto 7);
						when others => res <= "00000000";
					end case;						
				end if;
				if (arith_logical = ARITH) then
					case num_shift_rotate is
						when std_logic_vector(to_unsigned(1,3)) => 	res <= r1(7) & r1(7 downto 1);
						when std_logic_vector(to_unsigned(2,3)) => 	res <= r1(7) & r1(7) & r1(7 downto 2);
						when std_logic_vector(to_unsigned(3,3)) => 	res <= r1(7) & r1(7) & r1(7) & r1(7 downto 3);
						when std_logic_vector(to_unsigned(4,3)) => 	res <= r1(7) & r1(7) & r1(7) & r1(7) & r1(7 downto 4);
						when std_logic_vector(to_unsigned(5,3)) => 	res <= r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7 downto 5);
						when std_logic_vector(to_unsigned(6,3)) => 	res <= r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7 downto 6);
						when std_logic_vector(to_unsigned(7,3)) => 	res <= r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7) & r1(7 downto 7);
						when others => res <= "00000000";
					end case;						
				end if;
			end if;		
		
		end if;
		
		
		if (shift_rot = ROTATE) then
		
			if (dir = LEFT) then
				case num_shift_rotate is
					when std_logic_vector(to_unsigned(1,3)) => 	res <= r1(6 downto 0) & r1(7 downto 7);
					when std_logic_vector(to_unsigned(2,3)) => 	res <= r1(5 downto 0) & r1(7 downto 6);
					when std_logic_vector(to_unsigned(3,3)) => 	res <= r1(4 downto 0) & r1(7 downto 5);
					when std_logic_vector(to_unsigned(4,3)) => 	res <= r1(3 downto 0) & r1(7 downto 4);
					when std_logic_vector(to_unsigned(5,3)) => 	res <= r1(2 downto 0) & r1(7 downto 3);
					when std_logic_vector(to_unsigned(6,3)) => 	res <= r1(1 downto 0) & r1(7 downto 2);
					when std_logic_vector(to_unsigned(7,3)) => 	res <= r1(0 downto 0) & r1(7 downto 1);
					when others => res <= "00000000";
				end case;						
			end if;
			
			if (dir = RIGHT) then
				case num_shift_rotate is
					when std_logic_vector(to_unsigned(1,3)) => 	res <= r1(0 downto 0) & r1(7 downto 1);
					when std_logic_vector(to_unsigned(2,3)) => 	res <= r1(1 downto 0) & r1(7 downto 2);
					when std_logic_vector(to_unsigned(3,3)) => 	res <= r1(2 downto 0) & r1(7 downto 3);
					when std_logic_vector(to_unsigned(4,3)) => 	res <= r1(3 downto 0) & r1(7 downto 4);
					when std_logic_vector(to_unsigned(5,3)) => 	res <= r1(4 downto 0) & r1(7 downto 5);
					when std_logic_vector(to_unsigned(6,3)) => 	res <= r1(5 downto 0) & r1(7 downto 6);
					when std_logic_vector(to_unsigned(7,3)) => 	res <= r1(6 downto 0) & r1(7 downto 7);
					when others => res <= "00000000";
				end case;						
			end if;		
		
		end if;
	
	
	
	end process;

end RTL;

