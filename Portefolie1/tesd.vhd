--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:25:10 03/28/2016
-- Design Name:   
-- Module Name:   D:/Github/DIG/Portefolie1/tesd.vhd
-- Project Name:  Portefolie1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: muxdisplay_ver3
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
 
ENTITY tesd IS
END tesd;
 
ARCHITECTURE behavior OF tesd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxdisplay_ver3
    PORT(
         Clk_50MHz : IN  std_logic;
         Bcd : IN  std_logic_vector(15 downto 0);
         Dp : IN  std_logic_vector(3 downto 0);
         Segm : OUT  std_logic_vector(1 to 8);
         An : OUT  std_logic_vector(3 downto 0);
         Clk_1kHz : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk_50MHz : std_logic := '0';
   signal Bcd : std_logic_vector(15 downto 0) := (others => '0');
   signal Dp : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Segm : std_logic_vector(1 to 8);
   signal An : std_logic_vector(3 downto 0);
   signal Clk_1kHz : std_logic;

   -- Clock period definitions
   constant Clk_50MHz_period : time := 10 ns;
   constant Clk_1kHz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxdisplay_ver3 PORT MAP (
          Clk_50MHz => Clk_50MHz,
          Bcd => Bcd,
          Dp => Dp,
          Segm => Segm,
          An => An,
          Clk_1kHz => Clk_1kHz
        );

   -- Clock process definitions
   Clk_50MHz_process :process
   begin
		Clk_50MHz <= '0';
		wait for Clk_50MHz_period/2;
		Clk_50MHz <= '1';
		wait for Clk_50MHz_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_50MHz_period*10;

      -- insert stimulus here 
		
		wait for 10 ms;
		
		Bcd <= "0000000000000101";
		
		wait for 10 ms;
		
      wait;
   end process;

END;
