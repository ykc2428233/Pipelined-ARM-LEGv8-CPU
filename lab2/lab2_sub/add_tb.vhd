LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADD_tb is
END ADD_tb;

ARCHITECTURE tb of ADD_tb IS
  COMPONENT ADD
  PORT(
     	in0    : in  STD_LOGIC_VECTOR(63 downto 0);
     	in1    : in  STD_LOGIC_VECTOR(63 downto 0);
     	output : out STD_LOGIC_VECTOR(63 downto 0)	  
	);
  END COMPONENT;
  SIGNAL in0	: STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL in1	: STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL output	: STD_LOGIC_VECTOR(63 downto 0);

BEGIN
  UUT : ADD PORT MAP(
	in0 => in0,
	in1 => in1,
	output => output
	);
  stim_proc: PROCESS
    BEGIN
    in0 <= x"0000FFFF1111CCCC";
    in1 <= x"1111CCCCFFFF0000";
      WAIT FOR 100 ns;
    in0 <= x"FFFFCCCC00009999";
    in1 <= x"1111999900001111";
      WAIT FOR 100 ns;
    in0 <= x"7FFFFFFFFFFFFFFF";
    in1 <= x"0000000000000001";
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;
END tb;

