library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER_tb is
end FULL_ADDER_tb;

-- A combination of structural, behavioural, and dataflow modeling
architecture tb of FULL_ADDER_TB is
   -- Define 'wires' that are internal to the entity
   signal A, B, Cin, Sum, Carry: std_logic;
begin
   -- Use structural to instantiate the EUT (entity under test)
	instance0 : entity 
		work.FULL_ADDER port map(A => A, B=> B, Cin => Cin, Sum => Sum, Carry=>Carry);
   -- Use behavoural modeling to make a test bench
   process
   --variable errCnt : integer := 0;
   begin
      A <= '0';
      B <= '1';
      Cin <= '0';
      wait for 100 ns;
      -- Sum: 1 Carry: 0
   
      --Can use assert statements
      --assert(Sum = '1') report "sum error 1" severity error;
      --assert(Carry = '0') report "Cout error 1" severity error;
   
      --Can check the output and count the errors
      --if(Sum /= '1' or Carry /= '0') then
      --  errCnt := errCnt + 1;
      --end if;
   
      A <= '1';
      B <= '1';
      Cin <= '0';
      wait for 100 ns;
      A <= '1';
      B <= '0';
      Cin <= '0';
      wait for 100 ns;
      A <= '0';
      B <= '0';
      Cin <= '0';
      wait for 100 ns;
      A <= '0';
      B <= '1';
      Cin <= '1';
      wait for 100 ns;
      -- Sum: 1 Carry: 0
   
      --Can use assert statements
      --assert(Sum = '1') report "sum error 1" severity error;
      --assert(Carry = '0') report "Cout error 1" severity error;
   
      --Can check the output and count the errors
      --if(Sum /= '1' or Carry /= '0') then
      --  errCnt := errCnt + 1;
      --end if;
   
      A <= '1';
      B <= '1';
      Cin <= '1';
      wait for 100 ns;
      A <= '1';
      B <= '0';
      Cin <= '1';
      wait for 100 ns;
      A <= '0';
      B <= '0';
      Cin <= '1';
      wait for 100 ns;
      A <= 'X';
      B <= 'X';
      Cin <= 'X';
      -- Stop the simulation (you can use `run -all`)
      report "end of tests" severity failure;
   end process;
   -- Generate a clock with 100ns period using dataflow style modeling
   -- clk <= not clk after 50 ns;
end tb;