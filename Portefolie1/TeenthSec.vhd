----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:34 10/06/2007 
-- Design Name: 
-- Module Name:    TeenthSec - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TeenthSec is
    Port ( Bcd1_10 : in  STD_LOGIC_VECTOR (3 downto 0);
           Leds : out  STD_LOGIC_VECTOR (7 downto 0));
end TeenthSec;

architecture Behavioral of TeenthSec is
begin
   with Bcd1_10 select
	   Leds <= "00000000" when "0000",
		        "00000001" when "0001",
		        "00000011" when "0010",
		        "00000111" when "0011",
		        "00001111" when "0100",
		        "00011111" when "0101",
		        "00111111" when "0110",
		        "01111111" when "0111",
		        "11111111" when "1000",
		        "11111110" when "1001",
		        "00000000" when others;
end Behavioral;

