LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
port(
     x : in  STD_LOGIC_VECTOR(31 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
);
end SignExtend;

-- I type, width 10, I(9)=1, I(6)=1, I(10)=00;
-- B type, width 6, B(5 DOWNTO 0) = 000101
-- CB type, width 8, CB(4 DOWNTO 0) = 1010
-- D type, width 11, D(10 DOWNTO 2) = 111110000

ARCHITECTURE behavioral OF SignExtend IS

SIGNAL temp_sign52 : STD_LOGIC_VECTOR(51 DOWNTO 0);
SIGNAL temp_sign38 : STD_LOGIC_VECTOR(37 DOWNTO 0);
SIGNAL temp_sign45 : STD_LOGIC_VECTOR(44 DOWNTO 0);
SIGNAL temp_sign55 : STD_LOGIC_VECTOR(54 DOWNTO 0);
SIGNAL temp_sign58 : STD_LOGIC_VECTOR(57 DOWNTO 0);

BEGIN
  PROCESS(x, temp_sign52, temp_sign38, temp_sign45, temp_sign55, temp_sign58)
  BEGIN
    IF (x(31) = '1' AND x(28 DOWNTO 26) = "100" AND x(23 DOWNTO 22) = "00") THEN  -- I type
      --REPORT "HELLO I";
      IF(x(21) = '0') THEN
        temp_sign52 <= (OTHERS=>'0');
        y <= temp_sign52&x(21 DOWNTO 10);  -- 21 DOWNTO 10
      ELSIF (x(21) = '1') THEN
        temp_sign52 <= (OTHERS=>'1');
         y <= temp_sign52&x(21 DOWNTO 10);
      END IF;
    END IF;
 -- I type end

    -- B type
    IF (x(31 DOWNTO 26) = "000101") THEN
      --REPORT "HELLO B";
      IF (x(25) = '0') THEN
        temp_sign38 <= (OTHERS=>'0');
        y <= temp_sign38&x(25 DOWNTO 0);
      ELSIF (x(25) = '1') THEN
        temp_sign38 <= (OTHERS=>'1');
        y <= temp_sign38&x(25 DOWNTO 0);
      END IF;
    END IF; 
-- B type end

-- CB type
    IF (x(31 DOWNTO 25) = "1011010" OR x(31 DOWNTO 24) = "01010100") THEN
      --REPORT "HELLO CB";
      IF (x(23) = '0') THEN
        temp_sign45 <= (OTHERS=>'0');
        y <= temp_sign45&x(23 DOWNTO 5);
      ELSIF (x(23) = '1') THEN
        temp_sign45 <= (OTHERS=>'1');
        y <= temp_sign45&x(23 DOWNTO 5);
      END IF;
    END IF; 
-- CB type end

-- D type
    IF (x(31 DOWNTO 23) = "111110000" AND x(21) = '0') THEN
      --REPORT "HELLO D";
      IF (x(20) = '0') THEN
        temp_sign55 <= (OTHERS=>'0');
        y <= temp_sign55&x(20 DOWNTO 12);
      ELSIF (x(20) = '1') THEN
        temp_sign55 <= (OTHERS=>'1');
        y <= temp_sign55&x(20 DOWNTO 12);
      END IF;
    END IF; 
-- D type end

-- R type LSL, LSR, unsigned
    IF (x(31 DOWNTO 23) = "110100110") THEN
      --REPORT "HELLO LSL LSR";
      temp_sign58 <= (OTHERS=>'0');
      y <= temp_sign58&x(15 DOWNTO 10);
    END IF; 
-- LSR, LSL end

  END PROCESS;
END behavioral;