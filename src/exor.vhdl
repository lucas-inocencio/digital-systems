-- 4-Bit XOR Gate

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY exor IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC(3 DOWNTO 0));
END exor;

ARCHITECTURE Behavioral OF exor IS

BEGIN

    PROCESS (a, b)
    BEGIN
        FOR i IN 0 TO 3 LOOP
            y(i) <= (a(i) AND NOT b(i)) OR (NOT a(i) AND b(i));
        END LOOP;

    END PROCESS;

END Behavioral;