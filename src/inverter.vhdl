-- 4-Bit inverter 2's complement

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY inverter IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));

END inverter;

ARCHITECTURE behavior OF inverter IS

    COMPONENT incrementer
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            incout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            inccout : OUT STD_LOGIC);
    END COMPONENT;

BEGIN

    U0 : incrementer PORT MAP(NOT (a), y, OPEN);

END behavior;