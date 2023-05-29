LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity SingleCycleCPU is
port(clk :in STD_LOGIC;
     rst :in STD_LOGIC;
     --Probe ports used for testing
     --The current address (AddressOut from the PC)
     DEBUG_PC : out STD_LOGIC_VECTOR(63 downto 0);
     --The current instruction (Instruction output of IMEM)
     DEBUG_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0);
     --DEBUG ports from other components
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
     --TMP_DEBUG : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
     --TMP_OPcode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
     --DEBUG_Reg2Loc : OUT STD_LOGIC;
     --DEBUG_CBranch : OUT STD_LOGIC;
     --DEBUG_MemRead : OUT STD_LOGIC;
     --DEBUG_MemtoReg : OUT STD_LOGIC;
     --DEBUG_MemWrite : OUT STD_LOGIC;
     --DEBUG_ALUSrc : OUT STD_LOGIC;
     --DEBUG_RegWrite : OUT STD_LOGIC;
     --DEBUG_UBranch : OUT STD_LOGIC;
     --DEBUG_ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
     --DEBUG_ZERO : OUT STD_LOGIC
);
end SingleCycleCPU;
	
ARCHITECTURE SingleCycleCPU_arch OF SingleCycleCPU IS

SIGNAL PCAddressIn_MuxOut : STD_LOGIC_VECTOR(63 DOWNTO 0); --2 ok
SIGNAL AddALU_Mux641 : STD_LOGIC_VECTOR(63 DOWNTO 0); --2 ok
SIGNAL Mux640_PCAddOut : STD_LOGIC_VECTOR(63 DOWNTO 0); --2 ok
SIGNAL PCOut_IMEMRead_PCAddA_ADDALUA : STD_LOGIC_VECTOR(63 DOWNTO 0); --4 ok
SIGNAL AdderALUB_ShiftLeftY : STD_LOGIC_VECTOR(63 DOWNTO 0); --2 ok
SIGNAL Instructions : STD_LOGIC_VECTOR(31 DOWNTO 0); --8 OK
SIGNAL MUX5Out_RegRead2 : STD_LOGIC_VECTOR(4 DOWNTO 0); --2 ok
SIGNAL MUX64Out_RegWData : STD_LOGIC_VECTOR(63 DOWNTO 0); --2 ok
SIGNAL DMEMRData_MUX641 : STD_LOGIC_VECTOR(63 DOWNTO 0); -- 2 ok
SIGNAL ALUresult_DMEMAddress_MUX640 : STD_LOGIC_VECTOR(63 DOWNTO 0); --3 ok
SIGNAL DMEMWData_RegRData2_MUX640 : STD_LOGIC_VECTOR(63 DOWNTO 0); --3 ok
SIGNAL ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0); --2 ok
SIGNAL ALU_Operation : STD_LOGIC_VECTOR(3 downto 0); -- 2 ok
SIGNAL MemRead : STD_LOGIC; --2 ok
SIGNAL MemWrite : STD_LOGIC; --2 ok
SIGNAL Mem2Reg : STD_LOGIC; --2 ok
SIGNAL SignExtended : STD_LOGIC_VECTOR(63 DOWNTO 0); --3 ok
SIGNAL RegRData1_ALU0 : STD_LOGIC_VECTOR (63 downto 0); --2 ok
SIGNAL RegWrite : STD_LOGIC; --2 ok
SIGNAL ALUSrc : STD_LOGIC; --2 ok
SIGNAL ALUin1_MUX64Out : STD_LOGIC_VECTOR (63 downto 0); --2 ok
SIGNAL Reg2Loc : STD_LOGIC; --2 
-- DEBUG
SIGNAL Conditional_Branch : STD_LOGIC;
SIGNAL Unconditional_Branch : STD_LOGIC;
SIGNAL ALU_Zero : STD_LOGIC;
SIGNAL ALU_Overflow : STD_LOGIC;
--SIGNAL PC_enable : STD_LOGIC;
SIGNAL Branch_AND_Zero : STD_LOGIC;
SIGNAL Branch_and_zero_OR_UBranch : STD_LOGIC;
SIGNAL Tmp_Regs : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
SIGNAL Saved_Regs : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
SIGNAL MEM_Contents : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
--SIGNAL TMP_ZERO : STD_LOGIC;
SIGNAL NOTZERO : STD_LOGIC;
SIGNAL ZEROorNOT : STD_LOGIC;

