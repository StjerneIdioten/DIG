----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:26 10/06/2007 
-- Design Name: 
-- Module Name:    Lap_Time_Latch - Behavioral 
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

entity Lap_Time_Latch is
    Port ( Latch : in  STD_LOGIC;
           Bcd1_10 : in  STD_LOGIC_VECTOR ( 7 downto 0);
           BcdSec :  in  STD_LOGIC_VECTOR ( 7 downto 0);
           BcdMin :  in  STD_LOGIC_VECTOR ( 7 downto 0);
           Leds :   out  STD_LOGIC_VECTOR ( 7 downto 0);
           Bcd :    out  STD_LOGIC_VECTOR (15 downto 0));
end Lap_Time_Latch;

architecture Behavioral of Lap_Time_Latch is

begin
   process( Latch,Bcd1_10,BcdSec,BcdMin)
	begin
	   if Latch='0' then
		   Leds <= Bcd1_10;
			Bcd  <= BcdMin & BcdSec;
		end if;
	end process;
end Behavioral;

