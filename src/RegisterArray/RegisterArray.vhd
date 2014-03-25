--  Register Array
--
--  Description: This is the register array for the nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/15/14    1) Initial revision.
--      Steven Okai     03/24/14    1) Updated to use GeneralFuncPkg conversions.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.GeneralFuncPkg.all;
    
entity RegisterArray is
    generic (
        REG_WIDTH : natural := 8;   -- Width of registers in bits.
        NUM_REG   : natural := 16   -- Number of registers.
    );
    port (
        Clk     : in  std_logic;
        
        -- Index of register A and B.
        RegANum : in  std_logic_vector(3 downto 0);
        RegBNum : in  std_logic_vector(3 downto 0);
        
        -- Write enables for register A and B.
        RegAWr  : in  std_logic;
        RegBWr  : in  std_logic;
        
        -- Inputs for registers A and B.
        RegAIn  : in  std_logic_vector(REG_WIDTH-1 downto 0);
        RegBIn  : in  std_logic_vector(REG_WIDTH-1 downto 0);
        
        -- Outputs for registers A and B.
        RegAOut : out std_logic_vector(REG_WIDTH-1 downto 0);
        RegBOut : out std_logic_vector(REG_WIDTH-1 downto 0)
    );
    
end RegisterArray;

architecture RTL of RegisterArray is

    type reg_array is array (0 to NUM_REG-1) of std_logic_vector(REG_WIDTH-1 downto 0);
    
    -- Array of registers.
    signal registers : reg_array;
    
    begin
    
    process(Clk)
        begin
        
        if (rising_edge(Clk)) then
            
            -- If writes enabled to register A, write value.
            if (RegAWr = '1') then
                registers(slv_to_unsigned_int(RegANum)) <= RegAIn;
            end if;
            
            -- If writes enabled to register B, write value.
            if (RegBWr = '1') then
                registers(slv_to_unsigned_int(RegBNum)) <= RegBIn;
            end if;
            
            -- Output addressed registers.
            RegAOut <= registers(slv_to_unsigned_int(RegANum)) <= RegAIn;
            RegBOut <= registers(slv_to_unsigned_int(RegBNum)) <= RegBIn;

        end if;
    end process;
    
end RTL;
