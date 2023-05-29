LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity IMEM is
-- The instruction memory is a byte addressable, little-endian, read-only memory
-- Reads occur continuously
-- HINT: Use the provided dmem.vhd as a starting point
generic(NUM_BYTES : integer := 128);
-- NUM_BYTES is the number of bytes in the memory (small to save computation resources)
port(
     Address  : in  STD_LOGIC_VECTOR(63 downto 0); -- Address to read from
     ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end IMEM;

ARCHITECTURE behavioral of IMEM IS
TYPE ByteArray is ARRAY (0 TO NUM_BYTES) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL imemBytes:ByteArray;
BEGIN
  PROCESS(Address)
  VARIABLE addr:INTEGER;
  VARIABLE first:BOOLEAN := TRUE;
  BEGIN 
    IF (first) THEN

      
      imemBytes(3) <= "11010011";  -- LSL X9, X9, 1
      imemBytes(2) <= "01100000"; 
      imemBytes(1) <= "00000101"; 
      imemBytes(0) <= "00101001";

      imemBytes(7) <= "11010011";  -- LSR X9, X9, 1
      imemBytes(6) <= "01000000"; 
      imemBytes(5) <= "00000101"; 
      imemBytes(4) <= "00101001"; 
 
      imemBytes(11) <= "10110101"; -- CBNZ, X9, 2
      imemBytes(10) <= "00000000"; 
      imemBytes(9) <= "00000000"; 
      imemBytes(8) <= "01001001"; 

      imemBytes(15) <= "10101010"; -- ORR X9, X9, X10
      imemBytes(14) <= "00001010"; 
      imemBytes(13) <= "00000001"; 
      imemBytes(12) <= "00101001"; 

      imemBytes(19) <= "10110010";  -- ORRI X9, X9, 255
      imemBytes(18) <= "00000011"; 
      imemBytes(17) <= "11111101"; 
      imemBytes(16) <= "00101001"; 

 
      imemBytes(23) <= "00000000";
      imemBytes(22) <= "00000000"; 
      imemBytes(21) <= "00000000"; 
      imemBytes(20) <= "00000000"; 
      
      imemBytes(31) <= "00000000";
      imemBytes(30) <= "00000000"; 
      imemBytes(29) <= "00000000"; 
      imemBytes(28) <= "00000000"; 
      imemBytes(27) <= "00000000"; 
      imemBytes(26) <= "00000000"; 
      imemBytes(25) <= "00000000"; 
      imemBytes(24) <= "00000000"; 


      imemBytes(39) <= "00000000";
      imemBytes(38) <= "00000000"; 
      imemBytes(37) <= "00000000"; 
      imemBytes(36) <= "00000000"; 
      imemBytes(35) <= "00000000"; 
      imemBytes(34) <= "00000000"; 
      imemBytes(33) <= "00000000"; 
      imemBytes(32) <= "00000110"; 

      imemBytes(47) <= "00000000";
      imemBytes(46) <= "00000000"; 
      imemBytes(45) <= "00000000"; 
      imemBytes(44) <= "00000000"; 
      imemBytes(43) <= "00000000"; 
      imemBytes(42) <= "00000000"; 
      imemBytes(41) <= "00000000"; 
      imemBytes(40) <= "00000000"; 
 
      imemBytes(55) <= "00000000";
      imemBytes(54) <= "00000000"; 
      imemBytes(53) <= "00000000"; 
      imemBytes(52) <= "00000000"; 
      imemBytes(51) <= "00000000"; 
      imemBytes(50) <= "00000000"; 
      imemBytes(49) <= "00000000"; 
      imemBytes(48) <= "00000000"; 

      imemBytes(63) <= "00000000";
      imemBytes(62) <= "00000000"; 
      imemBytes(61) <= "00000000"; 
      imemBytes(60) <= "00000000"; 
      imemBytes(59) <= "00000000"; 
      imemBytes(58) <= "00000000"; 
      imemBytes(57) <= "00000000"; 
      imemBytes(56) <= "00000000"; 

      imemBytes(71) <= "00000000";
      imemBytes(70) <= "00000000"; 
      imemBytes(69) <= "00000000"; 
      imemBytes(68) <= "00000000"; 
      imemBytes(67) <= "00000000"; 
      imemBytes(66) <= "00000000"; 
      imemBytes(65) <= "00000000"; 
      imemBytes(64) <= "00000000"; 

      imemBytes(79) <= "00000000";
      imemBytes(78) <= "00000000"; 
      imemBytes(77) <= "00000000"; 
      imemBytes(76) <= "00000000"; 
      imemBytes(75) <= "00000000"; 
      imemBytes(74) <= "00000000"; 
      imemBytes(73) <= "00000000"; 
      imemBytes(72) <= "00000000"; 
 
      imemBytes(87) <= "00000000";
      imemBytes(86) <= "00000000"; 
      imemBytes(85) <= "00000000"; 
      imemBytes(84) <= "00000000"; 
      imemBytes(83) <= "00000000"; 
      imemBytes(82) <= "00000000"; 
      imemBytes(81) <= "00000000"; 
      imemBytes(80) <= "00000000"; 

      imemBytes(95) <= "00000000";
      imemBytes(94) <= "00000000"; 
      imemBytes(93) <= "00000000"; 
      imemBytes(92) <= "00000000"; 
      imemBytes(91) <= "00000000"; 
      imemBytes(90) <= "00000000"; 
      imemBytes(89) <= "00000000"; 
      imemBytes(88) <= "00000000"; 


      imemBytes(103) <= "00000000";
      imemBytes(102) <= "00000000"; 
      imemBytes(101) <= "00000000"; 
      imemBytes(100) <= "00000000"; 
      imemBytes(99) <= "00000000"; 
      imemBytes(98) <= "00000000"; 
      imemBytes(97) <= "00000000"; 
      imemBytes(96) <= "00000000"; 

      imemBytes(111) <= "00000000";
      imemBytes(110) <= "00000000"; 
      imemBytes(109) <= "00000000"; 
      imemBytes(108) <= "00000000"; 
      imemBytes(107) <= "00000000"; 
      imemBytes(106) <= "00000000"; 
      imemBytes(105) <= "00000000"; 
      imemBytes(104) <= "00000000"; 
 
      imemBytes(119) <= "00000000";
      imemBytes(118) <= "00000000"; 
      imemBytes(117) <= "00000000"; 
      imemBytes(116) <= "00000000"; 
      imemBytes(115) <= "00000000"; 
      imemBytes(114) <= "00000000"; 
      imemBytes(113) <= "00000000"; 
      imemBytes(112) <= "00000000"; 

      imemBytes(127) <= "00000000";
      imemBytes(126) <= "00000000"; 
      imemBytes(125) <= "00000000"; 
      imemBytes(124) <= "00000000"; 
      imemBytes(123) <= "00000000"; 
      imemBytes(122) <= "00000000"; 
      imemBytes(121) <= "00000000"; 
      imemBytes(120) <= "00000000";

      first := FALSE;
    END IF;

    addr := TO_INTEGER(UNSIGNED(Address));
    IF (addr+3 < NUM_BYTES) THEN
      ReadData(7 DOWNTO 0) <= imemBytes(addr);
      ReadData(15 DOWNTO 8) <= imemBytes(addr+1);
      ReadData(23 DOWNTO 16) <= imemBytes(addr+2);
      ReadData(31 DOWNTO 24) <= imemBytes(addr+3);
    ELSE REPORT "Invalid IMEM addr. Attempted to read 4-bytes starting at address " & 
      INTEGER'IMAGE(addr) & " but only " & INTEGER'IMAGE(NUM_BYTES) & " bytes are available."
      SEVERITY ERROR;
    END IF;

  END PROCESS;
END behavioral;