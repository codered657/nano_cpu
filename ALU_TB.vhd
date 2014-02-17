----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:17:53 02/16/2014 
-- Design Name: 
-- Module Name:    ALU_TB - Behavioral 
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
use work.ALUPkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is
	constant NUM_TEST_VALUES : integer := 10;
	type slv_a_array is array (0 to NUM_TEST_VALUES - 1) of std_logic_vector(7 downto 0);
	constant op_array: slv_a_array := (ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD,
												  ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD, ALU_OP_ADD);
	constant r1_array: slv_a_array := (x"00", x"01", x"02", x"01", x"01", x"01", x"01", x"01", x"01", x"01") ;
	constant r2_array: slv_a_array := (x"01", x"01", x"01", x"01", x"01", x"01", x"01", x"01", x"01", x"01") ;
	constant result_array: slv_a_array := (x"01", x"02", x"03", x"02", x"02", x"02", x"02", x"02", x"02", x"02") ;

	signal op: std_logic_vector(7 downto 0);
	signal r1: std_logic_vector(7 downto 0);
	signal r2: std_logic_vector(7 downto 0);
	signal result: std_logic_vector(7 downto 0);
	signal flags: std_logic_vector(7 downto 0);
	
	signal clk: std_logic;
	
	constant clock_period: time := 10 ns;

begin
	alu_ut : entity work.alu port map (
		clk => clk,
		op => op,
		r1 => r1,
		r2 => r2,
		result => result,
		flags => flags);
		
	process
	begin
		while (True) loop
			clk <= '1';
			wait for clock_period/2;
			clk <= '0';
			wait for clock_period/2;
		end loop;
		wait;
	end process;
	
	process
	begin
		wait until (rising_edge(clk)); 
		for i in 0 to NUM_TEST_VALUES - 1 loop
			op <= op_array(i);
			r1 <= r1_array(i);
			r2 <= r2_array(i);
			wait until (rising_edge(clk));
		end loop;
		wait;
	end process;
	
	process
	begin
		wait until (rising_edge(clk)); 
		wait until (rising_edge(clk)); 
		for i in 0 to NUM_TEST_VALUES - 1 loop
			wait for 1 ns; 
			assert (result = result_array(i))
				report integer'image(to_integer(unsigned(op))) & " " &
						 integer'image(to_integer(unsigned(r1))) & " " &
						 integer'image(to_integer(unsigned(r2)))
				severity error;
			wait until (rising_edge(clk));
		end loop;
		wait;
	end process;
	

end Behavioral;

