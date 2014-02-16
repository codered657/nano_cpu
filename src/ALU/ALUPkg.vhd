--  ALU Package
--
--  Description: The package contains types and constants for the ALU of nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/15/13    1) Initial revision.
--                                  2) Added values for F-block ops.
--

package ALUPkg is
    -- ALU opcode type
    subtype alu_op is std_logic_vector(7 downto 0);
    
    -- ALU opcodes
    constant ALU_OP_ADD  : alu_op := "XXXXXXXX"; -- ADD R1, R2
    constant ALU_OP_SUB  : alu_op := "XXXXXXXX"; -- SUB R1, R2
    constant ALU_OP_AND  : alu_op := "00001000"; -- AND R1, R2
    constant ALU_OP_OR   : alu_op := "00001110"; -- OR R1, R2
    constant ALU_OP_XOR  : alu_op := "00000110"; -- XOR R1, R2 
    constant ALU_OP_NEG  : alu_op := "XXXXXXXX"; -- NEG R1 
    constant ALU_OP_NOT  : alu_op := "00000011"; -- NOT R1
    constant ALU_OP_SLL  : alu_op := "XXXXXXXX"; -- SLL R1, R2
    constant ALU_OP_SRL  : alu_op := "XXXXXXXX"; -- SRL R1, R2
    constant ALU_OP_SRA  : alu_op := "XXXXXXXX"; -- SRA R1, R2
    constant ALU_OP_BSET : alu_op := "XXXXXXXX"; -- BSET R1, R2 
    constant ALU_OP_BCLK : alu_op := "XXXXXXXX"; -- BCLR R1, R2
    constant ALU_OP_INC  : alu_op := "XXXXXXXX"; -- INC R1
    constant ALU_OP_DEC  : alu_op := "XXXXXXXX"; -- DEC R1
    
end package ALUPkg;