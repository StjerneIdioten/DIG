----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:05:00 05/18/2016 
-- Design Name: 
-- Module Name:    Randomizer - Behavioral 
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

entity Randomizer is
    Port ( Clk : in  STD_LOGIC;
           Rand : out  STD_LOGIC_VECTOR (12 downto 0));
end Randomizer;

architecture Behavioral of Randomizer is

begin

NumbGen : process(Clk)

variable Number : STD_LOGIC_VECTOR(12 downto 0) := "0011001101011";
begin
	if rising_edge(Clk) then
		Number := Number(11 downto 0) & (Number(12) XOR Number(11));
		Rand <= Number;
	end if;
end process;

end Behavioral;

