<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="HEX(3:0)" />
        <signal name="ANODES(3:0)" />
        <signal name="SEGMENTS(7:0)" />
        <signal name="SWITCHES(3:0)" />
        <port polarity="Input" name="HEX(3:0)" />
        <port polarity="Output" name="ANODES(3:0)" />
        <port polarity="Output" name="SEGMENTS(7:0)" />
        <port polarity="Input" name="SWITCHES(3:0)" />
        <blockdef name="HexToSevenSegment">
            <timestamp>2016-3-27T16:53:15</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="432" y="-108" height="24" />
            <line x2="496" y1="-96" y2="-96" x1="432" />
            <rect width="64" x="432" y="-44" height="24" />
            <line x2="496" y1="-32" y2="-32" x1="432" />
            <rect width="368" x="64" y="-128" height="192" />
        </blockdef>
        <blockdef name="clockscaler50_1">
            <timestamp>2016-3-28T12:9:24</timestamp>
            <rect width="304" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="432" y1="-96" y2="-96" x1="368" />
        </blockdef>
        <block symbolname="HexToSevenSegment" name="XLXI_1">
            <blockpin signalname="HEX(3:0)" name="HEX(3:0)" />
            <blockpin signalname="SEGMENTS(7:0)" name="SEGMENTS(7:0)" />
            <blockpin signalname="ANODES(3:0)" name="ANODES(3:0)" />
            <blockpin signalname="SWITCHES(3:0)" name="ANODE_SELECT(3:0)" />
        </block>
        <block symbolname="clockscaler50_1" name="XLXI_2">
            <blockpin name="clock_in" />
            <blockpin name="clock_select(1:0)" />
            <blockpin name="clock_out" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <iomarker fontsize="28" x="1840" y="496" name="ANODES(3:0)" orien="R0" />
        <iomarker fontsize="28" x="1840" y="432" name="SEGMENTS(7:0)" orien="R0" />
        <iomarker fontsize="28" x="1280" y="432" name="HEX(3:0)" orien="R180" />
        <branch name="HEX(3:0)">
            <wire x2="1296" y1="432" y2="432" x1="1280" />
            <wire x2="1312" y1="432" y2="432" x1="1296" />
        </branch>
        <branch name="ANODES(3:0)">
            <wire x2="1824" y1="496" y2="496" x1="1808" />
            <wire x2="1840" y1="496" y2="496" x1="1824" />
        </branch>
        <branch name="SEGMENTS(7:0)">
            <wire x2="1824" y1="432" y2="432" x1="1808" />
            <wire x2="1840" y1="432" y2="432" x1="1824" />
        </branch>
        <instance x="1312" y="528" name="XLXI_1" orien="R0">
        </instance>
        <branch name="SWITCHES(3:0)">
            <wire x2="1312" y1="560" y2="560" x1="1296" />
        </branch>
        <iomarker fontsize="28" x="1296" y="560" name="SWITCHES(3:0)" orien="R180" />
        <instance x="1312" y="288" name="XLXI_2" orien="R0">
        </instance>
    </sheet>
</drawing>