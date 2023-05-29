library ieee;
use ieee.std_logic_1164.all;

entity HALF_ADDER is
port(
   A : in std_logic;
	B : in std_logic;
	Sum : out std_logic;
	Carry : out std_logic
);
end HALF_ADDER;

--------------------------------------------------------------------------------------

-- Structural modeling (instantiating primitive entities, e.g. logic gates gates and flip-flops)

-- Explicit port mapping
architecture structural_example of HALF_ADDER is
--List the components that will be used
component XOR_GATE is
port(
	in0 : in std_logic;
	in1 : in std_logic;
	out0 : out std_logic
);
end component;
--Define signal(s) that will be used internally as wires or registers
--signal internal_signal : std_logic;
begin
	--explicit port mapping
	ha_xor_gate : XOR_GATE port map(in0 => A, in1=> B, out0 => Sum);
	Carry <= A and B;
end structural_example;

--------------------------------------------------------------------------------------

-- Implicit port mapping (by order)
architecture structural_example1 of HALF_ADDER is
--List the components that will be used
component XOR_GATE is
port(
	in0 : in std_logic;
	in1 : in std_logic;
	out0 : out std_logic
);
end component;
--Define signal(s) that will be used internally as wires or registers
begin
	--impicit ports mapping by order
	ha_xor_gate : XOR_GATE port map(A, B, Sum);
	Carry <= A and B;
end structural_example1;

--------------------------------------------------------------------------------------

-- Loading directly from 'work' library with explicit port mapping
architecture structural_example2 of HALF_ADDER is
--Define signal(s) that will be used internally as wires or registers
signal out_signal : std_logic;
begin
	--Pull the entity description from the work library directly
	ha_xor_gate : entity 
		work.XOR_GATE port map(in0 => A, in1=> B, out0 => Sum);
	--Carry <= in0 and in1;
	Carry <= A and B;
end structural_example2;
