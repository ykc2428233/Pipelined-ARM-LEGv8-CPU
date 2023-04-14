LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity PipelinedCPU2 is
port(
     clk :in std_logic;
     rst :in std_logic;
     --Probe ports used for testing
     DEBUG_IF_FLUSH : out std_logic;
     DEBUG_REG_EQUAL : out std_logic;
     -- Forwarding control signals
     DEBUG_FORWARDA : out std_logic_vector(1 downto 0);
     DEBUG_FORWARDB : out std_logic_vector(1 downto 0);
     --The current address (AddressOut from the PC)
     DEBUG_PC : out std_logic_vector(63 downto 0);
     --Value of PC.write_enable
     DEBUG_PC_WRITE_ENABLE : out STD_LOGIC;
     --The current instruction (Instruction output of IMEM)
     DEBUG_INSTRUCTION : out std_logic_vector(31 downto 0);
     --DEBUG ports from other components
     DEBUG_TMP_REGS : out std_logic_vector(64*4 - 1 downto 0);
     DEBUG_SAVED_REGS : out std_logic_vector(64*4 - 1 downto 0);
     DEBUG_MEM_CONTENTS : out std_logic_vector(64*4 - 1 downto 0)
);
end PipelinedCPU2;

ARCHITECTURE PipelinedCPU2_arch OF PipelinedCPU2 IS
--PCMUX64
SIGNAL EXMEM_ALUResult : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL PCSrc : STD_LOGIC; -- 2-1
SIGNAL Mux640_PCAddOut : STD_LOGIC_VECTOR(63 DOWNTO 0);

-- PC
SIGNAL PCAddressIn_MuxOut : STD_LOGIC_VECTOR(63 DOWNTO 0); 
SIGNAL PCOut_IMEMRead_PCAddA_ADDALUA : STD_LOGIC_VECTOR(63 DOWNTO 0); --0
SIGNAL PCWrite : STD_LOGIC;

--IMEM
SIGNAL Instructions : STD_LOGIC_VECTOR(31 DOWNTO 0); --0

--IF/ID
SIGNAL IFID_PC_Out : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL IFID_Inst_Out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL IFFLUSH : STD_LOGIC;

--mux of regs
SIGNAL MUX5Out_RegRead2 : STD_LOGIC_VECTOR(4 DOWNTO 0);

--CPU Control
SIGNAL Conditional_Branch : STD_LOGIC;
SIGNAL Unconditional_Branch : STD_LOGIC;
SIGNAL MemRead : STD_LOGIC;
SIGNAL MemWrite : STD_LOGIC;
SIGNAL Mem2Reg : STD_LOGIC;
SIGNAL ALUSrc : STD_LOGIC;
SIGNAL RegWrite : STD_LOGIC;
SIGNAL NOTZERO : STD_LOGIC;
SIGNAL ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0);

--CPU MUX Control
SIGNAL Conditional_Branch_MUX : STD_LOGIC;
SIGNAL Unconditional_Branch_MUX : STD_LOGIC;
SIGNAL MemRead_MUX : STD_LOGIC;
SIGNAL MemWrite_MUX : STD_LOGIC;
SIGNAL Mem2Reg_MUX : STD_LOGIC;
SIGNAL ALUSrc_MUX : STD_LOGIC;
SIGNAL RegWrite_MUX : STD_LOGIC;
SIGNAL NOTZERO_MUX : STD_LOGIC;
SIGNAL ALUOp_MUX : STD_LOGIC_VECTOR(1 DOWNTO 0);

--Register
SIGNAL MEMWB_RegWrite_Out : STD_LOGIC;
SIGNAL Tmp_Regs : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
SIGNAL Saved_Regs : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
SIGNAL RegRData1_ALU0_In : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL DMEMWData_RegRData2_MUX640_In : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL MUX64Out_RegWData : STD_LOGIC_VECTOR(63 DOWNTO 0);

--Equal
SIGNAL equal0 : STD_LOGIC;

--Hazard
SIGNAL IFIDWrite : STD_LOGIC;
SIGNAL StallEnable : STD_LOGIC;

