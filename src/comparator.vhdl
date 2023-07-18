-- 4-Bit Magnitude Comparator

LIBRARY IEE;
USE IEE.std_logic_1164.ALL;

ENTITY comparator IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        eq, gt, lt : OUT STD_LOGIC);
END comparator;

ARCHITECTURE behavioral OF comparator IS

BEGIN
    PROCESS (a, b)
    BEGIN
        FOR i IN 3 DOWNTO 0 LOOP
            IF a(i) AND NOT b(i) THEN
                eq <= '0';
                gt <= '1';
                lt <= '0';
                EXIT;
            ELSIF NOT a(i) AND b(i) THEN
                eq <= '0';
                gt <= '0';
                lt <= '1';
                EXIT;
            ELSIF a(i) XNOR b(i) THEN
                eq <= '1';
                gt <= '0';
                lt <= '0';
            END IF;
        END LOOP;
    END PROCESS;

END behavioral;