--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:14 03/28/2016
-- Design Name:   
-- Module Name:   D:/Github/DIG/Portefolie1/MuxDisplayTest.vhd
-- Project Name:  Portefolie1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MuxDisplay
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
 
ENTITY MuxDisplayTest IS
END MuxDisplayTest;
 
ARCHITECTURE behavior OF MuxDisplayTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MuxDisplay
    PORT(
         Clk_in_50 : IN  std_logic;
         Clk_out_1 : OUT  std_logic;
         Bcd : IN  std_logic_vector(15 downto 0);
         Segm : OUT  std_logic_vector(1 to 8);
         Dp : IN  std_logic_vector(3 downto 0);
         An : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk_in_50 : std_logic := '0';
   signal Bcd : std_logic_vector(15 downto 0) := (others => '0');
   signal Dp : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Clk_out_1 : std_logic;
   signal Segm : std_logic_vector(1 to 8);
   signal An : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clk_in_50_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MuxDisplay PORT MAP (
          Clk_in_50 => Clk_in_50,
          Clk_out_1 => Clk_out_1,
          Bcd => Bcd,
          Segm => Segm,
          Dp => Dp,
          An => An
        );

   -- Clock process definitions
   Clk_in_50_process :process
   begin
		Clk_in_50 <= '0';
		wait for Clk_in_50_period/2;
		Clk_in_50 <= '1';
		wait for Clk_in_50_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_in_50_period*10;

      -- insert stimulus here 
		
		Bcd <= "0000000000000000";

      wait;
   end process;

END;
