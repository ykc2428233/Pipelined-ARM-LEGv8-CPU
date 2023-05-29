LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX5_tb IS
END MUX5_tb;

ARCHITECTURE tb OF MUX5_tb IS
  COMPONENT MUX5
  PORT(
	in0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	in1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	sel : IN STD_LOGIC;
	output : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
  END COMPONENT;
  SIGNAL in0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL in1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL sel : STD_LOGIC;
  SIGNAL output : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN
  UUT : MUX5 PORT MAP(
	  in0 => in0,
	  in1 => in1,
	  sel => sel,
	  output => output
	);
  stim_proc: PROCESS
    BEGIN
    in0 <= "00000";
    in1 <= "11111";
    sel <= '0';
      WAIT FOR 100 ns;
    sel <= '1';
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;

END tb;

