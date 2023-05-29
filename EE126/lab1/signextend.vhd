LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
port(
     x : in  STD_LOGIC_VECTOR(31 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
);
end SignExtend;

ARCHITECTURE behavioral OF SignExtend IS
BEGIN
  PROCESS(x)
  BEGIN
    IF (x(31) = '0') THEN
      y <= x"00000000"&x;
    ELSIF (x(31) = '1') THEN
      y <= x"FFFFFFFF"&x;
    END IF;
  END PROCESS;
END behavioral;