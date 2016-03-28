----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:17:12 10/08/2007 
-- Design Name: 
-- Module Name:    Cnt23 - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cnt23 is
    Port ( En :      in  STD_LOGIC;
			  Clr,Clk : in  STD_LOGIC;
           Bcd23 :   out STD_LOGIC_VECTOR(7 downto 0);           
			  Rco:      out STD_LOGIC);
end Cnt23;

architecture Behavioral of Cnt23 is
   signal Cif10,Cif1: integer range 0 to 15;
begin
   process( Clk, Clr)
	begin
	   if Clr='1' then
			Cif1  <= 0;
			Cif10 <= 0;
		elsif Rising_edge( Clk) then
		   if En='1' then
			   if Cif10=2 and Cif1=3 then
					Cif10 <=  0;
					Cif1  <=  0;
				else
               if Cif1<9 then
                  Cif1 <= Cif1+1;
               else
					   Cif1  <= 0;
						Cif10 <= Cif10+1;
					end if;
          	end if;
			end if;
		end if;
	end process;
	
	Rco   <= '1' when Cif10=2 and Cif1=3 and En='1' else '0';
	Bcd23 <= Conv_std_logic_vector(Cif10,4)&
				Conv_std_logic_vector(Cif1,4);
end Behavioral;

