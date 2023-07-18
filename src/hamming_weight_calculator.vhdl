-- 4-Bit Hamming-Weight Calculator
-- The Hamming weight of a string is the number of symbols that are different from the zero-symbol

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY hamming_weight_calculator IS
    PORT (
        a : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
END hamming_weight_calculator;

ARCHITECTURE Behavioral OF hamming_weight_calculator IS

BEGIN

    PROCESS (a)
    BEGIN
        IF a = "0000" THEN
            y <= "00";
        ELSIF a = "0001" OR a = "0010" OR a = "0100" OR a = "1000" THEN
            y <= "01";
        ELSIF a = "1111" THEN
            y <= "11";
        ELSE
            y <= "10";
        END IF;
    END PROCESS;

END Behavioral;