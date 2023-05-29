LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
entity ALU is
-- Implement: AND, OR, ADD (signed), SUBTRACT (signed)
--    as described in Section 4.4 in the textbook.
-- The functionality of each instruction can be found on the 'ARM Reference Data' sheet at the
--    front of the textbook (or the Green Card pdf on Canvas).
port(
     in0       : in     STD_LOGIC_VECTOR(63 downto 0);
     in1       : in     STD_LOGIC_VECTOR(63 downto 0);
     operation : in     STD_LOGIC_VECTOR(3 downto 0);
     result    : buffer STD_LOGIC_VECTOR(63 downto 0);
     zero      : buffer STD_LOGIC;
     overflow  : buffer STD_LOGIC
    );
end ALU;

ARCHITECTURE structural OF ALU IS
SIGNAL add_out : STD_LOGIC_VECTOR(63 downto 0);

BEGIN
  adder_64 : ENTITY
	WORK.ADDER64
  	PORT MAP(
	  A => in0,
	  B => in1,
	  Cin => '0',
	  Sum => add_out
	);
  PROCESS(operation, in0, in1, result, add_out)
  VARIABLE test:integer;
  CONSTANT ZR : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    zero <= '0';
    overflow <= '0';
    CASE operation IS
      WHEN "0000" => -- AND
      result <= in0 AND in1;
      WHEN "0001" => -- OR
      result <= in0 OR in1;
      WHEN "0010" => -- '+'
      result <= add_out; --STD_LOGIC_VECTOR(SIGNED(in0) + SIGNED(in1));
      test := to_integer(unsigned(add_out));
      report integer'image(test);
        IF (in0(63) = in1(63) AND in0(63) /= result(63)) THEN
          overflow <= '1';
        END IF;
      WHEN "0110" =>
      result <= STD_LOGIC_VECTOR(SIGNED(in0) - SIGNED(in1));
        IF (in0(63) /= in1(63) AND in0(63) /= result(63)) THEN
          overflow <= '1';
        END IF;
      WHEN OTHERS =>
    END CASE;
    IF (result = ZR) THEN
      zero <= '1';
    END IF;

  END PROCESS;

END structural;