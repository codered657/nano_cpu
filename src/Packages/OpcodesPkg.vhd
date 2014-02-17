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
    constant OPCODE_ADD  : opcode := "00000000--------";
    constant OPCODE_SUB  : opcode := "00000001--------";
    constant OPCODE_AND  : opcode := "00000010--------";
    constant OPCODE_OR   : opcode := "00000011--------";
    constant OPCODE_XOR  : opcode := "00000100--------";
    constant OPCODE_NEG  : opcode := "00000101--------";
    constant OPCODE_NOT  : opcode := "00000110--------";
    constant OPCODE_SLL  : opcode := "00000111--------";
    constant OPCODE_SRL  : opcode := "00001000--------";
    constant OPCODE_SRA  : opcode := "00001001--------";
    constant OPCODE_BSET : opcode := "00001010--------";
    constant OPCODE_BCLK : opcode := "00001011--------";
    constant OPCODE_INC  : opcode := "00001100--------";
    constant OPCODE_DEC  : opcode := "00001101--------";
    
    constant OPCODE_LDI : opcode := "1XXX------------"; -- Load from immediate
    constant OPCODE_LDM : opcode := "0XXXXXXX--------"; -- Load from memory
    constant OPCODE_STR : opcode := "0XXXXXXX--------"; -- Store (from register)
    constant OPCODE_MOV : opcode := "0XXXXXXX--------"; -- Move (register to register)
    
    constant OPCODE_PUSH : opcode := "0XXXXXXXXXXXXXXX";
    constant OPCODE_POP  : opcode := "0XXXXXXXXXXXXXXX";
    
    constant OPCODE_CALL : opcode := "0XXXXXXXXXXXXXXX"; -- Call
    constant OPCODE_RET  : opcode := "0XXXXXXXXXXXXXXX"; -- Return
    
    constant OPCODE_JMP  : opcode := "0XXXXXXX_XXXXXXXX"; -- Unconditional jump
    
    constant OPCODE_JPLT : opcode := "0XXXXXXX--------"; -- Jump less than (signed)
    constant OPCODE_JPGT : opcode := "0XXXXXXX--------"; -- Jump greater than (signed)
    constant OPCODE_JPLE : opcode := "0XXXXXXX--------"; -- Jump less than equal (signed)
    constant OPCODE_JPGE : opcode := "0XXXXXXX--------"; -- Jump greater than equal (signed)
    constant OPCODE_JPA  : opcode := "0XXXXXXX--------"; -- Jump above (unsigned)
    constant OPCODE_JPB  : opcode := "0XXXXXXX--------"; -- Jump below (unsigned)
    constant OPCODE_JPAE : opcode := "0XXXXXXX--------"; -- Jump above equal (unsigned)
    constant OPCODE_JPBE : opcode := "0XXXXXXX--------"; -- Jump below equal (unsigned)
    constant OPCODE_JPEQ : opcode := "0XXXXXXX--------"; -- Jump equal
    constant OPCODE_JPNE : opcode := "0XXXXXXX--------"; -- Jump not equal
    
    
    constant OPCODE_JPC : opcode := "0XXXXXXXXXXXXXXX"; -- Jump carry
    constant OPCODE_JPO : opcode := "0XXXXXXXXXXXXXXX"; -- Jump overflow
    constant OPCODE_JPZ : opcode := "0XXXXXXXXXXXXXXX"; -- Jump zero
    constant OPCODE_JPN : opcode := "0XXXXXXXXXXXXXXX"; -- Jump negative

    
end package OpcodesPkg;