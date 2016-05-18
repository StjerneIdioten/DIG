----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:44 05/17/2016 
-- Design Name: 
-- Module Name:    ClockScaler - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockScaler is

	generic (Count : integer := 50000
	);  
	

   Port ( Clk_In : in  STD_LOGIC;
          Clk_Out : out  STD_LOGIC
	);
	
end ClockScaler;

architecture Behavioral of ClockScaler is

signal clk2 : STD_LOGIC;

begin

Clk_Out <= clk2;

Clock_scale:
	process( Clk_In)
		variable i: integer range 0 to Count;
	begin
	   if rising_edge( Clk_In) then
		   if i<Count then
			   i := i + 1;
				Clk2 <= '0';
			else
			   i := 1;
				Clk2 <= '1';
			end if;				   
      end if;
	end process;

end Behavioral;

