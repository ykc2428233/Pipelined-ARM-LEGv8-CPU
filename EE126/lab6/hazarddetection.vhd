LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY HazardDetection IS
PORT(
  IDEX_MemRead	: IN STD_LOGIC;
  IDEX_Rd	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  IFID_Rn	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  IFID_Rm	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  PCWrite	: OUT STD_LOGIC;
  IFIDWrite	: OUT STD_LOGIC;
  StallEnable	: OUT STD_LOGIC
);
END HazardDetection;

ARCHITECTURE behavioral OF HazardDetection IS
BEGIN
  PROCESS(IDEX_MemRead, IDEX_Rd, IFID_Rn, IFID_Rm)
  BEGIN
    IF (IDEX_MemRead = '1' AND (IDEX_Rd = IFID_Rn OR IDEX_Rd = IFID_Rm)) THEN
      PCWrite <= '0';
      IFIDWrite <= '0';
      StallEnable <= '1';
    ELSE
      PCWrite <= '1';
      IFIDWrite <= '1';
      StallEnable <= '0';
    END IF;
  END PROCESS;
END behavioral;