LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DMEM_tb is
END DMEM_tb;

ARCHITECTURE tb OF DMEM_tb IS
  COMPONENT DMEM
  PORT(
	  WriteData          : in  STD_LOGIC_VECTOR(63 downto 0); -- Input data
     	  Address            : in  STD_LOGIC_VECTOR(63 downto 0); -- Read/Write address
     	  MemRead            : in  STD_LOGIC; -- Indicates a read operation
     	  MemWrite           : in  STD_LOGIC; -- Indicates a write operation
     	  Clock              : in  STD_LOGIC; -- Writes are triggered by a rising edge
     	  ReadData           : out STD_LOGIC_VECTOR(63 downto 0); -- Output data
     	  DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
	);
  END COMPONENT;
  SIGNAL WriteData	    : STD_LOGIC_VECTOR(63 downto 0); -- Input data
  SIGNAL Address	    : STD_LOGIC_VECTOR(63 downto 0); -- Read/Write address
  SIGNAL MemRead            : STD_LOGIC; -- Indicates a read operation
  SIGNAL MemWrite           : STD_LOGIC; -- Indicates a write operation
  SIGNAL Clock              : STD_LOGIC; -- Writes are triggered by a rising edge
  SIGNAL ReadData           : STD_LOGIC_VECTOR(63 downto 0); -- Output data
  SIGNAL DEBUG_MEM_CONTENTS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
  CONSTANT cycle : TIME := 50 ns;

BEGIN
  UUT : DMEM PORT MAP(
	  WriteData => WriteData,
	  Address => Address,
	  MemRead => MemRead,
	  MemWrite => MemWrite,
	  Clock => Clock,
	  ReadData => ReadData,
	  DEBUG_MEM_CONTENTS => DEBUG_MEM_CONTENTS
	);

  clk: PROCESS
  BEGIN
  Clock <= '0';
  WAIT FOR cycle/2;
  INFINITE: LOOP
	Clock <= NOT Clock;
	WAIT FOR cycle/2;
  END LOOP;
  END PROCESS;

  stim_proc: PROCESS
    BEGIN
    WriteData <= x"0123456789ABCDEF";
    Address <= x"000000000000000F";
      WAIT FOR 100 ns;
    MemRead <= '1';
    MemWrite <= '0';
      WAIT FOR 100 ns;
    MemWrite <= '1';
    Address <= x"0000000000000000";
      WAIT FOR 100 ns;
    Address <= x"000000000000000F";
    MemRead <= '0';
      WAIT FOR 100 ns;
    MemWrite <= '0';
    MemRead <= '1';
      WAIT FOR 100 ns;
    Address <= x"0000000000000500";
    MemWrite <= '0';
    MemRead <= '1';
      WAIT FOR 100 ns;
    Address <= x"0000000000000500";
    MemWrite <= '1';
    MemRead <= '0';
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;

END tb;