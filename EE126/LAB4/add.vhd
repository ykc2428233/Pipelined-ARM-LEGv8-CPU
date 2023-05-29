LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ADD is
-- Adds two signed 64-bit inputs
-- output = in1 + in2
port(
     in0    : in  STD_LOGIC_VECTOR(63 downto 0);
     in1    : in  STD_LOGIC_VECTOR(63 downto 0);
     output : out STD_LOGIC_VECTOR(63 downto 0)
);
end ADD;

ARCHITECTURE structural_example OF ADD IS
BEGIN
  adder_64 : ENTITY 
	WORK.ADDER64
	PORT MAP(
	  A => in0,
	  B => in1,
	  Cin => '0',
	  Sum => output
	);
END structural_example;