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

	SIGNAL y1, y2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL equal, greater, less : STD_LOGIC;
	 
BEGIN

    U0 : comparator PORT MAP(a, b, equal, greater, less);
	U1 : subtractor PORT MAP(a, b, y1);
	U2 : subtractor PORT MAP(b, a, y2);

    PROCESS(equal, greater, less, a, b)
    BEGIN
        IF equal = '1' THEN
            y <= "0000";
        ELSIF greater = '1' THEN
            y <= y1;
        ELSIF less = '1' THEN
            y <= y2;
        END IF;
    END PROCESS;

END behavioral;