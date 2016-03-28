--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : muxdisplay.vhf
-- /___/   /\     Timestamp : 03/27/2016 18:13:01
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
   component HexToSevenSegment
      port ( HEX      : in    std_logic_vector (3 downto 0); 
             SWITCHES : in    std_logic_vector (3 downto 0); 
             SEGMENTS : out   std_logic_vector (7 downto 0); 
             ANODES   : out   std_logic_vector (3 downto 0));
   end component;
   
begin
   XLXI_1 : HexToSevenSegment
      port map (HEX(3 downto 0)=>HEX(3 downto 0),
                SWITCHES(3 downto 0)=>SWITCHES(3 downto 0),
                ANODES(3 downto 0)=>ANODES(3 downto 0),
                SEGMENTS(7 downto 0)=>SEGMENTS(7 downto 0));
   
end BEHAVIORAL;


