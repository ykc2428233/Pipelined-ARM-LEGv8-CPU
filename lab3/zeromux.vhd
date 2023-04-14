LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MUXZero is -- Two by one mux with 5 bit inputs/outputs
port(
    zero    : in STD_LOGIC; -- sel == 0
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC
);
end MUXZero;

ARCHITECTURE behavioral OF MUXZero IS
BEGIN
  PROCESS(sel, zero)
  BEGIN
    IF (sel = '0') THEN
      output <= zero;
    ELSIF (sel = '1') THEN
      output <= NOT zero;
    END IF;
  END PROCESS;
END behavioral;