--IDEX
SIGNAL RegWrite_IDEX_Out : STD_LOGIC;
SIGNAL MemtoReg_IDEX_Out : STD_LOGIC;
SIGNAL Unconditional_Branch_IDEX_OUT : STD_LOGIC;
SIGNAL Conditional_Branch_IDEX_OUT : STD_LOGIC;
SIGNAL MemRead_IDEX_Out : STD_LOGIC;
SIGNAL MemWrite_IDEX_Out : STD_LOGIC;
SIGNAL ALUOp_IDEX_Out : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ALUSrc_IDEX_Out : STD_LOGIC;
SIGNAL NOTZERO_IDEX_OUT : STD_LOGIC;

SIGNAL SignExtended : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL IDEX_Data1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL IDEX_Data2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL IDEX_Extended : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL IDEX_Inst31_21 : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL IDEX_Inst4_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL IDEX_Rm20_16 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL IDEX_Rn9_5 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL IDEX_PCaddr : STD_LOGIC_VECTOR(63 DOWNTO 0);

-- Shiftleft
SIGNAL AdderALUB_ShiftLeftY : STD_LOGIC_VECTOR(63 DOWNTO 0);

-- ALU control
SIGNAL ALU_Operation : STD_LOGIC_VECTOR(3 downto 0);

--Forward
SIGNAL ForwardA : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ForwardB : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ALUIn0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL ALUIn1 : STD_LOGIC_VECTOR(63 DOWNTO 0);

-- MUX64 of ALU
SIGNAL ALUin1_MUX64Out : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL ALU_Zero : STD_LOGIC;
SIGNAL ALU_Overflow : STD_LOGIC;
SIGNAL ALUresult : STD_LOGIC_VECTOR(63 DOWNTO 0);

--PC Address adder
SIGNAL PCaddrNew : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL FlagZeroOrNot : STD_LOGIC;

-- EX/MEM
SIGNAL RegWrite_EXMEM_Out : STD_LOGIC;
SIGNAL MemtoReg_EXMEM_Out : STD_LOGIC;
SIGNAL Unconditional_Branch_EXMEM_OUT : STD_LOGIC;
SIGNAL Conditional_Branch_EXMEM_OUT : STD_LOGIC;
SIGNAL MemRead_EXMEM_Out : STD_LOGIC;
SIGNAL MemWrite_EXMEM_Out : STD_LOGIC;

SIGNAL EXMEM_Data2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL EXMEM_FlagZeroOrNot : STD_LOGIC;
SIGNAL EXMEM_Inst4_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL EXMEM_PCaddrNew : STD_LOGIC_VECTOR(63 DOWNTO 0);

--DMEM
SIGNAL MEM_Contents : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
SIGNAL DMEMRData : STD_LOGIC_VECTOR(63 DOWNTO 0);

--Branch
SIGNAL CBranch : STD_LOGIC;

--MEMWB
SIGNAL MEMWB_ALUresult : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL MEMWB_Inst4_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL MEMWB_DMEMRData : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL RegWrite_MEMWB_Out : STD_LOGIC;
SIGNAL MemtoReg_MEMWB_Out : STD_LOGIC;

