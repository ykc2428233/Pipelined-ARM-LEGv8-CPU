LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPUControl_tb IS
END CPUControl_tb;

ARCHITECTURE tb OF CPUControl_tb IS
  COMPONENT CPUControl
  port(
	  Opcode   : in  STD_LOGIC_VECTOR(10 downto 0);
     	  Reg2Loc  : out STD_LOGIC;
     	  CBranch  : out STD_LOGIC;  --conditional
     	  MemRead  : out STD_LOGIC;
     	  MemtoReg : out STD_LOGIC;
     	  MemWrite : out STD_LOGIC;
     	  ALUSrc   : out STD_LOGIC;
     	  RegWrite : out STD_LOGIC;
     	  UBranch  : out STD_LOGIC; -- This is unconditional
     	  ALUOp    : out STD_LOGIC_VECTOR(1 downto 0)
	);
  END COMPONENT;
  SIGNAL Opcode		: STD_LOGIC_VECTOR(10 DOWNTO 0);
  SIGNAL Reg2Loc	: STD_LOGIC;
  SIGNAL CBranch  	: STD_LOGIC;  
  SIGNAL MemRead  	: STD_LOGIC;
  SIGNAL MemtoReg 	: STD_LOGIC;
  SIGNAL MemWrite 	: STD_LOGIC;
  SIGNAL ALUSrc   	: STD_LOGIC;
  SIGNAL RegWrite 	: STD_LOGIC;
  SIGNAL UBranch  	: STD_LOGIC; 
  SIGNAL ALUOp    	: STD_LOGIC_VECTOR(1 downto 0);

BEGIN
  UUT : CPUControl PORT MAP(
	  Opcode => Opcode,
	  Reg2Loc => Reg2Loc,
	  CBranch => CBranch,
	  MemRead => MemRead,
	  MemtoReg => MemtoReg,
	  MemWrite => MemWrite,
	  ALUSrc => ALUSrc,
	  RegWrite => RegWrite,
 	  UBranch => UBranch,
	  ALUOp => ALUOp
	);
  stim_proc: PROCESS
    BEGIN 
    Opcode <= "11111000010";
      WAIT FOR 100 ns;
    Opcode <= "11101011000";
      WAIT FOR 100 ns;
    Opcode <= "11111000000";
      WAIT FOR 100 ns;
    Opcode <= "10110100110";
      WAIT FOR 100 ns;
    Opcode <= "00010100101";
      WAIT FOR 100 ns;
    WAIT;
    END PROCESS;
END tb;

