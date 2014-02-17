--  Instruction Decoder
--
--  Description: This is the instruction decoder for the nano_cpu.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/16/13    1) Initial revision.
--
library ieee;
use ieee.std_logic_1164.all;
use work.GeneralFuncPkg.all;
use work.ALUPkg.all;
use work.ControlUnitPkg.all;

entity InstructionDecoder is
    generic
        REG_OUTPUT  : boolean := false
    );
    port (
        OpcodeIn    : in  opcode;
        ALUControl  : out control_to_alu;
        RegControl  : out control_to_reg;
        NumCycles   : out std_logic_vector(1 downto 0);
        CycleCount  : in  std_logic_vector(1 downto 0)
    );
end InstructionDecoder;

architecture RTL of InstructionDecoder is
    
    signal ALUControlUnreg : control_to_alu;
    signal RegControlUnreg : control_to_reg;
    
    constant NUM_CYCLES_ALU : std_logic_vector(1 downto 0) := "10";
    
    begin
    
    process(OpcodeIn)
    
        variable RegANum : std_logic_vector(3 downto 0); -- Extracted register A index.
        variable RegBNum : std_logic_vector(3 downto 0); -- Extracted register B index.
        
        begin
        
        -- Default to no flags modified.
        ALUControlUnreg.FlagMask <= (others=>'0');
        
        -- Default to no registers modified.
        RegControlUnreg.RegAWr = '0';
        RegControlUnreg.RegBWr = '0';
        
        -- Extract register indicies.
        RegANum := OpcodeIn(7 downto 4);
        RegBNum := OpcodeIn(3 downto 0);
        
        if (std_match(OpcodeIn, OPCODE_ADD)) then
            ALUControlUnreg.ALUOp <= ALU_OP_ADD;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_SUB)) then
            ALUControlUnreg.ALUOp <= ALU_OP_SUB;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_AND)) then
            ALUControlUnreg.ALUOp <= ALU_OP_AND;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_OR)) then
            ALUControlUnreg.ALUOp <= ALU_OP_OR;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_XOR)) then
            ALUControlUnreg.ALUOp <= ALU_OP_XOR;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            NumCycles <= NUM_CYCLES_ALU;            
        end if;
        
        if (std_match(OpcodeIn, OPCODE_NEG)) then
            ALUControlUnreg.ALUOp <= ALU_OP_NEG;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_NOT)) then
            ALUControlUnreg.ALUOp <= ALU_OP_NOT;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_SLL)) then
            ALUControlUnreg.ALUOp <= ALU_OP_SLL;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_SRL)) then
            ALUControlUnreg.ALUOp <= ALU_OP_SRL;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_SRA)) then
            ALUControlUnreg.ALUOp <= ALU_OP_SRA;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_C or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_BSET)) then
            ALUControlUnreg.ALUOp <= ALU_OP_BSET;
            NumCycles <= NUM_CYCLES_ALU;
            
        end if;
        
        if (std_match(OpcodeIn, OPCODE_BCLR)) then
            ALUControlUnreg.ALUOp <= ALU_OP_BCLR;
            NumCycles <= NUM_CYCLES_ALU;
            
        end if;
        
        if (std_match(OpcodeIn, OPCODE_INC)) then
            ALUControlUnreg.ALUOp <= ALU_OP_INC;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
        if (std_match(OpcodeIn, OPCODE_DEC)) then
            ALUControlUnreg.ALUOp <= ALU_OP_DEC;
            ALUControlUnreg.FlagMask <= FLAG_Z or FLAG_N or FLAG_O or FLAG_S;
            RegControlUnreg.RegANum <= RegANum;
            RegControlUnreg.RegBNum <= RegBNum;
            RegControlUnreg.RegAWr <= '1';
            NumCycles <= NUM_CYCLES_ALU;
        end if;
        
    end process;
    
    -- Generate output register if called for.
    registered_output : if (REG_OUTPUT) generate
        process(Clk)
            begin
            if (rising_edge(Clk)) then
                ALUControl <= ALUControlUnreg;
                RegControl <= RegControlUnreg;
            end if;
        end process;
    end generate registered_output;
    
    -- Otherwise, do not register output.
    no_registered_output : if (not REG_OUTPUT) generate
        ALUControl <= ALUControlUnreg;
        RegControl <= RegControlUnreg;
    end generate no_registered_output;
    
end RTL;