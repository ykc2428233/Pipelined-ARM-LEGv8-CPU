LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity CPUControl is
-- Functionality should match the truth table shown in Figure 4.22 of the textbook, inlcuding the
--    output 'X' values.
-- The truth table in Figure 4.22 omits the unconditional branch instruction:
--    UBranch = '1'
--    MemWrite = RegWrite = '0'
--    all other outputs = 'X'	
port(Opcode   : in  STD_LOGIC_VECTOR(10 downto 0);
     Reg2Loc  : out STD_LOGIC;
     CBranch  : out STD_LOGIC;  --conditional
     MemRead  : out STD_LOGIC;
     MemtoReg : out STD_LOGIC;
     MemWrite : out STD_LOGIC;
     ALUSrc   : out STD_LOGIC;
     RegWrite : out STD_LOGIC;
     UBranch  : out STD_LOGIC; -- This is unconditional
     ALUOp    : out STD_LOGIC_VECTOR(1 downto 0)
);
end CPUControl;

ARCHITECTURE behavioral OF CPUControl IS
BEGIN
  PROCESS(Opcode)
  BEGIN
    IF (Opcode(10 DOWNTO 5) = "000101") THEN --unconditional branch
      Reg2Loc <= 'X';
      CBranch <= 'X';
      MemRead <= 'X';
      MemtoReg <= 'X';
      MemWrite <= '0';
      ALUSrc <= 'X';
      RegWrite <= '0';
      UBranch <= '1';
      ALUOp <= "XX";
    END IF;
    IF (Opcode(10 DOWNTO 0) = "11111000010") THEN -- LDUR
      Reg2Loc <= 'X';
      CBranch <= '0';
      MemRead <= '1';
      MemtoReg <= '1';
      MemWrite <= '0';
      ALUSrc <= '1';
      RegWrite <= '1';
      UBranch <= '0';
      ALUOp <= "00";
    END IF;
    IF (Opcode(10 DOWNTO 0) = "11111000000") THEN -- STUR
      Reg2Loc <= '1';
      CBranch <= '0';
      MemRead <= '0';
      MemtoReg <= 'X';
      MemWrite <= '1';
      ALUSrc <= '1';
      RegWrite <= '0';
      UBranch <= '0';
      ALUOp <= "00";
    END IF;
    IF (Opcode(10 DOWNTO 3) = "10110100") THEN -- CBZ
      Reg2Loc <= '1';
      CBranch <= '1';
      MemRead <= '0';
      MemtoReg <= 'X';
      MemWrite <= '0';
      ALUSrc <= '0';
      RegWrite <= '0';
      UBranch <= '0';
      ALUOp <= "01";
    END IF;
    IF (Opcode(10) = '1' AND Opcode(7 DOWNTO 4) = "0101" AND Opcode(2 DOWNTO 0) = "000") THEN -- R format
      Reg2Loc <= '0';
      CBranch <= '0';
      MemRead <= '0';
      MemtoReg <= '0';
      MemWrite <= '0';
      ALUSrc <= '0';
      RegWrite <= '1';
      UBranch <= '0';
      ALUOp <= "10";
    END IF;
  END PROCESS;
END behavioral;