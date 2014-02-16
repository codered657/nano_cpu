--  Control Unit
--
--  Description: This is the control unit for the nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/16/13    1) Initial revision.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ControlUnitPkg.all;

entity ControlUnit is
    port (
        Clk         : in std_logic;
        Reset       : in std_logic;
        
        OpcodeIn    : in opcode;
        
        FlagsIn     : in std_logic_vector(7 downto 0); -- TODO: update to use a constant
        
        ALUControl  : out control_to_alu;
        
        RegControl  : out control_to_reg
        
    );
    
end ControlUnit;

architecture RTL of ControlUnit is
    
end RTL;
        
        
        