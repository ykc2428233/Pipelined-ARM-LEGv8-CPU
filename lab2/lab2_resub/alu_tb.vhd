LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE tb OF ALU_tb IS
  COMPONENT ALU
  port(
     in0       : in     STD_LOGIC_VECTOR(63 downto 0);
     in1       : in     STD_LOGIC_VECTOR(63 downto 0);
     operation : in     STD_LOGIC_VECTOR(3 downto 0);
     result    : buffer STD_LOGIC_VECTOR(63 downto 0);
     zero      : buffer STD_LOGIC;
     overflow  : buffer STD_LOGIC
    );
  end COMPONENT;
  SIGNAL in0       : STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL in1       : STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL operation : STD_LOGIC_VECTOR(3 downto 0);
  SIGNAL result    : STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL zero      : STD_LOGIC;
  SIGNAL overflow  : STD_LOGIC;

BEGIN
  UUT : ALU PORT MAP(
	  in0 => in0,
	  in1 => in1,
	  operation => operation,
	  result => result,
	  zero => zero,
	  overflow => overflow
	);
  stim_proc: PROCESS
    BEGIN
    in0 <= (others => '0');
    in1 <= (others => '1');
    operation <= "0000";
      WAIT FOR 100 ns;
    operation <= "0001";
      WAIT FOR 100 ns;
    operation <= "0010";
    in0 <= ( 3 => '1', 2 => '1', 1 => '1', others => '0');
    in1 <= ( 0 => '1', others => '0');
      WAIT FOR 100 ns;
    operation <= "0110";
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;

END tb;
