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
		  op: in std_logic_vector(7 downto 0); 
          r1, r2: in std_logic_vector(7 downto 0);
		  result, flags: out std_logic_vector(7 downto 0));
end ALU;

architecture RTL of ALU is
    signal adder_in1: std_logic_vector(7 downto 0);
    signal adder_in2: std_logic_vector(7 downto 0);
    signal adder_output: std_logic_vector(7 downto 0);
	signal f_output: std_logic_vector(7 downto 0);
	signal bsetclr_out: std_logic_vector(7 downto 0);
	signal temp_result: std_logic_vector(7 downto 0);
begin

f_block : entity work.f_block port map (
	f_op => op(3 downto 0), --the lower four bits of the opcode correspond to the bit operation
	f_r1 => r1,
	f_r2 => r1, -- THIS SEEMS REALLY WRONG ????
	f => f_output
    );
    
adder : entity work.adder_subtractor port map (
	addSub => op(0),
	in0 => r1,
	in1 => adder_in2,
	res => adder_output
    );
    
process (op,r1,r2)    
begin
    if (op = ALU_OP_INC) then
        adder_in2 <= std_logic_vector(to_unsigned(1,8));
    elsif (op = ALU_OP_DEC) then
        adder_in2 <= std_logic_vector(to_unsigned(-1,8));
    else
        adder_in2 <= r2;
    end if;
end process;

process (op,r1,r2)    
begin
    if (op = ALU_OP_NEG) then
        adder_in1 <= std_logic_vector(to_unsigned(0,8));
    else
        adder_in1 <= r1;
    end if;
end process;

process (clk,op,r1,r2)
begin
	if (rising_edge(clk)) then
		case op is
			when ALU_OP_ADD => 	result <= adder_output; --flags Z,C,S,O
			when ALU_OP_SUB => 	result <= adder_output; --flags Z,C,S,O
			when ALU_OP_AND => 	result <= f_output; --flags Z,S,O
			when ALU_OP_OR =>  	result <= f_output; --flags Z,S,O
			when ALU_OP_XOR => 	result <= f_output; --flags Z,S,O
			when ALU_OP_NEG => 	result <= adder_output; --flags Z,C,S,O
			when ALU_OP_NOT => 	result <= f_output; --flags Z,S,O
			when ALU_OP_SLL => 	result <= R1(6 downto 0) & '0'; --flags 
			when ALU_OP_SRL => 	result <= '0' & R1(7 downto 1);
			when ALU_OP_SRA => 	result <= R1(7) & R1(7 downto 1);
			when ALU_OP_BSET =>	result <= bsetclr_out; -- no flags
			when ALU_OP_BCLR =>	result <= bsetclr_out; -- no flags
			when ALU_OP_INC => 	result <= adder_output; -- flags Z,S,O
			when ALU_OP_DEC => 	result <= adder_output; -- flags Z,S,O
			when others => result <= "00000000";
		end case;
	end if;
end process;

process (op,r1,r2)
begin
	bsetclr_out <= r1;
	if (op = ALU_OP_BSET) then
		bsetclr_out(to_integer(unsigned(r2))) <= '1';
	end if;
	if (op = ALU_OP_BCLR) then
		bsetclr_out(to_integer(unsigned(r2))) <= '0';
	end if;
end process;


end RTL;

