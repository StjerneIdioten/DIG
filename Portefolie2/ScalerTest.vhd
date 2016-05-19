--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:37:51 05/19/2016
-- Design Name:   
-- Module Name:   D:/Github/DIG/Portefolie2/ScalerTest.vhd
-- Project Name:  Portefolie2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClockScaler
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
 
ENTITY ScalerTest IS
END ScalerTest;
 
ARCHITECTURE behavior OF ScalerTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockScaler
    PORT(
         Clk_In : IN  std_logic;
         Clk_Out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk_In : std_logic := '0';

 	--Outputs
   signal Clk_Out : std_logic;

   -- Clock period definitions
   constant Clk_In_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClockScaler PORT MAP (
          Clk_In => Clk_In,
          Clk_Out => Clk_Out
        );

   -- Clock process definitions
   Clk_In_process :process
   begin
		Clk_In <= '0';
		wait for Clk_In_period/2;
		Clk_In <= '1';
		wait for Clk_In_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for 10 ms;

      -- insert stimulus here 

      wait;
   end process;

END;
