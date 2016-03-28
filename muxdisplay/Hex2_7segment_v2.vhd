----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Hex2_7segment_v2 is
    Port ( Hex :    IN  STD_LOGIC_VECTOR (3 downto 0);
           abcdefg: OUT STD_LOGIC_VECTOR (1 to 7));
end Hex2_7segment_v2;

architecture Behavioral of Hex2_7segment_v2 is
begin
   WITH Hex SELECT
	abcdefg <= "0000001" WHEN "0000", --OUTPUT WHEN INPUT	
	           "1001111" WHEN "0001",	
	           "0010010" WHEN "0010",
	           "0000110" WHEN "0011",
	           "1001100" WHEN "0100",
	           "0100100" WHEN "0101",	
	           "0100000" WHEN "0110",
	           "0001111" WHEN "0111",
	           "0000000" WHEN "1000",
	           "0000100" WHEN "1001",	
	           "0001000" WHEN "1010",
	           "1100000" WHEN "1011",
	           "0110001" WHEN "1100",
	           "1000010" WHEN "1101",	
	           "0110000" WHEN "1110",
	           "0111000" WHEN "1111",
              "0000000" WHEN OTHERS;	
end Behavioral;

