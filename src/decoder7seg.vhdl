-- 7-segment decoder

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder7seg IS
    PORT (
        bcd_in : IN unsigned(3 DOWNTO 0) := "0000";
        seven_seg_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END decoder7seg;

ARCHITECTURE structural OF decoder7seg IS
BEGIN
    PROCESS(bcd_in)
    BEGIN
        CASE bcd_in IS
            WHEN "0000" => seven_seg_out <= "0000001"; -- 0
            WHEN "0001" => seven_seg_out <= "1001111"; -- 1
            WHEN "0010" => seven_seg_out <= "0010010"; -- 2
            WHEN "0011" => seven_seg_out <= "0000110"; -- 3
            WHEN "0100" => seven_seg_out <= "1001100"; -- 4
            WHEN "0101" => seven_seg_out <= "0100100"; -- 5
            WHEN "0110" => seven_seg_out <= "0100000"; -- 6
            WHEN "0111" => seven_seg_out <= "0001111"; -- 7
            WHEN "1000" => seven_seg_out <= "0000000"; -- 8
            WHEN "1001" => seven_seg_out <= "0000100"; -- 9
            WHEN "1010" => seven_seg_out <= "0001000"; -- A
            WHEN "1011" => seven_seg_out <= "1100000"; -- B
            WHEN "1100" => seven_seg_out <= "0110001"; -- C
            WHEN "1101" => seven_seg_out <= "1000010"; -- D
            WHEN "1110" => seven_seg_out <= "0110000"; -- E
            WHEN "1111" => seven_seg_out <= "0111000"; -- F
            WHEN OTHERS => seven_seg_out <= "1111111"; -- OFF
        END CASE;
    END PROCESS;
END structural;