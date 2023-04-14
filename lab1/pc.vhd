LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity PC is -- 64-bit rising-edge triggered register with write-enable and synchronous reset
-- For more information on what the PC does, see page 251 in the textbook
port(
     clk          : in  STD_LOGIC; -- Propogate AddressIn to AddressOut on rising edge of clock
     write_enable : in  STD_LOGIC; -- Only write if '1'
     rst          : in  STD_LOGIC; -- Asynchronous reset! Sets AddressOut to 0x0
     AddressIn    : in  STD_LOGIC_VECTOR(63 downto 0); -- Next PC address
     AddressOut   : out STD_LOGIC_VECTOR(63 downto 0) -- Current PC address
);
end PC;

ARCHITECTURE behavioral OF PC IS
BEGIN
  PROCESS(clk, rst)
  BEGIN
    IF (clk = '1' AND clk'event) THEN
      IF (write_enable = '1') THEN
        AddressOut <= AddressIn;
      END IF;
    END IF;
    IF (rst = '1') THEN
      AddressOut <= x"0000000000000000";
    END IF;
  END PROCESS;
END behavioral;