library ieee;
use ieee.std_logic_1164.all;

entity ADDER64_tb is
end ADDER64_tb;

ARCHITECTURE tb OF ADDER64_tb IS
COMPONENT ADDER64
PORT(
	Cin 	: IN STD_LOGIC;
	A	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	B	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	Sum	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	Cout	: OUT STD_LOGIC	
);
END COMPONENT;
SIGNAL Cin, Cout : STD_LOGIC;
SIGNAL A, B, Sum : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
  UUT : ADDER64 PORT MAP(
	  Cin => Cin,
	  A => A,
	  B => B,
	  Sum => Sum,
	  Cout => Cout
	);
  stim_proc: PROCESS
    BEGIN
    Cin <= '0';
    A <= ( 3 => '1', 2 => '1', 1 => '1', others => '0');
    B <= ( 0 => '1', others => '0');
      WAIT FOR 100 ns;
    Cin <= '1';
    A <= (63 => '0', OTHERS => '1');
    B <= (0 => '1', OTHERS => '0');
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;
END tb;
