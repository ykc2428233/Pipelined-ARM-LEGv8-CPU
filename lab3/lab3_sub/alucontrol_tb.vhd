LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALUControl_tb IS
END ALUControl_tb;

ARCHITECTURE tb OF ALUControl_tb IS
  COMPONENT ALUControl
  port(
     ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
     Opcode    : in  STD_LOGIC_VECTOR(10 downto 0);
     Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
  end COMPONENT;
  SIGNAL ALUOp		: STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL Opcode    	: STD_LOGIC_VECTOR(10 downto 0);
  SIGNAL Operation 	: STD_LOGIC_VECTOR(3 downto 0);

BEGIN
  UUT : ALUControl PORT MAP(
	  ALUOp => ALUOp,
	  Opcode => Opcode,
	  Operation => Operation
	);
  stim_proc: PROCESS
    BEGIN
    Opcode <= "10010001000";
    ALUOp <= "10";
      WAIT FOR 100 ns;
    ALUOp(0) <= '1';
      WAIT FOR 100 ns;
    ALUOp <= "10";
    Opcode <= (3 => '1', 9 => '0', 8 => '1', OTHERS => 'X');
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;
END tb;