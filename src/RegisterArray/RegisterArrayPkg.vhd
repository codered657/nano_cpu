--  Register Array Package
--
--  Description: This package contains types and constants for the Register Array of 
--               nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     03/24/14    1) Initial revision.
--

library ieee;
use ieee.std_logic_1164.all;

package RegisterArrayPkg is
    
    -- Control bus from control unit to register array.
    type control_to_reg is
        record
            RegANum     : std_logic_vector(3 downto 0); -- Register A index
            RegBNum     : std_logic_vector(3 downto 0); -- Register B index
            RegAWr      : std_logic;                    -- Register A write enable
            RegBWr      : std_logic;                    -- Register B write enable
        end record;
       
end package RegisterArrayPkg;
