----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MuxDisplay_StartHelp is
	 Generic( n: integer := 20); -- Values from 0 to 20 
	 
    Port ( Clk :  in  STD_LOGIC;
           Sw :   in  STD_LOGIC_VECTOR (1 downto 0);
           Segm : out STD_LOGIC_VECTOR (1 to 8);
           An :   out STD_LOGIC_VECTOR (3 downto 0));
end MuxDisplay_StartHelp;

architecture Behavioral of MuxDisplay_StartHelp is
	signal Counter: STD_LOGIC_VECTOR (35 downto 0) := X"123456789";
	signal Cnt2bit: STD_LOGIC_VECTOR ( 1 downto 0) := "00";
	signal Hex:     STD_LOGIC_VECTOR ( 3 downto 0); 
	signal abcdefg: STD_LOGIC_VECTOR (1 to 7); -- & Decimal Point
	signal Scalecnt: integer;
	
	COMPONENT Hex2_7segment_v2
	PORT(	Hex :     IN  STD_LOGIC_VECTOR(3 downto 0);          
		   abcdefg : OUT STD_LOGIC_VECTOR(1 to 7));
	END COMPONENT;	
begin
   ------------- Please use your decoder here -----------------------
	U1: Hex2_7segment_v2 PORT MAP( Hex => Hex, abcdefg => abcdefg);
	
	Segm <= abcdefg & '1';  -- & Decimal Point 
	
	TestCounter: process( Clk)  -- Remove the comments to use
	begin
		if rising_edge(Clk) then
			Counter <= Counter+1;
		end if;
	end process;

   ScaleProcess: PROCESS( Clk, Sw)
		variable Scale_count: integer range 0 to 50000000 := 0;
		variable xScale:      integer range 0 to 50000000 := 0;
		---------------------
		constant   x3Hz:     integer  := 50000000/3;
		constant  x75Hz: 		integer  := 50000000/75;
		constant x200Hz: 		integer  := 50000000/200;
		constant x10MHz: 		integer  := 50000000/10000000; -- For simulation		
	begin
	   -------------- Select a xScale for clk scaling ----------------------
		case Sw is
			when "00" =>    xScale := x10MHz;
			when "01" =>    xScale := x3Hz;
			when "10" =>    xScale := x75Hz;
			when others =>  xScale := x200Hz;
      end case; 
		-------------------------------- Wait for a 50 MHz _+-- edge
		if rising_edge( Clk) then
			Scale_count := Scale_count+1; 
			
			if Scale_count > xScale then
				Scale_count := 1;
				Cnt2bit     <= Cnt2bit+1;  -- The Two bit Counter     
			end if;
			ScaleCnt <= Scale_count;
		end if;
	end process;
	
   -- Multiplexer for the Hex selection -----------------------------
	with Cnt2bit select
	Hex <=     Counter( n+15 downto n+12) when "11",
              Counter( n+11 downto n+8)  when "10",
              Counter( n+7  downto n+4)  when "01",
              Counter( n+3  downto   n)  when others;	
				  
   -- Encoder (1 of 4) for the An selection -------------------------
	with Cnt2bit select
   An <= "1110" when "00",
		   "1101" when "01",
			"1011" when "10",
			"0111" when others;
			
end Behavioral;

