----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:28 05/01/2016 
-- Design Name: 
-- Module Name:    NumberToBcd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NumberToBcd is
    Port ( Number : in  STD_LOGIC_VECTOR (11 downto 0);
           BcdOut : out  STD_LOGIC_VECTOR (15 downto 0);
           Clk : in  STD_LOGIC);
end NumberToBcd;

architecture Behavioral of NumberToBcd is

begin

	calculateBCD : process(Clk)
	variable numberIn : std_logic_vector(11 downto 0) := (others => '0');
	variable numberOut : std_logic_vector(15 downto 0) := (others => '0');
	begin
		numberOut := (others => '0');
		if rising_edge(Clk) then
			numberIn := Number;
			for I in 0 to 11 loop
				if numberOut(3 downto 0) > 4 then
					numberOut(3 downto 0) := numberOut(3 downto 0) + 3;
				end if;
				if numberOut(7 downto 4) > 4 then
					numberOut(7 downto 4) := numberOut(7 downto 4) + 3;
				end if;
				if numberOut(11 downto 8) > 4 then
					numberOut(11 downto 8) := numberOut(11 downto 8) + 3;
				end if;
				if numberOut(15 downto 12) > 4 then
					numberOut(15 downto 12) := numberOut(15 downto 12) + 3;
				end if;
			
				numberOut := numberOut(14 downto 0) & numberIn(11);
				numberIn := numberIn(10 downto 0) & '0';
			end loop;
			BcdOut <= numberOut;
		end if;
	end process;


end Behavioral;

