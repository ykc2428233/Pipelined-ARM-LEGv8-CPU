LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegIDEX IS
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
  --EX
  ALUOpIn		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  ALUOpOut		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
  ALUSrcIn 		: IN STD_LOGIC;
  ALUSrcOut		: OUT STD_LOGIC := '0';
  NOTZEROIn		: In STD_LOGIC;
  NOTZEROOut		: OUT STD_LOGIC := '0';
-- Info
  ReadData1In		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  ReadData2In		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  ExtendedInstIn	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  Inst31_21In		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
  Inst4_0In		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  Rm20_16In		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  Rn9_5In		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  PCaddrIn		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  ReadData1Out		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  ReadData2Out		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  ExtendedInstOut	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  Inst31_21Out		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000000";
  Inst4_0Out		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  Rm20_16Out		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  Rn9_5Out		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  PCaddrOut		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000"

);
END RegIDEX;

ARCHITECTURE behavioral OF RegIDEX IS
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
      ALUOpOut <= ALUOpIn;
      ALUSrcOut <= ALUSrcIn;
      NOTZEROOut <= NOTZEROIn;

      ReadData1Out <= ReadData1In;
      ReadData2Out <= ReadData2In;
      ExtendedInstOut <= ExtendedInstIn;
      Inst31_21Out <= Inst31_21In;
      Inst4_0Out <= Inst4_0In;
      Rm20_16Out <= Rm20_16In;
      Rn9_5Out <= Rn9_5In;
      PCaddrOut <= PCaddrIn;
    END IF;
    IF (rst = '1') THEN
      RegWriteOut <= '0';
      MemtoRegOut <= '0';
      CBranchOut <= '0';
      UBranchOut <= '0';
      MemReadOut <= '0';
      MemWriteOut <= '0';
      ALUOpOut <= "00";
      ALUSrcOut <= '0';
      NOTZEROOut <= '0';

      ReadData1Out <= x"0000000000000000";
      ReadData2Out <= x"0000000000000000";
      ExtendedInstOut <= x"0000000000000000";
      Inst31_21Out <= "00000000000";
      Inst4_0Out <= "00000";
      Rm20_16Out <= "00000";
      Rn9_5Out <= "00000";
      PCaddrOut <= x"0000000000000000";
    END IF;
  END PROCESS;
END behavioral;