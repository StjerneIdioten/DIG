-- Vhdl test bench created from schematic D:\Github\DIG\Portefolie1\Stopwatch.sch - Mon Mar 28 19:23:50 2016
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY Stopwatch_Stopwatch_sch_tb IS
END Stopwatch_Stopwatch_sch_tb;
ARCHITECTURE behavioral OF Stopwatch_Stopwatch_sch_tb IS 

   COMPONENT Stopwatch
   PORT( StartStop	:	IN	STD_LOGIC; 
          Lap	:	IN	STD_LOGIC; 
          Clear	:	IN	STD_LOGIC; 
          Led	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          Seg	:	OUT	STD_LOGIC_VECTOR (1 TO 8); 
          An	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Clk	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL StartStop	:	STD_LOGIC := '0';
   SIGNAL Lap	:	STD_LOGIC := '0';
   SIGNAL Clear	:	STD_LOGIC := '0';
   SIGNAL Led	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL Seg	:	STD_LOGIC_VECTOR (1 TO 8);
   SIGNAL An	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Clk	:	STD_LOGIC := '0';
	
	constant Clk_50MHz_period : time := 10 ns;

BEGIN

   UUT: Stopwatch PORT MAP(
		StartStop => StartStop, 
		Lap => Lap, 
		Clear => Clear, 
		Led => Led, 
		Seg => Seg, 
		An => An, 
		Clk => Clk
   );

	Clk_50MHz_process :process
   begin
		Clk <= '0';
		wait for Clk_50MHz_period/2;
		Clk <= '1';
		wait for Clk_50MHz_period/2;
   end process;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_50MHz_period*10;

      -- insert stimulus here 
		
		wait;
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
