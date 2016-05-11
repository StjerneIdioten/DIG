----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library WORK;
use WORK.Projekt_Data.all;

entity SPI_Slave3 is
	 		
    Port ( Clk : 		in    STD_LOGIC;  -- FPGA 50 MHz clk
           -- The SPI interface
			  SClk : 	in    STD_LOGIC;
           SS : 		in    STD_LOGIC;
           MOSI : 	in    STD_LOGIC;
           MISO : 	out   STD_LOGIC;
			  -- The internal AdrBus, DataBus and Write Enable
           AdrBus :	out   STD_LOGIC_VECTOR (3 downto 0);
           WE : 		out   STD_LOGIC;
           DataBusToSlave : in STD_LOGIC_VECTOR (11 downto 0);
			  DataBusFromSlave : out STD_LOGIC_VECTOR (11 downto 0));
end SPI_Slave3;

architecture Behavioral of SPI_Slave3 is
   -- DataBus buffers for input and output data
   signal DataIn :            STD_LOGIC_VECTOR (11 downto 0) := (others=>'0');
   signal DataOut :           STD_LOGIC_VECTOR (11 downto 0) := (others=>'0');
	
	-- XSClk and xSS used to detect rising and falling edges of SClk and SS
	signal xSClk:      			std_logic_vector( 1 downto 0) := "00";
	signal xSS:        			std_logic_vector( 1 downto 0) := "11";
	
	-- SClk_Count and _Cnt used to keep track of the number af SClk pulses
   signal SClk_Count: 			std_logic_vector( 15 downto 0) := (others=>'1');	
	shared variable SClk_Cnt:  integer range 0 to 15 := 0; 
	-------------------------------------------------------------------------------
	signal WE_net: std_logic := '1'; -- Active low
   signal InBuf: 	std_logic_vector( 0 to 15) := (others=>'0');
   signal UdBuf:  std_logic_vector( 0 to  15) := (others=>'0');	
   alias  Adr:    std_logic_vector( 3 downto 0) is InBuf( 0 to 3); 

	type States is (Wait_for_SS_low, --Wait for the SS line to turn low and initiate a transfer
	                Wait_for_Adr, --Wait for the four address bits to have been transfered
						 Wait_state1, --Allow the device some time to transfer the data
						 Load_UdBuf, --Load in data from the device selected by the address
						 Wait_for_Databits, --Wait for all the data to have been transfered 
						 Set_WE0, --Read in the data, because write enable is off
						 Wait_state2,
						 Set_WE1, --Set write enable high again
						 Wait_for_SS_high); --Wait for SS to turn high again and end the data transfer
						 
	signal State: States := Wait_for_SS_low;
	
begin
	-- SClk_Count <= conv_std_logic_vector( SClk_cnt, SClk_Count'length); --alternativ 
	
   WE      <= WE_net;												 -- WE = Active Low
	DataIn  <= DataBusToSlave; -- Read from DataBus
   DataBusFromSlave <= DataOut; -- Write to DataBus
	
 --################################################################################## 
 --# This process detect changes of SS and SClk
 --# SClk_Count will reset by a falling edge of SS
 --# For each rising edge will:  SClk_Count <= SClk_count+1
 --#    InBuf( SClk_cnt) will get to MOSI signal
 --#    MISO will get OutBuf( SClk_cnt) 
 --################################################################################## 	
	SClk_Counter: process( Clk)
	begin
	   if rising_edge( Clk) then
			xSClk <= xSClk(0) & SClk;    -- SClk detection (SClk << 25 MHz)   
			xSS   <= xSS(0) & SS;        -- SS detection		
		end if;
		
		if falling_edge( Clk) then       -- Clk will be 50 MHz 
			if xSS="10" then
				SClk_Count <= (others=>'0'); -- Reset the SClk counter
				--MISO <= '1';
			end if;
			---------------------------Receive MOSI @ Rising SClk ----------			
			if xSClk="01" then
				SClk_Count <= SClk_Count + 1; -- Count the number of rising SClk's
				SClk_Cnt := conv_integer( SClk_Count); 
				MISO <= UdBuf( SClk_Cnt);
			end if;
			
			if xSClk="10" then
				InBuf( SClk_Cnt) <= MOSI;	
			end if;
			
		end if;
	end process;

 --##################################################################################
 --# This State Machine controls the basic timing between the SPI interface and 
 --# the internal bus-system
 --################################################################################## 
   State_Machine:	process( Clk)
	begin
		if falling_edge( Clk) then
			WE_net <= '1';
			case State is
				--Wait for the select line to go low, set UdBuf so that the first 4 bits does not cause any confusion during address transfer
				when Wait_for_SS_low => 
					UdBuf <= (others => '0');
					if(xSS = "10") then
						UdBuf(0 to 3) <= "1111";--DataIn(3 downto 0); --Put data out in reverse because lsb is shifted out first but msb is expected
						State <= Wait_for_adr;
					end if;
				
				--Wait for the address to be transfered, once transfered then put it out on the address bus
	         when Wait_for_Adr =>
					if Sclk_Cnt = 3 and xSClk = "00" then
						State <= Wait_state1;
						AdrBus <= Adr;
					end if;
				
				--Wait an extra cycle to allow the connected modules to react to the address
				when Wait_state1 =>            -- Extra wait state 
					State <= Load_UdBuf;	               
				
				--Load the output buffer with the data from the databus. 
				--Reversing the bit order since we are communicating with MSB first, but UdBuf is clocked out from the other end.
				when Load_UdBuf =>
					UdBuf(4 to 15) <= DataIn(11 downto 0);
					State <= Wait_for_Databits;
				
				--Wait for the rest of the data to be clocked in
				when Wait_for_Databits =>
					if Sclk_Cnt = 15 and xSClk = "00" then
						State <= Set_WE0;
						DataOut<= InBuf(4 to 15);
					end if;
				
				--WE goes low to enable the slave to clock out the data to the databus
				when Set_WE0 =>
					WE_net <= '0';	
					State <= Wait_state2;
					
				when Wait_state2 =>
					State <= Set_WE1;
				
				--WE goes high so data kan be loaded onto the databus again from the devices
				when Set_WE1 =>
					WE_net <= '1';
					State <= Wait_for_SS_high;
				
				--Wait for the datasignal to go high again
				when Wait_for_SS_high =>
					--		=> (others => '0');
					if xSS = "01" then
						State <= Wait_for_SS_low;
					end if;
			end case;
		end if;
	end process;
end Behavioral;

