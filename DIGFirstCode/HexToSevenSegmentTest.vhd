--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:01:29 03/27/2016
-- Design Name:   
-- Module Name:   D:/Github/DIG/DIGFirstCode/HexToSevenSegmentTest.vhd
-- Project Name:  DIGFirstCode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HexToSevenSegment
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY HexToSevenSegmentTest IS
	PORT(CLK : OUT std_logic);
END HexToSevenSegmentTest;
 
ARCHITECTURE behavior OF HexToSevenSegmentTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HexToSevenSegment
    PORT(
         SEGMENTS : OUT  std_logic_vector(7 downto 0);
         HEX : IN  std_logic_vector(3 downto 0);
         ANODES : OUT  std_logic_vector(3 downto 0);
         SWITCHES : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal HEX : std_logic_vector(3 downto 0) := (others => '0');
   signal SWITCHES : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal SEGMENTS : std_logic_vector(7 downto 0);
   signal ANODES : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
	signal clock : std_logic := '0';
 
   constant clock_period : time := 20 ns;
 
BEGIN
 
	CLK <= clock;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HexToSevenSegment PORT MAP (
          SEGMENTS => SEGMENTS,
          HEX => HEX,
          ANODES => ANODES,
          SWITCHES => SWITCHES
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		
		SWITCHES <= "0001";
		HEX <= "0001";
		
		wait for 20 ns;

      wait;
   end process;

END;
