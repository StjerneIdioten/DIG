----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MuxDisplay is
    Port ( Clk_in_50 : in  STD_LOGIC;
			  Clk_out_1 : out STD_LOGIC;
           Bcd :   in  STD_LOGIC_VECTOR (15 downto 0);
           Segm : out STD_LOGIC_VECTOR (1 to 8);
			  Dp : in STD_LOGIC_VECTOR (3 downto 0);
           An :   out STD_LOGIC_VECTOR (3 downto 0));
end MuxDisplay;

architecture Behavioral of MuxDisplay is
	Signal Clk_Out : STD_LOGIC;
	Signal Bcd_numb : STD_LOGIC_VECTOR(3 downto 0);
	Signal DPo : STD_LOGIC;
	Signal Segments : STD_LOGIC_VECTOR(1 to 7);
	
	function Conv_boolean(B:boolean) return std_logic is
	   Variable Return_data: std_logic := '0';
	begin
	   if B then Return_data := '1'; end if;
		return Return_data;
	end Conv_boolean;
	
begin
   Clk_out_1 <= Clk_out; --Bind signal to port
	
	Clock_scale:
		process(Clk_in_50) --trigger on 50MHz clock
			variable Q: integer range 0 to 50000;
		begin
			if rising_edge(Clk_in_50) then
				if Q<50000 then
					Q := Q + 1;
					Clk_out <= '0';
				else
					Q := 1;
					Clk_out <= '1';
				end if;
			end if;
		end process;
		
Multiplexer: 
		Process(Clk_out)
			variable S: STD_LOGIC_VECTOR(1 downto 0);
		begin
			if rising_edge(Clk_out) then
				S:= S+1;
				 case S is 
					when "00" =>
						DPo <= DP(0);
						Bcd_numb <= Bcd(3 downto 0);
						An <= "1110";
					when "01" =>
						DPo <= DP(1);
						Bcd_numb <= Bcd(7 downto 4);
						An <= "1101";
					when "10" =>
						DPo <= DP(2);
						Bcd_numb <= Bcd(11 downto 8);
						An <= "1011";
					when "11" =>
						DPo <= DP(3);
						Bcd_numb <= Bcd(15 downto 12);
						An <= "0111";
					when others =>
						null;
					end case;
				end if;
		end process;
		
--BcdToSevenSegment:
--	Process(Bcd_numb)
--	
--	begin
--		case Bcd_numb is
--			when "0000" =>
--				Segments <= "0000001";
--			when "0001" =>
--				Segments <= "1001111";
--			when "0010" =>
--				Segments <= "0010010";
--			when "0011" =>
--				Segments <= "0000110";
--			when "0100" =>
--				Segments <= "1001100";
--			when "0101" =>
--				Segments <= "0100100";
--			when "0110" =>
--				Segments <= "0100000";
--			when "0111" =>
--				Segments <= "0001111";
--			when "1000" =>
--				Segments <= "0000000";
--			when "1001" =>
--				Segments <= "0000100";
--			when others =>
--				null;
--			end case;
--	end process;
--		
--	Segm <= Segments & DPo; 

BCD27segm:
	process(Bcd_numb)
	   type D16_bit is array( 15 downto 0) of boolean;
	   variable D: D16_bit;
		variable Sa,Sb,Sc,Sd,Se,Sf,Sg: std_logic;
	begin
		D := (others => false);					   -- Set all D(x) = false;
		D( Conv_integer(Bcd_numb)) := true;	-- Set D(bcd)   = true; 
      Sa := Conv_Boolean( D( 1) or D( 4) or D(11) or D(13));
      Sb := Conv_Boolean( D( 5) or D( 6) or D(11) or D(12) or D(14) or D(15));
      Sc := Conv_Boolean( D( 2) or D(12) or D(14) or D(15));
		Sd := Conv_Boolean( D( 1) or D( 4) or D( 7) or D(10) or D(15));
		Se := Conv_Boolean( D( 1) or D( 3) or D( 4) or D( 5) or D( 7) or D( 9));
		Sf := Conv_Boolean( D( 1) or D( 2) or D( 3) or D( 7) or D(13));
		Sg := Conv_Boolean( D( 0) or D( 1) or D( 7) or D(12));
		
		Segments <= Sa & Sb & Sc & Sd & Se & Sf & Sg;		 
	end process;

	--7 Segments and the Decimalpoint joined together
   Segm <=  Segments & DPo;
	 		 
		
end Behavioral;

