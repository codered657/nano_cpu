--  Instruction Address Unit Package
--
--  Description: This package contains types and constants for the Address Instrtion
--               Unit of nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     03/24/14    1) Initial revision.
--

library ieee;
use ieee.std_logic_1164.all;

package InstructionAddressUnitPkg is

    -- Control bus from control unit to instruction address unit.
    type control_to_iau is
        record
            Load                : std_logic;                    -- Load address flag.
            Fetch               : std_logic;                    -- Request to fetch next instruction.
            OffsetSourceSel     : std_logic_vector(2 downto 0); -- Offset source select.
        end record;
        
    constant OFFSET_SEL_UNCONDITIONAL   : std_logic_vector(2 downto 0) := "000";
    constant OFFSET_SEL_CONDITIONAL     : std_logic_vector(2 downto 0) := "001";
    constant OFFSET_SEL_REGISTER        : std_logic_vector(2 downto 0) := "010";
    constant OFFSET_SEL_ZERO            : std_logic_vector(2 downto 0) := "011";
    constant OFFSET_SEL_INCREMENT       : std_logic_vector(2 downto 0) := "100";
    
end package InstructionAddressUnitPkg;
