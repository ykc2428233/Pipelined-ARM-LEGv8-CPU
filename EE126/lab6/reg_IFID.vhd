LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegIFID IS 
PORT(
  clk		: IN STD_LOGIC;  
  rst		: IN STD_LOGIC;
  write_enable	: IN STD_LOGIC;
  PCaddrIn	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  InstIn 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  flush		: IN STD_LOGIC;
  PCaddrOut	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0000000000000000";
  InstOut 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000"
);
END RegIFID;

ARCHITECTURE behavioral OF RegIFID IS 
BEGIN
  PROCESS(clk, rst, write_enable)
  BEGIN
    IF (clk = '1' AND clk'event AND write_enable = '1') THEN 
      PCaddrOut <= PCaddrIn;
      InstOut <= InstIn;
    END IF;
    IF (clk = '1' AND clk'event AND flush = '1') THEN 
      PCaddrOut <= PCaddrIn;
      InstOut <= x"00000000";
    END IF;
    IF (rst = '1') THEN
      PCaddrOut <= x"0000000000000000";
      InstOut <= x"00000000";
    END IF;
  END PROCESS;
END behavioral;