LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MUXControl is
port(
     --Reg2LocIn  : in STD_LOGIC;
     CBranchIn  : in STD_LOGIC;  --conditional
     MemReadIn  : in STD_LOGIC;
     MemtoRegIn : in STD_LOGIC;
     MemWriteIn : in STD_LOGIC;
     ALUSrcIn   : in STD_LOGIC;
     RegWriteIn : in STD_LOGIC;
     UBranchIn  : in STD_LOGIC; -- This is unconditional
     ALUOpIn    : in STD_LOGIC_VECTOR(1 downto 0);
     NOTZEROIn  : in STD_LOGIC; 
     sel      	: in STD_LOGIC;

     --Reg2LocOut  : out STD_LOGIC;
     CBranchOut  : out STD_LOGIC;  --conditional
     MemReadOut  : out STD_LOGIC;
     MemtoRegOut : out STD_LOGIC;
     MemWriteOut : out STD_LOGIC;
     ALUSrcOut   : out STD_LOGIC;
     RegWriteOut : out STD_LOGIC;
     UBranchOut  : out STD_LOGIC; -- This is unconditional
     ALUOpOut    : out STD_LOGIC_VECTOR(1 downto 0);
     NOTZEROOut  : out STD_LOGIC 
);
end MUXControl;

ARCHITECTURE behavioral OF MUXControl IS
BEGIN
  PROCESS (CBranchIn, MemReadIn, MemtoRegIn, MemWriteIn, ALUSrcIn, RegWriteIn, UBranchIn, ALUOpIn, NOTZEROIn, sel)
  BEGIN
    IF (sel = '0') THEN
      --Reg2LocOut <= Reg2LocIn;
      CBranchOut <= CBranchIn;
      MemReadOut <= MemReadIn;
      MemtoRegOut <= MemtoRegIn;
      MemWriteOut <= MemWriteIn;
      ALUSrcOut <= ALUSrcIn;
      RegWriteOut <= RegWriteIn;
      UBranchOut <= UBranchIn;
      ALUOpOut  <= ALUOpIn;
      NOTZEROOut <= NOTZEROIn;
    ELSIF (sel = '1') THEN
      --Reg2LocOut <= '0';
      CBranchOut <= '0';
      MemReadOut <= '0';
      MemtoRegOut <= '0';
      MemWriteOut <= '0';
      ALUSrcOut <= '0';
      RegWriteOut <= '0';
      UBranchOut <= '0';
      ALUOpOut  <= "00";
      NOTZEROOut <= '0';
    END IF;
  END PROCESS;
END behavioral;