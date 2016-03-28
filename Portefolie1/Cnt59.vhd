----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:30:50 10/05/2007 
-- Design Name: 
-- Module Name:    Cnt59 - Behavioral 
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

entity Cnt59 is
    Port ( En :      in  STD_LOGIC;
			  Clr,Clk : in  STD_LOGIC;
           Bcd59 :   out STD_LOGIC_VECTOR(7 downto 0);           
			  Rco:      out STD_LOGIC);
end Cnt59;

architecture Behavioral of Cnt59 is
   signal Cif10,Cif1: integer range 0 to 15;
begin
   process( Clk, Clr)
	begin
	   if Clr='1' then
			Cif1  <= 0;
			Cif10 <= 0;
		elsif Rising_edge( Clk) then
		   if En='1' then
			   if Cif10=5 and Cif1=9 then
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
	
	Rco   <= '1' when Cif10=5 and Cif1=9 and En='1' else '0';
	Bcd59 <= Conv_std_logic_vector(Cif10,4)&
				Conv_std_logic_vector(Cif1,4);
end Behavioral;

