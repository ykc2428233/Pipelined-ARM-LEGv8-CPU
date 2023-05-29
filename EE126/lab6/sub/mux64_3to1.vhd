LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MUX64321 is -- Two by one mux with 32 bit inputs/outputs
port(
    in0    : in STD_LOGIC_VECTOR(63 downto 0);
    in1    : in STD_LOGIC_VECTOR(63 downto 0);
    in2    : in STD_LOGIC_VECTOR(63 downto 0);
    sel    : in STD_LOGIC_VECTOR(1 DOWNTO 0);
    output : out STD_LOGIC_VECTOR(63 downto 0)
);
end MUX64321;

ARCHITECTURE behavioral OF MUX64321 IS
BEGIN
  PROCESS(sel, in0, in1, in2)
  BEGIN
    IF (sel = "00") THEN
      output <= in0;
    ELSIF (sel = "01") THEN
      output <= in1;
    ELSIF (sel = "10") THEN
      output <= in2;
    END IF;
  END PROCESS;
END behavioral;