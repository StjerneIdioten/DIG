----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:01:11 05/02/2016 
-- Design Name: 
-- Module Name:    DesignVHDL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.Projekt_Data.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DesignVHDL is

Port(	Clk : in  STD_LOGIC;
			Toggle_Display : in STD_LOGIC;
			M1_Pan_Z : in STD_LOGIC;
			M2_Tilt_Z : in STD_LOGIC;
			H_I_0_Pan : in STD_LOGIC;
			H_I_1_Tilt : in STD_LOGIC;
			M1_H_A : in STD_LOGIC;
			M1_H_B : in STD_LOGIC;
			M2_H_A : in STD_LOGIC;
			M2_H_B : in STD_LOGIC;
			SPI_SS : in STD_LOGIC;
			SPI_MOSI : in STD_LOGIC;
			SPI_CLK : in STD_LOGIC;
			SPI_MISO : out STD_LOGIC;
			M1_Pan : out STD_LOGIC_VECTOR(1 downto 0);
			M2_Tilt : out STD_LOGIC_VECTOR(1 downto 0);
			M1_Pan_E : out STD_LOGIC;
			M2_Tilt_E : out STD_LOGIC;
			M1_Led : out STD_LOGIC_VECTOR(1 downto 0);
			M2_Led : out STD_LOGIC_VECTOR(1 downto 0);
			Seg : out STD_LOGIC_VECTOR(7 downto 0);
			Enable : out STD_LOGIC_VECTOR(3 downto 0)
	);

end DesignVHDL;

architecture Behavioral of DesignVHDL is

	--Internal Data System 
	signal Adr_Bus : STD_LOGIC_VECTOR(3 downto 0);
	signal Data_Bus_To_Slave : STD_LOGIC_VECTOR(11 downto 0);
	signal Data_Bus_From_Slave : STD_LOGIC_VECTOR(11 downto 0);
	signal Write_En : STD_LOGIC;

	--Motor 1 Pan 
	signal M1_Pan_Z_Toggle : STD_LOGIC := '0';
	signal M1_Pan_Z_Push : STD_LOGIC := '0';
	signal M1_Pan_Z_Pulse : STD_LOGIC := '0';
	
	signal M1_Pan_Ticks : STD_LOGIC_VECTOR(11 downto 0);
	
	signal M1_Pan_Zeroed : STD_LOGIC;
	
	--Motor 2 Tilt 
	signal M2_Tilt_Z_Toggle : STD_LOGIC := '0';
	signal M2_Tilt_Z_Push : STD_LOGIC := '0';
	signal M2_Tilt_Z_Pulse : STD_LOGIC := '0';
	
	signal M2_Tilt_Ticks : STD_LOGIC_VECTOR(11 downto 0);
	
	signal M2_Tilt_Zeroed : STD_LOGIC;
	
	--BCD
	signal NTB_M1_Pan_Ticks_BCD : STD_LOGIC_VECTOR(15 downto 0);
	signal NTB_M2_Tilt_Ticks_BCD : STD_LOGIC_VECTOR(15 downto 0);

	signal Bcd_To_Display : STD_LOGIC_VECTOR(15 downto 0);
	
	--Retarded Conversion
	signal Retarded_Conversion : STD_LOGIC_VECTOR(0 to 7);

