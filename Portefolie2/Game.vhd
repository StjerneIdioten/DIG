----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:36:13 05/11/2016 
-- Design Name: 
-- Module Name:    Game - Behavioral 
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

entity Game is
    Port ( Clk : in  STD_LOGIC;
			  Button1_Toggle : in STD_LOGIC;
			  Button1_Push : in STD_LOGIC;
			  Button1_Pulse : in STD_LOGIC;
			  Rand : in STD_LOGIC_VECTOR(12 downto 0);
			  Score : out STD_LOGIC_VECTOR(11 downto 0);
			  HighScore : out STD_LOGIC_VECTOR(11 downto 0);
			  Led : out STD_LOGIC
	 );
end Game;

architecture Behavioral of Game is

type States is (Init,
					 GameBegin,
					 RandomWait,
					 ReactionTest,
					 GameEnd
					 ); 
					 
signal State: States := Init;

begin

State_Machine:	process(Clk)
begin
	if falling_edge( Clk) then 
		case State is
		
			when Init =>
				if Button1_Pulse = '1' then
					State <= GameBegin;
				end if;
			
			when GameBegin =>
				
			when RandomWait =>
			
			when ReactionTest =>
			
			when GameEnd =>
			
		end case;
	end if;
end process;

end Behavioral;

