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
  Operation(3) <= '0';
  PROCESS(ALUOp, Opcode)
  BEGIN
  IF (ALUOp = "00") THEN
    Operation(2 DOWNTO 0) <= "010";
  ELSIF (ALUOp = "01") THEN
    Operation(2 DOWNTO 0) <= "111";
  ELSIF (ALUOp(1) = '1') THEN
    Operation(2 DOWNTO 0) <= Opcode(3)&Opcode(9)&Opcode(8);
  END IF;
  END PROCESS;
END behavioral;