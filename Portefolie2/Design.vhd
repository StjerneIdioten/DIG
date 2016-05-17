----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:31 05/11/2016 
-- Design Name: 
-- Module Name:    Design - Behavioral 
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

entity Design is
    Port ( Clk : in  STD_LOGIC);
end Design;

architecture Behavioral of Design is

	signal Bcd_To_Display : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');

begin

	Button : entity work.Toggle_Button3 
		port map (
		Clk=>Clk, 
		Button=>M1_Pan_Z, 
		Toggle=>M1_Pan_Z_Toggle, 
		Deboun=>M1_Pan_Z_Push, 
		Pulse=>M1_Pan_Z_Pulse
	);

	NumberToBcd : entity work.NumberToBcd
		port map(
		Clk=>Clk,
		Number=>M1_Pan_Ticks,
		BcdOut=>NTB_M1_Pan_Ticks_BCD
	);
	
	DisplayMultiplexer : entity work.MultiplexDisplay
		port map(
		Clk_50MHz=>Clk,
		Bcd=>Bcd_To_Display,
		Seg=>Seg,
		An=>Enable
	);
	
	Game : entity work.Game
		port map (
		Clk => Clk
	);

end Behavioral;