BEGIN

  PC : ENTITY work.PC 
    PORT MAP(
	clk => clk,
	write_enable => '1', 
	rst => rst,
	AddressIn => PCAddressIn_MuxOut,
	AddressOut => PCOut_IMEMRead_PCAddA_ADDALUA
    );	
 
  PCMUX64 : ENTITY work.MUX64 
    PORT MAP(
	in0 => Mux640_PCAddOut,
	in1 => AddALU_Mux641,
	sel => Branch_and_zero_OR_UBranch,
	output => PCAddressIn_MuxOut
    );
	
  PC_ADDer : ENTITY work.ADDER64 -- OK
    PORT MAP(
	Cin => '0',
	A => PCOut_IMEMRead_PCAddA_ADDALUA,
	B => x"0000000000000004",
	Sum => Mux640_PCAddOut,
	Cout => OPEN
    );

  ALU_ADDer : ENTITY work.ADDER64 -- OK
    PORT MAP(
	Cin => '0',
	A => PCOut_IMEMRead_PCAddA_ADDALUA,
	B => AdderALUB_ShiftLeftY,
	Sum => AddALU_Mux641,
	Cout => OPEN
    );

  Shift_left_2 : ENTITY work.ShiftLeft2 -- OK
    PORT MAP(
	x => SignExtended,
	y => AdderALUB_ShiftLeftY
    );

  Sign_Extend : ENTITY work.SignExtend --OK
    PORT MAP(
	x => Instructions,
	y => SignExtended
    );

  ALU_Control : ENTITY work.ALUControl --OK
    PORT MAP(
	ALUOp => ALUOp,
	Opcode => Instructions(31 DOWNTO 21),
	Operation => ALU_Operation

    );

  CPU_Control : ENTITY work.CPUControl
    PORT MAP(
	Opcode => Instructions(31 DOWNTO 21),
	Reg2Loc => Reg2Loc,
	CBranch => Conditional_Branch,
	MemRead => MemRead,
	MemtoReg => Mem2Reg,
	MemWrite => MemWrite,
	ALUSrc => ALUSrc,
	RegWrite => RegWrite,
	UBranch => Unconditional_Branch,
	ALUOp => ALUOp,
        NOTZERO => NOTZERO
    );

  MUX5_RegIn : ENTITY work.MUX5 -- OK
    PORT MAP(
	in0 => Instructions(20 DOWNTO 16),
	in1 => Instructions(4 DOWNTO 0),
	sel => Reg2Loc,
	output => MUX5Out_RegRead2
    );

  Regs : ENTITY work.registers
    PORT MAP(
	RR1 => Instructions(9 DOWNTO 5),
	RR2 => MUX5Out_RegRead2,
	WR => Instructions(4 DOWNTO 0),
	WD => MUX64Out_RegWData,
	RegWrite => RegWrite,
	Clock => clk,
	RD1 => RegRData1_ALU0,
	RD2 => DMEMWData_RegRData2_MUX640,
	DEBUG_TMP_REGS => Tmp_Regs,  --DEBUG SIGNAL
	DEBUG_SAVED_REGS => Saved_Regs  --DEBUG SIGNAL
    );

  MUX64_RegOut : ENTITY work.MUX64 -- OK
    PORT MAP(
	in0 => DMEMWData_RegRData2_MUX640,
	in1 => SignExtended,
	sel => ALUSrc,
	output => ALUin1_MUX64Out
    );
  
  MUX64_DMEMOut : ENTITY work.MUX64 -- OK
    PORT MAP(
	in0 => ALUresult_DMEMAddress_MUX640,
	in1 => DMEMRData_MUX641,
	sel => Mem2Reg,
	output => MUX64Out_RegWData
    );


  Data_MEM : ENTITY work.DMEM 
    --GENERIC(NUM_BYTE : INTEGER := 1024);
    PORT MAP(
	WriteData => DMEMWData_RegRData2_MUX640,
	Address => ALUresult_DMEMAddress_MUX640,
	MemRead => MemRead,
	MemWrite => MemWrite,
	Clock => clk,
	ReadData => DMEMRData_MUX641,
	DEBUG_MEM_CONTENTS => MEM_Contents--DEBUG SIGNAL
    );

  Instruction_MEM : ENTITY work.IMEM --OK
    --GENERIC(NUM_BYTE : INTEGER := 128);
    PORT MAP(
	Address => PCOut_IMEMRead_PCAddA_ADDALUA,
	ReadData => Instructions
    );

  ALU_full : ENTITY work.ALU
    PORT MAP(
	in0 => RegRData1_ALU0,
	in1 => ALUin1_MUX64Out,
	operation => ALU_Operation,
	result => ALUresult_DMEMAddress_MUX640,
	zero => ALU_Zero,
	overflow => ALU_Overflow
    );

  NOTZERO_MUX : ENTITY work.MUXZero
    PORT MAP(
	zero => ALU_Zero,
	sel => NOTZERO,
	output => ZEROorNOT
    );

  Branch_AND_Zero <= (Conditional_Branch AND ZEROorNOT);
  Branch_and_zero_OR_UBranch <= (Branch_AND_Zero OR Unconditional_Branch);
  DEBUG_TMP_REGS <= Tmp_Regs;
  DEBUG_SAVED_REGS <= Saved_Regs;
  DEBUG_MEM_CONTENTS <= MEM_Contents;
  DEBUG_INSTRUCTION <= Instructions;
  DEBUG_PC <= PCOut_IMEMRead_PCAddA_ADDALUA;
  --TMP_DEBUG <= ALUresult_DMEMAddress_MUX640;
  --TMP_OPcode <= ALU_Operation;
  --TMP_ZERO <= ALU_ZERO;
-- CPU Control Debug
  --DEBUG_Reg2Loc <= Reg2Loc;
  --DEBUG_CBranch <= Conditional_Branch;
  --DEBUG_MemRead <= MemRead;
  --DEBUG_MemtoReg <= Mem2Reg;
  --DEBUG_MemWrite <= MemWrite;
  --DEBUG_ALUSrc <= ALUSrc;
  --DEBUG_RegWrite <= RegWrite;
  --DEBUG_UBranch <= Unconditional_Branch;
  --DEBUG_ALUOp <= ALUOp;
  --DEBUG_ZERO <= TMP_ZERO;
  --PC_enable = '1';

  
END SingleCycleCPU_arch;