LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2 is -- Shifts the input by 2 bits
port(
     x : in  STD_LOGIC_VECTOR(63 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- x << 2
);
end ShiftLeft2;

ARCHITECTURE dataflow OF ShiftLeft2 IS
BEGIN
  y <= x(61 DOWNTO 0)&"00";
END dataflow;
  