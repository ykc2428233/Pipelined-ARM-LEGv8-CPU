LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AND2_tb IS
END AND2_tb;

ARCHITECTURE tb of AND2_tb IS
  COMPONENT AND2
  PORT(
       in0 : IN STD_LOGIC;
       in1 : IN STD_LOGIC;
       output : OUT STD_LOGIC
  );
  END COMPONENT;
  SIGNAL in0 : STD_LOGIC;
  SIGNAL in1 : STD_LOGIC;
  SIGNAL output : STD_LOGIC;
BEGIN
  UUT : AND2 PORT MAP( 
	  in0 => in0, 
	  in1 => in1, 
	  output => output
	);
stim_proc: PROCESS
BEGIN 
in0 <= '0';
in1 <= '0';
  WAIT FOR 50 ns;
in0 <= '0';
in1 <= '1';
  WAIT FOR 50 ns;
in0 <= '1';
in1 <= '0';
  WAIT FOR 50 ns;
in0 <= '1';
in1 <= '1';
  WAIT FOR 50 ns;
  WAIT;
END PROCESS;

END tb;
	