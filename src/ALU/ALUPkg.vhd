--  ALU Package
--
--  Description: This package contains types and constants for the ALU of nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/15/13    1) Initial revision.
--                                  2) Added values for F-block ops.
--

library IEEE;
use IEEE.std_logic_1164.all;

package ALUPkg is
    -- ALU opcode type
    subtype alu_op is std_logic_vector(7 downto 0);
    
    -- ALU opcodes
    constant ALU_OP_ADD  : alu_op := "00010000"; -- ADD R1, R2
    constant ALU_OP_SUB  : alu_op := "00100000"; -- SUB R1, R2
    constant ALU_OP_AND  : alu_op := "00001000"; -- AND R1, R2
    constant ALU_OP_OR   : alu_op := "00001110"; -- OR R1, R2
    constant ALU_OP_XOR  : alu_op := "00000110"; -- XOR R1, R2 
    constant ALU_OP_NEG  : alu_op := "00110000"; -- NEG R1 
    constant ALU_OP_NOT  : alu_op := "00000011"; -- NOT R1
    constant ALU_OP_SLL  : alu_op := "01000000"; -- SLL R1, R2
    constant ALU_OP_SRL  : alu_op := "01010000"; -- SRL R1, R2
    constant ALU_OP_SRA  : alu_op := "01100000"; -- SRA R1, R2
    constant ALU_OP_BSET : alu_op := "01110000"; -- BSET R1, R2 
    constant ALU_OP_BCLR : alu_op := "10000000"; -- BCLR R1, R2
    constant ALU_OP_INC  : alu_op := "10010000"; -- INC R1
    constant ALU_OP_DEC  : alu_op := "10100000"; -- DEC R1
	
	
	constant ALU_FBLOCK_SELECT 	: std_logic_vector(3 downto 0) := "0000";  -- indicates fblock action
    
end package ALUPkg;