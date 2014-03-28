--  Control Unit Package
--
--  Description: This package contains types and constants for the Control Unit of nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/16/14    1) Initial revision.
--      Steven Okai     03/24/14    1) Moved control bus types out of file.
--

library ieee;
use ieee.std_logic_1164.all;
use work.ALUPkg.all;

package ControlUnitPkg is
        
    -- instruction decoder to instruction cycle counter
        -- total num cycles
    -- instruction cycle counter to decoder
        -- current cycle count

    -- Flag constants
    --                                                "---SONZC"
    constant FLAG_C : std_logic_vector(7 downto 0) := "00000001"; -- Carry flag
    constant FLAG_Z : std_logic_vector(7 downto 0) := "00000010"; -- Zero flag
    constant FLAG_N : std_logic_vector(7 downto 0) := "00000100"; -- Negative flag
    constant FLAG_O : std_logic_vector(7 downto 0) := "00001000"; -- Signed overflow flag
    constant FLAG_S : std_logic_vector(7 downto 0) := "00010000"; -- Signed bit

end package ControlUnitPkg;