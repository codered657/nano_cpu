----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:35:10 03/18/2014 
-- Design Name: 
-- Module Name:    RAM - RTL 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    port( clk: in std_logic;
        en: in std_logic;
        r_nw: in std_logic;
        address: in std_logic_vector(15 downto 0);
        data_out: out std_logic_vector(7 downto 0);
        data_in: in std_logic_vector(7 downto 0)
		);
end RAM;

architecture RTL of RAM is

    type RAM_array is array (0 to 1024) of std_logic_vector(7 downto 0);
    signal RAM: RAM_array := (others => (others => '0'));
	
    attribute ram_style: string;
    attribute ram_style of RAM : signal is "block";

begin


process(clk, en, r_nw, data_in, address)
begin
    if(rising_edge(clk) and (en = '1')) then
        if (r_nw = '1') then
            data_out <= RAM(to_integer(unsigned(address)));
        else
            RAM(to_integer(unsigned(address))) <= data_in;
        end if;
    end if; 
end process;


end RTL;

