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
	port (addSub: in std_logic;
		  in0: in std_logic_vector(7 downto 0);
          in1: in std_logic_vector(7 downto 0);
		  res: out std_logic_vector(7 downto 0);
          c_out: out std_logic
          );
end adder_subtractor;

architecture RTL of adder_subtractor is

signal c_rip: std_logic_vector(8 downto 0);
signal inp1: std_logic_vector(7 downto 0);

constant ADD: std_logic := '0';
constant SUB: std_logic := '1';
                   
begin

    process(addSub, in0, in1)
    begin
        if (addSub = ADD) then
            c_rip(0) <= '0';
            inp1 <= in1;
        else
            c_rip(0) <= '1';
            inp1 <= not in1;
        end if;
    end process;
    
	generate_adder: for i in 0 to 7 generate
		adder : entity work.adder_subtractor_1b port map (
			c_in => c_rip(i),
			A => in0(i),
			B => inp1(i),
			S => res(i),
			c_out => c_rip(i+1)
            );
	end generate; 

 c_out <= c_rip(8);     


end RTL;

