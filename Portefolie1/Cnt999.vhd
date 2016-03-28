----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:47 10/06/2007 
-- Design Name: 
-- Module Name:    Cnt999 - Behavioral 
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

entity Cnt999 is
    Port ( En,Clr,Clk : in STD_LOGIC;
           Bcd1_10 :    out STD_LOGIC_VECTOR (3 downto 0);
           Rco :        out STD_LOGIC);
end Cnt999;

architecture Behavioral of Cnt999 is
   signal Cif100,Cif10,Cif1: integer range 0 to 15;
begin
   process( Clk, Clr)
	begin
	   if Clr='1' then
			Cif100<= 0; 	Cif10 <= 0; 	Cif1  <= 0;
		elsif Rising_edge( Clk) then
		   if En='1' then
			   if Cif100=9 and Cif10=9 and Cif1=9 then
				   Cif100<= 0; 	Cif10 <= 0; 	Cif1  <= 0;
				else
               if Cif1<9 then
                  Cif1 <= Cif1+1;
               elsif Cif10<9 then
					   Cif1  <= 0;
						Cif10 <= Cif10+1;
					else
					   Cif1  <= 0;
						Cif10 <= 0;
						Cif100<=Cif100+1;
					end if;
          	end if;
			end if;
		end if;
	end process;
	
	Rco<= '1' when Cif100=9 and Cif10=9 and Cif1=9 and En='1' else 
	      '0';
	Bcd1_10 <= Conv_std_logic_vector(Cif100,4);
	
end Behavioral;

