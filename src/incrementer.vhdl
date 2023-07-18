-- 4-Bit incrementer

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY incrementer IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        incout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        inccout : OUT STD_LOGIC);
END incrementer;

ARCHITECTURE behavior OF incrementer IS
    COMPONENT carry_lookahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cin : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL carry : STD_LOGIC;
BEGIN
    add : carry_lookahead_adder PORT MAP(a, (OTHERS => '0'), '1', sum, carry);
    incout <= sum;
    inccout <= carry;
END behavior;