-- 4-Bit incrementer

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY incrementer IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC;
    );
END incrementer;

ARCHITECTURE behavior OF incrementer IS
    COMPONENT carry_lookahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cin : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cout : OUT STD_LOGIC;
        );
    END COMPONENT;
BEGIN
    adder : carry_lookahead_adder PORT MAP(a, '0', '1', sum, carry);
    y <= sum;
    cout <= carry;
END behavior;