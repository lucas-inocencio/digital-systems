-- 4-bit counter with 7-segment display

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY count_display IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        G_HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END count_display;

ARCHITECTURE structural OF count_display IS
    SIGNAL counter : unsigned(3 DOWNTO 0) := "0000";

    COMPONENT counter_seconds IS
        PORT (
            CLOCK_50 : IN STD_LOGIC;
            counter_out : OUT unsigned(3 DOWNTO 0) := "0000"
        );
    END COMPONENT;

    COMPONENT decoder7seg IS
        PORT (
            bcd_in : IN unsigned(3 DOWNTO 0) := "0000";
            seven_seg_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    counter0 : counter_seconds PORT MAP(CLOCK_50, counter);
    decoder0 : decoder7seg PORT MAP(counter, G_HEX0);
END structural;