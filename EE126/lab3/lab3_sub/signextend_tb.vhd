LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SignExtend_tb IS
END SignExtend_tb;

ARCHITECTURE tb OF SignExtend_tb IS
  COMPONENT SignExtend
  PORT(
	x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
  END COMPONENT;
  SIGNAL x : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL y : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
  UUT : SignExtend PORT MAP(
	  x => x,
	  y => y
	);
  stim_proc: PROCESS
  BEGIN
  x <= x"14000003";
    WAIT FOR 100 ns;
  x <= x"1FFFFFFF";
    WAIT FOR 100 ns;
      WAIT;
  END PROCESS;
END tb;