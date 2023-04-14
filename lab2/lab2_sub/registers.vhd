LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity registers is
-- This component is described in the textbook, starting on section 4.3 
-- The indices of each of the registers can be found on the LEGv8 Green Card
-- Keep in mind that register 31 (XZR) has a constant value of 0 and cannot be overwritten
-- This should only write on the negative edge of Clock when RegWrite is asserted.
-- Reads should be purely combinatorial, i.e. they don't depend on Clock
-- HINT: Use the provided dmem.vhd as a starting point
port(RR1      : in  STD_LOGIC_VECTOR (4 downto 0); 
     RR2      : in  STD_LOGIC_VECTOR (4 downto 0); 
     WR       : in  STD_LOGIC_VECTOR (4 downto 0); 
     WD       : in  STD_LOGIC_VECTOR (63 downto 0);
     RegWrite : in  STD_LOGIC;
     Clock    : in  STD_LOGIC;
     RD1      : out STD_LOGIC_VECTOR (63 downto 0);
     RD2      : out STD_LOGIC_VECTOR (63 downto 0);
     --Probe ports used for testing.
     -- Notice the width of the port means that you are 
     --      reading only part of the register file. 
     -- This is only for debugging
     -- You are debugging a sebset of registers here
     -- Temp registers: $X9 & $X10 & X11 & X12 
     -- 4 refers to number of registers you are debugging
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     -- Saved Registers X19 & $X20 & X21 & X22 
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end registers;

ARCHITECTURE behavioral OF registers IS
TYPE Array64 IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL RegData:Array64; 
BEGIN
  PROCESS(RR1, RR2, WR, WD, RegWrite, Clock, RegData)
  VARIABLE Waddr, Raddr1, Raddr2:INTEGER;
  VARIABLE first:BOOLEAN := TRUE;
  BEGIN
    IF (first) THEN

      RegData(31) <= (others => '0');
      RegData(30) <= x"0000000000000000";

      RegData(29) <= x"0000000000000000";

      RegData(28) <= x"0000000000000000";

      RegData(27) <= x"0000000000000080";
      RegData(26) <= x"0000000000000080";
      RegData(25) <= x"0000000000000040";
      RegData(24) <= x"0000000000000020";
      RegData(23) <= x"0000000000000010";
      RegData(22) <= x"0000000000000004";
      RegData(21) <= x"0000000000000002";
      RegData(20) <= x"0000000000000000";
      RegData(19) <= x"0000000000000008";

      RegData(18) <= x"0000000000000000";

      RegData(17) <= x"0000000000000000";

      RegData(16) <= x"0000000000000000";

      RegData(15) <= x"0000000000000020";
      RegData(14) <= x"0000000000000010";
      RegData(13) <= x"0000000000000008";
      RegData(12) <= x"0000000000000004";
      RegData(11) <= x"0000000000000002";
      RegData(10) <= x"0000000000000001";
      RegData(9) <= x"0000000000000000";

      RegData(8) <= x"0000000000000000";

      RegData(7) <= x"0000000000000000";
      RegData(6) <= x"0000000000000000";
      RegData(5) <= x"0000000000000000";
      RegData(4) <= x"0000000000000000";
      RegData(3) <= x"0000000000000000";
      RegData(2) <= x"0000000000000000";
      RegData(1) <= x"0000000000000000";
      RegData(0) <= x"0000000000000000";

      first := FALSE;
    END IF;
      
    Raddr1 := TO_INTEGER(UNSIGNED(RR1));
    Raddr2 := TO_INTEGER(UNSIGNED(RR2));

    IF (FALLING_EDGE(Clock) AND RegWrite='1') THEN
        Waddr := TO_INTEGER(UNSIGNED(WR));
        IF (NOT (Waddr = 31)) THEN
          RegData(Waddr) <= WD;
        END IF;
    END IF;
    RD1 <= RegData(Raddr1);
    RD2 <= RegData(Raddr2);
  END PROCESS;
  DEBUG_TMP_REGS <= RegData(9)&RegData(10)&RegData(11)&RegData(12);
  DEBUG_SAVED_REGS <= RegData(19)&RegData(20)&RegData(21)&RegData(22);
END behavioral;
