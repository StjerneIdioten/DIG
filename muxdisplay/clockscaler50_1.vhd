----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:35:07 03/27/2016 
-- Design Name: 
-- Module Name:    clockscaler50_1 - Behavioral 
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

entity clockscaler50_1 is
	Generic(n : integer := 20); -- Values from 0 to 20

   Port ( clock_in : in  STD_LOGIC;
			 clock_out : out  STD_LOGIC;
			 clock_select : in STD_LOGIC_VECTOR(1 downto 0));
end clockscaler50_1;

architecture Behavioral of clockscaler50_1 is

begin


end Behavioral;

