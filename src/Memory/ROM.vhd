----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:05 03/18/2014 
-- Design Name: 
-- Module Name:    ROM - RTL 
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

entity ROM is
    port( clk: in std_logic;
        en: in std_logic;
        address: in std_logic_vector(15 downto 0);
        data_out: out std_logic_vector(15 downto 0)
		);
end ROM;

architecture RTL of ROM is
	
    type ROM_array is array (0 to 4095) of std_logic_vector(15 downto 0);
    signal ROM: ROM_array := (others => (others => '0'));
	
    attribute ram_style: string;
    attribute ram_style of ROM : signal is "block";

begin

process(clk, en, address)
begin
    if(rising_edge(clk) and (en = '1')) then
        data_out <= ROM(to_integer(unsigned(address)));
    end if; 
end process;


end RTL;

