LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
-- Functionality should match truth table shown in Figure 4.13 in the textbook.
-- Check table on page2 of Green Card.pdf on canvas. Pay attention to opcode of operations and type of operations. 
-- If an operation doesn't use ALU, you don't need to check for its case in the ALU control implemenetation.	
--  To ensure proper functionality, you must implement the "don't-care" values in the funct field,
-- for example when ALUOp = '00", Operation must be "0010" regardless of what Funct is.
port(
     ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
     Opcode    : in  STD_LOGIC_VECTOR(10 downto 0);
     Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALUControl;

ARCHITECTURE behavioral OF ALUControl IS
BEGIN
  PROCESS(ALUOp, Opcode)
  BEGIN
  IF (ALUOp(1 DOWNTO 0) = "00") THEN
    Operation(3 DOWNTO 0) <= "0010";
  ELSIF (ALUOp(1 DOWNTO 0) = "01") THEN
    Operation(3 DOWNTO 0) <= "0111";
  ELSIF (ALUOp(1 DOWNTO 0) = "10") THEN
    --REPORT "10";
    IF (Opcode(10 DOWNTO 0) = "11010011011") THEN --LSL
        Operation(3 DOWNTO 0) <= "1101";
    ELSIF (Opcode(10 DOWNTO 0) = "11010011010") THEN --LSR
        Operation(3 DOWNTO 0) <= "1110";
    ELSIF (Opcode(10 DOWNTO 1) = "1001000100" OR Opcode(10 DOWNTO 0) = "10001011000") THEN -- ADD/I
        Operation(3 DOWNTO 0) <= "0010";
    ELSIF (Opcode(10 DOWNTO 1) = "1001001000" OR Opcode(10 DOWNTO 0) = "10001010000") THEN -- AND/I
        Operation(3 DOWNTO 0) <= "0000";
    ELSIF (Opcode(10 DOWNTO 1) = "1011001000" OR Opcode(10 DOWNTO 0) = "10101010000") THEN -- ORR/I
        Operation(3 DOWNTO 0) <= "0001";
    ELSIF (Opcode(10 DOWNTO 1) = "1101000100" OR Opcode(10 DOWNTO 0) = "11001011000") THEN -- SUB/I
        Operation(3 DOWNTO 0) <= "0110";
    ELSE
        Operation(3 DOWNTO 0) <= "UUUU";
    END IF;  
  ELSE
    Operation(3 DOWNTO 0) <= "UUUU";
    --REPORT "WRONG Opcode!!!" severity error;
  END IF;
  END PROCESS;	
END behavioral;