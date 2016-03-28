--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : muxdisplay.vhf
-- /___/   /\     Timestamp : 03/28/2016 14:30:42
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl D:/Github/DIG/muxdisplay/muxdisplay.vhf -w D:/Github/DIG/muxdisplay/muxdisplay.sch
--Design Name: muxdisplay
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity muxdisplay is
   port ( HEX      : in    std_logic_vector (3 downto 0); 
          SWITCHES : in    std_logic_vector (3 downto 0); 
          ANODES   : out   std_logic_vector (3 downto 0); 
          SEGMENTS : out   std_logic_vector (7 downto 0));
end muxdisplay;

architecture BEHAVIORAL of muxdisplay is
   signal XLXI_2_clock_in_openSignal     : std_logic;
   signal XLXI_2_clock_select_openSignal : std_logic_vector (1 downto 0);
   component HexToSevenSegment
      port ( HEX          : in    std_logic_vector (3 downto 0); 
             SEGMENTS     : out   std_logic_vector (7 downto 0); 
             ANODES       : out   std_logic_vector (3 downto 0); 
             ANODE_SELECT : in    std_logic_vector (3 downto 0));
   end component;
   
   component clockscaler50_1
      port ( clock_in     : in    std_logic; 
             clock_select : in    std_logic_vector (1 downto 0); 
             clock_out    : out   std_logic);
   end component;
   
begin
   XLXI_1 : HexToSevenSegment
      port map (ANODE_SELECT(3 downto 0)=>SWITCHES(3 downto 0),
                HEX(3 downto 0)=>HEX(3 downto 0),
                ANODES(3 downto 0)=>ANODES(3 downto 0),
                SEGMENTS(7 downto 0)=>SEGMENTS(7 downto 0));
   
   XLXI_2 : clockscaler50_1
      port map (clock_in=>XLXI_2_clock_in_openSignal,
                clock_select(1 downto 0)=>XLXI_2_clock_select_openSignal(1 
            downto 0),
                clock_out=>open);
   
end BEHAVIORAL;


