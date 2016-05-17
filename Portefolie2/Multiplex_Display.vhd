library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MultiplexDisplay is
    Port ( Clk_50MHz : in std_logic;
           Bcd :       in std_logic_vector(15 downto 0);
			  Seg :      out std_logic_vector(1 to 8);
           An :        out std_logic_vector(3 downto 0));
end MultiplexDisplay;

architecture Behavioral of MultiplexDisplay is
	Signal Clk2:          std_logic;
	Signal Bcd_ciffer:    std_logic_vector(3 downto 0) := "0000";
	Signal Segmenter:     std_logic_vector(1 to 7);
	
	function Conv_boolean(B:boolean) return std_logic is
	   Variable Return_data: std_logic := '0';
	begin
	   if B then Return_data := '1'; end if;
		return Return_data;
	end Conv_boolean;
	
begin
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
	process( Clk2)
	   variable S: std_logic_vector( 1 downto 0);
	begin
	   if rising_edge(Clk2) then
	      S := S+1;
			case S is
			   when "00" =>
					 Bcd_ciffer    <= Bcd( 3 downto 0);
					 An            <= "1110";
			   when "01" =>
					 Bcd_ciffer    <= Bcd( 7 downto 4);
					 An            <= "1101";
			   when "10" =>
					 Bcd_ciffer    <= Bcd(11 downto 8);
					 An            <= "1011";
			   when "11" =>
					 Bcd_ciffer    <= Bcd(15 downto 12);
					 An            <= "0111";
				when others =>
				    null;
         end case;				 
		end if;
	end process;


-------------------------------------------------------------------------------- 
-- Denne process omsætter Bcd koder til 7 segment visning
--   Segmenter(1:7) = a b c d e f g
--------------------------------------------------------------------------------
	BCD27segm:
	process( Bcd_ciffer)
	   type D16_bit is array( 15 downto 0) of boolean;
	   variable D: D16_bit;
		variable Sa,Sb,Sc,Sd,Se,Sf,Sg: std_logic;
	begin
		D := (others => false);					   -- Set all D(x) = false;
		D( Conv_integer(Bcd_ciffer)) := true;	-- Set D(bcd)   = true; 
      Sa := Conv_Boolean( D( 1) or D( 4) or D(11) or D(13));
      Sb := Conv_Boolean( D( 5) or D( 6) or D(11) or D(12) or D(14) or D(15));
      Sc := Conv_Boolean( D( 2) or D(12) or D(14) or D(15));
		Sd := Conv_Boolean( D( 1) or D( 4) or D( 7) or D(10) or D(15));
		Se := Conv_Boolean( D( 1) or D( 3) or D( 4) or D( 5) or D( 7) or D( 9));
		Sf := Conv_Boolean( D( 1) or D( 2) or D( 3) or D( 7) or D(13));
		Sg := Conv_Boolean( D( 0) or D( 1) or D( 7) or D(12));
		
		Segmenter <= Sa & Sb & Sc & Sd & Se & Sf & Sg;		 
	end process;

	--7 Segments and the Decimalpoint joined together
   Seg <=  Segmenter & '1';
	 		 
end Behavioral;