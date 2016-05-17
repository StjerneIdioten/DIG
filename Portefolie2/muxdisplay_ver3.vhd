library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity muxdisplay_ver3 is
    Port ( Clk_50MHz : in std_logic;
           Bcd :       in std_logic_vector(15 downto 0);
           Dp :        in std_logic_vector(3 downto 0);
			  Segm :      out std_logic_vector(1 to 8);
           An :        out std_logic_vector(3 downto 0);
           Clk_1kHz :  out std_logic);
end muxdisplay_ver3;

architecture Behavioral of muxdisplay_ver3 is
	Signal Clk2:          std_logic;
	Signal Bcd_ciffer:    std_logic_vector(3 downto 0);
	Signal Decimal_Punkt: std_logic;
	Signal Segmenter:     std_logic_vector(1 to 7);
	
	function Conv_boolean(B:boolean) return std_logic is
	   Variable Return_data: std_logic := '0';
	begin
	   if B then Return_data := '1'; end if;
		return Return_data;
	end Conv_boolean;
	
begin
	Clk_1kHz <= Clk2;
--------------------------------------------------------- 
-- Denne process sørger for neddeling af systemclock
--   50.000.000 Hz deles ned til 1000 Hz
---------------------------------------------------------
Clock_scale:
	process( Clk_50MHz)
		variable Q: integer range 0 to 50000;
	begin
	   if rising_edge( Clk_50MHz) then
		   if Q<50000 then
			   Q := Q + 1;
				Clk2 <= '0';
			else
			   Q := 1;
				Clk2 <= '1';
			end if;				   
      end if;
	end process;

--------------------------------------------------------- 
-- Denne process styrer skiftene imellem de 4 display
--   Decimal_Punkt = Dp(x)
--   Bcd_ciffer    = Bcd(x*4+3..x*3)
--   An(x) = 0 resten = 1
---------------------------------------------------------
Multiplekser:
	process(Clk2)
	   variable S: std_logic_vector( 1 downto 0);
	begin
	   if rising_edge(Clk2) then
	      S := S+1;
			case S is
			   when "00" =>
				    Decimal_Punkt <= Dp(0);
					 Bcd_ciffer    <= Bcd( 3 downto 0);
					 An            <= "1110";
			   when "01" =>
				    Decimal_Punkt <= Dp(1);
					 Bcd_ciffer    <= Bcd( 7 downto 4);
					 An            <= "1101";
			   when "10" =>
				    Decimal_Punkt <= Dp(2);
					 Bcd_ciffer    <= Bcd(11 downto 8);
					 An            <= "1011";
			   when "11" =>
				    Decimal_Punkt <= Dp(3);
					 Bcd_ciffer    <= Bcd(15 downto 12);
					 An            <= "0111";
				when others =>
				    null;
         end case;				 
		end if;
	end process;
	
BcdToSevenSegment:
	Process(Bcd_ciffer)
	
	begin
		case Bcd_ciffer is
			when "0000" =>
				Segmenter <= "0000001";
			when "0001" =>
				Segmenter <= "1001111";
			when "0010" =>
				Segmenter <= "0010010";
			when "0011" =>
				Segmenter <= "0000110";
			when "0100" =>
				Segmenter <= "1001100";
			when "0101" =>
				Segmenter <= "0100100";
			when "0110" =>
				Segmenter <= "0100000";
			when "0111" =>
				Segmenter <= "0001111";
			when "1000" =>
				Segmenter <= "0000000";
			when "1001" =>
				Segmenter <= "0000100";
			when others =>
				Segmenter <= "1111111";
			end case;
	end process;
	
   Segm <=  Segmenter & Decimal_punkt;
	 		 
end Behavioral;