begin

	M1_Pan_Zero_Button : entity work.Toggle_Button3 
		port map (
		Clk=>Clk, 
		Button=>M1_Pan_Z, 
		Toggle=>M1_Pan_Z_Toggle, 
		Deboun=>M1_Pan_Z_Push, 
		Pulse=>M1_Pan_Z_Pulse
	);
	
	M2_Tilt_Zero_Button : entity work.Toggle_Button3 
		port map (
		Clk=>Clk,
		Button=>M2_Tilt_Z,
		Toggle=>M2_Tilt_Z_Toggle,
		Deboun=>M2_Tilt_Z_Push,
		Pulse=>M2_Tilt_Z_Pulse
	);
	
	SPI_Slave :  entity work.SPI_Slave3
		port map (
		Clk=>Clk,
		SClk=>SPI_CLK,
		SS=>SPI_SS,
		MOSI=>SPI_MOSI,
		MISO=>SPI_MISO,
		AdrBus=>Adr_Bus,
		WE=>Write_En,
		DataBusToSlave=>Data_Bus_To_Slave,
		DataBusFromSlave=>Data_Bus_From_Slave
	);
	
	M1_C_Pan : entity work.MotorController
		generic map(
		Address=>MOTOR_CONTROLLER1_PAN,
		Boundary_Max=>PAN_MAX,
		Boundary_Min=>PAN_MIN
		)
		port map(
		Clk=>Clk,
		Motor_Ticks=>M1_Pan_Ticks,
		DataBusFromSlave=>Data_Bus_From_Slave,
		AdrBus=>Adr_Bus,
		WE=>Write_En,
		HallIndex=>H_I_0_Pan,
		ButtonPress=>M1_Pan_Z_Push,
		ButtonToggle=>M1_Pan_Z_Toggle,
		ButtonPulse=>M1_Pan_Z_Pulse,
		MotorEnable=>M1_Pan_E,
		MotorPins=>M1_Pan,
		Zeroed=>M1_Pan_Zeroed,
		StateOutput=>M1_Led
	);
	
	M2_C_Tilt : entity work.MotorController
		generic map(
		Address=>MOTOR_CONTROLLER2_TILT,
		Boundary_Max=>TILT_MAX,
		Boundary_Min=>TILT_MIN
		)
		port map(
		Clk=>Clk,
		Motor_Ticks=>M2_Tilt_Ticks,
		DataBusFromSlave=>Data_Bus_From_Slave,
		AdrBus=>Adr_Bus,
		WE=>Write_En,
		HallIndex=>H_I_1_Tilt,
		ButtonPress=>M2_Tilt_Z_Push,
		ButtonToggle=>M2_Tilt_Z_Toggle,
		ButtonPulse=>M2_Tilt_Z_Pulse,
		MotorEnable=>M2_Tilt_E,
		MotorPins=>M2_Tilt,
		Zeroed=>M2_Tilt_Zeroed,
		StateOutput=>M2_Led
	);

	M1_PM_Pan : entity work.PositionsModul
		generic map(
		Address=>POSITIONS_MODUL1_PAN
		)
		port map(
		Clk=>Clk,
		HallA=>M1_H_A,
		HallB=>M1_H_B,
		HallIndex=>H_I_0_Pan,
		DataBusToSlave=>M1_Pan_Ticks,
		MotorZeroed=>M1_Pan_Zeroed
	);
	
	M2_PM_Tilt : entity work.PositionsModul
		generic map(
		Address=>POSITIONS_MODUL2_TILT
		)
		port map(
		Clk=>Clk,
		HallA=>M2_H_A,
		HallB=>M2_H_B,
		HallIndex=>H_I_1_Tilt,
		DataBusToSlave=>M2_Tilt_Ticks,
		MotorZeroed=>M2_Tilt_Zeroed
	);
	
	NTB_M1_Pan_Ticks : entity work.NumberToBcd
		port map(
		Clk=>Clk,
		Number=>M1_Pan_Ticks,
		BcdOut=>NTB_M1_Pan_Ticks_BCD
	);
	
	NTB_M2_Tilt_Ticks : entity work.NumberToBcd
		port map(
		Clk=>Clk,
		Number=>M2_Tilt_Ticks,
		BcdOut=>NTB_M2_Tilt_Ticks_BCD
	);
	
	DisplayMultiplexer : entity work.MultiplexDisplay
		port map(
		Clk_50MHz=>Clk,
		Bcd=>Bcd_To_Display,
		Seg=>Seg,
		An=>Enable
	);
	
	--Display Mux Mux2x16_1
	with Toggle_Display select Bcd_To_Display <=
		NTB_M1_Pan_Ticks_BCD when '0',
		NTB_M2_Tilt_Ticks_BCD when '1',
		(others=>'X') when others;
		
	--Databus to slave mux Mux2x12_4
	with Adr_Bus select Data_Bus_To_Slave <=
		M1_Pan_Ticks when POSITIONS_MODUL1_PAN,
		M2_Tilt_Ticks when POSITIONS_MODUL2_TILT,
		(others=>'0') when others;

end Behavioral;

