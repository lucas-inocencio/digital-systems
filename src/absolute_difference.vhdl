-- 4-Bit Absolute Difference

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY absolute_difference IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END absolute_difference;

ARCHITECTURE behavioral OF absolute_difference IS

    COMPONENT comparator IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            eq, gt, lt : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT subtractor IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

BEGIN

    U0 : comparator PORT MAP(a, b, eq, gt, lt);

    PROCESS(eq, gt, lt, a, b)
    BEGIN
        IF eq = '1' THEN
            y <= "0000";
        ELSIF gt = '1' THEN
            y <= subtractor(a, b, y);
        ELSIF lt = '1' THEN
            y <= subtractor(b, a, y);
        END IF;
    END PROCESS;

END behavioral;