BEGIN

  PCMUX64 : ENTITY work.MUX64 
    PORT MAP(
	in0 => Mux640_PCAddOut,
	in1 => PCaddrNew,
	sel => PCSrc, ----------------------------------
	output => PCAddressIn_MuxOut
    );

  PC : ENTITY work.PC 
    PORT MAP(
	clk => clk,
	write_enable => PCWrite, 
	rst => rst,
	AddressIn => PCAddressIn_MuxOut,
	AddressOut => PCOut_IMEMRead_PCAddA_ADDALUA
    );	
	DEBUG_PC <= PCOut_IMEMRead_PCAddA_ADDALUA;
	DEBUG_PC_WRITE_ENABLE <= PCWrite;

  PC_ADDer : ENTITY work.ADDER64
    PORT MAP(
	Cin => '0',
	A => PCOut_IMEMRead_PCAddA_ADDALUA,
	B => x"0000000000000004",
	Sum => Mux640_PCAddOut,
	Cout => OPEN
    );

   Instruction_MEM : ENTITY work.IMEM
    PORT MAP(
	Address => PCOut_IMEMRead_PCAddA_ADDALUA,
	ReadData => Instructions
    );
	DEBUG_INSTRUCTION <= Instructions;

  IFID : ENTITY work.RegIFID
    PORT MAP(
  	clk => clk, 
  	rst => rst,
  	write_enable => IFIDWrite,
  	PCaddrIn => PCOut_IMEMRead_PCAddA_ADDALUA,
  	InstIn 	=> Instructions,
        PCaddrOut => IFID_PC_Out,
	InstOut => IFID_Inst_Out,
        flush => IFFLUSH
    );
	IFFLUSH <= (Conditional_Branch_MUX AND equal0) OR Unconditional_Branch_MUX;
	DEBUG_IF_FLUSH <= IFFLUSH;

  MUX5_RegIn : ENTITY work.MUX5
    PORT MAP(
	in0 => IFID_Inst_Out(20 DOWNTO 16),
	in1 => IFID_Inst_Out(4 DOWNTO 0),
	sel => IFID_Inst_Out(28),
	output => MUX5Out_RegRead2
    );

  CPU_Control : ENTITY work.CPUControl
    PORT MAP(
	Opcode => IFID_Inst_Out(31 DOWNTO 21),
	Reg2Loc => OPEN,
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

  Regs : ENTITY work.registers
    PORT MAP(
	RR1 => IFID_Inst_Out(9 DOWNTO 5),
	RR2 => MUX5Out_RegRead2,
	WR => MEMWB_inst4_0, --WB
	WD => MUX64Out_RegWData,
	RegWrite => RegWrite_MEMWB_Out, --WB
	Clock => clk,
	RD1 => RegRData1_ALU0_In,
	RD2 => DMEMWData_RegRData2_MUX640_In,
	DEBUG_TMP_REGS => Tmp_Regs,  --DEBUG SIGNAL
	DEBUG_SAVED_REGS => Saved_Regs  --DEBUG SIGNAL
    );
	DEBUG_TMP_REGS <= Tmp_Regs;
  	DEBUG_SAVED_REGS <= Saved_Regs;

  Equal : ENTITY work.Equal0
    PORT MAP(
	datavalue => DMEMWData_RegRData2_MUX640_In,
	eq0 => equal0
    );
	DEBUG_REG_EQUAL <= equal0;

  Sign_Extend : ENTITY work.SignExtend --OK
    PORT MAP(
	x => IFID_Inst_Out,
	y => SignExtended
    );

  Hazard : ENTITY work.HazardDetection
    PORT MAP(
	IDEX_MemRead => MemRead_IDEX_Out,
  	IDEX_Rd	=> IDEX_Inst4_0,
  	IFID_Rn	=> IFID_Inst_Out(9 DOWNTO 5),
  	IFID_Rm	=> IFID_Inst_Out(20 DOWNTO 16),
  	PCWrite	=> PCWrite,
  	IFIDWrite => IFIDWrite,
  	StallEnable => StallEnable
    );

---------------------------------------------
  Shift_left_2 : ENTITY work.ShiftLeft2 
    PORT MAP(
	x => SignExtended,
	y => AdderALUB_ShiftLeftY
    );

  Addr_Adder : ENTITY work.ADDER64 -- OK
    PORT MAP(
	Cin => '0',
	A => IFID_PC_Out,
	B => AdderALUB_ShiftLeftY,
	Sum => PCaddrNew,
	Cout => OPEN
    );
	FlagZeroOrNot <= (ALU_ZERO XOR NOTZERO);
-------------------------------------------

  ControlMux : ENTITY work.MUXControl
    PORT MAP(
    	CBranchIn => Conditional_Branch,
     	MemReadIn => MemRead,
    	MemtoRegIn => Mem2Reg,
     	MemWriteIn => MemWrite,
     	ALUSrcIn => ALUSrc,
     	RegWriteIn => RegWrite,
     	UBranchIn => Unconditional_Branch,
     	ALUOpIn => ALUOp,
     	NOTZEROIn => NOTZERO,
     	sel => StallEnable,
     	CBranchOut => Conditional_Branch_MUX,
     	MemReadOut => MemRead_MUX,
     	MemtoRegOut => Mem2Reg_MUX,
     	MemWriteOut => MemWrite_MUX,
     	ALUSrcOut => ALUSrc_MUX,
     	RegWriteOut => RegWrite_MUX,
     	UBranchOut => Unconditional_Branch_MUX,
     	ALUOpOut => ALUOp_MUX,
     	NOTZEROOut => NOTZERO_MUX
    );

        PCSrc <= (Conditional_Branch_MUX AND equal0) OR Unconditional_Branch_MUX;

  IDEX : ENTITY work.RegIDEX
    PORT MAP(
	-- Control
  	clk => clk, 
  	rst => rst,
  	write_enable => '1',
	-- CPU Control Signal
	  --WB
	RegWriteIn => RegWrite_MUX,
  	RegWriteOut => RegWrite_IDEX_Out,
  	MemtoRegIn => Mem2Reg_MUX, 
  	MemtoRegOut => MemtoReg_IDEX_Out,
	  --M
  	UBranchIn  => Unconditional_Branch_MUX,
  	UBranchOut => Unconditional_Branch_IDEX_OUT,
  	CBranchIn  => Conditional_Branch_MUX,
  	CBranchOut => Conditional_Branch_IDEX_OUT,
  	MemReadIn => MemRead_MUX,
  	MemReadOut => MemRead_IDEX_Out,
  	MemWriteIn => MemWrite_MUX,
  	MemWriteOut => MemWrite_IDEX_Out,
  	  --EX
  	ALUOpIn	=> ALUOp_MUX,
  	ALUOpOut => ALUOp_IDEX_Out,
  	ALUSrcIn => ALUSrc_MUX,
  	ALUSrcOut => ALUSrc_IDEX_Out,
        NOTZEROIn => NOTZERO_MUX,
        NOTZEROOut => NOTZERO_IDEX_OUT,
	-- Info
  	ReadData1In => RegRData1_ALU0_In,
  	ReadData2In => DMEMWData_RegRData2_MUX640_In,
  	ExtendedInstIn	=> SignExtended,
  	Inst31_21In => IFID_Inst_Out(31 DOWNTO 21),
  	Inst4_0In => IFID_Inst_Out(4 DOWNTO 0),
        Rm20_16In => MUX5Out_RegRead2,
	Rn9_5In => IFID_Inst_Out(9 DOWNTO 5),
  	PCaddrIn => IFID_PC_Out,
  	ReadData1Out => IDEX_Data1,
  	ReadData2Out => IDEX_Data2,
  	ExtendedInstOut	=> IDEX_Extended,
  	Inst31_21Out => IDEX_Inst31_21,
  	Inst4_0Out => IDEX_Inst4_0,
	Rm20_16Out => IDEX_Rm20_16,
	Rn9_5Out => IDEX_Rn9_5,
  	PCaddrOut => IDEX_PCaddr
    );


  ALU_Control : ENTITY work.ALUControl --OK
    PORT MAP(
	ALUOp => ALUOp_IDEX_Out,
	Opcode => IDEX_Inst31_21,
	Operation => ALU_Operation
    );

  Forward : ENTITY work.FORWARDING
    PORT MAP(
  	Rn => IDEX_Rn9_5,
  	Rm => IDEX_Rm20_16,
  	--Rd => IDEX_Inst4_0,
  	EXMEM_Rd => EXMEM_Inst4_0,
  	MEMWB_Rd => MEMWB_Inst4_0,
  	EXMEM_RegWrite => RegWrite_EXMEM_Out,
 	MEMWB_RegWrite => RegWrite_MEMWB_Out,
 	ForwardA => ForwardA,
  	ForwardB => ForwardB
    );
	DEBUG_FORWARDA <= ForwardA;
	DEBUG_FORWARDB <= ForwardB;


  MUXFA : ENTITY work.MUX64321
    PORT MAP(
	in0 => IDEX_Data1,
    	in1 => MUX64Out_RegWData,
    	in2 => EXMEM_ALUresult,
    	sel => ForwardA,
    	output => ALUIn0
    );

  MUXFB : ENTITY work.MUX64321
    PORT MAP(
	in0 => IDEX_Data2,
    	in1 => MUX64Out_RegWData,
    	in2 => EXMEM_ALUresult,
    	sel => ForwardB,
    	output => ALUIn1
    );

  MUX64_ALUIn : ENTITY work.MUX64 -- OK
    PORT MAP(
	in0 => ALUIn1,
	in1 => IDEX_Extended,
	sel => ALUSrc_IDEX_Out,
	output => ALUin1_MUX64Out
    );

  ALU_full : ENTITY work.ALU
    PORT MAP(
	in0 => ALUIn0,
	in1 => ALUin1_MUX64Out,
	operation => ALU_Operation,
	result => ALUresult,
	zero => ALU_Zero,
	overflow => ALU_Overflow
    );


  EXMEM : ENTITY work.RegEXMEM
    PORT MAP(
	-- Control
  	clk => clk, 
  	rst => rst,
  	write_enable => '1',
	-- CPU Control Signal
	  --WB
	RegWriteIn => RegWrite_IDEX_Out,
  	RegWriteOut => RegWrite_EXMEM_Out,
  	MemtoRegIn => MemtoReg_IDEX_Out, 
  	MemtoRegOut => MemtoReg_EXMEM_Out,
	  --M
  	UBranchIn  => Unconditional_Branch_IDEX_OUT,
  	UBranchOut => Unconditional_Branch_EXMEM_OUT,
  	CBranchIn  => Conditional_Branch_IDEX_OUT,
  	CBranchOut => Conditional_Branch_EXMEM_OUT,
  	MemReadIn => MemRead_IDEX_Out,
  	MemReadOut => MemRead_EXMEM_Out,
  	MemWriteIn => MemWrite_IDEX_Out,
  	MemWriteOut => MemWrite_EXMEM_Out,
	-- Info
  	FlagZeroIn => FlagZeroOrNot,
	ALUResultIn => ALUresult,
	ReadData2In => ALUIn1,
	Inst4_0In => IDEX_Inst4_0,
	PCNewaddrIn => PCaddrNew,

  	FlagZeroOut => EXMEM_FlagZeroOrNot,
	ALUResultOut => EXMEM_ALUresult,
	ReadData2Out => EXMEM_Data2,
	Inst4_0Out => EXMEM_Inst4_0,
	PCNewaddrOut => EXMEM_PCaddrNew
    );

  Data_MEM : ENTITY work.DMEM 
    --GENERIC(NUM_BYTE : INTEGER := 1024);
    PORT MAP(
	WriteData => EXMEM_Data2,
	Address => EXMEM_ALUresult,
	MemRead => MemRead_EXMEM_Out,
	MemWrite => MemWrite_EXMEM_Out,
	Clock => clk,
	ReadData => DMEMRData,
	DEBUG_MEM_CONTENTS => MEM_Contents--DEBUG SIGNAL
    );
	DEBUG_MEM_CONTENTS <= MEM_Contents;

	--CBranch <= EXMEM_FlagZeroOrNot AND Conditional_Branch_EXMEM_OUT;
	--PCSrc <= CBranch OR Unconditional_Branch_EXMEM_OUT;

  MEMWB : ENTITY work.RegMEMWB
    PORT MAP(
	-- Control
  	clk => clk, 
  	rst => rst,
  	write_enable => '1',
	-- CPU Control Signal
	  --WB
	RegWriteIn => RegWrite_EXMEM_Out,
  	RegWriteOut => RegWrite_MEMWB_Out,
  	MemtoRegIn => MemtoReg_EXMEM_Out, 
  	MemtoRegOut => MemtoReg_MEMWB_Out,
	-- Info
	ALUResultIn => EXMEM_ALUresult,
	Inst4_0In => EXMEM_Inst4_0,
	MemReadIn => DMEMRData,
	ALUResultOut => MEMWB_ALUresult,
	Inst4_0Out => MEMWB_Inst4_0,
	MemReadOut => MEMWB_DMEMRData
    );

  MUX64_DMEMOut : ENTITY work.MUX64 -- OK
    PORT MAP(
	in0 => MEMWB_ALUresult,
	in1 => MEMWB_DMEMRData,
	sel => MemtoReg_MEMWB_Out,
	output => MUX64Out_RegWData
    );

END PipelinedCPU2_arch;