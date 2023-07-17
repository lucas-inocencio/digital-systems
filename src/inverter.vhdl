-- 4-Bit inverter 2's complement

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY inverter IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    );
END inverter;

ARCHITECTURE behavior OF inverter IS
BEGIN
    y <= (not a) + 1;
END behavior;