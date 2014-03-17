--  Instruction Address Unit
-- 
--  Description: This is the instruction address unit for the nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     03/16/14    1) Initial revision.
--

library ieee;
use ieee.std_logic_1164.all;

entity InstructionAddressUnit is
    generic(
        NUM_WAIT_STATES : integer := 1;
    );
    port (
        Clk     : in std_logic;
        Reset   : in std_logic;
        
        -- TODO: make a record for control signals between modules.
        Load                : in std_logic;
        Fetch               : in std_logic;
        OffsetSourceSel     : in std_logic_vector(2 downto 0);
        UnconditionalOffset : in std_logic_vector(15 downto 0);
        ConditionalOffset   : in std_logic_vector(15 downto 0);
        RegisterOffset      : in std_logic_vector(15 downto 0);
        
        InstructionOut      : out std_logic_vector(15 downto 0);
        
        MemAddress          : out std_logic_vector(15 downto 0);
        MemEnable           : out std_logic;
        MemInstructionIn    : in  std_logic_vector(15 downto 0);
        
    );
end InstructionAddressUnit;

architecture RTL of InstructionAddressUnit is
    
    type state is (STATE_IDLE, STATE_FETCHING);
    signal CurrentState : state;
    
    signal ProgramCounter       : std_logic_vector(15 downto 0);
    signal ProgramCounterSumIn  : std_logic_vector(15 downto 0);
    signal NewProgramCounter    : std_logic_vector(15 downto 0);
    
    signal FetchCounter         : integer;
    
    signal Offset               : std_logic_vector(15 downto 0);
    
    begin
    
    OffsetSourceSelMux : process (OffsetSourceSel, UnconditionalOffset, ConditionalOffset, RegisterOffset)
        begin
        
        if (OffsetSourceSelMux = "000") then
            Offset <= UnconditionalOffset;
        elsif (OffsetSourceSelMux = "001") then
            Offset <= ConditionalOffset;
        elsif (OffsetSourceSelMux = "010") then
            Offset <= RegisterOffset;
        elsif (OffsetSourceSelMux = "011") then
            Offset <= (others => '0');
        else
            Offset <= (others => '0')
            Offset(0) <= '1';
        end if;
        
    end OffsetSourceSelMux;
    
    process (ProgramCounter, Load) then
        begin
        
        if (Load = '1') then
            ProgramCounterSumIn <= (others => '0');
        else
            ProgramCounterSumIn <= ProgramCounter;
        end if;
        
    end if;
    
    -- Calculate new program counter.
    NewProgramCounter <= ProgramCounterSumIn + Offset;
    
    
    process (Clk, Reset)
        if (Reset = '1') then
            MemEnable <= '0';
            ProgramCounter <= (others => '0');
            CurrentState <= STATE_IDLE;
            -- NOTE: Don't need to clear fetch counter, reset in idle state.
            
        elsif (rising_edge(Clk)) then
            
            case CurrentState is
                when STATE_IDLE =>
                    
                    -- If a instruction fetch requested, access memory.
                    if (Fetch = '1') then
                        CurrentState <= STATE_FETCHING;         -- Wait for access to complete.
                        MemAddress <= NewProgramCounter;        -- Read address is the new program counter;
                        ProgramCounter <= NewProgramCounter;    -- Update program counter.
                        MemEnable <= '1'                        -- Enable memory access.
                    -- Otherwise, wait.
                    else
                        CurrentState <= STATE_IDLE;
                    end if;
                    
                    -- Keep fetch counter cleared until memory access.
                    FetchCounter = 0;
                    
                when STATE_FETCHING then
                
                    -- If memory access has completed go back to idle.
                    if (FetchCounter = NUM_WAIT_STATES-1) then
                        CurrentState <= STATE_IDLE;         -- Go back to idle.
                        MemEnable <= '0';                   -- Access done, disable memory.
                        InstructionOut <= MemInstructionIn; -- Output fetched instruction.
                        
                    -- Otherwise, wait for fetch to complete.
                    else
                        CurrentState <= STATE_FETCHING;
                        FetchCounter <= FetchCounter + 1;
                    end if;
                
            end case;
            
        end if;
        
    end process;
    
end RTL;