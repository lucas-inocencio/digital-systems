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

    COMPONENT incrementer
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            incout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            inccout : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL temp_cont, temp_y : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

    PROCESS (a)
    BEGIN
        y <= 0;

        FOR i IN 0 TO 3 RANGE LOOP
            IF a(i) = '1' THEN
                y <= y + 1;
            END IF;
        END LOOP;
    END PROCESS;
    
END Behavioral;