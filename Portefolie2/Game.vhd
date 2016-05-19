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
use IEEE.NUMERIC_STD.ALL;

library WORK;
use WORK.Projekt_Data.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Game is
    Port ( Clk : in  STD_LOGIC;
			  Clk_Scaled : in STD_LOGIC;
			  Button1_Toggle : in STD_LOGIC;
			  Button1_Push : in STD_LOGIC;
			  Button1_Pulse : in STD_LOGIC;
			  Rand : in STD_LOGIC_VECTOR(12 downto 0);
			  Score : out STD_LOGIC_VECTOR(11 downto 0);
			  HighScore : out STD_LOGIC_VECTOR(11 downto 0);
			  Led : out STD_LOGIC;
			  Status : out STD_LOGIC_VECTOR(3 downto 0)
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
--signal Clk_Scaled_Edge : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

State_Machine:	process(Clk)
variable cnt : integer := 0;
variable random : integer range 0 to RANDOM_OFFSET + 8192 := 0;

begin
	if falling_edge( Clk) then 
		case State is
			when Init =>
				Status <= "0001";
				Led <= '0';
				if Button1_Pulse = '1' then
					State <= GameBegin;
				end if;
			
			when GameBegin =>
				Status <= "0010";
				if Button1_Push = '0' then
					Led <= '1';
					cnt := 0;
					random := RANDOM_OFFSET + to_integer(unsigned(Rand));
					State <= RandomWait;
				end if;
				
			when RandomWait =>
				Status <= "0011";
				if Clk_Scaled = '1' then
					if cnt < random then
						cnt := cnt + 1;
					else
						Led <= '0';
						cnt := 0;
						State <= ReactionTest;
					end if;
				end if;
			
			when ReactionTest =>
				Status <= "0100";
				if Button1_Pulse = '1' then
					State <= GameEnd;
				elsif Clk_Scaled = '1' then
					cnt := cnt + 1;
				end if;
			 	
			when GameEnd =>
				Status <= "0101";
				
				Score <= std_logic_vector(to_unsigned(cnt, Score'length));
				
				if Button1_Pulse = '1' then
					State <= Init;
				end if;
			
		end case;
	end if;
end process;

end Behavioral;

