LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegMEMWB IS
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

-- Info
  MemReadIn		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  Inst4_0In		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  ALUResultIn		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  MemReadOut		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  Inst4_0Out		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  ALUResultOut		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000"
);
END RegMEMWB;

ARCHITECTURE behavioral OF RegMEMWB IS
BEGIN
  PROCESS(clk, rst, write_enable)
  BEGIN
    IF (clk = '1' AND clk'event AND write_enable = '1') THEN 
      RegWriteOut <= RegWriteIn;
      MemtoRegOut <= MemtoRegIn;

      ALUResultOut <= ALUResultIn;
      MemReadOut <= MemReadIn;
      Inst4_0Out <= Inst4_0In;
    END IF;
    IF (rst = '1') THEN
      RegWriteOut <= '0';
      MemtoRegOut <= '0';

      ALUResultOut <= x"0000000000000000";
      MemReadOut <= x"0000000000000000";
      Inst4_0Out <= "00000";
    END IF;
  END PROCESS;
END behavioral;
