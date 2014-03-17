----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:50 03/16/2014 
-- Design Name: 
-- Module Name:    DataAddressUnit - RTL 
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

entity DataAddressUnit is
	port(clk: in std_logic;
	     rst: in std_logic;
		  adrSrcSelect: in std_logic; --1: stack_point, 0: register
		  r_nw: in std_logic; --1: read 0: write
		  en: in std_logic;
		  stackPointer: in std_logic_vector (15 downto 0);
		  registerAddress: in std_logic_vector (15 downto 0);
		  CpuDataIn: in std_logic_vector (7 downto 0);
		  CpuDataOut: out std_logic_vector (7 downto 0);
		  MemAddress: out std_logic_vector (15 downto 0);
		  MemDataIn: in std_logic_vector (7 downto 0);
		  MemDataOut: out std_logic_vector (7 downto 0);
		  MemEnable: out std_logic;
		  MemRW: out std_logic
		  );
		  
end DataAddressUnit;

architecture RTL of DataAddressUnit is
	signal current_state: std_logic_vector (2 downto 0);
	signal next_state: std_logic_vector (2 downto 0);
	signal stateCounter: std_logic_vector (2 downto 0);
	signal nextStateCounter: std_logic_vector (2 downto 0);
	
	constant IDLE: std_logic_vector := "000";
	constant R_ASSERT_MEM_SIGNALS: std_logic_vector := "001";
	constant R_WAIT_FOR_MEMORY_ACCESS: std_logic_vector := "010";
	constant R_GIVE_DATA_TO_CPU: std_logic_vector := "011";
	constant W_WAIT_FOR_MEMORY_ACCESS: std_logic_vector := "100";
	constant W_GIVE_DATA_TO_MEM: std_logic_vector := "101";
	
	constant NUM_WAIT_CYCLES: std_logic_vector := "011"; -- wait 3 clock cycles for memory access

begin

	-- non state machine logic
	CpuDataOut <= MemDataIn;
	MemDataOut <= CpuDataIn;
	
	process (adrSrcSelect)
	begin
		if (adrSrcSelect = '1') then
			MemAddress <= stackPointer;
		else
			MemAddress <= registerAddress;
		end if;
	end process;

	-- state machine dff block
	process (clk,rst)
	begin
		if (rst = '1') then
			current_state <= IDLE;
			stateCounter <= "000";
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			stateCounter <= nextStateCounter;
		end if;
	end process;
	
	-- state machine combinational logic block
	process (r_nw,en)
	begin
		case current_state is
		
			when IDLE =>
				if (en = '1') then
					if (r_nw = '1') then
						next_state <= R_ASSERT_MEM_SIGNALS;
					else
						next_state <= W_WAIT_FOR_MEMORY_ACCESS;
					end if;
					nextStateCounter <= "000";
				else
					next_state <= IDLE;
					nextStateCounter <= stateCounter + 1;
				end if;
				-- outputs
			  MemEnable <= '0';
			  MemRW <= '0';
				
				
			-- read data from memory	
			when R_ASSERT_MEM_SIGNALS =>
				next_state <= R_WAIT_FOR_MEMORY_ACCESS;
				nextStateCounter <= "000";
				-- outputs
			  MemEnable <= '1';
			  MemRW <= '1';
				
				
			when R_WAIT_FOR_MEMORY_ACCESS =>
				if (stateCounter = NUM_WAIT_CYCLES) then
					next_state <= R_GIVE_DATA_TO_CPU;
					nextStateCounter <= "000";
				else
					next_state <= R_WAIT_FOR_MEMORY_ACCESS;
					nextStateCounter <= stateCounter + 1;
				end if;
				-- outputs
			  MemEnable <= '1';
			  MemRW <= '1';
				

			when R_GIVE_DATA_TO_CPU =>
				next_state <= IDLE;
				nextStateCounter <= "000";
				-- outputs
			  MemEnable <= '1';
			  MemRW <= '1';
			  
			-- write data to memory			
			when W_WAIT_FOR_MEMORY_ACCESS =>
				if (stateCounter = NUM_WAIT_CYCLES) then
					next_state <= W_GIVE_DATA_TO_MEM;
					nextStateCounter <= "000";
				else
					next_state <= W_WAIT_FOR_MEMORY_ACCESS;
					nextStateCounter <= stateCounter + 1;
				end if;
				-- outputs
			  MemEnable <= '0';
			  MemRW <= '0';
				

			when W_GIVE_DATA_TO_MEM =>
				next_state <= IDLE;
				nextStateCounter <= "000";
				-- outputs
			  MemEnable <= '1';
			  MemRW <= '0';
				
				
			when others => 
				next_state <= IDLE;
				MemEnable <= '0';
				MemRW <= '0';
				
				
		end case;			
	end process;

end RTL;

