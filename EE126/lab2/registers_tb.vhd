LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY registers_tb IS
END registers_tb;


ARCHITECTURE tb OF registers_tb IS
  COMPONENT registers
  PORT(
	  RR1      : in  STD_LOGIC_VECTOR (4 downto 0); 
     	  RR2      : in  STD_LOGIC_VECTOR (4 downto 0); 
     	  WR       : in  STD_LOGIC_VECTOR (4 downto 0); 
     	  WD       : in  STD_LOGIC_VECTOR (63 downto 0);
    	  RegWrite : in  STD_LOGIC;
     	  Clock    : in  STD_LOGIC;
     	  RD1      : out STD_LOGIC_VECTOR (63 downto 0);
     	  RD2      : out STD_LOGIC_VECTOR (63 downto 0);  
	  DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
	  DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
	);
  END COMPONENT;
  SIGNAL RR1      : STD_LOGIC_VECTOR (4 downto 0); 
  SIGNAL RR2      : STD_LOGIC_VECTOR (4 downto 0); 
  SIGNAL WR       : STD_LOGIC_VECTOR (4 downto 0); 
  SIGNAL WD       : STD_LOGIC_VECTOR (63 downto 0);
  SIGNAL RegWrite : STD_LOGIC;
  SIGNAL Clock    : STD_LOGIC;
  SIGNAL RD1      : STD_LOGIC_VECTOR (63 downto 0);
  SIGNAL RD2      : STD_LOGIC_VECTOR (63 downto 0);  
  SIGNAL DEBUG_TMP_REGS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
  SIGNAL DEBUG_SAVED_REGS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
  CONSTANT cycle : TIME := 50 ns;

BEGIN
  UUT : registers PORT MAP(
	  RR1 => RR1,
	  RR2 => RR2,
	  WR => WR,
	  WD => WD,
	  RegWrite => RegWrite,
	  Clock => Clock,
	  RD1 => RD1,
	  RD2 => RD2,
	  DEBUG_TMP_REGS => DEBUG_TMP_REGS,
	  DEBUG_SAVED_REGS => DEBUG_SAVED_REGS
	);

  clk: PROCESS
  BEGIN
  Clock <= '0';
  WAIT FOR cycle/2;
  INFINITE: LOOP
	Clock <= NOT Clock;
	WAIT FOR cycle/2;
  END LOOP;
  END PROCESS;

  stim_proc: PROCESS
    BEGIN
    RegWrite <= '1';
    WD <= x"AAAAAAAAAAAAAAAA";
    WR <= "01001";
    RR1 <= "01001";
      WAIT FOR 100 ns;
    RR1 <= "11011";
    RR2 <= "01111";
      WAIT FOR 100 ns;
    WD <= x"CCCCCCCCCCCCCCCC";
    WR <= "01011";
    RR1 <= "01011";
      WAIT FOR 100 ns;
    WD <= x"DDDDDDDDDDDDDDDD";
    WR <= "01100";
    RR2 <= "01100";
      WAIT FOR 100 ns;
    WD <= x"EEEEEEEEEEEEEEEE";
    WR <= "10011";
    RR1 <= "10011";
      WAIT FOR 100 ns;
    RegWrite <= '0';
    WD <= x"FFFFFFFFFFFFFFFF";
    WR <= "10100";
    RR2 <= "10100";
      WAIT FOR 100 ns;
    WD <= x"9999999999999999";
    WR <= "10101";
    RR1 <= "10101";
      WAIT FOR 100 ns;
    WD <= x"8888888888888888";
    WR <= "10110";
    RR2 <= "10110";
      WAIT FOR 100 ns;
    WD <= x"7777777777777777";
    WR <= "10110";
      WAIT FOR 100 ns;
    RegWrite <= '1';
    RR1 <= "11111";
    WD <= x"1234567890ABCDEF";
    WR <= "11111";
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;

END tb;