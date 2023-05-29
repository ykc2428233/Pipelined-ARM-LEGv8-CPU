library ieee;
use ieee.std_logic_1164.all;

entity XOR_GATE is
port(
	in0 : in std_logic;
	in1 : in std_logic;
	out0 : out std_logic
);
end XOR_GATE;

--Each entity can have multiple architectures (implementations)
-- There are three 
-- dataflow (assignments using logic expressions)
architecture data_flow_example of XOR_GATE is
begin
	--Write concurrent assignment statements
	out0 <= in0 xor in1;
	--The LHS is updated when any of the RHS values changes
end data_flow_example;

-- behavioral (if then, case statements etc.)
architecture behavioural_example of XOR_GATE is
begin
	assign_output : process(in0, in1) is
	begin
		--Equality operator is '=' not '=='
		if (in0 = '1' and in1 = '1') or (in0 = '0' and in1 = '0') then
			out0 <= '0';
		elsif (in0 = '1' and in1 = '0') or (in0 = '0' and in1 = '1') then
			out0 <= '1';
		else
			out0 <= 'U';
		end if;
	end process assign_output;
end behavioural_example;
