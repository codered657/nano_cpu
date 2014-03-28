--  Instruction Address Unit
-- 
--  Description: This is the instruction address unit for the nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     03/16/14    1) Initial revision.
--      Steven Okai     03/24/14    1) Updated to use constants for decoding.
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.InstructionAddressUnitPkg.all;

entity InstructionAddressUnit is
    generic(
        NUM_WAIT_STATES : integer := 1;
    );
    port (
        Clk     : in std_logic;
        Reset   : in std_logic;
        
        ControlIn           : in control_to_iau;
        
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
    
    -- Decode which offset source to use.
    OffsetSourceSelMux : process (ControlIn.OffsetSourceSel, UnconditionalOffset, ConditionalOffset, RegisterOffset)
        begin
        
        if (ControlIn.OffsetSourceSel = OFFSET_SEL_UNCONDITIONAL) then
            Offset <= UnconditionalOffset;
        elsif (ControlIn.OffsetSourceSel = OFFSET_SEL_CONDITIONAL) then
            Offset <= ConditionalOffset;
        elsif (ControlIn.OffsetSourceSel = OFFSET_SEL_REGISTER) then
            Offset <= RegisterOffset;
        elsif (ControlIn.OffsetSourceSel = OFFSET_SEL_ZERO) then
            Offset <= (others => '0');
        else
            Offset <= (0 => '1', others => '0');
        end if;
        
    end OffsetSourceSelMux;
    
    process (ProgramCounter, ControlIn.Load) then
        begin
        
        -- If loading, an address, add loaded address to 0.
        if (ControlIn.Load = '1') then
            ProgramCounterSumIn <= (others => '0');
        -- Otherwise, add offset to the program counter.
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
                    if (ControlIn.Fetch = '1') then
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