LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ADDER64 IS
PORT(
	Cin 	: IN STD_LOGIC;
	A	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	B	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	Sum	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	Cout	: OUT STD_LOGIC	
);
END ADDER64;

ARCHITECTURE structural_example OF ADDER64 IS
COMPONENT FULL_ADDER
PORT(
	A : IN STD_LOGIC;
	B : IN STD_LOGIC;
	Cin : IN STD_LOGIC;
	Sum : OUT STD_LOGIC;
	Carry : OUT STD_LOGIC
);
END COMPONENT;
SIGNAL Carry64 : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '0');
BEGIN
    fa0 : FULL_ADDER
      PORT MAP(
	  A => A(0),
	  B => B(0),
	  Sum => Sum(0),
	  Cin => Cin,
	  Carry => Carry64(1)
	);

  init : FOR i IN 1 TO 62 GENERATE
    fa : FULL_ADDER
      PORT MAP(
	  A => A(i),
	  B => B(i),
	  Sum => Sum(i),
	  Cin => Carry64(i),
	  Carry =>  Carry64(i+1)
	);
  END GENERATE;

    fa63 : FULL_ADDER
      PORT MAP(
	  A => A(63),
	  B => B(63),
	  Sum => Sum(63),
	  Cin => Carry64(63),
	  Carry => Cout
	);


END structural_example;