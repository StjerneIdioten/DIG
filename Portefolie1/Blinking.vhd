----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:29 10/06/2007 
-- Design Name: 
-- Module Name:    Blinking - Behavioral 
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

entity Blinking is
    Port ( StartStop : in   STD_LOGIC;
           Lap :       in   STD_LOGIC;
           HalfSec :   in   STD_LOGIC;
           Dp :        out  STD_LOGIC_VECTOR (3 downto 0));
end Blinking;

architecture Behavioral of Blinking is

begin
   process( StartStop,Lap,HalfSec)
	begin
	   Dp <= "1111";
		if Lap='1' then
		   if Halfsec='0' then
			   Dp <= "0000";
			end if;
		end if;
		if StartStop='1' then
			Dp(2) <= not HalfSec;
		end if;
	end process;

end Behavioral;

