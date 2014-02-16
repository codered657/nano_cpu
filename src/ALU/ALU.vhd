----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:30 02/15/2014 
-- Design Name: 
-- Module Name:    ALU - RTL 
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

use work.ALUPkg.all;

entity ALU is
	port(clk: in std_logic;	
		  op, r1, r2: in std_logic_vector(7 downto 0);
		  result, flags: out std_logic_vector(7 downto 0));
end ALU;

architecture RTL of ALU is
	signal f_output: std_logic_vector(7 downto 0);
begin

f_block_i : entity work.f_block port map (
	f_op => op(3 downto 0), --the lower four bits of the opcode correspond to the bit operation
	f_r1 => r1,
	f_r2 => r1,
	f => f_output);

process (clk,op,r1,r2)
begin
	if (rising_edge(clk)) then
		case op is
			when ALU_OP_ADD => 	result <= std_logic_vector(unsigned(R1) + unsigned(R2));
			when ALU_OP_SUB => 	result <= std_logic_vector(unsigned(R1) - unsigned(R2));
			when ALU_OP_AND => 	result <= f_output;
			when ALU_OP_OR =>  	result <= f_output;
			when ALU_OP_XOR => 	result <= f_output;
			when ALU_OP_NEG => 	result <= std_logic_vector(to_unsigned(0,8) - unsigned(R1));
			when ALU_OP_NOT => 	result <= f_output;
			when ALU_OP_SLL => 	result <= R1(6 downto 0) & '0';
			when ALU_OP_SRL => 	result <= '0' & R1(7 downto 1);
			when ALU_OP_SRA => 	result <= R1(7) & R1(7 downto 1);
			when ALU_OP_BSET =>	result <= R1;
			when ALU_OP_BCLR =>	result <= R1;
			when ALU_OP_INC => 	result <= std_logic_vector(unsigned(R1) + to_unsigned(1,8));
			when ALU_OP_DEC => 	result <= std_logic_vector(unsigned(R1) - to_unsigned(1,8));
			when others => result <= "00000000";
		end case;
	end if;
end process;



end RTL;

