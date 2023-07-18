-- 4-Bit Subtractor using 2's Complement

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY subtractor IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END subtractor;

ARCHITECTURE behavior OF subtractor IS

    COMPONENT carry_lookahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cin : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT inverter
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    SIGNAL b_inv, sub, sub_inv : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sign_bit : STD_LOGIC;

BEGIN

    -- 2's Complement of b
    inv : inverter PORT MAP(b, b_inv);

    -- Add a and 2's Complement of b
    adder : carry_lookahead_adder PORT MAP(a, b_inv, '0', sub, sign_bit);

    -- if sign bit is 1, then the result is negative
    -- so we take 2's complement of the result
    inv2 : inverter PORT MAP(sub, sub_inv);
    
    PROCESS (sign_bit, sub)
    BEGIN
        IF (sign_bit = '1') THEN
            y <= sub_inv;
        ELSE
            y <= sub;
        END IF;
    END PROCESS;

END behavior;