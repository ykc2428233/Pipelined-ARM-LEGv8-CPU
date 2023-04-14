LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MUX64 is -- Two by one mux with 32 bit inputs/outputs
port(
    in0    : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 0
    in1    : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 1
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC_VECTOR(63 downto 0)
);
end MUX64;

ARCHITECTURE behavioral OF MUX64 IS
BEGIN
  PROCESS(sel, in0, in1)
  BEGIN
    IF (sel = '0') THEN
      output <= in0;
    ELSIF (sel = '1') THEN
      output <= in1;
    END IF;
  END PROCESS;
END behavioral;
