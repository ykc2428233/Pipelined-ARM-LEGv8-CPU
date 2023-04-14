LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FULL_ADDER IS
PORT(
	A : IN STD_LOGIC;
	B : IN STD_LOGIC;
	Cin : IN STD_LOGIC;
	Sum : OUT STD_LOGIC;
	Carry : OUT STD_LOGIC
);
END FULL_ADDER;

ARCHITECTURE structural_example OF FULL_ADDER IS
COMPONENT HALF_ADDER IS
PORT(
	A : in std_logic;
	B : in std_logic;
	Sum : out std_logic;
	Carry : out std_logic
);
END COMPONENT;
SIGNAL Sum0_A1 : STD_LOGIC;
SIGNAL OR0 : STD_LOGIC;
SIGNAL OR1 : STD_LOGIC;
BEGIN

  ha0 : HALF_ADDER 
    PORT MAP(
	  A => A,
	  B => B,
	  Sum => Sum0_A1,
	  Carry => OR0
	);
  ha1 : HALF_ADDER 
    PORT MAP(
	  A => Sum0_A1,
	  B => Cin,
	  Carry => OR1,
	  Sum => Sum
	);
  Carry <= OR0 OR OR1;
END structural_example; 