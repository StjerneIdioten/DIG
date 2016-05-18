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

library WORK;
use WORK.Projekt_Data.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Design is
    Port ( Clk : in  STD_LOGIC;
			  Button1 : in STD_LOGIC;
			  HighScore_Toggle : in STD_LOGIC;
			  Led : out STD_LOGIC;
			  Enable : out STD_LOGIC_VECTOR(3 downto 0);
			  Seg : out STD_LOGIC_VECTOR(7 downto 0)
	 );
end Design;

architecture Behavioral of Design is

	signal Bcd_To_Display : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
	signal Numb_To_Display : STD_LOGIC_VECTOR(11 downto 0) := (others=>'0');
	signal Clk_Scaled : STD_LOGIC := '0';
	signal Button1_Toggle : STD_LOGIC := '0';
	signal Button1_Push : STD_LOGIC := '0';
	signal Button1_Pulse : STD_LOGIC := '0';
	signal Score : STD_LOGIC_VECTOR(11 downto 0) := (others=>'0');
	signal HighScore : STD_LOGIC_VECTOR(11 downto 0) := (others=>'0');
	signal Rand : STD_LOGIC_VECTOR(12 downto 0) := (others =>'0');

begin

	Button : entity work.Toggle_Button3 
		port map (
		Clk=>Clk, 
		Button=>Button1, 
		Toggle=>Button1_Toggle, 
		Deboun=>Button1_Push, 
		Pulse=>Button1_Pulse
	);

	NumberToBcd : entity work.NumberToBcd
		port map(
		Clk=>Clk,
		Number=>Numb_To_Display,
		BcdOut=>Bcd_To_Display
	);
	
	DisplayMultiplexer : entity work.MultiplexDisplay
		port map(
		Clk_50MHz=>Clk,
		Bcd=>Bcd_To_Display,
		Seg=>Seg,
		An=>Enable
	);
	
	ClockScaler : entity work.ClockScaler
		generic map (
		Count => CLOCK_SCALING
		)
		port map (
		Clk_In => Clk,
		Clk_Out => Clk_Scaled
		);
		
	Randomizer : entity work.Randomizer
		port map (
			Clk => Clk,
			Rand => Rand
		);
		
	
	Game : entity work.Game
		port map (
		Clk => Clk,
		Button1_Toggle => Button1_Toggle,
		Button1_Push => Button1_Push,
		Button1_Pulse => Button1_Pulse,
		Score => Score,
		HighScore => HighScore,
		Rand => Rand,
		Led => Led
	);
	
	--Toggle if score or highscore is displayed
	with HighScore_Toggle select Numb_To_Display <=
		Score when '0',
		HighScore when '1',
		(others=>'X') when others;

end Behavioral;

