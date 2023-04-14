LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY PipelinedCPU1_tb IS
END PipelinedCPU1_tb;

ARCHITECTURE tb OF PipelinedCPU1_tb IS
  SIGNAL clk : STD_LOGIC;
  SIGNAL rst : STD_LOGIC;
  SIGNAL DEBUG_PC : STD_LOGIC_VECTOR(63 DOWNTO 0);
  SIGNAL DEBUG_INSTRUCTION : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL DEBUG_TMP_REGS : STD_LOGIC_VECTOR(64*4 - 1 DOWNTO 0);
  SIGNAL DEBUG_SAVED_REGS : STD_LOGIC_VECTOR(64*4 - 1 DOWNTO 0);
  SIGNAL DEBUG_MEM_CONTENTS : STD_LOGIC_VECTOR(64*4 - 1 DOWNTO 0);
  SIGNAL DEBUG_FORWARDA : std_logic_vector(1 downto 0);
  SIGNAL DEBUG_FORWARDB : std_logic_vector(1 downto 0);
  SIGNAL DEBUG_PC_WRITE_ENABLE : STD_LOGIC;

BEGIN
  Pipelined_CPU : ENTITY work.PipelinedCPU1
    PORT MAP(
	clk => clk,
	rst => rst,
     	--Probe ports used for testing
     	--The current address (AddressOut from the PC)
     	DEBUG_PC => DEBUG_PC,
     	--The current instruction (Instruction output of IMEM)
     	DEBUG_INSTRUCTION => DEBUG_INSTRUCTION,
     	--DEBUG ports from other components
     	DEBUG_TMP_REGS => DEBUG_TMP_REGS,
     	DEBUG_SAVED_REGS => DEBUG_SAVED_REGS,
     	DEBUG_MEM_CONTENTS => DEBUG_MEM_CONTENTS,
	DEBUG_FORWARDA => DEBUG_FORWARDA,
	DEBUG_FORWARDB => DEBUG_FORWARDB,
	DEBUG_PC_WRITE_ENABLE =>DEBUG_PC_WRITE_ENABLE
    );

  clock : PROCESS
    CONSTANT clk_period : TIME := 50 ns;
    BEGIN
      clk <= '1';
      WAIT FOR clk_period;
      clk <= '0';
      WAIT FOR clk_period;
    END PROCESS;

  reset : PROCESS
    BEGIN
      rst <= '1';
      WAIT FOR 10 ns;
      rst <= '0';
      WAIT;
    END PROCESS;

END tb;