LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PC_tb IS
END PC_tb;

ARCHITECTURE tb OF PC_tb IS
  COMPONENT PC 
  PORT(
	clk : IN STD_LOGIC;
	write_enable 	: IN STD_LOGIC;
	rst		: IN STD_LOGIC;
	AddressIn	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	AddressOut	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
  END COMPONENT;
  SIGNAL clk : STD_LOGIC;
  SIGNAL write_enable 	: STD_LOGIC;
  SIGNAL rst		: STD_LOGIC;
  SIGNAL AddressIn	: STD_LOGIC_VECTOR(63 DOWNTO 0);
  SIGNAL AddressOut	: STD_LOGIC_VECTOR(63 DOWNTO 0);
  CONSTANT cycle : TIME := 100 ns;

BEGIN
  UUT : PC PORT MAP(
	  clk => clk,
	  write_enable => write_enable,
	  rst => rst,
	  AddressIn => AddressIn,
	  AddressOut => AddressOut
	);
  clock: PROCESS
  BEGIN
  clk <= '0';
  WAIT FOR cycle/2;
  INFINITE: LOOP
	clk <= NOT clk;
	WAIT FOR cycle/2;
  END LOOP;
  END PROCESS;

  reset: PROCESS
  BEGIN
  rst <= '0';
  WAIT FOR cycle;
  INFINITE: LOOP
	rst <= NOT rst;
	WAIT FOR cycle;
  END LOOP;
  END PROCESS;

  write_in: PROCESS
  BEGIN
  write_enable <= '0';
  WAIT FOR cycle*2;
  INFINITE: LOOP
	write_enable <= NOT write_enable;
	WAIT FOR cycle*2;
  END LOOP;
  END PROCESS;

  stim_proc: PROCESS
  BEGIN
  AddressIn <= x"FFFFFFFFFFFFFFFF";
  WAIT FOR 4*cycle;
    WAIT;
  END PROCESS;
END tb;
