--  General Function Package
--
--  Description: This package contains general VHDL functions.
--
--  Notes: None.
--
--  Revision History:
--      Steven Okai     02/16/14    1) Initial revision.
--                                  2) Added bitwise functions and log2().
--

library ieee;
use ieee.std_logic_1164.all;

package GeneralFuncPkg is

    function bitwise_and (A : std_logic_vector; B : std_logic_vector) return std_logic_vector;
    function bitwise_or (A : std_logic_vector; B : std_logic_vector) return std_logic_vector;
    function bitwise_xor (A : std_logic_vector; B : std_logic_vector) return std_logic_vector;
    function bitwise_not (A : std_logic_vector) return std_logic_vector;
    
    function log2(x : integer) return integer;
end package GeneralFuncPkg;

package body GeneralFuncPkg is
    -- This function returns the bitwise AND of two std_logic_vectors or equal length.
    function bitwise_and (A : std_logic_vector; B : std_logic_vector) return std_logic_vector is
        
        variable C : std_logic_vector(A'range);
        
        begin
        
        -- Check that the vectors are the same width.
        assert A'length = B'length
            report "Vectors are different lengths."
            severity failure;
        
        -- Go through vector and-ing bits.
        for i in A'range loop
            C(i) := A(i) and B(i);
        end loop;
        
        return C; -- Return result.
        
    end bitwise_and;
    
    -- This function returns the bitwise OR of two std_logic_vectors or equal length.
    function bitwise_or (A : std_logic_vector; B : std_logic_vector) return std_logic_vector is
        
        variable C : std_logic_vector(A'range);
        
        begin
        
        -- Check that the vectors are the same width.
        assert A'length = B'length
            report "Vectors are different lengths."
            severity failure;
        
        -- Go through vector or-ing bits.
        for i in A'range loop
            C(i) := A(i) or B(i);
        end loop;
        
        return C; -- Return result.
        
    end bitwise_or;
    
    -- This function returns the bitwise XOR of two std_logic_vectors or equal length.
    function bitwise_xor (A : std_logic_vector; B : std_logic_vector) return std_logic_vector is
        
        variable C : std_logic_vector(A'range);
        
        begin
        
        -- Check that the vectors are the same width.
        assert A'length = B'length
            report "Vectors are different lengths."
            severity failure;
        
        -- Go through vector or-ing bits.
        for i in A'range loop
            C(i) := A(i) xor B(i);
        end loop;
        
        return C; -- Return result.
        
    end bitwise_xor;
    
    -- This function returns the bitwise XOR of two std_logic_vectors or equal length.
    function bitwise_not (A : std_logic_vector) return std_logic_vector is
        
        variable C : std_logic_vector(A'range);
        constant ONES : std_logic_vector(A'range) := (others=>'1');
        begin
        
        -- XOR vector with all ones will flip all bits.
        C := bitwise_xor(A, ONES);
        
        return C; -- Return result.
        
    end bitwise_not;

    -- This function returns ceil(log2(x)).
    function log2 (x : integer) return integer is
        variable xTemp : integer := x; -- Make a copy of x.
        variable DivCount : integer := 0; -- Number of times x can be divided by 2.
        
        begin
        
        -- Count how many times can be divided by 2.
        while (xTemp > 1) loop
            DivCount := DivCount + 1; -- Increment div count.
            xTemp := xTemp/2; -- Divide by 2.
        end loop;
        
        -- Number of times divided by 2 is log2(x).
        return DivCount;
        
    end log2;
    
end GeneralFuncPkg;