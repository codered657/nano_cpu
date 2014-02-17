--  Opcodes Package
--
--  Description: This file contains the opcodes for the nano_cpu.
--
--  Revision History:
--      Steven Okai     02/15/13    Initial revision.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package OpcodesPkg is

    -- Opcode type
    subtype opcode is std_logic_vector(15 downto 0);
    
    -- Arithmetic opcodes.
    constant OPCODE_ADD  : opcode := "00000000_--------";
    constant OPCODE_SUB  : opcode := "00000001_--------";
    constant OPCODE_AND  : opcode := "00000010_--------";
    constant OPCODE_OR   : opcode := "00000011_--------";
    constant OPCODE_XOR  : opcode := "00000100_--------";
    constant OPCODE_NEG  : opcode := "00000101_--------";
    constant OPCODE_NOT  : opcode := "00000110_--------";
    constant OPCODE_SLL  : opcode := "00000111_--------";
    constant OPCODE_SRL  : opcode := "00001000_--------";
    constant OPCODE_SRA  : opcode := "00001001_--------";
    constant OPCODE_BSET : opcode := "00001010_--------";
    constant OPCODE_BCLK : opcode := "00001011_--------";
    constant OPCODE_INC  : opcode := "00001100_--------";
    constant OPCODE_DEC  : opcode := "00001101_--------";
    
    constant OPCODE_LDI : opcode := "1XXX----_--------"; -- Load from immediate
    constant OPCODE_LDM : opcode := "0XXXXXXX_--------"; -- Load from memory
    constant OPCODE_STR : opcode := "0XXXXXXX_--------"; -- Store (from register)
    constant OPCODE_MOV : opcode := "0XXXXXXX_--------"; -- Move (register to register)
    
    constant OPCODE_PUSH : opcode := "0XXXXXXX_XXXXXXXX";
    constant OPCODE_POP  : opcode := "0XXXXXXX_XXXXXXXX";
    
    constant OPCODE_CALL : opcode := "0XXXXXXX_XXXXXXXX"; -- Call
    constant OPCODE_RET  : opcode := "0XXXXXXX_XXXXXXXX"; -- Return
    
    constant OPCODE_JMP  : opcode := "0XXXXXXX_XXXXXXXX"; -- Unconditional jump
    
    constant OPCODE_JPLT : opcode := "0XXXXXXX_--------"; -- Jump less than (signed)
    constant OPCODE_JPGT : opcode := "0XXXXXXX_--------"; -- Jump greater than (signed)
    constant OPCODE_JPLE : opcode := "0XXXXXXX_--------"; -- Jump less than equal (signed)
    constant OPCODE_JPGE : opcode := "0XXXXXXX_--------"; -- Jump greater than equal (signed)
    constant OPCODE_JPA  : opcode := "0XXXXXXX_--------"; -- Jump above (unsigned)
    constant OPCODE_JPB  : opcode := "0XXXXXXX_--------"; -- Jump below (unsigned)
    constant OPCODE_JPAE : opcode := "0XXXXXXX_--------"; -- Jump above equal (unsigned)
    constant OPCODE_JPBE : opcode := "0XXXXXXX_--------"; -- Jump below equal (unsigned)
    constant OPCODE_JPEQ : opcode := "0XXXXXXX_--------"; -- Jump equal
    constant OPCODE_JPNE : opcode := "0XXXXXXX_--------"; -- Jump not equal
    
    
    constant OPCODE_JPC : opcode := "0XXXXXXX_XXXXXXXX"; -- Jump carry
    constant OPCODE_JPO : opcode := "0XXXXXXX_XXXXXXXX"; -- Jump overflow
    constant OPCODE_JPZ : opcode := "0XXXXXXX_XXXXXXXX"; -- Jump zero
    constant OPCODE_JPN : opcode := "0XXXXXXX_XXXXXXXX"; -- Jump negative

    
end package OpcodesPkg;