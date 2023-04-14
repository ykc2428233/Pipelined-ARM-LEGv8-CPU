LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegEXMEM IS
PORT(
-- Control
  clk		: IN STD_LOGIC;  
  rst		: IN STD_LOGIC;
  write_enable	: IN STD_LOGIC;
-- CPU Control Signal
  --WB
  RegWriteIn		: IN STD_LOGIC;
  RegWriteOut		: OUT STD_LOGIC := '0';
  MemtoRegIn		: IN STD_LOGIC;
  MemtoRegOut		: OUT STD_LOGIC := '0';
  --M
  CBranchIn		: IN STD_LOGIC;
  CBranchOut		: OUT STD_LOGIC := '0';
  UBranchIn		: IN STD_LOGIC;
  UBranchOut		: OUT STD_LOGIC := '0';
  MemReadIn		: IN STD_LOGIC;
  MemReadOut		: OUT STD_LOGIC := '0';
  MemWriteIn		: IN STD_LOGIC;
  MemWriteOut		: OUT STD_LOGIC := '0';
-- Info
  FlagZeroIn		: IN STD_LOGIC;
  ALUResultIn		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  ReadData2In		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  Inst4_0In		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  PCNewaddrIn		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  FlagZeroOut		: Out STD_LOGIC := '0';
  ALUResultOut		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  ReadData2Out		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  Inst4_0Out		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  PCNewaddrOut		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000"
);
END RegEXMEM;

ARCHITECTURE behavioral OF RegEXMEM IS
BEGIN
  PROCESS(clk, rst, write_enable)
  BEGIN
    IF (clk = '1' AND clk'event AND write_enable = '1') THEN 
      RegWriteOut <= RegWriteIn;
      MemtoRegOut <= MemtoRegIn;
      CBranchOut <= CBranchIn;
      UBranchOut <= UBranchIn;
      MemReadOut <= MemReadIn;
      MemWriteOut <= MemWriteIn;

      FlagZeroOut <= FlagZeroIn;
      ALUResultOut <= ALUResultIn;
      ReadData2Out <= ReadData2In;
      Inst4_0Out <= Inst4_0In;
      PCNewaddrOut <= PCNewaddrIn;
    END IF;
    IF (rst = '1') THEN
      RegWriteOut <= '0';
      MemtoRegOut <= '0';
      CBranchOut <= '0';
      UBranchOut <= '0';
      MemReadOut <= '0';
      MemWriteOut <= '0';

      FlagZeroOut <= '0';
      ALUResultOut <= x"0000000000000000";
      ReadData2Out <= x"0000000000000000";
      Inst4_0Out <= "00000";
      PCNewaddrOut <= x"0000000000000000";
    END IF;
  END PROCESS;
END behavioral;
