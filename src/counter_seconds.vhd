LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter_seconds IS
    GENERIC (t_max : INTEGER := 100000000);
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        counter_out : OUT unsigned(3 DOWNTO 0) := "0000"
    );
END counter_seconds;

ARCHITECTURE behavioral OF counter_seconds IS

    SIGNAL counter_temp : unsigned(3 DOWNTO 0) := "0000";

BEGIN
    counter_label : PROCESS (CLOCK_50)
        VARIABLE slow_clock : INTEGER RANGE t_max DOWNTO 0 := 0;
    BEGIN
        IF (CLOCK_50'event AND CLOCK_50 = '1') THEN
            IF (slow_clock <= t_max) THEN
                slow_clock := slow_clock + 1;
            ELSE
                counter_temp <= counter_temp + 1;
                slow_clock := 0;
            END IF;
        END IF;
    END PROCESS;
    counter_out <= counter_temp;
END behavioral;