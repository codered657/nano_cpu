----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:12:08 03/27/2014 
-- Design Name: 
-- Module Name:    StackControlUnit - RTL 
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
use work.GeneralFuncPkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity StackControlUnit is
    port(clk: in std_logic;
         en: in std_logic;
         op: in std_logic_vector(1 downto 0);
         sp_load_in: in std_logic_vector(15 downto 0);
         sp_out: out std_logic_vector(15 downto 0)
         );
end StackControlUnit;

architecture RTL of StackControlUnit is

constant OP_PUSH: std_logic_vector := "01";
constant OP_POP: std_logic_vector := "10";
constant OP_LOAD: std_logic_vector := "11";

signal stackPointer: std_logic_vector(15 downto 0);

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
            if (en = '1') then
                case op is
                    when OP_PUSH => sp_out <= (others => '0');
                                    stackPointer <= increment(stackPointer);
                    when OP_POP => sp_out <= stackPointer;
                                   stackPointer <= decrement(stackPointer);
                    when OP_LOAD => sp_out <= (others => '0');
                                   stackPointer <= sp_load_in;
                    when others => sp_out <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end RTL;

