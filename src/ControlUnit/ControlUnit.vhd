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
    
    type state is (STATE_LOAD, STATE_EXECUTE);
    
    signal NumCycles  : std_logic_vector(1 downto 0);
    signal CycleCount : std_logic_vector(1 downto 0);
    
    signal OpcodeReg : opcode;
    signal CurrState : state;
    
    begin
    
    instruction_decoder : entity work.InstructionDecoder
        generic map (
            REG_OUTPUT => false
        )
        port map (
            OpcodeIn => OpcodeReg,
            ALUControl => ALUControlInt,
            RegControl => RegControlInt,
            NumCycles  => NumCycles,
            CycleCount => CycleCount
        );
        
    process(Clk)
        begin
        if (rising_edge(Clk)) then
            
            -- By default, do not update registers.
            RegControl.RegAWr <= '0';
            RegControl.RegBWr <= '0';
            
            -- Output decoded control signals.
            ALUControl <= ALUControlInt;
            RegControl.RegANum <= RegControlInt.RegANum;
            RegControl.RegBNum <= RegControlInt.RegBNum;
            
            case CurrState is
                
                when STATE_LOAD =>
                    -- Load into instruction register
                    OpcodeReg <= OpcodeIn;
                    
                    -- Reset cycle count
                    CycleCount <= (others=>'0');
                    
                    -- Next state is execute state
                    CurrState <= STATE_EXECUTE;
                
                when STATE_EXECUTE =>
                    -- Incremement count
                    CycleCount <= std_logic_vector(unsigned(CycleCount) + to_unsigned(1, 2));
                    
                    if (CycleCount >= NumCycles) then
                        CurrState <= STATE_LOAD;
                        
                        -- If register must be modified, write new value to register.
                        RegControl.RegAWr <= RegControlInt.RegAWr;
                        RegControl.RegBWr <= RegControlInt.RegBWr;
                        
                    else
                        CurrState <= STATE_EXECUTE;
                    end if;
                        
            end case;
            
            if (Reset = '1') then
                CurrState <= STATE_LOAD;
            end if;
        end if;
    end process;
    
end RTL;
        
        
        