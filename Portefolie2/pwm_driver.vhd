----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:17:47 03/03/2016 
-- Design Name: 
-- Module Name:    pwm_driver - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_driver is

    Port ( clk : in  STD_LOGIC;
			  data : in STD_LOGIC_VECTOR (7 downto 0);
           pwm : out  STD_LOGIC);
end pwm_driver;

architecture Behavioral of pwm_driver is

signal clk_divider: integer range 0 to 195000 := 0;
signal current_value: unsigned (7 downto 0) := "00000000";
signal iterator: unsigned (7 downto 0) := "00000000";
signal DataIn : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin

DataIn <= data;

counter: process(clk)		
begin
	if rising_edge(clk) then
		
		if clk_divider = 7 then										-- 20ns * 8 	= 160ns   
																			-- 160ns * 256 = 40.96us
			if iterator = "11111111" then							-- 1/40.96us	= 24414.0625 Hz
				iterator <= "00000000";
			else															-- PWM Freq
				iterator <= iterator + 1;							-- 24.414 kHz <=> clk_divider = 7
			end if;														-- 0.998   Hz <=> clk_divider = 195000
			
			clk_divider <= 0;
			
		else
			clk_divider <= clk_divider + 1;

		end if;
	end if;
end process;

latch_data: process(clk)
begin
	if rising_edge(clk) then	
			current_value <= unsigned(DataIn);
	end if;
end process;
	
pulse_gen: process(current_value,iterator)
begin
	if current_value = X"FF" then
		pwm <= '1';
	elsif current_value > iterator then
		pwm <= '1';
	else
		pwm <= '0';
	end if;
end process;	

end Behavioral;

