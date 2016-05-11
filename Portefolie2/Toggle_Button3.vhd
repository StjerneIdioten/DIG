
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Toggle_Button3 is
    Port ( Clk : in  STD_LOGIC;
           Button : in  STD_LOGIC;
           Toggle : out  STD_LOGIC;
			  Deboun : out  STD_LOGIC;
			  Pulse  : out  STD_LOGIC);
end Toggle_Button3;

architecture Behavioral of Toggle_Button3 is
   signal Q:    STD_LOGIC_VECTOR( 1 to 4);
	signal Sreg: STD_LOGIC_VECTOR( 2 downto 0):= "000"; 
	
   constant S0: STD_LOGIC_VECTOR( 2 downto 0):= "000"; 
   constant S1: STD_LOGIC_VECTOR( 2 downto 0):= "111"; 
   constant S2: STD_LOGIC_VECTOR( 2 downto 0):= "110"; 
   constant S3: STD_LOGIC_VECTOR( 2 downto 0):= "100";
   constant S4: STD_LOGIC_VECTOR( 2 downto 0):= "011"; 
   constant S5: STD_LOGIC_VECTOR( 2 downto 0):= "010";  	
	signal Set,Res: STD_LOGIC;
begin

   Set <= '1' when Q="1111" else '0';
	Res <= '1' when Q="0000" else '0';

   ---------------Implements a 4-bit shiftregister ------	
	process( Clk)
	begin
	   if Rising_edge(Clk) then
		   Q <= Q(2 to 4)& Button;
		end if;
	end process;
	--------------- State Machine ------------------------
	-- Q(2) Coded as a toggle bit - Button press => Toggle
	-- Q(1) Coded as a debounced Button signal
	-- Q(0) Coded as a pulse bit - One clock pulse wide
	process( Clk)
	begin
	   if Rising_edge(Clk) then
		   case Sreg is
			    when S0 => if Set='1' then
				               Sreg <= S1;
								end if;
			    when S1 => Sreg <= S2;
				 when S2 => if Res='1' then
				               Sreg <= S3;
								end if;
			    when S3 => if Set='1' then
				               Sreg <= S4;
								end if;
				 when S4 => Sreg <= S5;				 
			    when S5 => if Res='1' then
				               Sreg <= S0;
  								end if;
				 when others => null;
 			end case;							   
		end if;
	end process;
	
	Toggle <= Sreg(2);
	Deboun <= Sreg(1);
	Pulse  <= Sreg(0);
end Behavioral;

